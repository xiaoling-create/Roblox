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

-- 检测背包中是否有"Military Armory Keycard"
local function hasMilitaryKeycard()
    local backpack = LocalPlayer.Backpack
    -- 检查背包
    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name == "Military Armory Keycard" then
            return true
        end
    end
    -- 检查是否在手中
    local character = LocalPlayer.Character
    if character then
        for _, item in ipairs(character:GetChildren()) do
            if item:IsA("Tool") and item.Name == "Military Armory Keycard" then
                return true
            end
        end
    end
    return false
end

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

repeat
    task.wait()
    simulateMovement()
    task.wait(0.01)
until not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("ForceField"))

-- 检查是否已有Military Armory Keycard，有则直接换服
if hasMilitaryKeycard() then
    print("检测到背包中已有Military Armory Keycard，准备换服...")
    local targetServer = getRandomServer()
    if targetServer then
        queue_on_teleport(MainScript)
        task.wait(1)
        TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
    else
        warn("检测到Military Armory Keycard但无可用服务器")
    end
    return
end

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

local function collectItem(item, character)
    if not character then return false end
    if not item.instance:IsDescendantOf(game) then
        return true 
    end

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
        -- 再次检查是否已获得Military Armory Keycard，有则停止拾取并换服
        if hasMilitaryKeycard() then
            print("拾取过程中获得了Military Armory Keycard，准备换服...")
            if targetServer then
                queue_on_teleport(MainScript)
                task.wait(1)
                TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
            else
                warn("获得Military Armory Keycard但无可用服务器")
            end
            return
        end
        
        print("正在拾取 " .. i .. "/" .. #allItems .. "（" .. item.type .. "）")
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local success = collectItem(item, character)
        
        if not success then
            warn("首次拾取失败，重试一次：" .. item.type)
            task.wait(2)
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

    -- 检查是否在拾取后获得了Military Armory Keycard
    if hasMilitaryKeycard() then
        print("拾取完成后发现已获得Military Armory Keycard，准备换服...")
        if targetServer then
            queue_on_teleport(MainScript)
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
        else
            warn("获得Military Armory Keycard但无可用服务器")
        end
        return
    end

    if #failedItems > 0 then
        print("存在无法拾取的物品，将在3分钟后换服：")  -- 修改为3分钟
        for _, item in ipairs(failedItems) do
            print("- " .. item.type)
        end
        
        task.wait(180)  -- 3分钟（180秒）
        if targetServer then
            print("3分钟超时，执行换服...")
            queue_on_teleport(MainScript)
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
        else
            warn("3分钟超时但无可用服务器")
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
