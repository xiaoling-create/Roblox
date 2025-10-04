local Http = game:GetService("HttpService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- 目标物品列表
local TARGET_ITEMS = {
    "Money Printer", "Blue Candy Cane", "Bunny Balloon", "Ghost Balloon", "Clover Balloon",
    "Bat Balloon", "Gold Clover Balloon", "Golden Rose", "Black Rose", "Heart Balloon",
    "Diamond Ring", "Diamond", "Void Gem", "Dark Matter Gem", "Rollie", "NextBot Grenade",
    "Nuclear Missile Launcher", "Suitcase Nuke", "Car", "Helicopter", "Trident", "Golden Cup", 
    "Easter Basket", "Military Armory Keycard", "Treasure Map", "Police Armory Keycard", "Holy Grail"
}

-- 特殊物品（快速换服）
local SPECIAL_ITEMS = {
    "Military Armory Keycard",
    "Police Armory Keycard"
}

-- 配置与状态变量
local config = {
    collectRedCard = true,  -- Military Armory Keycard
    collectBlueCard = true, -- Police Armory Keycard
    isRunning = true
}
local SPECIAL_ITEM_TIMEOUT = 5    -- 特殊物品超时时间
local NORMAL_ITEM_TIMEOUT = 180   -- 普通物品超时时间

-- 创建UI界面
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItemCollectorUI"
ScreenGui.Parent = CoreGui or LocalPlayer.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 按钮创建函数（优化位置到右侧，放大文字）
local function createButton(name, text, position, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = text
    btn.Position = position
    btn.Size = UDim2.new(0, 200, 0, 50)  -- 增大按钮尺寸
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20  -- 放大文字
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.new(0, 0, 0)
    btn.Parent = ScreenGui
    return btn
end

-- 移出红卡按钮 (Military Armory Keycard) - 移至右侧
local removeRedCardBtn = createButton(
    "RemoveRedCard", 
    "移出红卡", 
    UDim2.new(0.8, -200, 0.1, 0),  -- 右侧定位
    Color3.new(0.8, 0.2, 0.2)
)
removeRedCardBtn.MouseButton1Click:Connect(function()
    config.collectRedCard = false
    removeRedCardBtn.Text = "已移出红卡"
    removeRedCardBtn.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    removeRedCardBtn.Active = false
end)

-- 移出蓝卡按钮 (Police Armory Keycard) - 移至右侧
local removeBlueCardBtn = createButton(
    "RemoveBlueCard", 
    "移出蓝卡", 
    UDim2.new(0.8, -200, 0.2, 0),  -- 右侧定位
    Color3.new(0.2, 0.2, 0.8)
)
removeBlueCardBtn.MouseButton1Click:Connect(function()
    config.collectBlueCard = false
    removeBlueCardBtn.Text = "已移出蓝卡"
    removeBlueCardBtn.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    removeBlueCardBtn.Active = false
end)

-- 立即换服按钮 - 移至右侧
local teleportNowBtn = createButton(
    "TeleportNow", 
    "立即换服", 
    UDim2.new(0.8, -200, 0.3, 0),  -- 右侧定位
    Color3.new(0.2, 0.6, 0.2)
)

-- 关闭脚本按钮 - 移至右侧
local stopScriptBtn = createButton(
    "StopScript", 
    "关闭脚本", 
    UDim2.new(0.8, -200, 0.4, 0),  -- 右侧定位
    Color3.new(0.6, 0.2, 0.2)
)
stopScriptBtn.MouseButton1Click:Connect(function()
    config.isRunning = false
    ScreenGui:Destroy()
    warn("脚本已关闭")
end)

-- 模拟移动防止AFK
local function simulateMovement()
    if not config.isRunning then return end
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:Move(Vector3.new(0, 0, 1), true)
        task.wait(0.01)
        humanoid:Move(Vector3.new(0, 0, 0), false)
    end
end

-- 服务器列表相关（修复换服逻辑）
local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"

function ListServers(cursor)
    if not config.isRunning then return nil end
    local url = _servers .. (cursor and "&cursor=" .. cursor or "")
    -- 兼容不同环境的HTTP请求
    local requestFunc = syn and syn.request 
        or http and http.request 
        or (fluxus and fluxus.request) 
        or request
        
    if not requestFunc then
        warn("未找到可用的HTTP请求函数")
        return nil
    end
    
    local success, response = pcall(function()
        return requestFunc({
            Url = url,
            Method = "GET",
            Headers = {["Content-Type"] = "application/json"}
        })
    end)
    
    if not success or not response or not response.Body then
        warn("获取服务器列表失败: " .. (response or "未知错误"))
        return nil
    end
    return Http:JSONDecode(response.Body)
end

local function getRandomServer()
    if not config.isRunning then return nil end
    local Server, Next
    local maxRetries = 3  -- 增加重试机制
    local retryCount = 0
    
    while not Server and retryCount < maxRetries do
        retryCount += 1
        local Servers = ListServers(Next)
        if not Servers then 
            task.wait(2)
            continue 
        end
        
        local validServers = {}
        for _, srv in ipairs(Servers.data) do
            if typeof(srv) == "table" 
                and srv.id ~= game.JobId 
                and srv.playing 
                and srv.playing < srv.maxPlayers 
                and srv.playing > 0  -- 过滤空服务器
            then
                table.insert(validServers, srv)
            end
        end
        
        if #validServers > 0 then
            local randomIndex = math.random(1, #validServers)
            Server = validServers[randomIndex]
        end
        
        Next = Servers.nextPageCursor
        if not Next then break end
    end
    
    return Server
end

-- 主脚本字符串（用于传送后重新执行）
local MainScript = [[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoling-create/Roblox/refs/heads/main/Starrain%E5%8D%B0%E9%92%9E%E6%9C%BA%E6%B5%8B%E8%AF%95.lua"))()
]]

-- 等待无敌状态消失
repeat
    task.wait()
    simulateMovement()
    task.wait(0.01)
until not (config.isRunning and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("ForceField"))
-- 安全传送函数
local function safeTeleport(targetCFrame, character)
    if not config.isRunning then return false end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not humanoid then return false end

    local originalCanCollide = rootPart.CanCollide
    rootPart.CanCollide = false

    local startCFrame = rootPart.CFrame
    local steps = 10
    for i = 1, steps do
        if not config.isRunning then break end
        rootPart.CFrame = startCFrame:Lerp(targetCFrame, i / steps)
        RunService.Heartbeat:Wait()
    end

    rootPart.CanCollide = originalCanCollide
    return true
end

-- 查找所有目标物品（过滤已禁用的物品）
local function findAllTargetItems()
    if not config.isRunning then return {} end
    local targetItems = {}
    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Entities") and workspace.Game.Entities:FindFirstChild("ItemPickup") then
        for _, v in ipairs(workspace.Game.Entities.ItemPickup:GetChildren()) do
            local primaryPart = v.PrimaryPart
            if primaryPart then
                local prompt = primaryPart:FindFirstChildOfClass("ProximityPrompt")
                if prompt and table.find(TARGET_ITEMS, prompt.ObjectText) then
                    -- 根据配置过滤物品
                    local skip = false
                    if prompt.ObjectText == "Military Armory Keycard" and not config.collectRedCard then
                        skip = true
                    elseif prompt.ObjectText == "Police Armory Keycard" and not config.collectBlueCard then
                        skip = true
                    end
                    
                    if not skip then
                        local isSpecial = table.find(SPECIAL_ITEMS, prompt.ObjectText) ~= nil
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
    end
    return targetItems
end

-- 拾取物品函数
local function collectItem(item, character)
    if not config.isRunning then return false end
    if not character then return false end
    if not item.instance:IsDescendantOf(game) then
        return true 
    end

    local targetCFrame = item.part.CFrame * CFrame.new(0, 1, -3)
    local success = safeTeleport(targetCFrame, character)
    if not success then return false end

    task.wait(0.5)
    if not config.isRunning then return false end
    
    local interactSuccess = pcall(function()
        fireproximityprompt(item.prompt, 1)
    end)
    
    if interactSuccess then
        task.wait(1)
        if not config.isRunning then return false end
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

-- 执行换服操作（修复换服逻辑）
local function performServerHop()
    if not config.isRunning then return false end
    print("尝试获取可用服务器...")
    local targetServer = getRandomServer()
    
    -- 若未找到服务器，增加重试机制
    local retryCount = 0
    while not targetServer and retryCount < 3 and config.isRunning do
        retryCount += 1
        warn("未找到服务器，第" .. retryCount .. "次重试...")
        task.wait(3)
        targetServer = getRandomServer()
    end
    
    if targetServer then
        print("找到目标服务器：" .. targetServer.id)
        -- 确保传送前脚本仍在运行
        if config.isRunning then
            queue_on_teleport(MainScript)
            task.wait(1)
            TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
            return true
        end
    else
        warn("多次尝试后仍未找到可用服务器")
        return false
    end
end

-- 绑定立即换服按钮事件
teleportNowBtn.MouseButton1Click:Connect(function()
    if config.isRunning then
        print("用户触发立即换服...")
        performServerHop()
    end
end)

-- 主逻辑
local function main()
    while config.isRunning do
        local allItems = findAllTargetItems()

        -- 无物品时直接换服
        if #allItems == 0 then
            print("未检测到任何目标物品，准备换服...")
            performServerHop()
            task.wait(5)
            continue
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
            if not config.isRunning then break end
            print("正在拾取 " .. i .. "/" .. #allItems .. "（" .. item.type .. "）")
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local success = collectItem(item, character)
            
            if not success then
                warn("首次拾取失败，重试一次：" .. item.type)
                task.wait(2)
                if not config.isRunning then break end
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

        if not config.isRunning then break end

        -- 处理失败物品
        if #failedItems > 0 then
            print("开始处理标记为失败的物品（共" .. #failedItems .. "个）")
            
            -- 检查是否包含特殊物品
            local hasSpecialFailed = false
            for _, item in ipairs(failedItems) do
                if item.isSpecial then
                    hasSpecialFailed = true
                    break
                end
            end
            
            -- 特殊物品拾取失败处理
            if hasSpecialFailed then
                print("检测到特殊物品拾取失败，" .. SPECIAL_ITEM_TIMEOUT .. "秒后换服：")
                for _, item in ipairs(failedItems) do
                    if item.isSpecial then
                        print("- 特殊物品：" .. item.type)
                    end
                end
                
                task.wait(SPECIAL_ITEM_TIMEOUT)
                if config.isRunning then
                    print("特殊物品超时，执行换服...")
                    performServerHop()
                end
                break
            end
            
            -- 处理普通失败物品
            local finalFailed = {}
            for i, item in ipairs(failedItems) do
                if not config.isRunning then break end
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
            
            if not config.isRunning then break end
            
            -- 普通物品拾取失败处理
            if #finalFailed > 0 then
                print("存在无法拾取的普通物品，" .. NORMAL_ITEM_TIMEOUT .. "秒后换服：")
                for _, item in ipairs(finalFailed) do
                    print("- " .. item.type)
                end
                
                task.wait(NORMAL_ITEM_TIMEOUT)
                if config.isRunning then
                    print("普通物品超时，执行换服...")
                    performServerHop()
                end
                break
            end
        end

        if config.isRunning then
            -- 所有物品拾取成功，直接换服
            print("所有目标物品已拾取，准备换服...")
            performServerHop()
        end
        break
    end
end

main()
