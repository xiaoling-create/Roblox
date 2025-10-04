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

-- 特殊物品配置
local SPECIAL_ITEMS = {
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

-- 创建UI（放大版本）
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItemCollectorUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- 按钮容器（放大并移至右侧）
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0, 280, 0, 160)
ButtonContainer.Position = UDim2.new(0.95, -280, 0.5, -80)
ButtonContainer.BackgroundTransparency = 0.8
ButtonContainer.BackgroundColor3 = Color3.new(0, 0, 0)
ButtonContainer.BorderSizePixel = 3
ButtonContainer.BorderColor3 = Color3.new(0.7, 0.7, 0.7)
ButtonContainer.ClipsDescendants = true
ButtonContainer.Parent = ScreenGui

-- 标题（放大文字）
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "物品过滤"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.Parent = ButtonContainer

-- 红卡按钮（放大）
local RedCardButton = Instance.new("TextButton")
RedCardButton.Size = UDim2.new(1, -20, 0, 35)
RedCardButton.Position = UDim2.new(0, 10, 0, 35)
RedCardButton.BackgroundColor3 = SPECIAL_ITEMS["Military Armory Keycard"].color
RedCardButton.TextColor3 = Color3.new(1, 1, 1)
RedCardButton.Font = Enum.Font.Gotham
RedCardButton.TextSize = 16
RedCardButton.Text = "移出 " .. SPECIAL_ITEMS["Military Armory Keycard"].name
RedCardButton.Parent = ButtonContainer

-- 蓝卡按钮（放大）
local BlueCardButton = Instance.new("TextButton")
BlueCardButton.Size = UDim2.new(1, -20, 0, 35)
BlueCardButton.Position = UDim2.new(0, 10, 0, 80)
BlueCardButton.BackgroundColor3 = SPECIAL_ITEMS["Police Armory Keycard"].color
BlueCardButton.TextColor3 = Color3.new(1, 1, 1)
BlueCardButton.Font = Enum.Font.Gotham
BlueCardButton.TextSize = 16
BlueCardButton.Text = "移出 " .. SPECIAL_ITEMS["Police Armory Keycard"].name
BlueCardButton.Parent = ButtonContainer

-- 立即换服按钮（放大）
local HopServerButton = Instance.new("TextButton")
HopServerButton.Size = UDim2.new(1, -20, 0, 35)
HopServerButton.Position = UDim2.new(0, 10, 0, 125)
HopServerButton.BackgroundColor3 = Color3.new(0, 1, 0)
HopServerButton.TextColor3 = Color3.new(1, 1, 1)
HopServerButton.Font = Enum.Font.Gotham
HopServerButton.TextSize = 16
HopServerButton.Text = "立即换服"
HopServerButton.Parent = ButtonContainer

-- 定义全局变量供代码二调用（修复210行变量未定义报错）
_G.itemFilters = itemFilters
_G.RedCardButton = RedCardButton
_G.BlueCardButton = BlueCardButton
_G.HopServerButton = HopServerButton
-- 修复210行报错：声明_place变量（原代码未定义）
local _place = game.PlaceId

-- 修复114行报错：定义performServerHop函数
local function performServerHop()
    local targetServer = getRandomServer()
    if targetServer then
        -- 换服前保存过滤状态到数据存储
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

-- 按钮事件（红卡）
_G.RedCardButton.MouseButton1Click:Connect(function()
    _G.itemFilters["Military Armory Keycard"] = not _G.itemFilters["Military Armory Keycard"]
    _G.RedCardButton.Text = (_G.itemFilters["Military Armory Keycard"] and "启用 " or "移出 ") .. SPECIAL_ITEMS["Military Armory Keycard"].name
    _G.RedCardButton.BackgroundTransparency = _G.itemFilters["Military Armory Keycard"] and 0.5 or 0
end)

-- 按钮事件（蓝卡）
_G.BlueCardButton.MouseButton1Click:Connect(function()
    _G.itemFilters["Police Armory Keycard"] = not _G.itemFilters["Police Armory Keycard"]
    _G.BlueCardButton.Text = (_G.itemFilters["Police Armory Keycard"] and "启用 " or "移出 ") .. SPECIAL_ITEMS["Police Armory Keycard"].name
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

-- 主脚本字符串（包含过滤状态恢复逻辑）
local MainScript = [[
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local DataStoreService = game:GetService("DataStoreService")
    
    -- 恢复换服前的过滤状态
    local playerData = DataStoreService:GetDataStore("PlayerFilters")
    local savedFilters = nil
    pcall(function()
        savedFilters = playerData:GetAsync(LocalPlayer.UserId .. "_filters")
    end)
    if savedFilters then
        _G.itemFilters = savedFilters
    end
    
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

-- 后续逻辑（物品查找、拾取等）与主函数调用...
local function findAllTargetItems()
    -- 保持原有逻辑...
end

local function collectItem(item, character)
    -- 保持原有逻辑...
end

local function main()
    -- 保持原有逻辑...
end

main()
