local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local Settings = {
    AimBot = {Enabled = false, FOV = 120, Smoothness = 0.3, TargetPart = "Head", TeamCheck = false, WallCheck = false},
    ESP = {Enabled = false, Box = false, Tracers = false, Health = false, Distance = false, TeamColor = false}
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RyzenMobile"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local FloatButton = Instance.new("ImageButton")
FloatButton.Size = UDim2.new(0, 70, 0, 70)
FloatButton.Position = UDim2.new(0.85, -35, 0.85, -35)
FloatButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
FloatButton.BackgroundTransparency = 0.2
FloatButton.BorderSizePixel = 2
FloatButton.BorderColor3 = Color3.fromRGB(0, 255, 200)
FloatButton.Image = "rbxassetid://3926305904"
FloatButton.ImageColor3 = Color3.fromRGB(0, 255, 200)
FloatButton.ImageTransparency = 0.5
FloatButton.Parent = ScreenGui

local ButtonLabel = Instance.new("TextLabel")
ButtonLabel.Size = UDim2.new(1, 0, 1, 0)
ButtonLabel.BackgroundTransparency = 1
ButtonLabel.Text = "UNIVERSAL"
ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonLabel.TextScaled = true
ButtonLabel.Font = Enum.Font.SourceSansBold
ButtonLabel.Parent = FloatButton

local dragging = false
local dragStart = nil
local startPos = nil

FloatButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = FloatButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        newPos = UDim2.new(
            math.clamp(newPos.X.Scale, 0, 1),
            math.clamp(newPos.X.Offset, 0, 0),
            math.clamp(newPos.Y.Scale, 0, 1),
            math.clamp(newPos.Y.Offset, 0, 0)
        )
        FloatButton.Position = newPos
    end
end)

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.5
Overlay.Visible = false
Overlay.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 370, 0, 620)
MainFrame.Position = UDim2.new(0.5, -185, 0.5, -310)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
Title.BackgroundTransparency = 0.3
Title.Text = "🤑 Ryzen aimbot 🤑"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.Selectable = false
Title.AutoButtonColor = false
Title.Active = false
Title.Parent = MainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = Title

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.9, 0, 0, 2)
Divider.Position = UDim2.new(0.05, 0, 0, 42)
Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Divider.BackgroundTransparency = 0.5
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- Создание кнопок упрощённое (без сложных функций)
local function createCheckbox(parent, yPos, label)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.95, 0, 0, 40)
    container.Position = UDim2.new(0.025, 0, 0, yPos)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    local checkbox = Instance.new("TextButton")
    checkbox.Size = UDim2.new(0, 30, 0, 30)
    checkbox.Position = UDim2.new(0, 0, 0.5, -15)
    checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    checkbox.BorderSizePixel = 2
    checkbox.BorderColor3 = Color3.fromRGB(150, 150, 170)
    checkbox.Text = ""
    checkbox.TextColor3 = Color3.fromRGB(0, 255, 100)
    checkbox.TextScaled = true
    checkbox.Font = Enum.Font.SourceSansBold
    checkbox.Parent = container
    
    local chkCorner = Instance.new("UICorner")
    chkCorner.CornerRadius = UDim.new(0, 4)
    chkCorner.Parent = checkbox
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -40, 1, 0)
    text.Position = UDim2.new(0, 40, 0, 0)
    text.BackgroundTransparency = 1
    text.Text = label
    text.TextColor3 = Color3.fromRGB(220, 220, 220)
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextScaled = true
    text.Font = Enum.Font.SourceSans
    text.Parent = container
    
    local current = false
    local function updateCheckbox()
        if current then
            checkbox.Text = "✓"
            checkbox.TextColor3 = Color3.fromRGB(0, 255, 100)
            checkbox.BorderColor3 = Color3.fromRGB(0, 255, 100)
            checkbox.BackgroundColor3 = Color3.fromRGB(0, 50, 25)
        else
            checkbox.Text = ""
            checkbox.TextColor3 = Color3.fromRGB(0, 255, 100)
            checkbox.BorderColor3 = Color3.fromRGB(150, 150, 170)
            checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        end
    end
    updateCheckbox()
    
    checkbox.MouseButton1Click:Connect(function()
        current = not current
        updateCheckbox()
    end)
    
    text.MouseButton1Click:Connect(function()
        current = not current
        updateCheckbox()
    end)
    
    return checkbox
end

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 0, 470)
scrollFrame.Position = UDim2.new(0, 0, 0, 48)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 700)
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 200)
scrollFrame.Parent = MainFrame

local y = 5

local aimLabel = Instance.new("TextLabel")
aimLabel.Size = UDim2.new(1, 0, 0, 25)
aimLabel.Position = UDim2.new(0, 0, 0, y)
aimLabel.BackgroundTransparency = 1
aimLabel.Text = "AIMBOT"
aimLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
aimLabel.TextScaled = true
aimLabel.Font = Enum.Font.SourceSansBold
aimLabel.Parent = scrollFrame
y = y + 30

createCheckbox(scrollFrame, y, "Aimbot")
y = y + 45

createCheckbox(scrollFrame, y, "Wall Check")
y = y + 45

-- Слайдер FOV (упрощённый)
local sliderContainer = Instance.new("Frame")
sliderContainer.Size = UDim2.new(0.95, 0, 0, 70)
sliderContainer.Position = UDim2.new(0.025, 0, 0, y)
sliderContainer.BackgroundTransparency = 1
sliderContainer.Parent = scrollFrame
y = y + 80

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Size = UDim2.new(0.6, 0, 0, 20)
sliderLabel.Position = UDim2.new(0, 0, 0, 0)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = "FOV Range: 120"
sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
sliderLabel.TextScaled = true
sliderLabel.Font = Enum.Font.SourceSans
sliderLabel.Parent = sliderContainer

local sliderTrack = Instance.new("Frame")
sliderTrack.Size = UDim2.new(0.7, 0, 0, 6)
sliderTrack.Position = UDim2.new(0, 0, 0, 25)
sliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
sliderTrack.BorderSizePixel = 0
sliderTrack.Parent = sliderContainer

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.3, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderTrack

local sliderKnob = Instance.new("ImageButton")
sliderKnob.Size = UDim2.new(0, 20, 0, 20)
sliderKnob.Position = UDim2.new(0.3, -10, 0.5, -10)
sliderKnob.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
sliderKnob.Image = "rbxassetid://3926305904"
sliderKnob.ImageColor3 = Color3.fromRGB(0, 255, 200)
sliderKnob.BorderSizePixel = 2
sliderKnob.BorderColor3 = Color3.fromRGB(255, 255, 255)
sliderKnob.Parent = sliderTrack

createCheckbox(scrollFrame, y, "Team Check")
y = y + 50

createCheckbox(scrollFrame, y, "Target (Head/Torso)")
y = y + 80

local espLabel = Instance.new("TextLabel")
espLabel.Size = UDim2.new(1, 0, 0, 25)
espLabel.Position = UDim2.new(0, 0, 0, y)
espLabel.BackgroundTransparency = 1
espLabel.Text = "ESP"
espLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
espLabel.TextScaled = true
espLabel.Font = Enum.Font.SourceSansBold
espLabel.Parent = scrollFrame
y = y + 30

createCheckbox(scrollFrame, y, "ESP Total")
y = y + 45
createCheckbox(scrollFrame, y, "Box ESP")
y = y + 45
createCheckbox(scrollFrame, y, "Tracers")
y = y + 45
createCheckbox(scrollFrame, y, "Health Bar")
y = y + 45
createCheckbox(scrollFrame, y, "Distance")
y = y + 45
createCheckbox(scrollFrame, y, "Team Colors")

scrollFrame.CanvasSize = UDim2.new(0, 0, 0, y + 50)

local bottomFrame = Instance.new("Frame")
bottomFrame.Size = UDim2.new(1, 0, 0, 60)
bottomFrame.Position = UDim2.new(0, 0, 1, -60)
bottomFrame.BackgroundTransparency = 1
bottomFrame.Parent = MainFrame

local dividerBottom = Instance.new("Frame")
dividerBottom.Size = UDim2.new(0.9, 0, 0, 2)
dividerBottom.Position = UDim2.new(0.05, 0, 0, 0)
dividerBottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dividerBottom.BackgroundTransparency = 0.3
dividerBottom.BorderSizePixel = 0
dividerBottom.Parent = bottomFrame

local offAllBtn = Instance.new("TextButton")
offAllBtn.Size = UDim2.new(0.43, 0, 0, 35)
offAllBtn.Position = UDim2.new(0.04, 0, 0, 10)
offAllBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
offAllBtn.BackgroundTransparency = 0.2
offAllBtn.BorderSizePixel = 2
offAllBtn.BorderColor3 = Color3.fromRGB(255, 200, 0)
offAllBtn.Text = "OFF ALL"
offAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
offAllBtn.TextScaled = true
offAllBtn.Font = Enum.Font.SourceSansBold
offAllBtn.Parent = bottomFrame

local offCorner = Instance.new("UICorner")
offCorner.CornerRadius = UDim.new(0, 6)
offCorner.Parent = offAllBtn

local destroyBtn = Instance.new("TextButton")
destroyBtn.Size = UDim2.new(0.43, 0, 0, 35)
destroyBtn.Position = UDim2.new(0.53, 0, 0, 10)
destroyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
destroyBtn.BackgroundTransparency = 0.2
destroyBtn.BorderSizePixel = 2
destroyBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
destroyBtn.Text = "!DESTROY!"
destroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
destroyBtn.TextScaled = true
destroyBtn.Font = Enum.Font.SourceSansBold
destroyBtn.Parent = bottomFrame

