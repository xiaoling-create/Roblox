local Http = game:GetService("HttpService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local GuiService = game:GetService("GuiService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

-- 配置变量
local ignoreRedCard = false  -- 是否忽略红卡拾取
local allowServerHop = true  -- 是否允许换服
local teleportInProgress = false  -- 换服是否进行中

local TARGET_ITEMS = {
    "Money Printer", "Blue Candy Cane", "Bunny Balloon", "Ghost Balloon", "Clover Balloon",
    "Bat Balloon", "Gold Clover Balloon", "Golden Rose", "Black Rose", "Heart Balloon",
    "Diamond Ring", "Diamond", "Void Gem", "Dark Matter Gem", "Rollie", "NextBot Grenade",
    "Nuclear Missile Launcher", "Suitcase Nuke", "Car", "Helicopter", "Trident", "Golden Cup", 
    "Easter Basket", "Military Armory Keycard", "Treasure Map",  "Holy Grail"
}

-- 创建按钮函数
local function createButton(name, position, size, text, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Position = position
    button.Size = size
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.BorderColor3 = Color3.new(1, 1, 1)
    button.BorderSizePixel = 1
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Parent = ScreenGui
    
    button.MouseButton1Click:Connect(callback)
    return button
end

-- 计算屏幕右侧位置
local screenWidth = GuiService:GetScreenResolution().X
local buttonX = UDim.new(1, -120)  -- 右侧留出100像素
local buttonWidth = UDim.new(0, 100)
local buttonHeight = UDim.new(0, 40)
local buttonSpacing = 10

-- 创建"移出红卡"按钮
local removeRedCardBtn = createButton(
    "RemoveRedCardBtn",
    UDim2.new(buttonX, UDim.new(0, 20)),
    UDim2.new(buttonWidth, buttonHeight),
    "移出红卡",
    function()
        ignoreRedCard = not ignoreRedCard
        removeRedCardBtn.BackgroundColor3 = ignoreRedCard and Color3.new(0, 1, 0) or Color3.new(0.2, 0.2, 0.2)
        print(ignoreRedCard and "已启用忽略红卡" or "已禁用忽略红卡")
    end
)

-- 创建"停止换服"按钮
local toggleHopBtn = createButton(
    "ToggleHopBtn",
    UDim2.new(buttonX, UDim.new(0, 20 + buttonHeight + buttonSpacing)),
    UDim2.new(buttonWidth, buttonHeight),
    "停止换服",
    function()
        allowServerHop = not allowServerHop
        toggleHopBtn.Text = allowServerHop and "停止换服" or "启动换服"
        toggleHopBtn.BackgroundColor3 = allowServerHop and Color3.new(0.2, 0.2, 0.2) or Color3.new(1, 0, 0)
        print(allowServerHop and "已启用换服功能" or "已禁用换服功能")
    end
)

-- 创建"立即换服"按钮
local instantHopBtn = createButton(
    "InstantHopBtn",
    UDim2.new(buttonX, UDim.new(0, 20 + 2*(buttonHeight + buttonSpacing))),
    UDim2.new(buttonWidth, buttonHeight),
    "立即换服",
    function()
        if teleportInProgress then return end
        print("触发立即换服...")
        local targetServer = getRandomServer()
        if targetServer then
            teleportInProgress = true
            queue_on_teleport(MainScript)
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
        else
            warn("没有可用服务器进行立即换服")
        end
    end
)

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
                    -- 如果启用了忽略红卡，跳过红卡物品
                    if not (ignoreRedCard and prompt.ObjectText == "Military Armory Keycard") then
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

local function performServerHop()
    if not allowServerHop or teleportInProgress then return end
    
    local targetServer = getRandomServer()
    if targetServer then
        teleportInProgress = true
        queue_on_teleport(MainScript)
        task.wait(1)
        TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
    else
        warn("没有可用服务器进行换服")
    end
end

local function main()
    while true do
        if teleportInProgress then break end
        
        local allItems = findAllTargetItems()
        local targetServer = allowServerHop and getRandomServer() or nil

        if #allItems == 0 then
            print("未检测到任何目标物品，准备换服...")
            if allowServerHop then
                performServerHop()
            else
                print("换服功能已禁用，等待物品刷新...")
                task.wait(10)
            end
            continue
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
        local hasFailedMilitaryKeycard = false

        for i, item in ipairs(allItems) do
            -- 如果启用了忽略红卡，跳过红卡物品
            if ignoreRedCard and item.type == "Military Armory Keycard" then
                print("已忽略红卡拾取")
                continue
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
                    if item.type == "Military Armory Keycard" then
                        hasFailedMilitaryKeycard = true
                    end
                else
                    table.insert(normalItems, item) 
                end
            else
                table.insert(normalItems, item) 
            end
        end

        if hasFailedMilitaryKeycard and allowServerHop then
            print("Military Armory Keycard 拾取失败，5秒后换服...")
            task.wait(5)
            performServerHop()
            continue
        end

        if #failedItems > 0 and allowServerHop then
            print("存在无法拾取的普通物品，3分钟后换服：")
            for _, item in ipairs(failedItems) do
                print("- " .. item.type)
            end
            
            -- 3分钟等待期间检查是否禁用了换服
            local waitTime = 180
            local checkInterval = 5
            while waitTime > 0 and allowServerHop do
                task.wait(checkInterval)
                waitTime -= checkInterval
            end
            
            if allowServerHop then
                print("3分钟超时，执行换服...")
                performServerHop()
            else
                print("换服功能已禁用，停止换服倒计时")
            end
        elseif #failedItems == 0 and allowServerHop then
            print("所有目标物品已拾取，准备换服...")
            performServerHop()
        else
            print("换服功能已禁用，继续等待...")
            task.wait(10)
        end
    end
end

main()
