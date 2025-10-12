local Http = game:GetService("HttpService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local TARGET_ITEMS = {
    "Money Printer", "Blue Candy Cane", "Bunny Balloon", "Ghost Balloon", "Clover Balloon",
    "Bat Balloon", "Gold Clover Balloon", "Golden Rose", "Black Rose", "Heart Balloon",
    "Diamond Ring", "Diamond", "Void Gem", "Dark Matter Gem", "Rollie", "NextBot Grenade",
    "Nuclear Missile Launcher", "Suitcase Nuke", "Car", "Helicopter", "Trident", "Golden Cup", 
    "Easter Basket", "Military Armory Keycard", "Treasure Map",  "Holy Grail"
}

local function simulateMovement()
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:Move(Vector3.new(0, 0, 1), true)
        task.wait(0.01)
        humanoid:Move(Vector3.new(0, 0, 0), false)
    end
end

local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"

function ListServers(cursor)
    local url = _servers .. (cursor and "&cursor=" .. cursor or "")
    local success, raw = pcall(function()
        return game:HttpGet(url)
    end)
    if not success then
        warn("获取服务器列表失败: " .. raw)
        return nil
    end
    return Http:JSONDecode(raw)
end

local function getRandomServer()
    local Server, Next
    repeat
        local Servers = ListServers(Next)
        if not Servers then break end
        local validServers = {}
        for _, srv in ipairs(Servers.data) do
            if srv.id ~= game.JobId and srv.playing < srv.maxPlayers then
                table.insert(validServers, srv)
            end
        end
        if #validServers > 0 then
            local randomIndex = math.random(1, #validServers)
            Server = validServers[randomIndex]
        end
        Next = Servers.nextPageCursor
    until Server or not Next
    return Server
end

local MainScript = [[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoling-create/Roblox/refs/heads/main/Starrain%E5%8D%B0%E9%92%9E%E6%9C%BA%E6%B5%8B%E8%AF%95.lua"))()
]]

-- 尝试绕过力场的函数
local function bypassForceField(character)
    if not character then return end
    
    -- 方法1：直接移除力场
    local forceField = character:FindFirstChild("ForceField")
    if forceField then
        pcall(function() forceField:Destroy() end)
    end
    
    -- 方法2：修改力场属性（如果存在）
    if forceField and forceField:IsA("ForceField") then
        pcall(function()
            forceField.Visible = false
            forceField.Enabled = false
        end)
    end
    
    -- 方法3：暂时禁用碰撞（辅助拾取）
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        pcall(function() rootPart.CanCollide = false end)
    end
end

-- 修改等待力场消失的逻辑，加入主动绕过尝试
repeat
    task.wait()
    simulateMovement()
    bypassForceField(LocalPlayer.Character) -- 每次循环都尝试绕过
    task.wait(0.01)
until not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("ForceField"))

local function safeTeleport(targetCFrame, character)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not humanoid then return false end

    local originalCanCollide = rootPart.CanCollide
    rootPart.CanCollide = false

    local startCFrame = rootPart.CFrame
    local steps = 10
    for i = 1, steps do
        rootPart.CFrame = startCFrame:Lerp(targetCFrame, i / steps)
        RunService.Heartbeat:Wait()
    end

    rootPart.CanCollide = originalCanCollide
    return true
end

local function findAllTargetItems()
    local targetItems = {}
    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Entities") and workspace.Game.Entities:FindFirstChild("ItemPickup") then
        for _, v in ipairs(workspace.Game.Entities.ItemPickup:GetChildren()) do
            local primaryPart = v.PrimaryPart
            if primaryPart then
                local prompt = primaryPart:FindFirstChildOfClass("ProximityPrompt")
                if prompt and table.find(TARGET_ITEMS, prompt.ObjectText) then
                    table.insert(targetItems, {
                        part = primaryPart,
                        prompt = prompt,
                        instance = v,
                        type = prompt.ObjectText
                    })
                end
            end
        end
    end
    return targetItems
end

-- 新增：直接调用拾取函数（如果存在）
local function directPickup(item)
    -- 尝试通过物品实例的函数直接拾取
    if item.instance and item.instance:FindFirstChild("PickupFunction") then
        local success, result = pcall(function()
            return item.instance.PickupFunction:InvokeServer(LocalPlayer)
        end)
        if success then return true end
    end
    
    -- 尝试通过游戏全局函数拾取
    if game:GetService("ReplicatedStorage"):FindFirstChild("PickupItem") then
        local success, result = pcall(function()
            game.ReplicatedStorage.PickupItem:FireServer(item.instance)
        end)
        if success then return true end
    end
    
    return false
end

local function collectItem(item, character)
    if not character then return false end
    if not item.instance:IsDescendantOf(game) then
        return true 
    end

    -- 拾取前再次尝试绕过力场
    bypassForceField(character)
    
    -- 先尝试直接拾取（不移动）
    if directPickup(item) then
        task.wait(0.5)
        if not item.instance:IsDescendantOf(game) then
            return true
        end
    end
    
    -- 正常移动拾取流程
    local targetCFrame = item.part.CFrame * CFrame.new(0, 1, -3)
    local success = safeTeleport(targetCFrame, character)
    if not success then return false end

    task.wait(0.5)
    local interactSuccess = pcall(function()
        fireproximityprompt(item.prompt, 1)
    end)
    
    if interactSuccess then
        task.wait(1)
        if not item.instance:IsDescendantOf(game) then
            return true
        else
            warn("交互成功但物品未消失：" .. item.type)
            return false
        end
    else
        warn("拾取失败：" .. item.type)
        return false
    end
end

local function main()
    local allItems = findAllTargetItems()
    local targetServer = getRandomServer()

    if #allItems == 0 then
        print("未检测到任何目标物品，准备换服...")
        if targetServer then
            queue_on_teleport(MainScript)
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
        else
            warn("未检测到物品且无可用服务器")
        end
        return
    end

    local itemCounts = {}
    for _, item in ipairs(allItems) do
        itemCounts[item.type] = (itemCounts[item.type] or 0) + 1
    end
    local countText = {}
    for itemType, count in pairs(itemCounts) do
        table.insert(countText, itemType .. "：" .. count .. "个")
    end
    print("发现目标物品：" .. table.concat(countText, "，") .. "，开始拾取...")

    local normalItems = {}
    local failedItems = {}

    for i, item in ipairs(allItems) do
        print("正在拾取 " .. i .. "/" .. #allItems .. "（" .. item.type .. "）")
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        -- 拾取前再次绕过力场
        bypassForceField(character)
        local success = collectItem(item, character)
        
        if not success then
            warn("首次拾取失败，重试一次：" .. item.type)
            task.wait(2)
            bypassForceField(character) -- 重试前再次绕过
            success = collectItem(item, character)
            if not success then
                warn("标记为无法拾取：" .. item.type)
                table.insert(failedItems, item) 
            else
                table.insert(normalItems, item) 
            end
        else
            table.insert(normalItems, item) 
        end
    end

    if #failedItems > 0 then
        print("开始处理标记为失败的物品（共" .. #failedItems .. "个）")
        for i, item in ipairs(failedItems) do
            print("最后尝试拾取 失败物品 " .. i .. "/" .. #failedItems .. "（" .. item.type .. "）")
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            bypassForceField(character) -- 最后尝试前绕过
            local success = collectItem(item, character)
            
            if success then
                table.remove(failedItems, i)
                print("失败物品拾取成功：" .. item.type)
            else
                warn("最终拾取失败：" .. item.type)
            end
        end
    end

    if #failedItems > 0 then
        print("存在无法拾取的物品，将在5分钟后换服：")
        for _, item in ipairs(failedItems) do
            print("- " .. item.type)
        end
        
        task.wait(10)
        if targetServer then
            print("5分钟超时，执行换服...")
            queue_on_teleport(MainScript)
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
        else
            warn("5分钟超时但无可用服务器")
        end
    else
        print("所有目标物品已拾取，准备换服...")
        if targetServer then
            queue_on_teleport(MainScript)
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
        else
            warn("物品拾取完成，但未找到可用服务器")
        end
    end
end

main()
