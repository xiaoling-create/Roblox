local Http = game:GetService("HttpService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
 
local TARGET_ITEMS = {
"Money Printer", "Blue Candy Cane", "Bunny Balloon", "Ghost Balloon", "Clover Balloon",
"Bat Balloon", "Gold Clover Balloon", "Golden Rose", "Black Rose", "Heart Balloon",
"Diamond Ring", "Diamond", "Void Gem", "Dark Matter Gem", "Rollie", "NextBot Grenade",
"Nuclear Missile Launcher", "Suitcase Nuke",  "Trident", "Golden Cup",
"Easter Basket", "Military Armory Keycard", "Holy Grail","Skull Balloon",
"Spectral Scythe"
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
loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoling-create/Roblox/refs/heads/main/Starrain%E5%8D%B0%E9%92%9E%E6%9C%BA3%E5%88%86%E9%92%9F%E5%B8%A6%E6%9C%89%E7%BA%A2%E5%8D%A1.lua"))()
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
local hasFailedMilitaryKeycard = false
 
for i, item in ipairs(allItems) do
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
 
if hasFailedMilitaryKeycard then
print("Military Armory Keycard 拾取失败，1秒后换服...")
task.wait(1)
if targetServer then
queue_on_teleport(MainScript)
task.wait(1)
TeleportService:TeleportToPlaceInstance(_place, targetServer.id, LocalPlayer)
else
warn("Military Armory Keycard 拾取失败但无可用服务器")
end
return
end
 
if #failedItems > 0 then
print("存在无法拾取的普通物品，3分钟后换服：")
for _, item in ipairs(failedItems) do
print("- " .. item.type)
end
 
task.wait(180)
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