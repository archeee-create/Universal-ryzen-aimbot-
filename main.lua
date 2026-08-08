local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

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
local clickStart = nil
local isDragging = false

FloatButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        clickStart = tick()
        dragStart = input.Position
        startPos = FloatButton.Position
        dragging = true
        isDragging = false
    end
end)

FloatButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and dragging then
        dragging = false
        local elapsed = tick() - clickStart
        if elapsed < 0.3 and not isDragging then
            menuOpen = not menuOpen
            MainFrame.Visible = menuOpen
            Overlay.Visible = menuOpen
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        if delta.Magnitude > 10 then
            isDragging = true
        end
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
MainFrame.Size = UDim2.new(0, 370, 0, 400)
MainFrame.Position = UDim2.new(0.5, -185, 0.5, -200)
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

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 0, 310)
scrollFrame.Position = UDim2.new(0, 0, 0, 48)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 200)
scrollFrame.Parent = MainFrame

local function createLabel(parent, y, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.Position = UDim2.new(0, 0, 0, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 255, 200)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.Parent = parent
    return label
end

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

local y = 5
createLabel(scrollFrame, y, "AIMBOT")
y = y + 30
createCheckbox(scrollFrame, y, "Aimbot")
y = y + 45
createCheckbox(scrollFrame, y, "Wall Check")
y = y + 45
createCheckbox(scrollFrame, y, "Team Check")
y = y + 60
createLabel(scrollFrame, y, "ESP")
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

local destroyCorner = Instance.new("UICorner")
destroyCorner.CornerRadius = UDim.new(0, 6)
destroyCorner.Parent = destroyBtn

destroyBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    Overlay.Visible = false
    ScreenGui:Destroy()
end)

local menuOpen = false
