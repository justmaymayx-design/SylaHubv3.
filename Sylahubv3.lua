
--==================================
--       SYLA HUB V3
--       IPHONE EDITION
--==================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("SylaHubV3")
if old then old:Destroy() end

local animations = true
local notifications = true
local transparency = 0

local purple = Color3.fromRGB(170, 115, 255)
local dark = Color3.fromRGB(24, 21, 34)
local panel = Color3.fromRGB(40, 34, 55)
local buttonColor = Color3.fromRGB(65, 52, 85)
local white = Color3.fromRGB(255, 255, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "SylaHubV3"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0.92, 0, 0, 390)
main.Position = UDim2.new(0.04, 0, 0.25, 0)
main.BackgroundColor3 = dark
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 14)

local stroke = Instance.new("UIStroke")
stroke.Color = purple
stroke.Thickness = 2
stroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = panel
header.Parent = main

Instance.new("UICorner", header).CornerRadius =
    UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "✦ SYLA HUB V3"
title.TextColor3 = white
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(38, 38)
close.Position = UDim2.new(1, -45, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(180, 65, 85)
close.Text = "×"
close.TextColor3 = white
close.TextSize = 24
close.Parent = header

Instance.new("UICorner", close).CornerRadius =
    UDim.new(0, 8)

close.Activated:Connect(function()
    gui:Destroy()
end)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 110, 1, -70)
sidebar.Position = UDim2.fromOffset(8, 62)
sidebar.BackgroundColor3 = panel
sidebar.Parent = main

Instance.new("UICorner", sidebar).CornerRadius =
    UDim.new(0, 10)

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -135, 1, -70)
content.Position = UDim2.fromOffset(125, 62)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 9)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 8)
padding.PaddingLeft = UDim.new(0, 7)
padding.PaddingRight = UDim.new(0, 7)
padding.Parent = content

local function clear()
    for _, item in ipairs(content:GetChildren()) do
        if item:IsA("GuiObject") and
            item ~= layout and item ~= padding then
            item:Destroy()
        end
    end
end

local function label(text, size)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -5, 0, size or 45)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = white
    l.Font = Enum.Font.Gotham
    l.TextSize = 14
    l.TextWrapped = true
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = content
    return l
end

local function button(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 42)
    b.BackgroundColor3 = buttonColor
    b.Text = text
    b.TextColor3 = white
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 13
    b.Parent = content

    Instance.new("UICorner", b).CornerRadius =
        UDim.new(0, 8)

    b.Activated:Connect(callback)

    b.MouseEnter:Connect(function()
        if animations then
            TweenService:Create(b, TweenInfo.new(0.15), {
                BackgroundColor3 = purple
            }):Play()
        end
    end)

    b.MouseLeave:Connect(function()
        if animations then
            TweenService:Create(b, TweenInfo.new(0.15), {
                BackgroundColor3 = buttonColor
            }):Play()
        end
    end)

    return b
end

local function notify(text)
    if not notifications then return end

    local n = Instance.new("TextLabel")
    n.Size = UDim2.fromOffset(220, 45)
    n.Position = UDim2.new(0.5, -110, 0.1, 0)
    n.BackgroundColor3 = panel
    n.TextColor3 = white
    n.Text = text
    n.Font = Enum.Font.GothamSemibold
    n.TextSize = 13
    n.Parent = gui

    Instance.new("UICorner", n).CornerRadius =
        UDim.new(0, 8)

    task.delay(2.5, function()
        n:Destroy()
    end)
end

local function home()
    clear()
    label("Welcome to Syla Hub V3 ✨", 45)
    label("Your personal mobile Roblox hub.", 40)
    label("Username: " .. player.Name, 35)
    label("Display name: " .. player.DisplayName, 35)
    label("User ID: " .. player.UserId, 35)
    label("Status: Ready", 35)
end

local function playerPage()
    clear()
    label("👤 PLAYER INFORMATION", 45)
    label("Username: " .. player.Name, 35)
    label("Display name: " .. player.DisplayName, 35)
    label("User ID: " .. player.UserId, 35)

    button("🔄 Refresh", function()
        playerPage()
        notify("Information refreshed!")
    end)
end

local function features()
    clear()
    label("⭐ FEATURES", 45)

    button("🔄 Refresh Player", function()
        playerPage()
    end)

    button("♻️ Reset Character", function()
        local character = player.Character
        local humanoid = character and
            character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.Health = 0
            notify("Character reset!")
        end
    end)

    button("📍 Return to Spawn", function()
        notify("Spawn is controlled by your game.")
    end)
end

local function settings()
    clear()
    label("⚙️ SETTINGS", 45)

    button("✨ Animations: " ..
        (animations and "ON" or "OFF"), function()
        animations = not animations
        settings()
    end)

    button("🔔 Notifications: " ..
        (notifications and "ON" or "OFF"), function()
        notifications = not notifications
        settings()
    end)

    button("🎨 Transparency: " ..
        math.floor(transparency * 100) .. "%", function()

        transparency = (transparency + 0.25) % 1
        main.BackgroundTransparency = transparency
        settings()
    end)

    button("🔄 Reset Settings", function()
        animations = true
        notifications = true
        transparency = 0
        main.BackgroundTransparency = 0
        settings()
        notify("Settings reset!")
    end)
end

local function sidebarButton(text, y, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 43)
    b.Position = UDim2.fromOffset(5, y)
    b.BackgroundColor3 = buttonColor
    b.Text = text
    b.TextColor3 = white
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 12
    b.Parent = sidebar

    Instance.new("UICorner", b).CornerRadius =
        UDim.new(0, 7)

    b.Activated:Connect(callback)
end

sidebarButton("🏠 Home", 10, home)
sidebarButton("👤 Player", 60, playerPage)
sidebarButton("⭐ Features", 110, features)
sidebarButton("⚙️ Settings", 160, settings)

-- TOUCH DRAGGING
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then

        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

home()
notify("Syla Hub V3 Loaded!")

print("Syla Hub V3 Started")
