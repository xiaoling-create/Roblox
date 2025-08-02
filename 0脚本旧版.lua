local TweenService = game:GetService("TweenService")
local LocalizationService = game:GetService("LocalizationService")
local player = game.Players.LocalPlayer

local result, code = pcall(function()
	return LocalizationService:GetCountryRegionForPlayerAsync(player)
end)

local ScreenGui = Instance.new("ScreenGui")
local MAIN = Instance.new("Frame")
local LOGO = Instance.new("ImageLabel")
local UICorner = Instance.new("UICorner")
local BAR = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local TITLE = Instance.new("TextLabel")
local LOADING = Instance.new("TextLabel")
local WindowStroke = Instance.new("UIStroke")

-- Properties:
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MAIN.Name = "MAIN"
MAIN.Parent = ScreenGui
MAIN.BackgroundColor3 = Color3.fromRGB(4, 4, 4)
MAIN.AnchorPoint = Vector2.new(0.5, 0.5)
MAIN.Position = UDim2.new(0.5, 0, 0.5, 0)
MAIN.Size = UDim2.new(0, 357, 0, 158)

WindowStroke.Name = "WindowStroke"
WindowStroke.Parent = MAIN
WindowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
WindowStroke.Color = Color3.fromRGB(255, 255, 255) -- 初始颜色
WindowStroke.LineJoinMode = Enum.LineJoinMode.Round
WindowStroke.Thickness = 2
WindowStroke.Transparency = 0
WindowStroke.Enabled = true

LOGO.Name = "LOGO"
LOGO.Parent = MAIN
LOGO.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LOGO.BackgroundTransparency = 1.000
LOGO.Position = UDim2.new(-0.0323287919, 0, -0.079336822, 0)
LOGO.Size = UDim2.new(0, 162, 0, 160)
LOGO.Image = "rbxassetid://11354741327"

UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = MAIN

BAR.Name = "BAR"
BAR.Parent = MAIN
BAR.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- 初始颜色
BAR.BorderSizePixel = 0
BAR.Position = UDim2.new(0.106, 0, 0.835, 0)
BAR.Size = UDim2.new(0, 0, 0, 15)

UICorner_2.Parent = BAR

TITLE.Name = "TITLE"
TITLE.Parent = MAIN
TITLE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TITLE.BackgroundTransparency = 1.000
TITLE.Position = UDim2.new(0.403277725, 0, 0.0506329127, 0)
TITLE.Size = UDim2.new(0, 169, 0, 44)
TITLE.Font = Enum.Font.Highway
TITLE.Text = "零脚本 V1"
TITLE.TextColor3 = Color3.fromRGB(255, 255, 255)
TITLE.TextScaled = true
TITLE.TextSize = 14.000
TITLE.TextWrapped = true

LOADING.Name = "加载中"
LOADING.Parent = MAIN
LOADING.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LOADING.BackgroundTransparency = 1.000
LOADING.Position = UDim2.new(0.378, 0, 0.43, 0)
LOADING.Size = UDim2.new(0, 169, 0, 44)
LOADING.Font = Enum.Font.SourceSansItalic
LOADING.Text = "作者小零"
LOADING.TextColor3 = Color3.fromRGB(255, 255, 255)
LOADING.TextSize = 20.000
LOADING.TextWrapped = true

-- 彩虹边框效果
local function rainbowStroke()
    local hue = 0
    while MAIN and MAIN.Parent do
        hue = (hue + 0.01) % 1
        WindowStroke.Color = Color3.fromHSV(hue, 1, 1) -- 彩虹边框
        wait()
    end
end

-- 启动彩虹边框效果
coroutine.wrap(rainbowStroke)()

-- 彩虹进度条效果
local function rainbowBar()
    local hue = 0
    while BAR and BAR.Parent do
        hue = (hue + 0.01) % 1
        BAR.BackgroundColor3 = Color3.fromHSV(hue, 1, 1) -- 彩虹进度条
        wait()
    end
end

-- 启动彩虹进度条效果
coroutine.wrap(rainbowBar)()

-- 彩虹文字效果
local function rainbowText()
    local hue = 0
    while TITLE and TITLE.Parent do
        hue = (hue + 0.01) % 1
        TITLE.TextColor3 = Color3.fromHSV(hue, 1, 1) -- 彩虹标题
        LOADING.TextColor3 = Color3.fromHSV(hue, 1, 1) -- 彩虹加载文字
        wait()
    end
end

-- 启动彩虹文字效果
coroutine.wrap(rainbowText)()

-- 加载动画
wait(1)
LOADING.Text = "V1版本"
BAR:TweenSize(UDim2.new(0, 150, 0, 15), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
wait(1)
LOADING.Text = "你好 " .. game.Players.LocalPlayer.DisplayName .. " 来自: " .. (code or "未知")
BAR:TweenSize(UDim2.new(0, 200, 0, 15), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
wait(1)
LOADING.Text = "检查游戏..."
BAR:TweenSize(UDim2.new(0, 250, 0, 15), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
wait(1)
LOADING.Text = "欢迎使用主脚本"
BAR:TweenSize(UDim2.new(0, 260, 0, 15), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
wait(1)
LOADING.Text = "零启动！"
BAR:TweenSize(UDim2.new(0, 285, 0, 15), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
wait(1)
MAIN:TweenSize(UDim2.new(0, 0, 0, 5), "Out", "Quad", 1, true)
LOGO:Destroy()
TITLE:Destroy()
LOADING:Destroy()
BAR:Destroy()
wait(1)
MAIN:Destroy()

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/xiaoling-create/UI/refs/heads/main/%E9%9B%B6%E8%84%9A%E6%9C%ACUi.txt'))()
local Window = Library:new("零脚本")

local creds = Window:Tab("公告",'126183273159066')
local about = creds:section("信息",true)

about:Label("账号年龄:"..game.Players.LocalPlayer.AccountAge.."天")

about:Label("服务器id:"..game.GameId)

about:Label("用户id:"..game.Players.LocalPlayer.UserId)

about:Label("客户端id:"..game:GetService("RbxAnalyticsService"):GetClientId())

about:Label("注入器:"..identifyexecutor())

about:Label("用户名:"..game.Players.LocalPlayer.Character.Name)

about:Label("服务器名称:"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)

local about = creds:section("作者",true)

about:Label("作者小零")
about:Label("作者qq1707182940")
about:Label("正在努力优化")
about:Label("请勿倒卖")
about:Button("复制作者QQ", function()
    setclipboard("1707182940")
end)
about:Button("复制QQ群", function()
    setclipboard("https://qm.qq.com/q/Bnttbp66ha")
end)
about:Button("复制DC", function()
    setclipboard("https://discord.com/invite/3jf4wkuMtJ")
end)
about:Button("复制QQ频道", function()
    setclipboard("https://pd.qq.com/s/gdle0l6hp?b=9")
end)

local EN = Window:Tab("作者通告",'126183273159066')
local about = EN:section("玩家公告!",true)

about:Label("帮助者名单：")
about:Label("神青脚本作者")
about:Label("苏脚本作者")
about:Label("星海脚本作者")
about:Label("后续会缓慢更新")
about:Label("要什么服务器请投稿")
about:Label("前往q群或频道投稿")
about:Label("缝合不收费")
about:Label("支持我越有动力")
about:Label("谢谢您使用了我的脚本")

local Main = Window:Tab("主要",'126183273159066')
local about = Main:section("玩家",true)

about:Slider("步行速度!", "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 16, 400, false, function(Speed)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed end end)
end)
about:Slider("跳跃高度!", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 50, 400, false, function(Jump)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump end end)
end)
about:Textbox("重力设置!", "Gravity", "输入", function(Gravity)
  spawn(function() while task.wait() do game.Workspace.Gravity = Gravity end end)
end)
about:Toggle("夜视", "Light", false, function(Light)
  spawn(function() while task.wait() do if Light then game.Lighting.Ambient = Color3.new(1, 1, 1) else game.Lighting.Ambient = Color3.new(0, 0, 0) end end end)
end)
about:Button("透视", function()
  local Players = game:GetService("Players"):GetChildren() local RunService = game:GetService("RunService") local highlight = Instance.new("Highlight") highlight.Name = "Highlight" for i, v in pairs(Players) do repeat wait() until v.Character if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then local highlightClone = highlight:Clone() highlightClone.Adornee = v.Character highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart") highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop highlightClone.Name = "Highlight" end end game.Players.PlayerAdded:Connect(function(player) repeat wait() until player.Character if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then local highlightClone = highlight:Clone() highlightClone.Adornee = player.Character highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart") highlightClone.Name = "Highlight" end end) game.Players.PlayerRemoving:Connect(function(playerRemoved) playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy() end) RunService.Heartbeat:Connect(function() for i, v in pairs(Players) do repeat wait() until v.Character if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then local highlightClone = highlight:Clone() highlightClone.Adornee = v.Character highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart") highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop highlightClone.Name = "Highlight" task.wait() end end end)
end)
about:Button("隐身道具", function()
  loadstring(game:HttpGet("https://gist.githubusercontent.com/skid123skidlol/cd0d2dce51b3f20ad1aac941da06a1a1/raw/f58b98cce7d51e53ade94e7bb460e4f24fb7e0ff/%257BFE%257D%2520Invisible%2520Tool%2520(can%2520hold%2520tools)",true))()
end)
about:Toggle("穿墙(可用)", "NoClip", false, function(NC)
  local Workspace = game:GetService("Workspace") local Players = game:GetService("Players") if NC then Clipon = true else Clipon = false end Stepped = game:GetService("RunService").Stepped:Connect(function() if not Clipon == false then for a, b in pairs(Workspace:GetChildren()) do if b.Name == Players.LocalPlayer.Name then for i, v in pairs(Workspace[Players.LocalPlayer.Name]:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end end else Stepped:Disconnect() end end)
end)

local about = Main:section("通用",true)

about:Button("最强透视",function()
  loadstring(game:HttpGet("https://pastebin.com/raw/uw2P2fbY"))()
end)
about:Button("飞行v3",function()
  loadstring(game:HttpGet'https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt')()
end)
about:Button("甩人",function()
  loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end)
about:Button("反挂机v2",function()
  loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
end)
about:Button("铁拳",function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)
about:Button("键盘",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"))()
end)
about:Button("动画中心",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
end)
about:Button("立即死亡",function()
  game.Players.LocalPlayer.Character.Humanoid.Health=0
end)
about:Button("爬墙",function()
  loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)
about:Button("转起来",function()
  loadstring(game:HttpGet('https://pastebin.com/raw/r97d7dS0', true))()
end)
about:Button("子弹追踪",function()
  loadstring(game:HttpGet("https://pastebin.com/raw/1AJ69eRG"))()
end)
about:Button("飞车",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/63T0fkBm"))()
end)
about:Button("吸人",function()
    loadstring(game:HttpGet("https://shz.al/~HHAKS"))()
end)
about:Button("无限跳跃",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
end)

local about = Main:section("ESP",true)

about:Toggle("人物显示", "RWXS", false, function(RWXS)
    getgenv().enabled = RWXS getgenv().filluseteamcolor = true getgenv().outlineuseteamcolor = true getgenv().fillcolor = Color3.new(1, 0, 0) getgenv().outlinecolor = Color3.new(1, 1, 1) getgenv().filltrans = 0.5 getgenv().outlinetrans = 0.5 loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/Highlight-ESP.lua"))()
end)

local about = Main:section("其他",true)

about:Button("死亡笔记", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/krlpl/dfhj/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0.txt"))()
end)
about:Button("纳西妲", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rbxluau/Roblox/main/ScriptHub.lua"))()
end)
about:Button("JM传送", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoling-create/JM/refs/heads/main/JM%E4%BC%A0%E9%80%81.lua"))()
end)

local JSDGt = Window:Tab("驾驶帝国",'126183273159066')
local about = JSDGt:section("自动&刷钱",true)

about:Button("自动刷钱", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/cool83birdcarfly02six/Lightux/main/README.md'),true))()
end)

local FMDHt = Window:Tab("伐木大亨2",'126183273159066')
local about = FMDHt:section("伐木大亨2",true)

about:Button("伐木大亨2", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/LuaWareLoader.lw/main/luawareloader.wtf"))()
end)

local SKQSt = Window:Tab("鲨口求生2",'126183273159066')
local about = SKQSt:section("鲨口&求生",true)

about:Dropdown("船只提取器", "FreeBoat", {"不知道怎么汉化", "不知道怎么汉化", "摩托艇", "摩托艇", "独角兽挺", "摩托艇", "红马林鱼", "单栀帆船", "拖船", "小船摩托艇", "摩托艇甜甜圈", "马林鱼", "管船", "渔船", "维京船", "SmallWoodenSailboat", "RedCanopyMotorboat", "Catamaran", "CombatBoat", "TourBoat", "Duckmarine", "PartyBoat", "MilitarySubmarine", "GingerbreadSteamBoat", "Sleigh2022", "Snowmobile", "CruiseShip"}, function(CS)
  game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat:FireServer(CS)
end)
about:Button("自动杀鲨鱼🦈", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndlerScripts/RobloxScripts/main/Misc%20Scripts/sharkbite2.lua",true))()
end)

local DoorsT = Window:Tab("doors",'126183273159066')
local about = DoorsT:section("通用&功能",true)

about:Button("NBDoors", function()
  loadstring(game:HttpGet("https://github.com/DocYogurt/DOORS/raw/main/Loader.lua"))()
end)
about:Button("AND已汉化 推荐配合穿墙", function()
  loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end)
about:Button("穿墙(无拉回)", function()
  loadstring(game:HttpGet("https://github.com/DXuwu/OK/raw/main/clip"))()
end)
about:Button("MS DOORS",function()
      loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/poopdoors_edited/main/poopdoors_edited.lua"),true))()
end)
about:Button("DOORS目前好用的",function()
loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end)
about:Button("自动过rooms",function()
 loadstring(game:HttpGet('\x68\x74\x74\x70\x73\x3A\x2F\x2F\x68\x2E\x6C\x6B\x6D\x63\x2E\x61\x73\x69\x61\x2F\x73\x63\x72\x69\x70\x74\x2F\x64\x6F\x6F\x72\x73\x72\x6F\x6F\x6D\x2E\x6C\x75\x61'))()
end)
about:Button("rooms自动行走", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/DaRealGeo/roblox/master/rooms-autowalk"))()
end)
about:Button("十字架", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/FCSyG6Th"))();
end)
about:Button("夜视仪", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/4Vsv1Xwn"))()
end)
about:Button("神圣炸弹", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/u5B1UjGv"))()
end)
about:Button("吸铁石", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/xHxGDp51"))()
end)
about:Button("剪刀", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/v2yEJYmu"))()
end)
about:Button("可以清除东西的枪",function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Laser%20Gun"))()
end)

local about = DoorsT:section("其他",true)

about:Toggle("刷新时通知", "TZ", false, function(TZ)
     _G.IE = (TZ and true or false) LatestRoom.Changed:Connect(function() if _G.IE == true then local n = ChaseStart.Value - LatestRoom.Value if 0 < n and n < 4 then Notification:Notify("请注意", "事件可能刷新于" .. tostring(n) .. " 房间","rbxassetid://17360377302",3) end end end) workspace.ChildAdded:Connect(function(inst) if inst.Name == "RushMoving" and _G.IE == true then Notify("请注意", "Rush 已刷新","rbxassetid://17360377302",3) elseif inst.Name == "AmbushMoving" and _G.IE == true then Notify("请注意", "Ambush 已刷新","rbxassetid://17360377302",3) end end)
end)
about:Toggle("自动躲避Rush/Ambush", "ADB", false, function(ADB)
    _G.Avoid = (ADB and true or false) workspace.ChildAdded:Connect(function(inst) if inst.Name == "RushMoving" and _G.Avoid == true then Notify("请注意!", "正在躲避 Rush.","rbxassetid://17360377302",3) local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position local con = game:GetService("RunService").Heartbeat:Connect(function() game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0)) end) inst.Destroying:Wait() con:Disconnect() game.Players.LocalPlayer.Character:MoveTo(OldPos) elseif inst.Name == "AmbushMoving" and _G.Avoid == true then Notify("注意!", "正在躲避 Ambush.","rbxassetid://17360377302",3) local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position local con = game:GetService("RunService").Heartbeat:Connect(function() game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0)) end) inst.Destroying:Wait() con:Disconnect() game.Players.LocalPlayer.Character:MoveTo(OldPos) end end)
end)
about:Toggle("无 Screech", "NCH", false, function(NCH)
    _G.NS = (NCH and true or false) workspace.CurrentCamera.ChildAdded:Connect(function(child) if child.Name == "Screech" and _G.NS == true then child:Destroy() end end)
end)

local LLCQt = Window:Tab("力量传奇",'126183273159066')
local about = LLCQt:section("主要&功能",true)

about:Toggle("自动比赛开关", "AR", false, function(AR)
  while AR do wait() wait(2) game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl") end
end)
about:Toggle("自动举哑铃", "ATYL", false, function(ATYL)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATYL do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Weight" then v.Parent = game.Players.LocalPlayer.Character end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end
end)
about:Toggle("自动俯卧撑", "ATFWC", false, function(ATFWC)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATFWC do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Pushups" then v.Parent = game.Players.LocalPlayer.Character end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end
end)
about:Toggle("自动仰卧起坐", "ATYWQZ", false, function(ATYWQZ)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATYWQZ do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Situps" then v.Parent = game.Players.LocalPlayer.Character end end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end)
about:Toggle("自动倒立身体", "ATDL", false, function(ATDL)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATDL do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Handstands" then v.Parent = game.Players.LocalPlayer.Character end end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end)
about:Toggle("自动锻炼", "ATAAA", false, function(ATAAA)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true while ATAAA do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Handstands" or v.Name == "Situps" or v.Name == "Pushups" or v.Name == "Weight" then v:FindFirstChildOfClass("NumberValue").Value = 0 repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end end end
end)

local about = LLCQt:section("自动收集",true)

about:Toggle("自动重生", "ATRE", false, function(ATRE)
  while ATRE do wait() game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest") end
end)
about:Button("收集宝石", function()
  jk = {} for _, v in pairs(game:GetService("ReplicatedStorage").chestRewards:GetDescendants()) do if v.Name ~= "Light Karma Chest" or v.Name ~= "Evil Karma Chest" then table.insert(jk, v.Name) end end for i = 1, #jk do wait(2) game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(jk[i]) end
end)

local about = LLCQt:section("跑步机",true)

about:Toggle("沙滩跑步机10", "PPJ10", false, function(PPJ10)
    getgenv().PPJ10 = PPJ10 while getgenv().PPJ10 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(238.671112, 5.40315914, 387.713165, -0.0160072874, -2.90710176e-08, -0.99987185, -3.3434191e-09, 1, -2.90212157e-08, 0.99987185, 2.87843993e-09, -0.0160072874) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end if not getgenv().PPJ10 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
about:Toggle("健身房跑步机2000", "PPJ2000", false, function(PPJ2000)
    if game.Players.LocalPlayer.Agility.Value >= 2000 then getgenv().PPJ2000 = PPJ2000 while getgenv().PPJ2000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-3005.37866, 14.3221855, -464.697876, -0.015773816, -1.38508964e-08, 0.999875605, -5.13225586e-08, 1, 1.30429667e-08, -0.999875605, -5.11104332e-08, -0.015773816) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().PPJ2000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
about:Toggle("神话健身房跑步机2000", "SHPPJ2000", false, function(SHPPJ2000)
    if game.Players.LocalPlayer.Agility.Value >= 2000 then getgenv().SHPPJ2000 = SHPPJ2000 while getgenv().SHPPJ2000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2571.23706, 15.6896839, 898.650391, 0.999968231, 2.23868635e-09, -0.00797206629, -1.73198844e-09, 1, 6.35660768e-08, 0.00797206629, -6.3550246e-08, 0.999968231) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().SHPPJ2000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
about:Toggle("永恒健身房跑步机3500", "YHPPJ3500", false, function(YHPPJ3500)
    if game.Players.LocalPlayer.Agility.Value >= 3500 then getgenv().YHPPJ3500 = YHPPJ3500 while getgenv().YHPPJ3500 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7077.79102, 29.6702118, -1457.59961, -0.0322036594, -3.31122768e-10, 0.99948132, -6.44344267e-09, 1, 1.23684493e-10, -0.99948132, -6.43611742e-09, -0.0322036594) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().YHPPJ3500 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
about:Toggle("传奇健身房跑步机3000", "CQPPJ3000", false, function(CQPPJ3000)
    if game.Players.LocalPlayer.Agility.Value >= 3000 then getgenv().CQPPJ3000 = CQPPJ3000 while getgenv().CQPPJ3000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4370.82812, 999.358704, -3621.42773, -0.960604727, -8.41949266e-09, -0.27791819, -6.12478646e-09, 1, -9.12496567e-09, 0.27791819, -7.06329528e-09, -0.960604727) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().CQPPJ3000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)

local about = LLCQt:section("岩石",true)

about:Toggle("石头0", "RK0", false, function(RK0)
    getgenv().RK0 = RK0 while getgenv().RK0 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(7.60643005, 4.02632904, 2104.54004, -0.23040159, -8.53662385e-08, -0.973095655, -4.68743764e-08, 1, -7.66279342e-08, 0.973095655, 2.79580536e-08, -0.23040159) end if not getgenv().RK0 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end
end)
about:Toggle("石头10", "RK10", false, function(RK10)
    if game.Players.LocalPlayer.Durability.Value >= 10 then getgenv().RK10 = RK10 while getgenv().RK10 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-157.680908, 3.72453046, 434.871185, 0.923298299, -1.81774684e-09, -0.384083599, 3.45247031e-09, 1, 3.56670582e-09, 0.384083599, -4.61917082e-09, 0.923298299) end if not getgenv().RK10 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
about:Toggle("石头100", "RK100", false, function(RK100)
    if game.Players.LocalPlayer.Durability.Value >= 100 then getgenv().RK100 = RK100 while getgenv().RK100 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(162.233673, 3.66615629, -164.686783, -0.921312928, -1.80826774e-07, -0.38882193, -9.13036544e-08, 1, -2.48719346e-07, 0.38882193, -1.93647494e-07, -0.921312928) end if not getgenv().RK100 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
about:Toggle("石头5000", "RK5000", false, function(RK5000)
    if game.Players.LocalPlayer.Durability.Value >= 5000 then getgenv().RK5000 = RK5000 while getgenv().RK5000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(329.831482, 3.66450214, -618.48407, -0.806075394, -8.67358096e-08, 0.591812849, -1.05715522e-07, 1, 2.57029176e-09, -0.591812849, -6.04919563e-08, -0.806075394) end if not getgenv().RK5000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
about:Toggle("石头150000", "RK150000", false, function(RK150000)
    if game.Players.LocalPlayer.Durability.Value >= 150000 then getgenv().RK150000 = RK150000 while getgenv().RK150000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-2566.78076, 3.97019577, -277.503235, -0.923934579, -4.11600105e-08, -0.382550538, -3.38838042e-08, 1, -2.57576183e-08, 0.382550538, -1.08360858e-08, -0.923934579) end if not getgenv().RK150000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
about:Toggle("石头400000", "RK400000", false, function(RK400000)
    if game.Players.LocalPlayer.Durability.Value >= 400000 then getgenv().RK400000 = RK400000 while getgenv().RK400000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2155.61743, 3.79830337, 1227.06482, -0.551303148, -9.16796949e-09, -0.834304988, -5.61318245e-08, 1, 2.61027839e-08, 0.834304988, 6.12216127e-08, -0.551303148) end if not getgenv().RK400000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
about:Toggle("石头750000", "RK750000", false, function(RK750000)
    if game.Players.LocalPlayer.Durability.Value >= 750000 then getgenv().RK750000 = RK750000 while getgenv().RK750000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7285.6499, 3.66624784, -1228.27417, 0.857643783, -1.58175091e-08, -0.514244199, -1.22581563e-08, 1, -5.12025977e-08, 0.514244199, 5.02172774e-08, 0.857643783) end if not getgenv().RK750000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
about:Toggle("石头100万", "RK1M", false, function(RK1M)
    if game.Players.LocalPlayer.Durability.Value >= 1000000 then getgenv().RK1M = RK1M while getgenv().RK1M do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4160.87109, 987.829102, -4136.64502, -0.893115997, 1.25481356e-05, 0.44982639, 5.02490684e-06, 1, -1.79187136e-05, -0.44982639, -1.37431543e-05, -0.893115997) end if not getgenv().RK1M then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
about:Toggle("石头500万", "RK5M", false, function(RK5M)
    if game.Players.LocalPlayer.Durability.Value >= 5000000 then getgenv().RK5M = RK5M while getgenv().RK5M do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-8957.54395, 5.53625107, -6126.90186, -0.803919137, 6.6065212e-08, 0.594738603, -8.93136143e-09, 1, -1.23155459e-07, -0.594738603, -1.04318865e-07, -0.803919137) end if not getgenv().RK5M then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)

local about = LLCQt:section("传送位置",true)

about:Toggle("安全地方", "TP-PLACE", false, function(Place)
  if Place then getgenv().place = true while getgenv().place do wait() game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-51.6716728, 32.2157211, 1290.41211, 0.9945544, 1.23613528e-08, -0.104218982, -7.58742402e-09, 1, 4.62031657e-08, 0.104218982, -4.51608102e-08, 0.9945544) end else getgenv().place = false wait() game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-34.1635208, 3.67689133, 219.640869, 0.599920511, -2.24152163e-09, 0.800059617, 4.46125981e-09, 1, -5.43559087e-10, -0.800059617, 3.89536625e-09, 0.599920511) end
end)
about:Button("传送到出生点", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7, 3, 108)
end)
about:Button("传送到冰霜健身房", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2543, 13, -410)
end)
about:Button("传送到神话健身房", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2177, 13, 1070)
end)
about:Button("传送到永恒健身房", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6686, 13, -1284)
end)
about:Button("传送到传说健身房", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4676, 997, -3915)
end)
about:Button("传送到肌肉之王健身房", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8554, 22, -5642)
end)
about:Button("传送到安全岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, 10, 1838)
end)
about:Button("传送到幸运抽奖区域", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2606, -2, 5753)
end)

local JSCQt = Window:Tab("极速传奇",'126183273159066')
local about = JSCQt:section("自动&玩家",true)

about:Toggle("自动重生", "ARS", false, function(ARS)
    if ARS then _G.loop = true while _G.loop == true do wait() game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest") end else _G.loop = false end
end)
about:Button("自动重生和自动刷等级", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/T9wTL150"))()
end)
about:Button("反踢出", function()
    local vu = game:GetService("VirtualUser") game:GetService("Players").LocalPlayer.Idled:connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) wait(1) vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end)
end)

local about = JSCQt:section("传送位置",true)

about:Button("城市", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-559.2, -7.45058e-08, 417.4))
end)
about:Button("雪城", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-858.358, 0.5, 2170.35))
end)
about:Button("岩浆城", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(1707.25, 0.550008, 4331.05))
end)
about:Button("公路传奇", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(3594.68, 214.804, 7274.56))
end)

local RZCQt = Window:Tab("忍者传奇",'126183273159066')
local about = RZCQt:section("自动&模式",true)

about:Toggle("自动挥舞", "ATHW", false, function(ATHW)
    if v or not ATHW then getgenv().autoswing = ATHW while true do if not getgenv().autoswing then return end for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:FindFirstChild("ninjitsuGain") then game.Players.LocalPlayer.Character.Humanoid:EquipTool(v) break end end local A_1 = "swingKatana" local Event = game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(A_1) wait() end end
end)
about:Toggle("自动售卖", "ATSELL", false, function(ATSELL)
    getgenv().autosell = ATSELL while true do if not getgenv().autosell then return end game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame wait(0.1) game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = CFrame.new(0,0,0) wait(0.1) end
end)
about:Toggle("自动购买排名", "ATBP", false, function(ATBP)
    getgenv().autobuyranks = ATBP while true do if not getgenv().autobuyranks then return end local deku1 = "buyRank" for i = 1, #ranks do game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(deku1, ranks[i]) end wait(0.1) end
end)
about:Toggle("自动购买腰带", "ATBYD", false, function(ATBYD)
    getgenv().autobuybelts = ATBYD while true do if not getgenv().autobuybelts then return end local A_1 = "buyAllBelts" local A_2 = "Inner Peace Island" local Event = game:GetService("Players").LocalPlayer.ninjaEvent Event:FireServer(A_1, A_2) wait(0.5) end
end)
about:Toggle("自动购买技能", "ATB", false, function(ATB)
    getgenv().autobuyskills = ATB while true do if not getgenv().autobuyskills then return end local A_1 = "buyAllSkills" local A_2 = "Inner Peace Island" local Event = game:GetService("Players").LocalPlayer.ninjaEvent Event:FireServer(A_1, A_2) wait(0.5) end
end)
about:Toggle("自动购买剑", "ATBS", false, function(ATBS)
    getgenv().autobuy = ATBS while true do if not getgenv().autobuy then return end local A_1 = "buyAllSwords" local A_2 = "Inner Peace Island" local Event = game:GetService("Players").LocalPlayer.ninjaEvent Event:FireServer(A_1, A_2) wait(0.5) end
end)
about:Button("解锁所有岛", function()
  for _, v in next, game.workspace.islandUnlockParts:GetChildren() do if v then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.islandSignPart.CFrame wait(.5) end end
end)

local about = RZCQt:section("传送位置",true)

about:Button("传送到出生点", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(25.665502548217773, 3.4228405952453613, 29.919952392578125)
end)
about:Button("传送到附魔岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(51.17238235473633, 766.1807861328125, -138.44842529296875)
end)
about:Button("传送到神秘岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171.97178649902344, 4047.380859375, 42.0699577331543)
end)
about:Button("传送到太空岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.83824157714844, 5657.18505859375, 73.5014877319336)
end)
about:Button("传送到冻土岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139.28330993652344, 9285.18359375, 77.36406707763672)
end)
about:Button("传送到永恒岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(149.34817504882812, 13680.037109375, 73.3861312866211)
end)
about:Button("传送到沙暴岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(133.37144470214844, 17686.328125, 72.00334167480469)
end)
about:Button("传送到雷暴岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(143.19349670410156, 24070.021484375, 78.05432891845703)
end)
about:Button("传送到远古炼狱岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.27163696289062, 28256.294921875, 69.3790283203125)
end)
about:Button("传送到午夜暗影岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(132.74267578125, 33206.98046875, 57.495574951171875)
end)
about:Button("传送到神秘灵魂岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.76148986816406, 39317.5703125, 61.06639862060547)
end)
about:Button("传送到冬季奇迹岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.2720184326172, 46010.5546875, 55.941951751708984)
end)
about:Button("传送到黄金大师岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(128.32339477539062, 52607.765625, 56.69411849975586)
end)
about:Button("传送到龙传奇岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(146.35226440429688, 59594.6796875, 77.53300476074219)
end)
about:Button("传送到赛博传奇岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.3321075439453, 66669.1640625, 72.21722412109375)
end)
about:Button("传送到天岚超能岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.48077392578125, 70271.15625, 57.02311325073242)
end)
about:Button("传送到混沌传奇岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)
end)
about:Button("传送到混沌传奇岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)
end)
about:Button("传送到灵魂融合岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(136.9700927734375, 79746.984375, 58.54051971435547)
end)
about:Button("传送到黑暗元素岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.697265625, 83198.984375, 72.73107147216797)
end)
about:Button("传送到内心和平岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.3157501220703, 87051.0625, 66.78429412841797)
end)
about:Button("传送到炽烈漩涡岛", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.08216857910156, 91246.0703125, 69.56692504882812)
end)
about:Button("传送到35倍金币区域", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86.2938232421875, 91245.765625, 120.54232788085938)
end)
about:Button("传送到死亡宠物", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4593.21337890625, 130.87181091308594, 1430.2239990234375)
end)

local JYRSt = Window:Tab("监狱人生",'126183273159066')
local about = JYRSt:section("整合",true)

about:Button("落叶监狱人生", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/uDs9bhc8"))()
end)

local about = JYRSt:section("监狱&主要",true)

about:Button("无敌模式", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/LdTVujTA"))()
end)
about:Button("杀死所有人", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/kXjfpFPh"))()
end)
about:Button("手里剑（秒杀）", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/mSLiAZHk"))()
end)
about:Button("变钢铁侠", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/7prijqYH"))()
end)
about:Button("变死神", function()
  loadstring(game:HttpGet("https://pastebin.com/ewv9bbRp"))()
end)
about:Button("变车模型", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/zLe3e4BS"))()
end)

local about = JYRSt:section("身份",true)

about:Button("变成警察", function()
    workspace.Remote.TeamEvent:FireServer("Bright blue");
end)
about:Button("变成囚犯", function()
    workspace.Remote.TeamEvent:FireServer("Bright orange");
end)

local about = JYRSt:section("其他",true)

about:Toggle("杀死光环", "SSGH", false, function(SSGH)
    States.KillAura = SSGH if state then print("Kill Aura On") CreateKillPart() else print("Kill Aura Off") if Parts[1] and Parts[1].Name == "KillAura" then Parts[1]:Destroy() Parts[1] = nil end end end) function CreateKillPart() if Parts[1] then pcall(function() Parts[1]:Destroy() end) Parts[1] = nil end local Part = Instance.new("Part",plr.Character) local hilight = Instance.new("Highlight",Part) hilight.FillTransparency = 1 Part.Anchored = true Part.CanCollide = false Part.CanTouch = false Part.Material = Enum.Material.SmoothPlastic Part.Transparency = .98 Part.Material = Enum.Material.SmoothPlastic Part.BrickColor = BrickColor.White() Part.Size = Vector3.new(20,2,20) Part.Name = "KillAura" Parts[1] = Part end task.spawn(function() repeat task.wait()until plr.Character and char and char:FindFirstChildOfClass("Humanoid") if States.KillAura then CreateKillPart() end end) game:GetService("RunService").Stepped:Connect(function() if States.KillAura then for i,v in pairs(game.Players:GetPlayers()) do if v ~= game.Players.LocalPlayer then if (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude <14 and v.Character.Humanoid.Health >0 then local args = {[1] = v} for i =1,2 do task.spawn(function() game:GetService("ReplicatedStorage").meleeEvent:FireServer(unpack(args)) end) end end end end end
end)

local about = JYRSt:section("传送地点",true)

about:Button("传送警卫室", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875)
end)
about:Button("传送监狱室内", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875)
end)
about:Button("传送罪犯复活点", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875)
end)
about:Button("传送监狱室外", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)
end)
about:Button("传送院子", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(788.5759887695312, 97.99992370605469, 2455.056640625)
end)
about:Button("传送警车库", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(602.7301635742188, 98.20000457763672, 2503.56982421875)
end)
about:Button("传送死人下水道", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.4256591796875, 78.69828033447266, 2416.18359375)
end)
about:Button("传送食堂", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(921.0059204101562, 99.98993682861328, 2289.23095703125)
end)

local ZDYSt = Window:Tab("战斗勇士",'126183273159066')
local about = ZDYSt:section("主要",true)

about:Button("弓箭爆头", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/6RQGbFqD"))()
end)

local HBTXt = Window:Tab("河北唐县",'126183273159066')
local about = HBTXt:section("主的",true)

about:Label("请成成为快递员，才能自动刷钱")
about:Toggle("自动刷钱", "AM", false, function(AM)
    local virtualUser = game:GetService('VirtualUser') virtualUser:CaptureController() function teleportTo(CFrame) game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame end _G.autoFarm = false function autoFarm() while _G.autoFarm do fireclickdetector(game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector) task.wait(2.2) for _,point in pairs(game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()) do if point.Locate.Locate.Enabled then teleportTo(point.CFrame) end end task.wait(0) end end
end)
about:Button("河北唐县卡车刷钱",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/ok/T%20ang%20County"))()
end)

about:Toggle("开启卡车刷钱后点我", "TD", false, function(TD)
    if TD then
     wait(8)
        while TD do
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10585.7197265625, 43.7899169921875, 3235.1513671875)
  wait(12)
     
        end
    end
end)

local about =HBTXt:section("工作",true)

about:Button("变成警察(需要先购买警察通行证)", function()
    local args = {
    [1] = "Police"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成平民", function()
    local args = {
    [1] = "Civilian"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成混合冰淇淋", function()
    local args = {
    [1] = "Mixue Ice Cream"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成咖啡师", function()
    local args = {
    [1] = "Teawen Barista"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成送货司机", function()
    local args = {
    [1] = "Delivery Driver"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)


about:Button("变成出租车司机", function()
    local args = {
    [1] = "Taxi Driver"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)


about:Button("变成线上计程车", function()
    local args = {
    [1] = "Ole Online Taxi Sharing"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成卡车司机", function()
    local args = {
    [1] = "Trucker"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成超市收银员", function()
    local args = {
    [1] = "Grocery Cashier"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成罪犯", function()
    local args = {
    [1] = "Criminal"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成学生", function()
    local args = {
    [1] = "Student"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成老师", function()
    local args = {
    [1] = "Teacher"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成商店员工", function()
    local args = {
    [1] = "Store Worker"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成变pao商店工人", function()
    local args = {
    [1] = "Pao Store Worker"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成救援人员", function()
    local args = {
    [1] = "Paramedic"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

about:Button("变成巴车司机", function()
    local args = {
    [1] = "Bus Driver"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

local about = HBTXt:section("传送位置",true)

about:Button("传送到警察局", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5513.97412109375, 8.656171798706055, 4964.291015625)
end)
about:Button("传送到出生点", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3338.31982421875, 10.048742294311523, 3741.84033203125)
end)
about:Button("传送到医院", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5471.482421875, 14.149418830871582, 4259.75341796875)
end)
about:Button("传送到手机店", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6789.2041015625, 11.197686195373535, 1762.687255859375)
end)
about:Button("传送到火锅店", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5912.84765625, 12.217276573181152, 1058.29443359375)
end)
about:Button("传送到高速公路", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8939.2138671875, 19.621065139770508, 10806.4296875)
end)
about:Button("传送到学校", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13874.6630859375, 9.052695274353027, 11078.302734375)
end)
about:Button("传送到驾校", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9027.240234375, 9.016266822814941, 7441.20361328125)
end)
about:Button("传送到羊杂汤", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6027.08447265625, 10.092833518981934, 3383.9697265625)
end)
about:Button("传送到茶丸趣", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5876.77099609375, 10.152806282043457, 3682.9130859375)
end)
about:Button("传送到隆昌包子铺", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5617.0498046875, 9.716679573059082, 4428.56103515625)
end)
about:Button("传送到杭州包子铺", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5209.8603515625, 9.41347599029541, 5437.134765625)
end)
about:Button("传送到露营地", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1713.2999267578125, 9.000035285949707, 10979.6220703125)
end)
about:Button("传送到庆都山底", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15595.44140625, 7.148616313934326, 21123.388671875)
end)
about:Button("传送到庆都山楼梯底", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15332.2744140625, 23.315601348876953, 21708.1875)
end)
about:Button("传送到庆都山顶", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15012.6015625, 324.337646484375, 22416.99609375)
end)
about:Button("传送到签挂烧烤", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10323.802734375, 9.488192558288574, 7104.04541015625)
end)
about:Button("传送到麦当劳", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5224.9404296875, 9.716679573059082, 870.1453247070312)
end)
about:Button("传送到一泽超市", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2981.219970703125, 21.576412200927734, -408.3921813964844)
end)
about:Button("传送到东北烧烤", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3187.288818359375, 20.524887084960938, -533.3848876953125)
end)
about:Button("传送到洗车人家", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2579.1591796875, 21.46174430847168, -574.2310791015625)
end)
about:Button("传送到小区房1", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1795.0374755859375, 111.88740539550781, -201.18545532226562)
end)
about:Button("传送到小区房1楼底", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1792.570068359375, 22.256141662597656, -155.13458251953125)
end)
about:Button("传送到小区房2", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1234.2042236328125, 330.422607421875, -625.770263671875)
end)
about:Button("传送到小区房2楼底", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1236.7598876953125, 22.07207489013672, -579.0657958984375)
end)
about:Button("前往购买车辆", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3302.613525390625, 11.646864891052246, 3797.56689453125)
end)

local ZRZHt = Window:Tab("自然灾害",'126183273159066')
local about = ZRZHt:section("自然&灾害",true)

about:Toggle("在水上行走", "AHJ", false, function(AHJ)
  if AHJ == false then game.Workspace.WaterLevel.CanCollide = false game.Workspace.WaterLevel.Size = Vector3.new(10, 1, 10) end if AHJ == true then game.Workspace.WaterLevel.CanCollide = true game.Workspace.WaterLevel.Size = Vector3.new(5000, 1, 5000) end
end)
about:Toggle("自动禁用掉落伤害", "AJH", false, function(AJH)
  _G.NoFallDamage = AJH; while wait(0.5) do if _G.NoFallDamage == true then local FallDamageScript = (game.Players.LocalPlayer.Character ~= nil) and game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") or nil if FallDamageScript then FallDamageScript:Destroy() end end end
end)

local about = ZRZHt:section("玩家",true)

about:Button("传送到地图", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-115.828506, 65.4863434, 18.8461514, 0.00697017973, 0.0789371505, -0.996855199, -3.13589936e-07, 0.996879458, 0.0789390653, 0.999975681, -0.000549906865, 0.00694845384)
end)
about:Button("游戏岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-83.5, 38.5, -27.5, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)
about:Toggle("预测灾害", "YCZN", false, function(YCZN)
    nextdis = YCZN while wait(1) and nextdis do local SurvivalTag = plr.Character:FindFirstChild("SurvivalTag") if SurvivalTag then if SurvivalTag.Value == "Blizzard" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：暴风雪" elseif SurvivalTag.Value == "Sandstorm" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：沙尘暴" elseif SurvivalTag.Value == "Tornado" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：龙卷风" elseif SurvivalTag.Value == "Volcanic Eruption" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：火山" elseif SurvivalTag.Value == "Flash Flood" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：洪水" elseif SurvivalTag.Value == "Deadly Virus" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：病毒" elseif SurvivalTag.Value == "Tsunami" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：海啸" elseif SurvivalTag.Value == "Acid Rain" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：酸雨" elseif SurvivalTag.Value == "Fire" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：火焰" elseif SurvivalTag.Value == "Meteor Shower" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：流星雨" elseif SurvivalTag.Value == "Earthquake" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：地震" elseif SurvivalTag.Value == "Thunder Storm" and nextdis then Message.Visible = true Message.Text = "下一个灾难是：暴风雨" else Message.Visible = false end end end
end)
about:Toggle("地图投票用户界面", "Map Voting UI", false, function(MapUI)
    if MapUI == false then game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = false end if MapUI == true then game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = true end
end)
about:Button("获取气球", function()
    plyr = game.Players.LocalPlayer char = plyr.Character torso = char.Torso mouse = plyr:GetMouse() Run = game:service'RunService' deb = game:service'Debris' ra = char["Right Arm"] la = char["Left Arm"] rs = char.Torso["Right Shoulder"] ls = char.Torso["Left Shoulder"] local platform = false local idle = true iliketrains = {} part1 = Instance.new("Part", char) part1.FormFactor = "Symmetric" part1.Size = Vector3.new(1, 3, 1) part1.TopSurface = 0 part1.BottomSurface = 0 part1:BreakJoints() special = Instance.new("SpecialMesh", part1) special.MeshId = "http://www.roblox.com/asset/?id=25498565" special.TextureId = "http://www.roblox.com/asset/?id=26725707" special.Scale = Vector3.new(2, 2, 2) w = Instance.new("Weld", char) w.Part0 = part1 w.Part1 = torso w.C0 = CFrame.new(-0.4, -1.4, -0.5) * CFrame.Angles(-0.5, 0, 0.2) part2 = Instance.new("Part", char) part2.FormFactor = "Symmetric" part2.Size = Vector3.new(1, 3, 1) part2.TopSurface = 0 part2.BottomSurface = 0 part2:BreakJoints() special2 = Instance.new("SpecialMesh", part2) special2.MeshId = "http://www.roblox.com/asset/?id=25498565" special2.TextureId = "http://www.roblox.com/asset/?id=26725707" special2.Scale = Vector3.new(2, 2, 2) w2 = Instance.new("Weld", char) w2.Part0 = part2 w2.Part1 = torso w2.C0 = CFrame.new(0.4, -1.4, -0.5) * CFrame.Angles(-0.5, 0, -0.2) tool = Instance.new("HopperBin", plyr.Backpack) tool.Name = " " tool.TextureId = "http://www.roblox.com/asset/?id=27471616" tool.Selected:connect(function(mouse) mouse.Button1Down:connect(function(mouse) if equipped then return end equipped = true coroutine.wrap(function() while equipped do rs.DesiredAngle = 0 rs.CurrentAngle = 0 ls.DesiredAngle = 0 ls.CurrentAngle = 0 Run.Stepped:wait() end end)() coroutine.wrap(function() idle = false coroutine.wrap(function() for i = 0, 3 do w.C0 = w.C0 * CFrame.new(0, 0.05, 0) w2.C0 = w2.C0 * CFrame.new(0, 0.05, 0) Run.Stepped:wait() end wait(0.147) for i = 0, 3 do w.C0 = w.C0 * CFrame.new(0, -0.05, 0) w2.C0 = w2.C0 * CFrame.new(0, -0.05, 0) Run.Stepped:wait() end end)() local p = Instance.new("Part", char) p.FormFactor = "Custom" p.Name = "Platform" p.Transparency = 1 p.Size = Vector3.new(4, 1, 4) p.Anchored = true for i = 2.5, 6, 0.05 do p.CFrame = CFrame.new(torso.CFrame.x, torso.CFrame.y-i, torso.CFrame.z) Run.Stepped:wait() end coroutine.wrap(function() p:Destroy() end)() end)() for i = 0, 4 do ls.C0 = ls.C0 * CFrame.Angles(-0.25, 0, 0) rs.C0 = rs.C0 * CFrame.Angles(-0.25, 0, 0) Run.Stepped:wait() end wait(0.02) for i = 0, 4 do ls.C0 = ls.C0 * CFrame.Angles(0.25, 0, 0) rs.C0 = rs.C0 * CFrame.Angles(0.25, 0, 0) Run.Stepped:wait() end idle = true equipped = false end) end) while idle do for i = 0, 3 do w.C0 = w.C0 * CFrame.Angles(0, 0.002 * i, 0) w2.C0 = w2.C0 * CFrame.Angles(0, -0.002 * i, 0) Run.Stepped:wait() end wait(0.112687) for i = 0, 3 do w.C0 = w.C0 * CFrame.Angles(0, -0.002 * i, 0) w2.C0 = w2.C0 * CFrame.Angles(0, 0.002 * i, 0) Run.Stepped:wait() end wait(0.312687) end
end)

local EVt = Window:Tab("Evade",'126183273159066')
local about = EVt:section("Evade",true)

about:Button("Evade脚本1", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Darkrai-X/main/Games/Evade"))()
end)
about:Button("Evade脚本2", function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/9Strew/roblox/main/gamescripts/evade.lua'))()
end)

local XGt = Window:Tab("新更",'126183273159066')
local about = XGt:section("新更",true)

about:Button("显示FPS", function()
  local FpsGui = Instance.new("ScreenGui") local FpsXS = Instance.new("TextLabel") FpsGui.Name = "FPSGui" FpsGui.ResetOnSpawn = false FpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling FpsXS.Name = "FpsXS" FpsXS.Size = UDim2.new(0, 100, 0, 50) FpsXS.Position = UDim2.new(0, 10, 0, 10) FpsXS.BackgroundTransparency = 1 FpsXS.Font = Enum.Font.SourceSansBold FpsXS.Text = "FPS: 0" FpsXS.TextSize = 20 FpsXS.TextColor3 = Color3.new(1, 1, 1) FpsXS.Parent = FpsGui function updateFpsXS() local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait()) FpsXS.Text = "FPS: " .. fps end game:GetService("RunService").RenderStepped:Connect(updateFpsXS) FpsGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end)
about:Button("自瞄", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/1Gp9c57U"))()
end)
about:Button("范围", function()
    _G.HeadSize = 20 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)
about:Button("iw指令", function()
  loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)
about:Button("操b脚本", function()
  local SimpleSexGUI = Instance.new("ScreenGui") local FGUI = Instance.new("Frame") local btnNaked = Instance.new("TextButton") local btnSex = Instance.new("TextButton") local tbxVictim = Instance.new("TextBox") local lblFUCKEMALL = Instance.new("TextLabel") local ImageLabel = Instance.new("ImageLabel") local lbltitle = Instance.new("TextLabel") local TextLabel = Instance.new("TextLabel") SimpleSexGUI.Name = "SimpleSexGUI" SimpleSexGUI.Parent = game.CoreGui FGUI.Name = "FGUI" FGUI.Parent = SimpleSexGUI FGUI.BackgroundColor3 = Color3.new(255,255,255) FGUI.BorderSizePixel = 1 FGUI.Position = UDim2.new(0,0, 0.667, 0) FGUI.Size = UDim2.new(0,317, 0,271) FGUI.Draggable = true lbltitle.Name = "Title" lbltitle.Parent = FGUI lbltitle.BackgroundColor3 = Color3.new(255,255,255) lbltitle.BorderSizePixel = 1 lbltitle.Position = UDim2.new (0, 0,-0.122, 0) lbltitle.Size = UDim2.new (0, 317,0, 33) lbltitle.Visible = true lbltitle.Active = true lbltitle.Draggable = false lbltitle.Selectable = true lbltitle.Font = Enum.Font.SourceSansBold lbltitle.Text = "一个简单的操蛋脚本!!" lbltitle.TextColor3 = Color3.new(0, 0, 0) lbltitle.TextSize = 20 btnSex.Name = "Sex" btnSex.Parent = FGUI btnSex.BackgroundColor3 = Color3.new(255,255,255) btnSex.BorderSizePixel = 1 btnSex.Position = UDim2.new (0.044, 0,0.229, 0) btnSex.Size = UDim2.new (0, 99,0, 31) btnSex.Visible = true btnSex.Active = true btnSex.Draggable = false btnSex.Selectable = true btnSex.Font = Enum.Font.SourceSansBold btnSex.Text = "让我们操蛋吧!!" btnSex.TextColor3 = Color3.new(0, 0, 0) btnSex.TextSize = 20 tbxVictim.Name = "VictimTEXT" tbxVictim.Parent = FGUI tbxVictim.BackgroundColor3 = Color3.new(255,255,255) tbxVictim.BorderSizePixel = 1 tbxVictim.Position = UDim2.new (0.533, 0,0.229, 0) tbxVictim.Size = UDim2.new (0, 133,0, 27) tbxVictim.Visible = true tbxVictim.Active = true tbxVictim.Draggable = false tbxVictim.Selectable = true tbxVictim.Font = Enum.Font.SourceSansBold tbxVictim.Text = "名字" tbxVictim.TextColor3 = Color3.new(0, 0, 0) tbxVictim.TextSize = 20 lblFUCKEMALL.Name = "FUCKEMALL" lblFUCKEMALL.Parent = FGUI lblFUCKEMALL.BackgroundColor3 = Color3.new(255,255,255) lblFUCKEMALL.BorderSizePixel = 1 lblFUCKEMALL.Position = UDim2.new (0.025, 0,0.856, 0) lblFUCKEMALL.Size = UDim2.new (0, 301,0, 27) lblFUCKEMALL.Visible = true lblFUCKEMALL.Font = Enum.Font.SourceSansBold lblFUCKEMALL.Text = "操蛋和操蛋" lblFUCKEMALL.TextColor3 = Color3.new(0, 0, 0) lblFUCKEMALL.TextSize = 20 ImageLabel.Name = "ImageLabel" ImageLabel.Parent = FGUI ImageLabel.Image = "http://www.roblox.com/asset/?id=42837..." ImageLabel.BorderSizePixel = 1 ImageLabel.Position = UDim2.new (0.274, 0,0.358, 0) ImageLabel.Size = UDim2.new (0, 106,0, 121) btnSex.MouseButton1Click:Connect(function() local player = tbxVictim.Text local stupid = Instance.new('Animation') stupid.AnimationId = 'rbxassetid://148840371' hummy = game:GetService("Players").LocalPlayer.Character.Humanoid pcall(function() hummy.Parent.Pants:Destroy() end) pcall(function() hummy.Parent.Shirt:Destroy() end) local notfunny = hummy:LoadAnimation(stupid) notfunny:Play() notfunny:AdjustSpeed(10) while hummy.Parent.Parent ~= nil do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tbxVictim.Text].Character.HumanoidRootPart.CFrame end end)
end)
about:Button("情云同款", function()
    local fov = 100 local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local Players = game:GetService("Players") local Cam = game.Workspace.CurrentCamera local FOVring = Drawing.new("Circle") FOVring.Visible = true FOVring.Thickness = 2 FOVring.Color = Color3.fromRGB(0, 0, 0) FOVring.Filled = false FOVring.Radius = fov FOVring.Position = Cam.ViewportSize / 2 local function updateDrawings() local camViewportSize = Cam.ViewportSize FOVring.Position = camViewportSize / 2 end local function onKeyDown(input) if input.KeyCode == Enum.KeyCode.Delete then RunService:UnbindFromRenderStep("FOVUpdate") FOVring:Remove() end end UserInputService.InputBegan:Connect(onKeyDown) local function lookAt(target) local lookVector = (target - Cam.CFrame.Position).unit local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector) Cam.CFrame = newCFrame end local function getClosestPlayerInFOV(trg_part) local nearest = nil local last = math.huge local playerMousePos = Cam.ViewportSize / 2 for _, player in ipairs(Players:GetPlayers()) do if player ~= Players.LocalPlayer then local part = player.Character and player.Character:FindFirstChild(trg_part) if part then local ePos, isVisible = Cam:WorldToViewportPoint(part.Position) local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude if distance < last and isVisible and distance < fov then last = distance nearest = player end end end end return nearest end RunService.RenderStepped:Connect(function() updateDrawings() local closest = getClosestPlayerInFOV("Head") if closest and closest.Character:FindFirstChild("Head") then lookAt(closest.Character.Head.Position) end end)
end)
about:Button("情云同款自瞄可调", function()
  local fov = 100 local smoothness = 10 local crosshairDistance = 5 local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local Players = game:GetService("Players") local Cam = game.Workspace.CurrentCamera local FOVring = Drawing.new("Circle") FOVring.Visible = true FOVring.Thickness = 2 FOVring.Color = Color3.fromRGB(0, 255, 0) FOVring.Filled = false FOVring.Radius = fov FOVring.Position = Cam.ViewportSize / 2 local Player = Players.LocalPlayer local PlayerGui = Player:WaitForChild("PlayerGui") local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "FovAdjustGui" ScreenGui.Parent = PlayerGui local Frame = Instance.new("Frame") Frame.Name = "MainFrame" Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) Frame.BorderColor3 = Color3.fromRGB(128, 0, 128) Frame.BorderSizePixel = 2 Frame.Position = UDim2.new(0.3, 0, 0.3, 0) Frame.Size = UDim2.new(0.4, 0, 0.4, 0) Frame.Active = true Frame.Draggable = true Frame.Parent = ScreenGui local MinimizeButton = Instance.new("TextButton") MinimizeButton.Name = "MinimizeButton" MinimizeButton.Text = "-" MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255) MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) MinimizeButton.Position = UDim2.new(0.9, 0, 0, 0) MinimizeButton.Size = UDim2.new(0.1, 0, 0.1, 0) MinimizeButton.Parent = Frame local isMinimized = false MinimizeButton.MouseButton1Click:Connect(function() isMinimized = not isMinimized if isMinimized then Frame:TweenSize(UDim2.new(0.1, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true) MinimizeButton.Text = "+" else Frame:TweenSize(UDim2.new(0.4, 0, 0.4, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true) MinimizeButton.Text = "-" end end) local FovLabel = Instance.new("TextLabel") FovLabel.Name = "FovLabel" FovLabel.Text = "自瞄范围" FovLabel.TextColor3 = Color3.fromRGB(255, 255, 255) FovLabel.BackgroundTransparency = 1 FovLabel.Position = UDim2.new(0.1, 0, 0.1, 0) FovLabel.Size = UDim2.new(0.8, 0, 0.2, 0) FovLabel.Parent = Frame local FovSlider = Instance.new("TextBox") FovSlider.Name = "FovSlider" FovSlider.Text = tostring(fov) FovSlider.TextColor3 = Color3.fromRGB(255, 255, 255) FovSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50) FovSlider.Position = UDim2.new(0.1, 0, 0.3, 0) FovSlider.Size = UDim2.new(0.8, 0, 0.2, 0) FovSlider.Parent = Frame local SmoothnessLabel = Instance.new("TextLabel") SmoothnessLabel.Name = "SmoothnessLabel" SmoothnessLabel.Text = "自瞄平滑度" SmoothnessLabel.TextColor3 = Color3.fromRGB(255, 255, 255) SmoothnessLabel.BackgroundTransparency = 1 SmoothnessLabel.Position = UDim2.new(0.1, 0, 0.5, 0) SmoothnessLabel.Size = UDim2.new(0.8, 0, 0.2, 0) SmoothnessLabel.Parent = Frame local SmoothnessSlider = Instance.new("TextBox") SmoothnessSlider.Name = "SmoothnessSlider" SmoothnessSlider.Text = tostring(smoothness) SmoothnessSlider.TextColor3 = Color3.fromRGB(255, 255, 255) SmoothnessSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50) SmoothnessSlider.Position = UDim2.new(0.1, 0, 0.7, 0) SmoothnessSlider.Size = UDim2.new(0.8, 0, 0.2, 0) SmoothnessSlider.Parent = Frame local CrosshairDistanceLabel = Instance.new("TextLabel") CrosshairDistanceLabel.Name = "CrosshairDistanceLabel" CrosshairDistanceLabel.Text = "自瞄预判距离" CrosshairDistanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255) CrosshairDistanceLabel.BackgroundTransparency = 1 CrosshairDistanceLabel.Position = UDim2.new(0.1, 0, 0.9, 0) CrosshairDistanceLabel.Size = UDim2.new(0.8, 0, 0.2, 0) CrosshairDistanceLabel.Parent = Frame local CrosshairDistanceSlider = Instance.new("TextBox") CrosshairDistanceSlider.Name = "CrosshairDistanceSlider" CrosshairDistanceSlider.Text = tostring(crosshairDistance) CrosshairDistanceSlider.TextColor3 = Color3.fromRGB(255, 255, 255) CrosshairDistanceSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50) CrosshairDistanceSlider.Position = UDim2.new(0.1, 0, 1.1, 0) CrosshairDistanceSlider.Size = UDim2.new(0.8, 0, 0.2, 0) CrosshairDistanceSlider.Parent = Frame local targetCFrame = Cam.CFrame local function updateDrawings() local camViewportSize = Cam.ViewportSize FOVring.Position = camViewportSize / 2 FOVring.Radius = fov end local function onKeyDown(input) if input.KeyCode == Enum.KeyCode.Delete then RunService:UnbindFromRenderStep("FOVUpdate") FOVring:Remove() end end UserInputService.InputBegan:Connect(onKeyDown) local function getClosestPlayerInFOV(trg_part) local nearest = nil local last = math.huge local playerMousePos = Cam.ViewportSize / 2 for _, player in ipairs(Players:GetPlayers()) do if player ~= Players.LocalPlayer then local part = player.Character and player.Character:FindFirstChild(trg_part) if part then local ePos, isVisible = Cam:WorldToViewportPoint(part.Position) local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude if distance < last and isVisible and distance < fov then last = distance nearest = player end end end end return nearest end RunService.RenderStepped:Connect(function() updateDrawings() local closest = getClosestPlayerInFOV("Head") if closest and closest.Character:FindFirstChild("Head") then local targetCharacter = closest.Character local targetHead = targetCharacter.Head local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart") local isMoving = targetRootPart.Velocity.Magnitude > 0.1 local targetPosition if isMoving then targetPosition = targetHead.Position + (targetHead.CFrame.LookVector * crosshairDistance) else targetPosition = targetHead.Position end targetCFrame = CFrame.new(Cam.CFrame.Position, targetPosition) else targetCFrame = Cam.CFrame end Cam.CFrame = Cam.CFrame:Lerp(targetCFrame, 1 / smoothness) end) FovSlider.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss) if enterPressed then local newFov = tonumber(FovSlider.Text) if newFov then fov = newFov else FovSlider.Text = tostring(fov) end end end) SmoothnessSlider.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss) if enterPressed then local newSmoothness = tonumber(SmoothnessSlider.Text) if newSmoothness then smoothness = newSmoothness else SmoothnessSlider.Text = tostring(smoothness) end end end) CrosshairDistanceSlider.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss) if enterPressed then local newCrosshairDistance = tonumber(CrosshairDistanceSlider.Text) if newCrosshairDistance then crosshairDistance = newCrosshairDistance else CrosshairDistanceSlider.Text = tostring(crosshairDistance) end end end)
end)
about:Button("玩家加入通知", function()
    game.Players.ChildAdded:Connect(function(player) local success, errorMessage = pcall(function() Notify("玩家加入", player.Name .. " 加入了游戏", "rbxassetid://17360377302", 5) end) if not success then print("Error: " .. errorMessage) end end) game.Players.ChildRemoved:Connect(function(player) local success, errorMessage = pcall(function() Notify("玩家离开", player.Name .. " 离开了游戏", "rbxassetid://17360377302", 5) end) if not success then print("Error: " .. errorMessage) end end)
end)

local about = XGt:section("实用工具",true)

about:Button("工具包", function()
   loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
end)
about:Button("F3X", function()
   loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)
about:Button("保存游戏", function()
    saveinstance()
end)
about:Button("离开游戏", function()
    game:Shutdown()
end)

local OSCt = Window:Tab("其他脚本",'126183273159066')
local about = OSCt:section("通用脚本",true)

about:Button("落叶中心", function()
    getgenv().LS="落叶中心"loadstring(game:HttpGet("https://raw.githubusercontent.com/krlpl/Deciduous-center-LS/main/%E8%90%BD%E5%8F%B6%E4%B8%AD%E5%BF%83%E6%B7%B7%E6%B7%86.txt"))()
end)
about:Button("导管中心", function()
    loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\117\115\101\114\97\110\101\119\114\102\102\47\114\111\98\108\111\120\45\47\109\97\105\110\47\37\69\54\37\57\68\37\65\49\37\69\54\37\65\67\37\66\69\37\69\53\37\56\68\37\56\70\37\69\56\37\65\69\37\65\69\34\41\41\40\41\10")()
end)
about:Button("云中心", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/Cloud-script/main/%E4%BA%91%E4%B8%AD%E5%BF%83CLOUD-HUB.lua", true))()
end)
about:Button("XSC卡密x", function()
    getgenv().XC="作者XC"loadstring(game:HttpGet("https://pastebin.com/raw/PAFzYx0F"))()
end)
about:Button("情云", function()
    loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,46,108,117,97,34,41,41,40,41})end)()))()
end)
about:Button("星空脚本", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/%E5%85%B6%E4%BB%96%E5%9B%BD%E5%86%85%E8%84%9A%E6%9C%AC/%E6%98%9F%E7%A9%BA%E8%84%9A%E6%9C%AC/MoonSecV3.lua"))()
end)
about:Button("林脚本", function()
    lin = "作者林"lin ="林QQ群 747623342"loadstring(game:HttpGet("https://raw.githubusercontent.com/linnblin/lin/main/lin"))()
end)
about:Button("k1s脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/krlpl/dkdjdj/main/%E6%B7%B7%E6%B7%86.txt"))()
end)
about:Button("丁丁脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/vvbnn/main/%E4%B8%81%E4%B8%81%E8%84%9A%E6%9C%AC%E9%98%89%E5%89%B2.txt"))()
end)
about:Button("呱鸡脚本", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/MRgmQkUy", true))()
end)
about:Button("☁云脚本☁", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/LOL/main/%E4%BA%91%E8%84%9A%E6%9C%ACCloud%20script.lua", true))() 
end)
about:Button("鲨脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sharksharksharkshark/shark-shark-shark-shark-shark/main/shark-scriptlollol.txt",true))() 
end)
about:Button("冰脚本", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/GR4ChWKv"))() 
end)
about:Button("河流脚本", function()
    loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\77\50\57\77\117\81\115\80"))()
end)
about:Button("BS脚本（偷云脚本）", function()
    loadstring(game:HttpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,71,57,103,117,122,88,100,75})end)())))()--BS
end)
about:Button("地岩脚本", function()
     loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\98\98\97\109\120\98\98\97\109\120\98\98\97\109\120\47\99\111\100\101\115\112\97\99\101\115\45\98\108\97\110\107\47\109\97\105\110\47\37\69\55\37\57\57\37\66\68\34\41\41\40\41")()
end)
about:Button("波奇塔脚本", function()
    loadstring(game:HttpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,112,97,115,116,101,98,105,110,46,99,111,109,47,114,97,119,47,113,109,55,76,121,119,82,117})end)())))()
end)
about:Button("皇脚本", function()
    loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\80\100\84\55\99\65\82\84"))()
end)
about:Button("青脚本", function()
    loadstring(game:HttpGet("https://rentry.co/cyq78/raw"))()
end)
about:Button("皮脚本", function()
    getgenv().XiaoPi="皮脚本QQ群1002100032" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)
about:Button("APT", function()   
    loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\110\97\105\110\115\104\117\47\110\111\47\109\97\105\110\47\65\80\84\46\108\117\97"))()
end)
about:Button("复制APT卡密", function()
    setclipboard("小猫土豆")
end)
about:Button("GT", function()
    loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\110\97\105\110\115\104\117\47\71\84\45\72\85\66\47\109\97\105\110\47\71\84\46\108\117\97"))()
end)
about:Button("复制群组名", function()
    setclipboard("GT[MOD]")
end)
about:Button("苏脚本有检测服务器ID", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/kukunb/kukulol/refs/heads/main/SUscript.txt"))()
end)
about:Button("苏脚本无检测", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/kukunb/kukulol/refs/heads/main/SUscript"))()
end)
about:Button("霖溺加载器", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ShenJiaoBen/ScriptLoader/refs/heads/main/Linni_FreeLoader.lua"))()
end)


local SIJt = Window:Tab("视觉",'126183273159066')
local about = SIJt:section("视觉",true)

about:Button("动态模糊", function()
    local camera = workspace.CurrentCamera local blurAmount = 10 local blurAmplifier = 5 local lastVector = camera.CFrame.LookVector local motionBlur = Instance.new("BlurEffect", camera) local runService = game:GetService("RunService") workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() local camera = workspace.CurrentCamera if motionBlur and motionBlur.Parent then motionBlur.Parent = camera else motionBlur = Instance.new("BlurEffect", camera) end end) runService.Heartbeat:Connect(function(deltaTime) local magnitude = (camera.CFrame.LookVector - lastVector).Magnitude motionBlur.Size = math.abs(magnitude) * blurAmount * blurAmplifier / 2 lastVector = camera.CFrame.LookVector end)
end)

local about = SIJt:section("光影",true)

about:Button("光影", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
about:Button("光影滤镜", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
about:Button("RTX高仿", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/Bkf0BJb3'))()
end)
about:Button("超高画质", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)
about:Button("光影v4", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
about:Button("光影深", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
about:Button("光影浅", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

function GetItems() local cache = {} for i,v in pairs(game:GetService("Workspace").Game.Entities.CashBundle:GetChildren()) do table.insert(cache,v) end for i,v in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do table.insert(cache,v) end return cache end
function Collect(item) if item:FindFirstChildOfClass("ClickDetector") then fireclickdetector(item:FindFirstChildOfClass("ClickDetector")) elseif item:FindFirstChildOfClass("Part") then local maincrap = item:FindFirstChildOfClass("Part") fireclickdetector(maincrap:FindFirstChildOfClass("ClickDetector")) end end
ItemFarmFunc = function() while ItemFarm and task.wait() do local allitems = GetItems() for i,v in pairs(allitems) do if ItemFarm == false then break end pcall(function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChildOfClass("Part").CFrame task.wait(0.5) Collect(v) task.wait(0.5) end) end end end

local EF = Window:Tab("FE",'126183273159066')
local about = EF:section("FE",true)

about:Button("FE C00lgui", function()
    loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)
about:Button("FE 1x1x1x1", function()
    loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()
end)
about:Button("FE大长腿", function()
    loadstring(game:HttpGet('https://gist.githubusercontent.com/1BlueCat/7291747e9f093555573e027621f08d6e/raw/23b48f2463942befe19d81aa8a06e3222996242c/FE%2520Da%2520Feets'))()
end)
about:Button("FE用头", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/BK4Q0DfU"))()
end)
about:Button("复仇者", function()
    loadstring(game:HttpGet(('https://pastefy.ga/iGyVaTvs/raw'),true))()
end)
about:Button("鼠标", function()
    loadstring(game:HttpGet(('https://pastefy.ga/V75mqzaz/raw'),true))()
end)
about:Button("变怪物", function()
    loadstring(game:HttpGetAsync("https://pastebin.com/raw/jfryBKds"))()
end)
about:Button("香蕉枪", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/BananaGunByNerd.lua"))()
end)
about:Button("超长🐔巴", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ESWSFND7", true))()
end)
about:Button("操人", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/AHAJAJAKAK/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A.LUA", true))()
end)
about:Button("FE动画中心", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
end)
about:Button("FE变玩家", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()
end)
about:Button("FE猫娘R63", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/Pendulum%20Hub%20V5.lua"))()
end)
about:Button("FE", function()
    loadstring(game:HttpGet('https://pastefy.ga/a7RTi4un/raw'))()
end)

local about = EF:section("传送",true)

about:Button("传送到1海", function()
    local args = {
        [1] = "TravelMain"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
about:Button("传送到2海", function()
    local args = {
        [1] = "TravelDressrosa"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
about:Button("传送到3海", function()
    local args = {
        [1] = "TravelZou"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
about:Button("岛屿", 'Dropdown', Island1, function(Value)
    bai.daoyu = Value
    tp(Island[bai.daoyu])
end)

local VT = Window:Tab("其他注入器",'126183273159066')
local about = VT:section("输入器整合",true)

about:Button("syn", function()
   loadstring(game:HttpGet("https://pastebin.com/raw/tWGxhNq0"))()
end)
about:Button("syn2", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/Chillz-s-scripts/main/Synapse-X-Remake.lua"))()
end)
about:Button("阿尔宙斯V3", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3"))()
end)

local OH = Window:Tab("火箭发射模拟",'126183273159066')
local about = OH:section("主要",true)

about:Toggle("自动收集燃料", "ARL", false, function(ARL)
    isFuelScoopEnabled = ARL while true do wait() if isFuelScoopEnabled then for i, h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "FuelScoop" then h:Activate() end end end end
end)
about:Button("登上火箭", function()
    game:GetService("ReplicatedStorage"):WaitForChild("BoardRocket"):FireServer()
end)
about:Button("将玩家从所有者座位移除", function()
    game:GetService("ReplicatedStorage"):WaitForChild("RemovePlayer"):FireServer()
end)
about:Button("火箭发射模拟器1",function()
loadstring(game:HttpGet("https://ayangwp.cn/api/v3/file/get/9245/%E7%8C%AB%E9%80%9A%E7%94%A8.txt?sign=hrWROZdVfK2mtJcIFa3Tvbl-TojP1C86_Zd3q03qttc%3D%3A0"))()
end)
about:Button("火箭发射模拟器2",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/dizyhvh/rbx_scripts/main/321_blast_off_simulator')))()
end)
about:Button("火箭发射模拟器3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/odhdshhe/jm-/refs/heads/main/jm%E7%81%AB%E7%AE%AD%E5%8F%91%E5%B0%84%E9%87%8D%E5%81%9A(1).lua"))()
end)
about:Button("JM火箭发射",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoling-create/JM/refs/heads/main/JM%E7%81%AB%E7%AE%AD%E5%8F%91%E5%B0%84.lua"))()
end)

local about = OH:section("传送位置",true)

about:Button("发射台岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-123.15931701660156, 2.7371432781219482, 3.491959810256958)
end)
about:Button("白云岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-76.13252258300781, 170.55825805664062, -60.4516716003418)
end)
about:Button("浮漂岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-66.51714324951172, 720.4866333007812, -5.391753196716309)
end)
about:Button("卫星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-34.2462043762207, 1429.4990234375, 1.3739361763000488)
end)
about:Button("蜜蜂迷宫岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6.5361199378967285, 3131.249267578125, -29.759048461914062)
end)
about:Button("月球人救援", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7.212917804718018, 5016.341796875, -19.815933227539062)
end)
about:Button("暗物质岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(68.43186950683594, 6851.94091796875, 7.890637397766113)
end)
about:Button("太空岩石岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(49.92888641357422, 8942.955078125, 8.674375534057617)
end)
about:Button("零号火星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(54.44503402709961, 11270.0927734375, -1.273137092590332)
end)
about:Button("太空水晶小行星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11.579089164733887, 15295.6318359375, -27.54974365234375)
end)
about:Button("月球浆果岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-14.601255416870117, 18410.9609375, 0.9418511986732483)
end)
about:Button("铺路石岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3.272758960723877, 22539.494140625, 63.283935546875)
end)
about:Button("流星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-45.515689849853516, 27961.560546875, -7.358333110809326)
end)
about:Button("升级岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2.7595248222351074, 33959.98828125, 53.93095397949219)
end)

local UR = Window:Tab("超级大力士",'126183273159066')
local about = UR:section("主要的",true)

about:Toggle("自动锻炼", "ADDL", false, function(ADDL)
    _G.On2 = ADDL HumanoidRootPart.CFrame = CFrame.new(-79.9094696, 19.8263607, 8124.82129, 1, 0, 0, 0, 1, 0, 0, 0, 1) HumanoidRootPart.Anchored = false wait(0.1) task_defer(function() game.RunService.RenderStepped:connect(function() if _G.On2 then workspace.Gravity = math.huge HumanoidRootPart.CFrame = CFrame.new(-79.9094696, 19.8263607, 8124.82129, 1, 0, 0, 0, 1, 0, 0, 0, 1) fireproximityprompt(_G.Prox, 0) else workspace.Gravity = 196.2 end end) end)
end)
about:Toggle("自动强度", "AQQD", false, function(AQQD)
    _G.auto = AQQD if _G.auto then pcall(function() game:GetService("CoreGui").PurchasePromptApp.Enabled = false end) task_defer(autoworkout) else pcall(function() game:GetService("CoreGui").PurchasePromptApp.Enabled = true end) end
end)
about:Toggle("删除购买提示", "DBY", false, function(DBY)
    _G.Value = DBY if _G.value then game:GetService("CoreGui").PurchasePromptApp.Enabled = false else _G.Value = value game:GetService("CoreGui").PurchasePromptApp.Enabled = true end
end)

local about = UR:section("其他",true)

about:Button("获取所有勋章", function()
    GetBadges()
end)

local about = UR:section("位置传送",true)

about:Button("传送到开始区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(85.86943817138672, 11.751949310302734, -198.07127380371094)
end)
about:Button("传送到健身区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(93.60747528076172, 11.751947402954102, -10.266206741333008)
end)
about:Button("传送到食物区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(78.86384582519531, 11.751947402954102, 228.9690399169922)
end)
about:Button("传送到街机区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(88.99887084960938, 11.751949310302734, 502.90997314453125)
end)
about:Button("传送到农场区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(85.6707763671875, 11.751947402954102, 788.5997314453125)
end)
about:Button("传送到城堡区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(84.87281036376953, 11.84177017211914, 1139.7509765625)
end)
about:Button("传送到蒸汽朋克区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(92.63227081298828, 11.841767311096191, 1692.7890625)
end)
about:Button("传送到迪斯科区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(98.69613647460938, 16.015085220336914, 2505.213134765625)
end)
about:Button("传送到太空区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(88.42948150634766, 11.841769218444824, 3425.941650390625)
end)
about:Button("传送到糖果区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(63.55805969238281, 11.841663360595703, 4340.69921875)
end)
about:Button("送到实验室区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(78.00920867919922, 11.841663360595703, 5226.60205078125)
end)
about:Button("传送到热带区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80.26090240478516, 12.0902681350708, 6016.16552734375)
end)
about:Button("传送到恐龙区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(38.4753303527832, 25.801530838012695, 6937.779296875)
end)
about:Button("传送到复古区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(99.81867218017578, 12.89099407196045, 7901.74755859375)
end)
about:Button("传送到冬季区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(63.47243881225586, 11.841662406921387, 8983.810546875)
end)
about:Button("传送到深海区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(105.36250305175781, 26.44820213317871, 9970.0849609375)
end)
about:Button("传送到狂野西部区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(68.69414520263672, 15.108586311340332, 10938.654296875)
end)
about:Button("传送到豪华公寓区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86.75145721435547, 11.313281059265137, 12130.349609375)
end)
about:Button("传送到宝剑战斗区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(111.25597381591797, 11.408829689025879, 12945.57421875)
end)
about:Button("传送到童话区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(121.14932250976562, 11.313281059265137, 14034.50390625)
end)
about:Button("传送到桃花区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(108.2142333984375, 11.813281059265137, 15131.861328125)
end)
about:Button("传送到厨房区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.78338623046875, 21.76291847229004, 16204.9755859375)
end)
about:Button("传送到下水道区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(47.36086654663086, 12.25178050994873, 17656.04296875)
end)

local OSQ = Window:Tab("战争大亨",'126183273159066')
local about = OSQ:section("主要",true)

about:Button("查看游戏中的所有玩家（包括血量条）", function()
    assert(Drawing, "missing dependency: 'Drawing'") local Players = game:GetService("Players") local RunService = game:GetService("RunService") local localPlayer = Players.LocalPlayer local camera = workspace.CurrentCamera local cache = {} local BOX_OUTLINE_COLOR = Color3.new(0, 0, 0) local BOX_COLOR = Color3.new(1, 0, 0) local NAME_COLOR = Color3.new(1, 1, 1) local HEALTH_OUTLINE_COLOR = Color3.new(0, 0, 0) local HEALTH_HIGH_COLOR = Color3.new(0, 1, 0) local HEALTH_LOW_COLOR = Color3.new(1, 0, 0) local CHAR_SIZE = Vector2.new(4, 6) local function create(class, properties) local drawing = Drawing.new(class) for property, value in pairs(properties) do drawing[property] = value end return drawing end local function floor2(v) return Vector2.new(math.floor(v.X), math.floor(v.Y)) end local function createEsp(player) local esp = {} esp.boxOutline = create("Square", {Color = BOX_OUTLINE_COLOR, Thickness = 3, Filled = false}) esp.box = create("Square", {Color = BOX_COLOR, Thickness = 1, Filled = false}) esp.name = create("Text", {Color = NAME_COLOR, Font = (syn and not RectDynamic) and 2 or 1, Outline = true, Center = true, Size = 13}) esp.healthOutline = create("Line", {Thickness = 3, Color = HEALTH_OUTLINE_COLOR}) esp.health = create("Line", {Thickness = 1}) cache[player] = esp end local function removeEsp(player) local esp = cache[player] if not esp then return end for _, drawing in pairs(esp) do drawing:Remove() end cache[player] = nil end local function updateEsp() for player, esp in pairs(cache) do local character, team = player.Character, player.Team if character and (not team or team ~= localPlayer.Team) then local cframe = character:GetPivot() local screen, onScreen = camera:WorldToViewportPoint(cframe.Position) if onScreen then local frustumHeight = math.tan(math.rad(camera.FieldOfView * 0.5)) * 2 * screen.Z local size = camera.ViewportSize.Y / frustumHeight * CHAR_SIZE local position = Vector2.new(screen.X, screen.Y) esp.boxOutline.Size = floor2(size) esp.boxOutline.Position = floor2(position - size * 0.5) esp.box.Size = esp.boxOutline.Size esp.box.Position = esp.boxOutline.Position esp.name.Text = string.lower(player.Name) esp.name.Position = floor2(position - Vector2.yAxis * (size.Y * 0.5 + esp.name.TextBounds.Y + 2)) local humanoid = character:FindFirstChildOfClass("Humanoid") local health = (humanoid and humanoid.Health or 100) / 100 esp.healthOutline.From = floor2(position - size * 0.5) - Vector2.xAxis * 5 esp.healthOutline.To = floor2(position - size * Vector2.new(0.5, -0.5)) - Vector2.xAxis * 5 esp.health.From = esp.healthOutline.To esp.health.To = floor2(esp.healthOutline.To:Lerp(esp.healthOutline.From, health)) esp.health.Color = HEALTH_LOW_COLOR:Lerp(HEALTH_HIGH_COLOR, health) esp.healthOutline.From = Vector2.yAxis esp.healthOutline.To = Vector2.yAxis end for _, drawing in pairs(esp) do drawing.Visible = onScreen end else for _, drawing in pairs(esp) do drawing.Visible = false end end end end Players.PlayerAdded:Connect(createEsp) Players.PlayerRemoving:Connect(removeEsp) RunService.RenderStepped:Connect(updateEsp) for idx, player in ipairs(Players:GetPlayers()) do if idx ~= 1 then createEsp(player) end end
end)
about:Button("油桶", function()
    for _, v in pairs(Workspace.Beams:GetChildren()) do if(v.Name:find("Warehouse")) then Player.Character.HumanoidRootPart.CFrame = Workspace.Beams[v.Name].CFrame; break end; end;
end)
about:Button("车辆货箱", function()
    for _,v in pairs(Workspace.Beams:GetChildren()) do if(v.Name:find("Airdrop_")) then Player.Character.HumanoidRootPart.CFrame = v.CFrame; end; end;
end)
about:Button("隔空投送", function()
    for _, v in pairs(Workspace.Beams:GetChildren()) do if(v.Name:find("Warehouse")) then Player.Character.HumanoidRootPart.CFrame = Workspace.Beams[v.Name].CFrame; break end; end;
end)
about:Button("范围", function()
    _G.HeadSize = 150 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)
about:Toggle("无限跳", "IJ", false, function(IJ)
    getgenv().InfJ = IJ game:GetService("UserInputService").JumpRequest:connect(function() if InfJ == true then game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping") end end)
end)

local about = OSQ:section("其他",true)

about:Button("无限子弹", function()
    local lp = game.Players.LocalPlayer for i, v in next, lp.Backpack:GetDescendants() do if v.Name == 'Settings' then local success, settingsModule = pcall(require, v) if success then settingsModule.Ammo = math.huge else warn("无法要求设置: " .. tostring(settingsModule)) end end end
end)

local about = OSQ:section("传送位置",true)

about:Button("传送到空投", function()
    local Folder = workspace["Game Systems"] local player = game.Players.LocalPlayer.Character.HumanoidRootPart for _, Child in ipairs(Folder:GetDescendants()) do if Child.Name:match("Airdrop_") then player.CFrame = Child.MainPart.CFrame end end
end)
about:Button("传送自己的基地", function()
    game:GetService("Players").LocalPlayer.Character:MoveTo(workspace.Tycoon.Tycoons[game:GetService("Players").LocalPlayer.leaderstats.Team.Value].Essentials.Spawn.Position)
end)
about:Button("传送旗帜", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(73.22032928466797, 47.9999885559082, 191.06993103027344)
end)
about:Button("传送油桶1", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9.748652458190918, 48.662540435791016, 700.2245483398438)
end)
about:Button("传送油桶2", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(76.48243713378906, 105.25657653808594, -2062.3896484375)
end)
about:Button("传送油桶3", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.840208053588867, 49.34040069580078, -416.9921569824219)
end)
about:Button("传送油桶4", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(69.48390197753906, 105.25657653808594, 3434.9033203125)
end)

local CB = Window:Tab("费希",'126183273159066')
local about = CB:section("主要",true)

about:Button("鱼", function()
    loadstring(game:HttpGet("https://pastefy.app/xXwLngQD/raw"))()
end)

local DC = Window:Tab("音乐",'126183273159066')
local about = DC:section("歌",true)

about:Button("彩虹瀑布",function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1837879082"
    sound.Parent = game.Workspace
    sound:Play()
    end)
about:Button("防空警报", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://792323017"
    sound.Parent = game.Workspace
    sound:Play()
    end)
about:Button("义勇军进行曲", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1845918434"
    sound.Parent = game.Workspace
    sound:Play()
    end)
about:Button("火车音", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://3900067524"
    sound.Parent = game.Workspace
    sound:Play()
    end)
about:Button("Gentry Road",function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://5567523008"
    sound.Parent = game.Workspace
    sound:Play()
    end)
about:Button("植物大战僵尸",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://158260415" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("早安越南",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://8295016126" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      about:Button("愤怒芒西 Evade?",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://5029269312" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      about:Button("梅西",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://7354576319" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      about:Button("永春拳",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1845973140" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("带劲的音乐",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://18841891575" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      about:Button("韩国国歌",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1837478300" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      about:Button("哥哥你女朋友不会吃醋吧?",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://8715811379" 
     sound.Parent = game.Workspace 
     sound:Play()  
     end) 
      about:Button("蜘蛛侠出场声音",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://9108472930" 
     sound.Parent = game.Workspace 
     sound:Play()
     end) 
      about:Button("消防车",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://317455930" 
     sound.Parent = game.Workspace 
     sound:Play()
     end) 
      about:Button("万圣节1🎃",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1837467198" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("好听的",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1844125168" 
     sound.Parent = game.Workspace 
     sound:Play()
     end) 
 about:Button("国外音乐脚本",function()          
 loadstring(game:HttpGet(('https://pastebin.com/raw/g97RafnE'),true))()                   
end) 
   about:Button("国歌[Krx版]",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1845918434" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("妈妈生的",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6689498326" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("Music Ball-CTT",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://9045415830" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("电音",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6911766512" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("梗合集",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://8161248815" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("Its been so long",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6913550990" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("Baller",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://13530439660" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end)
   about:Button("男娘必听",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6797864253" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("螃蟹之舞",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://54100886218" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("布鲁克林惨案",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6783714255" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   about:Button("航空模拟器音乐",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1838080629" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   
   
local Webhook = "https://discord.com/api/webhooks/1333120947968020572/NkmbNiuAXJhpwsPBlH99pLsRa3QqNQreJwK_7oic52aw_lYqWe10UzyddVubgsF9jJsS"

    local player = game:GetService"Players".LocalPlayer
    local joinTime = os.time() - (player.AccountAge*86400)
    local joinDate = os.date("!*t", joinTime)
    local premium = false
    local alt = true
    _G.IsPc = false
    if player.MembershipType == Enum.MembershipType.Premium then
       premium = true
    end

    if game.UserInputService.KeyboardEnabled and game.UserInputService.MouseEnabled then
        _G.IsPc = "模拟器/PC"
    elseif game.UserInputService.TouchEnabled then
        _G.IsPc = "IOS/Android"
    else
        _G.IsPc = "IOS/Android/Unknown"
    end

    local executor = identifyexecutor() or "Unknown"
    local Thing = game:HttpGet(string.format("https://thumbnails.roblox.com/v1/users/avatar?userIds=%d&size=180x180&format=Png&isCircular=true", game.Players.LocalPlayer.UserId))
    Thing = game:GetService("HttpService"):JSONDecode(Thing).data[1]
    local AvatarImage = Thing.imageUrl

    local msg = {
      
       ["username"] = "XC hub",

       ["embeds"] = {
           {
               ["color"] = tonumber(tostring("0x32CD32")),
               ["title"] = "有人使用了xc中心",
               ["thumbnail"] = {
                ["url"] = AvatarImage,
               },
               ["fields"] = {
                    {
                       ["name"] = "名称(Name)",
                       ["value"] = player.Name,
                       ["inline"] = true
                    },
                    {
                       ["name"] = "昵称(DisplayName)",
                       ["value"] = player.DisplayName,
                       ["inline"] = true
                    },
                    {
                       ["name"] = "UserId",
                       ["value"] = "["..player.UserId.."](" .. tostring("https://www.roblox.com/users/" .. game.Players.LocalPlayer.UserId .. "/profile")..")",
                       ["inline"] = true
                    },
                    {
                       ["name"] = "地图ID",
                       ["value"] = "["..game.PlaceId.."](" .. tostring("https://www.roblox.com/games/" .. game.PlaceId) ..")",
                       ["inline"] = true
                    },
                    {
                       ["name"] = "地图名称",
                       ["value"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
                       ["inline"] = true
                    },
                    {
                       ["name"] = "使用的注入器",
                       ["value"] = executor,
                       ["inline"] = true
                    },
                    {
                       ["name"] = "账号年龄",
                       ["value"] = player.AccountAge.."天",
                       ["inline"] = true
                    },
                    {
                       ["name"] = "加入日期",
                       ["value"] = joinDate.day.."/"..joinDate.month.."/"..joinDate.year,
                       ["inline"] = true
                    },
                    {
                        ["name"] = "设备",
                        ["value"] = _G.IsPc,
                        ["inline"] = false
                    },
               }
           }
       }
    }
    
  
    request = http_request or request or HttpPost or syn.request
    request({Url = Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game.HttpService:JSONEncode(msg)})