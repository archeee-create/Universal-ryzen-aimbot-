local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local Settings = {
    AimBot = {
        Enabled = false,
        FOV = 120,
        Smoothness = 0.3,
        TargetPart = "Head",
        TeamCheck = false,
        WallCheck = false
    },
    ESP = {
        Enabled = false,
        Box = false,
        Tracers = false,
        Health = false,
        Distance = false,
        TeamColor = false
    }
}

local checkboxes = {}

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

local function createDropdown(parent, yPos, label, options, settingPath, defaultIndex)
    local path = {}
    for part in string.gmatch(settingPath, "[^%.]+") do
        table.insert(path, part)
    end
    
    local currentIndex = defaultIndex or 1
    local isOpen = false
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.95, 0, 0, 70)
    container.Position = UDim2.new(0.025, 0, 0, yPos)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(1, 0, 0, 20)
    labelText.Position = UDim2.new(0, 0, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = Color3.fromRGB(200, 200, 200)
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.TextScaled = true
    labelText.Font = Enum.Font.SourceSans
    labelText.Parent = container
    
    local mainButton = Instance.new("TextButton")
    mainButton.Size = UDim2.new(1, 0, 0, 30)
    mainButton.Position = UDim2.new(0, 0, 0, 22)
    mainButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    mainButton.BorderSizePixel = 1
    mainButton.BorderColor3 = Color3.fromRGB(0, 255, 200)
    mainButton.Text = options[currentIndex]
    mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainButton.TextScaled = true
    mainButton.Font = Enum.Font.SourceSans
    mainButton.TextXAlignment = Enum.TextXAlignment.Left
    mainButton.TextTruncate = Enum.TextTruncate.None
    mainButton.Parent = container
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = mainButton
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 30, 1, 0)
    arrow.Position = UDim2.new(1, -30, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = Color3.fromRGB(0, 255, 200)
    arrow.TextScaled = true
    arrow.Font = Enum.Font.SourceSansBold
    arrow.Parent = mainButton
    
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    dropdownFrame.Position = UDim2.new(0, 0, 0, 52)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    dropdownFrame.BorderSizePixel = 1
    dropdownFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
    dropdownFrame.Visible = false
    dropdownFrame.Parent = container
    
    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropdownFrame
    
    local optionButtons = {}
    
    for i, option in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 30)
        optBtn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
        optBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
        optBtn.BackgroundTransparency = 0
        optBtn.BorderSizePixel = 0
        optBtn.Text = option
        optBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
        optBtn.TextScaled = true
        optBtn.Font = Enum.Font.SourceSans
        optBtn.TextXAlignment = Enum.TextXAlignment.Left
        optBtn.TextTruncate = Enum.TextTruncate.None
        optBtn.Parent = dropdownFrame
        
        local dot = Instance.new("TextLabel")
        dot.Size = UDim2.new(0, 20, 1, 0)
        dot.Position = UDim2.new(0.95, 0, 0, 0)
        dot.BackgroundTransparency = 1
        dot.Text = (i == currentIndex) and "●" or "○"
        dot.TextColor3 = (i == currentIndex) and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(100, 100, 120)
        dot.TextScaled = true
        dot.Font = Enum.Font.SourceSansBold
        dot.Parent = optBtn
        
        optBtn.MouseButton1Click:Connect(function()
            currentIndex = i
            mainButton.Text = options[i]
            
            for j, btn in ipairs(optionButtons) do
                local dotLabel = btn:FindFirstChildWhichIsA("TextLabel")
                if dotLabel then
                    dotLabel.Text = (j == i) and "●" or "○"
                    dotLabel.TextColor3 = (j == i) and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(100, 100, 120)
                end
            end
            
            dropdownFrame.Visible = false
            isOpen = false
            arrow.Text = "▼"
            
            local target = Settings
            for j = 1, #path - 1 do
                target = target[path[j]]
            end
            target[path[#path]] = options[i]
            
            if options[i] == "Torso" then
                target[path[#path]] = "UpperTorso"
            end
        end)
        
        table.insert(optionButtons, optBtn)
    end
    
    mainButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        dropdownFrame.Visible = isOpen
        arrow.Text = isOpen and "▲" or "▼"
    end)
    
    return container
end

local function createCheckbox(parent, yPos, label, settingPath, default)
    local path = {}
    for part in string.gmatch(settingPath, "[^%.]+") do
        table.insert(path, part)
    end
    
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
    
    local current = default
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
    
    local function toggle()
        current = not current
        updateCheckbox()
        
        local target = Settings
        for i = 1, #path - 1 do
            target = target[path[i]]
        end
        target[path[#path]] = current
    end
    
    checkbox.MouseButton1Click:Connect(toggle)
    text.MouseButton1Click:Connect(toggle)
    
    table.insert(checkboxes, {
        container = container,
        checkbox = checkbox,
        text = text,
        toggle = toggle,
        current = current,
        update = updateCheckbox
    })
    
    return checkbox
end

local function createSliderWithInput(parent, yPos, label, settingPath, minVal, maxVal, defaultValue)
    local path = {}
    for part in string.gmatch(settingPath, "[^%.]+") do
        table.insert(path, part)
    end
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.95, 0, 0, 70)
    container.Position = UDim2.new(0.025, 0, 0, yPos)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.6, 0, 0, 20)
    labelText.Position = UDim2.new(0, 0, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = Color3.fromRGB(200, 200, 200)
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.TextScaled = true
    labelText.Font = Enum.Font.SourceSans
    labelText.Parent = container
    
    local valueDisplay = Instance.new("TextLabel")
    valueDisplay.Size = UDim2.new(0.25, 0, 0, 20)
    valueDisplay.Position = UDim2.new(0.75, 0, 0, 0)
    valueDisplay.BackgroundTransparency = 1
    valueDisplay.Text = tostring(defaultValue)
    valueDisplay.TextColor3 = Color3.fromRGB(0, 255, 200)
    valueDisplay.TextXAlignment = Enum.TextXAlignment.Right
    valueDisplay.TextScaled = true
    valueDisplay.Font = Enum.Font.SourceSansBold
    valueDisplay.Parent = container
    
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Size = UDim2.new(0.7, 0, 0, 6)
    sliderTrack.Position = UDim2.new(0, 0, 0, 25)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Parent = container
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 3)
    trackCorner.Parent = sliderTrack
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((defaultValue - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = sliderFill
    
    local sliderKnob = Instance.new("ImageButton")
    sliderKnob.Size = UDim2.new(0, 20, 0, 20)
    sliderKnob.Position = UDim2.new((defaultValue - minVal) / (maxVal - minVal), -10, 0.5, -10)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    sliderKnob.Image = "rbxassetid://3926305904"
    sliderKnob.ImageColor3 = Color3.fromRGB(0, 255, 200)
    sliderKnob.BorderSizePixel = 2
    sliderKnob.BorderColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.Parent = sliderTrack
    
    local inputFrame = Instance.new("TextButton")
    inputFrame.Size = UDim2.new(0.25, 0, 0, 25)
    inputFrame.Position = UDim2.new(0.75, 0, 0, 35)
    inputFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    inputFrame.BorderSizePixel = 1
    inputFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
    inputFrame.Text = tostring(defaultValue)
    inputFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputFrame.TextScaled = true
    inputFrame.Font = Enum.Font.SourceSans
    inputFrame.Parent = container
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 4)
    inputCorner.Parent = inputFrame
    
    local currentValue = defaultValue
    
    local function updateSlider(value)
        value = math.clamp(value, minVal, maxVal)
        value = math.round(value)
        currentValue = value
        
        valueDisplay.Text = tostring(value)
        inputFrame.Text = tostring(value)
        
        local percent = (value - minVal) / (maxVal - minVal)
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        sliderKnob.Position = UDim2.new(percent, -10, 0.5, -10)
        
        local target = Settings
        for i = 1, #path - 1 do
            target = target[path[i]]
        end
        target[path[#path]] = value
    end
    
    local draggingSlider = false
    
    sliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
        end
    end)
    
    sliderKnob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)
    
    sliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            local pos = input.Position.X - sliderTrack.AbsolutePosition.X
            local percent = math.clamp(pos / sliderTrack.AbsoluteSize.X, 0, 1)
            local value = minVal + (maxVal - minVal) * percent
            updateSlider(value)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and input.UserInputType == Enum.UserInputType.Touch then
            local pos = input.Position.X - sliderTrack.AbsolutePosition.X
            local percent = math.clamp(pos / sliderTrack.AbsoluteSize.X, 0, 1)
            local value = minVal + (maxVal - minVal) * percent
            updateSlider(value)
        end
    end)
    
    local inputActive = false
    local inputText = ""
    
    inputFrame.MouseButton1Click:Connect(function()
        inputActive = true
        inputText = tostring(currentValue)
        inputFrame.Text = inputText .. "|"
        
        TextService:OpenVirtualKeyboard(Enum.VirtualKeyboardType.NumberPad)
        
        local function onInputBegan(input, gameProcessed)
            if gameProcessed then return end
            if not inputActive then return end
            
            if input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.DpadDown then
                inputActive = false
                local num = tonumber(inputText)
                if num then
                    updateSlider(num)
                else
                    updateSlider(currentValue)
                end
                inputFrame.Text = tostring(currentValue)
                TextService:CloseVirtualKeyboard()
                return
            end
            
            if input.KeyCode == Enum.KeyCode.Backspace then
                inputText = string.sub(inputText, 1, -2)
            else
                local char = input.KeyCode.Name:match("%d")
                if char then
                    inputText = inputText .. char
                end
            end
            
            inputFrame.Text = inputText .. "|"
        end
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            onInputBegan(input, gameProcessed)
            if not inputActive then
                connection:Disconnect()
            end
        end)
    end)
    
    updateSlider(defaultValue)
    return sliderTrack
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

createCheckbox(scrollFrame, y, "Aimbot", "AimBot.Enabled", false)
y = y + 45

createCheckbox(scrollFrame, y, "Wall Check", "AimBot.WallCheck", false)
y = y + 45

createSliderWithInput(scrollFrame, y, "FOV Range", "AimBot.FOV", 10, 360, 120)
y = y + 80

createCheckbox(scrollFrame, y, "Team Check", "AimBot.TeamCheck", false)
y = y + 50

createDropdown(scrollFrame, y, "Target", {"Head", "Torso"}, "AimBot.TargetPart", 1)
y = y + 80

local espLabel = Instance.new("TextLabel")
espLabel.Size = UDim2.new(1, 0, 0, 25)
espLabel.Position = UDim2.new(0, 0, 0, y)
espLabel.BackgroundTransparency =
