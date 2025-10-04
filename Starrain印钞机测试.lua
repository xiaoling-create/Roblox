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
    ["Military Armory Keycard"] = {name = "红卡", color = Color3.new(1, 0, 0)},  -- 红卡
    ["Police Armory Keycard"] = {name = "蓝卡", color = Color3.new(0, 0, 1)}      -- 蓝卡
}

-- 物品过滤状态 (true = 不拾取)
local itemFilters = {
    ["Military Armory Keycard"] = false,
    ["Police Armory Keycard"] = false
}

-- 超时配置
local SPECIAL_ITEM_TIMEOUT = 5
local NORMAL_ITEM_TIMEOUT = 180

-- 提前声明换服函数（解决作用域问题）
local performServerHop

-- 创建UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItemCollectorUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- 按钮容器（右侧）
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0, 200, 0, 110)
ButtonContainer.Position = UDim2.new(0.98, -200, 0.5, -55)
ButtonContainer.BackgroundTransparency = 0.8
ButtonContainer.BackgroundColor3 = Color3.new(0, 0, 0)
ButtonContainer.BorderSizePixel = 2
ButtonContainer.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
ButtonContainer.ClipsDescendants = true
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
RedCardButton.Text = "移出 " .. SPECIAL_ITEMS["Military Armory Keycard"].name
RedCardButton.Parent = ButtonContainer

-- 蓝卡按钮
local BlueCardButton = Instance.new("TextButton")
BlueCardButton.Size = UDim2.new(1, -10, 0, 25)
BlueCardButton.Position = UDim2.new(0, 5, 0, 55)
BlueCardButton.BackgroundColor3 = SPECIAL_ITEMS["Police Armory Keycard"].color
BlueCardButton.TextColor3 = Color3.new(1, 1, 1)
BlueCardButton.Font = Enum.Font.Gotham
BlueCardButton.TextSize = 14
BlueCardButton.Text = "移出 " .. SPECIAL_ITEMS["Police Armory Keycard"].name
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

-- 按钮事件
RedCardButton.MouseButton1Click:Connect(function()
    itemFilters["Military Armory Keycard"] = not itemFilters["Military Armory Keycard"]
    RedCardButton.Text = (itemFilters["Military Armory Keycard"] and "启用 " or "移出 ") .. SPECIAL_ITEMS["Military Armory Keycard"].name
    RedCardButton.BackgroundTransparency = itemFilters["Military Armory Keycard"] and 0.5 or 0
end)

BlueCardButton.MouseButton1Click:Connect(function()
    itemFilters["Police Armory Keycard"] = not itemFilters["Police Armory Keycard"]
    BlueCardButton.Text = (itemFilters["Police Armory Keycard"] and "启用 " or "移出 ") .. SPECIAL_ITEMS["Police Armory Keycard"].name
    BlueCardButton.BackgroundTransparency = itemFilters["Police Armory Keycard"] and 0.5 or 0
end)

-- 立即换服按钮事件（修复：使用提前声明的函数）
HopServerButton.MouseButton1Click:Connect(function()
    HopServerButton.Text = "换服中..."
    HopServerButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
    HopServerButton.Active = false  -- 防止重复点击
    
    -- 立即执行换服（使用pcall捕获错误）
    local success, result = pcall(function()
        return performServerHop()
    end)
    if not success or not result then
        warn("换服失败: " .. (result or "未知错误"))
        -- 换服失败时恢复按钮状态
        task.wait(2)
        HopServerButton.Text = "立即换服"
        HopServerButton.BackgroundColor3 = Color3.new(0, 1, 0)
        HopServerButton.Active = true
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

-- 主脚本字符串
local MainScript = [[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoling-create/Roblox/refs/heads/main/Starrain%E5%8D%B0%E9%92%9E%E6%9C%BA%E6%B5%8B%E8%AF%95.lua"))()
]]

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

-- 查找所有目标物品（过滤已禁用的）
local function findAllTargetItems()
    local targetItems = {}
    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Entities") and workspace.Game.Entities:FindFirstChild("ItemPickup") then
        for _, v in ipairs(workspace.Game.Entities.ItemPickup:GetChildren()) do
            local primaryPart = v.PrimaryPart
            if primaryPart then
                local prompt = primaryPart:FindFirstChildOfClass("ProximityPrompt")
                if prompt and table.find(TARGET_ITEMS, prompt.ObjectText) then
                    -- 检查是否被过滤
                    if itemFilters[prompt.ObjectText] then
                        continue  -- 跳过被过滤的物品
                    end
                    
                    -- 标记是否为特殊物品
                    local isSpecial = SPECIAL_ITEMS[prompt.ObjectText] ~= nil
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

-- 拾取物品函数
local function collectItem(item, character)
    -- 检查是否被过滤
    if itemFilters[item.type] then
        warn("物品已被过滤，跳过拾取：" .. item.type)
        return true
    end

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

-- 定义换服函数（在按钮事件之后，解决114行报错）
function performServerHop()
    -- 尝试获取可用服务器（增加错误捕获）
    local targetServer
    local success, err = pcall(function()
        targetServer = getRandomServer()
    end)
    if not success then
        warn("获取服务器失败: " .. err)
        return false
    end
    
    if targetServer then
        -- 尝试传送（增加错误捕获）
        local teleportSuccess, teleportErr = pcall(function()
            queue_on_teleport(MainScript)
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
        end)
        if not teleportSuccess then
            warn("传送失败: " .. teleportErr)
            return false
        end
        return true
    else
        warn("未找到可用服务器")
        return false
    end
end

-- 主逻辑
local function main()
    local allItems = findAllTargetItems()

    -- 无物品时直接换服
    if #allItems == 0 then
        print("未检测到任何目标物品，准备换服...")
        performServerHop()
        return
    end

    -- 统计物品数量
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

    -- 首次拾取循环
    for i, item in ipairs(allItems) do
        -- 跳过已过滤物品
        if itemFilters[item.type] then
            print("跳过已过滤物品：" .. item.type)
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
            else
                table.insert(normalItems, item) 
            end
        else
            table.insert(normalItems, item) 
        end
    end

    -- 处理失败物品
    if #failedItems > 0 then
        print("开始处理标记为失败的物品（共" .. #failedItems .. "个）")
        
        -- 检查是否包含特殊物品
        local hasSpecialFailed = false
        for _, item in ipairs(failedItems) do
            if item.isSpecial and not itemFilters[item.type] then
                hasSpecialFailed = true
                break
            end
        end
        
        -- 如果有特殊物品拾取失败，立即等待超时后换服
        if hasSpecialFailed then
            print("检测到特殊物品拾取失败，" .. SPECIAL_ITEM_TIMEOUT .. "秒后换服：")
            for _, item in ipairs(failedItems) do
                if item.isSpecial and not itemFilters[item.type] then
                    print("- 特殊物品：" .. item.type)
                end
            end
            
            task.wait(SPECIAL_ITEM_TIMEOUT)
            print("特殊物品超时，执行换服...")
            performServerHop()
            return
        end
        
        -- 处理普通失败物品
        local finalFailed = {}
        for i, item in ipairs(failedItems) do
            -- 跳过已过滤物品
            if itemFilters[item.type] then
                print("跳过已过滤的失败物品：" .. item.type)
                continue
            end
            
            print("最后尝试拾取 失败物品 " .. i .. "/" .. #failedItems .. "（" .. item.type .. "）")
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local success = collectItem(item, character)
            
            if not success then
                table.insert(finalFailed, item)
                warn("最终拾取失败：" .. item.type)
            else
                print("失败物品拾取成功：" .. item.type)
            end
        end
        
        -- 普通物品拾取失败，等待超时后换服
        if #finalFailed > 0 then
            print("存在无法拾取的普通物品，" .. NORMAL_ITEM_TIMEOUT .. "秒后换服：")
            for _, item in ipairs(finalFailed) do
                print("- " .. item.type)
            end
            
            task.wait(NORMAL_ITEM_TIMEOUT)
            print("普通物品超时，执行换服...")
            performServerHop()
            return
        end
    end

    -- 所有物品拾取成功，直接换服
    print("所有目标物品已拾取，准备换服...")
    performServerHop()
end

-- 启动主逻辑
main()
