local Http = game:GetService("HttpService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- 配置变量
local TARGET_ITEMS = {
    "Money Printer", "Blue Candy Cane", "Bunny Balloon", "Ghost Balloon", "Clover Balloon",
    "Bat Balloon", "Gold Clover Balloon", "Golden Rose", "Black Rose", "Heart Balloon",
    "Diamond Ring", "Diamond", "Void Gem", "Dark Matter Gem", "Rollie", "NextBot Grenade",
    "Nuclear Missile Launcher", "Suitcase Nuke", "Car", "Helicopter", "Trident", "Golden Cup", 
    "Easter Basket", "Military Armory Keycard", "Treasure Map", "Police Armory Keycard", "Holy Grail"
}

-- 特殊物品配置（全局共享）
_G.SPECIAL_ITEMS = {
    ["Military Armory Keycard"] = {name = "红卡", color = Color3.new(1, 0, 0)},
    ["Police Armory Keycard"] = {name = "蓝卡", color = Color3.new(0, 0, 1)}
}

-- 物品过滤状态 (true = 不拾取)
local itemFilters = {
    ["Military Armory Keycard"] = false,
    ["Police Armory Keycard"] = false
}

-- 超时配置
local SPECIAL_ITEM_TIMEOUT = 5
local NORMAL_ITEM_TIMEOUT = 180

-- 清除旧UI防止冲突
local oldGui = LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("ItemCollectorUI")
if oldGui then
    oldGui:Destroy()
end

-- 创建UI（修复交互问题）
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItemCollectorUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- 按钮容器（确保可交互）
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0, 280, 0, 160)
ButtonContainer.Position = UDim2.new(0.95, -280, 0.5, -80)
ButtonContainer.BackgroundTransparency = 0.8
ButtonContainer.BackgroundColor3 = Color3.new(0, 0, 0)
ButtonContainer.BorderSizePixel = 3
ButtonContainer.BorderColor3 = Color3.new(0.7, 0.7, 0.7)
ButtonContainer.ClipsDescendants = true
ButtonContainer.Active = true  -- 允许交互
ButtonContainer.Selectable = true
ButtonContainer.Parent = ScreenGui

-- 标题
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "物品过滤"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.Parent = ButtonContainer

-- 红卡按钮（修复交互）
local RedCardButton = Instance.new("TextButton")
RedCardButton.Size = UDim2.new(1, -20, 0, 35)
RedCardButton.Position = UDim2.new(0, 10, 0, 35)
RedCardButton.BackgroundColor3 = _G.SPECIAL_ITEMS["Military Armory Keycard"].color
RedCardButton.TextColor3 = Color3.new(1, 1, 1)
RedCardButton.Font = Enum.Font.Gotham
RedCardButton.TextSize = 16
RedCardButton.Text = "移出 " .. _G.SPECIAL_ITEMS["Military Armory Keycard"].name
RedCardButton.Active = true
RedCardButton.Selectable = true
RedCardButton.AutoButtonColor = true  -- 显示点击反馈
RedCardButton.Parent = ButtonContainer

-- 蓝卡按钮（修复交互）
local BlueCardButton = Instance.new("TextButton")
BlueCardButton.Size = UDim2.new(1, -20, 0, 35)
BlueCardButton.Position = UDim2.new(0, 10, 0, 80)
BlueCardButton.BackgroundColor3 = _G.SPECIAL_ITEMS["Police Armory Keycard"].color
BlueCardButton.TextColor3 = Color3.new(1, 1, 1)
BlueCardButton.Font = Enum.Font.Gotham
BlueCardButton.TextSize = 16
BlueCardButton.Text = "移出 " .. _G.SPECIAL_ITEMS["Police Armory Keycard"].name
BlueCardButton.Active = true
BlueCardButton.Selectable = true
BlueCardButton.AutoButtonColor = true
BlueCardButton.Parent = ButtonContainer

-- 立即换服按钮（修复交互）
local HopServerButton = Instance.new("TextButton")
HopServerButton.Size = UDim2.new(1, -20, 0, 35)
HopServerButton.Position = UDim2.new(0, 10, 0, 125)
HopServerButton.BackgroundColor3 = Color3.new(0, 1, 0)
HopServerButton.TextColor3 = Color3.new(1, 1, 1)
HopServerButton.Font = Enum.Font.Gotham
HopServerButton.TextSize = 16
HopServerButton.Text = "立即换服"
HopServerButton.Active = true
HopServerButton.Selectable = true
HopServerButton.AutoButtonColor = true
HopServerButton.Parent = ButtonContainer

-- 全局变量共享（确保代码二可访问）
_G.itemFilters = itemFilters
_G.RedCardButton = RedCardButton
_G.BlueCardButton = BlueCardButton
_G.HopServerButton = HopServerButton
-- 修复219行报错：补充缺失的Http服务声明
local Http = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local _place = game.PlaceId  -- 确保_place已定义

-- 执行换服函数
local function performServerHop()
    local targetServer = getRandomServer()
    if targetServer then
        -- 保存过滤状态
        local playerData = game:GetService("DataStoreService"):GetDataStore("PlayerFilters")
        pcall(function()
            playerData:SetAsync(LocalPlayer.UserId .. "_filters", _G.itemFilters)
        end)
        
        queue_on_teleport(MainScript)
        task.wait(1)
        TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
        return true
    else
        warn("未找到可用服务器")
        return false
    end
end

-- 红卡按钮事件（使用全局SPECIAL_ITEMS）
_G.RedCardButton.MouseButton1Click:Connect(function()
    _G.itemFilters["Military Armory Keycard"] = not _G.itemFilters["Military Armory Keycard"]
    _G.RedCardButton.Text = (_G.itemFilters["Military Armory Keycard"] and "启用 " or "移出 ") .. _G.SPECIAL_ITEMS["Military Armory Keycard"].name
    _G.RedCardButton.BackgroundTransparency = _G.itemFilters["Military Armory Keycard"] and 0.5 or 0
end)

-- 蓝卡按钮事件
_G.BlueCardButton.MouseButton1Click:Connect(function()
    _G.itemFilters["Police Armory Keycard"] = not _G.itemFilters["Police Armory Keycard"]
    _G.BlueCardButton.Text = (_G.itemFilters["Police Armory Keycard"] and "启用 " or "移出 ") .. _G.SPECIAL_ITEMS["Police Armory Keycard"].name
    _G.BlueCardButton.BackgroundTransparency = _G.itemFilters["Police Armory Keycard"] and 0.5 or 0
end)

-- 立即换服按钮事件
_G.HopServerButton.MouseButton1Click:Connect(function()
    _G.HopServerButton.Text = "换服中..."
    _G.HopServerButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
    _G.HopServerButton.Active = false
    
    local success = performServerHop()
    if not success then
        task.wait(2)
        _G.HopServerButton.Text = "立即换服"
        _G.HopServerButton.BackgroundColor3 = Color3.new(0, 1, 0)
        _G.HopServerButton.Active = true
    end
end)

-- 模拟移动防止AFK
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

-- 服务器列表相关
local Api = "https://games.roblox.com/v1/games/"
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

-- 主脚本字符串（更新github链接）
local MainScript = [[
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local DataStoreService = game:GetService("DataStoreService")
    local Http = game:GetService("HttpService")  -- 内部声明Http服务
    
    -- 恢复过滤状态
    local playerData = DataStoreService:GetDataStore("PlayerFilters")
    local savedFilters = nil
    pcall(function()
        savedFilters = playerData:GetAsync(LocalPlayer.UserId .. "_filters")
    end)
    if savedFilters then
        _G.itemFilters = savedFilters
    end
    
    -- 更新为新链接
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoling-create/Roblox/refs/heads/main/Starrain%E5%8D%B0%E9%92%9E%E6%9C%BA%E6%B5%8B%E8%AF%95.lua"))()
]]

-- 初始加载时恢复过滤状态
local playerData = game:GetService("DataStoreService"):GetDataStore("PlayerFilters")
local savedFilters = nil
pcall(function()
    savedFilters = playerData:GetAsync(LocalPlayer.UserId .. "_filters")
end)
if savedFilters then
    _G.itemFilters = savedFilters
end

-- 等待无敌状态消失
repeat
    task.wait()
    simulateMovement()
    task.wait(0.01)
until not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("ForceField"))

-- 安全传送函数
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

-- 物品查找与拾取逻辑
local function findAllTargetItems()
    local targetItems = {}
    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Entities") and workspace.Game.Entities:FindFirstChild("ItemPickup") then
        for _, v in ipairs(workspace.Game.Entities.ItemPickup:GetChildren()) do
            local primaryPart = v.PrimaryPart
            if primaryPart then
                local prompt = primaryPart:FindFirstChildOfClass("ProximityPrompt")
                if prompt and table.find(TARGET_ITEMS, prompt.ObjectText) then
                    if _G.itemFilters[prompt.ObjectText] then
                        continue
                    end
                    local isSpecial = _G.SPECIAL_ITEMS[prompt.ObjectText] ~= nil
                    table.insert(targetItems, {
                        part = primaryPart,
                        prompt = prompt,
                        instance = v,
                        type = prompt.ObjectText,
                        isSpecial = isSpecial
                    })
                end
            end
        end
    end
    return targetItems
end

local function collectItem(item, character)
    if _G.itemFilters[item.type] then
        warn("物品已被过滤：" .. item.type)
        return true
    end
    if not character or not item.instance:IsDescendantOf(game) then return true end
    local targetCFrame = item.part.CFrame * CFrame.new(0, 1, -3)
    local success = safeTeleport(targetCFrame, character)
    if not success then return false end
    task.wait(0.5)
    local interactSuccess = pcall(function()
        fireproximityprompt(item.prompt, 1)
    end)
    if interactSuccess then
        task.wait(1)
        return not item.instance:IsDescendantOf(game)
    else
        warn("拾取失败：" .. item.type)
        return false
    end
end

local function main()
    local allItems = findAllTargetItems()
    if #allItems == 0 then
        print("无目标物品，换服...")
        performServerHop()
        return
    end
    local itemCounts = {}
    for _, item in ipairs(allItems) do
        itemCounts[item.type] = (itemCounts[item.type] or 0) + 1
    end
    local countText = {}
    for k, v in pairs(itemCounts) do
        table.insert(countText, k .. "：" .. v .. "个")
    end
    print("发现物品：" .. table.concat(countText, "，"))
    
    local failedItems = {}
    for i, item in ipairs(allItems) do
        if _G.itemFilters[item.type] then continue end
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
    
    if #failedItems > 0 then
        local hasSpecialFailed = false
        for _, item in ipairs(failedItems) do
            if item.isSpecial and not _G.itemFilters[item.type] then
                hasSpecialFailed = true
                break
            end
        end
        if hasSpecialFailed then
            print("特殊物品拾取失败，" .. SPECIAL_ITEM_TIMEOUT .. "秒后换服")
            task.wait(SPECIAL_ITEM_TIMEOUT)
            performServerHop()
            return
        end
        local finalFailed = {}
        for _, item in ipairs(failedItems) do
            if _G.itemFilters[item.type] then continue end
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local success = collectItem(item, character)
            if not success then
                table.insert(finalFailed, item)
            end
        end
        if #finalFailed > 0 then
            print("普通物品拾取失败，" .. NORMAL_ITEM_TIMEOUT .. "秒后换服")
            task.wait(NORMAL_ITEM_TIMEOUT)
            performServerHop()
            return
        end
    end
    
    print("所有物品拾取完成，换服...")
    performServerHop()
end

main()
