-- 服务引用
local Http = game:GetService("HttpService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- 配置常量
local TARGET_ITEMS = {
    "Money Printer", "Blue Candy Cane", "Bunny Balloon", "Ghost Balloon", "Clover Balloon",
    "Bat Balloon", "Gold Clover Balloon", "Golden Rose", "Black Rose", "Heart Balloon",
    "Diamond Ring", "Diamond", "Void Gem", "Dark Matter Gem", "Rollie", "NextBot Grenade",
    "Nuclear Missile Launcher", "Suitcase Nuke", "Car", "Helicopter", "Trident", "Golden Cup", 
    "Easter Basket", "Military Armory Keycard", "Treasure Map", "Police Armory Keycard", "Holy Grail"
}

local SPECIAL_ITEMS = {
    ["Military Armory Keycard"] = {name = "红卡", color = Color3.new(1, 0, 0)},
    ["Police Armory Keycard"] = {name = "蓝卡", color = Color3.new(0, 0, 1)}
}

-- 持久化过滤状态（通过全局变量跨服务器保留）
_G.itemFilters = _G.itemFilters or {
    ["Military Armory Keycard"] = false,
    ["Police Armory Keycard"] = false
}
local itemFilters = _G.itemFilters

-- 超时配置
local SPECIAL_ITEM_TIMEOUT = 5
local NORMAL_ITEM_TIMEOUT = 180

-- 创建UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItemCollectorUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- 按钮容器
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0, 200, 0, 110)
ButtonContainer.Position = UDim2.new(0.98, -200, 0.5, -55)
ButtonContainer.BackgroundTransparency = 0.8
ButtonContainer.BackgroundColor3 = Color3.new(0, 0, 0)
ButtonContainer.BorderSizePixel = 2
ButtonContainer.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
ButtonContainer.Parent = ScreenGui

-- 标题
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 20)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "物品过滤"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.Gotham
TitleLabel.TextSize = 14
TitleLabel.Parent = ButtonContainer

-- 红卡按钮
local RedCardButton = Instance.new("TextButton")
RedCardButton.Size = UDim2.new(1, -10, 0, 25)
RedCardButton.Position = UDim2.new(0, 5, 0, 25)
RedCardButton.BackgroundColor3 = SPECIAL_ITEMS["Military Armory Keycard"].color
RedCardButton.TextColor3 = Color3.new(1, 1, 1)
RedCardButton.Font = Enum.Font.Gotham
RedCardButton.TextSize = 14
RedCardButton.Parent = ButtonContainer

-- 蓝卡按钮
local BlueCardButton = Instance.new("TextButton")
BlueCardButton.Size = UDim2.new(1, -10, 0, 25)
BlueCardButton.Position = UDim2.new(0, 5, 0, 55)
BlueCardButton.BackgroundColor3 = SPECIAL_ITEMS["Police Armory Keycard"].color
BlueCardButton.TextColor3 = Color3.new(1, 1, 1)
BlueCardButton.Font = Enum.Font.Gotham
BlueCardButton.TextSize = 14
BlueCardButton.Parent = ButtonContainer

-- 立即换服按钮
local HopServerButton = Instance.new("TextButton")
HopServerButton.Size = UDim2.new(1, -10, 0, 25)
HopServerButton.Position = UDim2.new(0, 5, 0, 85)
HopServerButton.BackgroundColor3 = Color3.new(0, 1, 0)
HopServerButton.TextColor3 = Color3.new(1, 1, 1)
HopServerButton.Font = Enum.Font.Gotham
HopServerButton.TextSize = 14
HopServerButton.Text = "立即换服"
HopServerButton.Parent = ButtonContainer

-- 更新按钮状态显示
local function updateButtonStates()
    RedCardButton.Text = (itemFilters["Military Armory Keycard"] and "启用 " or "移出 ") .. SPECIAL_ITEMS["Military Armory Keycard"].name
    RedCardButton.BackgroundTransparency = itemFilters["Military Armory Keycard"] and 0.5 or 0
    
    BlueCardButton.Text = (itemFilters["Police Armory Keycard"] and "启用 " or "移出 ") .. SPECIAL_ITEMS["Police Armory Keycard"].name
    BlueCardButton.BackgroundTransparency = itemFilters["Police Armory Keycard"] and 0.5 or 0
end

-- 初始化按钮状态
updateButtonStates()

-- 按钮事件
RedCardButton.MouseButton1Click:Connect(function()
    itemFilters["Military Armory Keycard"] = not itemFilters["Military Armory Keycard"]
    updateButtonStates()
end)

BlueCardButton.MouseButton1Click:Connect(function()
    itemFilters["Police Armory Keycard"] = not itemFilters["Police Armory Keycard"]
    updateButtonStates()
end)

-- 模拟移动防AFK
local function simulateMovement()
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:Move(Vector3.new(0, 0, 1), true)
        task.wait(0.01)
        humanoid:Move(Vector3.new(0, 0, 0), false)
    end
end

-- 服务器列表获取
local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"

local function ListServers(cursor)
    local url = _servers .. (cursor and "&cursor=" .. cursor or "")
    local success, raw = pcall(game.HttpGet, game, url)
    return success and Http:JSONDecode(raw) or nil
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
            Server = validServers[math.random(1, #validServers)]
        end
        Next = Servers.nextPageCursor
    until Server or not Next
    return Server
end

-- 换服函数
local function performServerHop()
    HopServerButton.Text = "换服中..."
    HopServerButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
    HopServerButton.Active = false

    -- 生成包含过滤状态的传送脚本
    local hopScript = [[
        _G.itemFilters = ]] .. Http:JSONEncode(itemFilters) .. [[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoling-create/Roblox/refs/heads/main/Starrain%E5%8D%B0%E9%92%9E%E6%9C%BA%E6%B5%8B%E8%AF%95.lua"))()
    ]]

    local success, err = pcall(function()
        local targetServer = getRandomServer()
        if targetServer then
            queue_on_teleport(hopScript)
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
            return true
        end
        return false
    end)

    if not success then
        warn("换服失败: " .. err)
        task.wait(2)
        HopServerButton.Text = "立即换服"
        HopServerButton.BackgroundColor3 = Color3.new(0, 1, 0)
        HopServerButton.Active = true
    end
end

HopServerButton.MouseButton1Click:Connect(performServerHop)

-- 安全传送
local function safeTeleport(targetCFrame, character)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not humanoid then return false end

    local originalCanCollide = rootPart.CanCollide
    rootPart.CanCollide = false
    local startCFrame = rootPart.CFrame

    for i = 1, 10 do
        rootPart.CFrame = startCFrame:Lerp(targetCFrame, i / 10)
        RunService.Heartbeat:Wait()
    end

    rootPart.CanCollide = originalCanCollide
    return true
end

-- 查找物品
local function findAllTargetItems()
    local targetItems = {}
    local itemPickup = workspace:FindFirstChild("Game")?.Entities:FindFirstChild("ItemPickup")
    if itemPickup then
        for _, v in ipairs(itemPickup:GetChildren()) do
            local primaryPart = v.PrimaryPart
            local prompt = primaryPart and primaryPart:FindFirstChildOfClass("ProximityPrompt")
            if prompt and table.find(TARGET_ITEMS, prompt.ObjectText) and not itemFilters[prompt.ObjectText] then
                table.insert(targetItems, {
                    part = primaryPart,
                    prompt = prompt,
                    instance = v,
                    type = prompt.ObjectText,
                    isSpecial = SPECIAL_ITEMS[prompt.ObjectText] ~= nil
                })
            end
        end
    end
    return targetItems
end

-- 拾取物品
local function collectItem(item, character)
    if itemFilters[item.type] then return true end
    if not item.instance:IsDescendantOf(game) then return true end

    local success = safeTeleport(item.part.CFrame * CFrame.new(0, 1, -3), character)
    if not success then return false end

    task.wait(0.5)
    local interactSuccess = pcall(fireproximityprompt, item.prompt, 1)
    
    if interactSuccess then
        task.wait(1)
        return not item.instance:IsDescendantOf(game)
    end
    return false
end

-- 主逻辑
local function main()
    -- 等待无敌状态消失
    repeat
        task.wait()
        simulateMovement()
    until not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("ForceField"))

    local allItems = findAllTargetItems()
    if #allItems == 0 then
        print("无目标物品，换服...")
        return performServerHop()
    end

    -- 统计物品
    local itemCounts = {}
    for _, item in ipairs(allItems) do
        itemCounts[item.type] = (itemCounts[item.type] or 0) + 1
    end
    local countText = {}
    for t, c in pairs(itemCounts) do table.insert(countText, t .. "：" .. c .. "个") end
    print("发现物品：" .. table.concat(countText, "，"))

    local failedItems = {}
    for i, item in ipairs(allItems) do
        if itemFilters[item.type] then
            print("跳过过滤物品：" .. item.type)
            continue
        end
        
        print("拾取 " .. i .. "/" .. #allItems .. "（" .. item.type .. "）")
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local success = collectItem(item, character)
        
        if not success then
            warn("重试拾取：" .. item.type)
            task.wait(2)
            success = collectItem(item, character)
            if not success then
                table.insert(failedItems, item)
            end
        end
    end

    -- 处理失败物品
    if #failedItems > 0 then
        local hasSpecialFailed = false
        for _, item in ipairs(failedItems) do
            if item.isSpecial and not itemFilters[item.type] then
                hasSpecialFailed = true
                break
            end
        end
        
        if hasSpecialFailed then
            print("特殊物品拾取失败，" .. SPECIAL_ITEM_TIMEOUT .. "秒后换服")
            task.wait(SPECIAL_ITEM_TIMEOUT)
            return performServerHop()
        end

        local finalFailed = {}
        for _, item in ipairs(failedItems) do
            if itemFilters[item.type] then continue end
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            if not collectItem(item, character) then
                table.insert(finalFailed, item)
            end
        end
        
        if #finalFailed > 0 then
            print("普通物品拾取失败，" .. NORMAL_ITEM_TIMEOUT .. "秒后换服")
            task.wait(NORMAL_ITEM_TIMEOUT)
            return performServerHop()
        end
    end

    print("所有物品拾取完成，换服...")
    performServerHop()
end

-- 启动
main()
