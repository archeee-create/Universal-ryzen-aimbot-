if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInput = game:GetService("VirtualInputManager")

-- ========== СОЗДАЁМ МЕНЮ ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VibeFarmUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Position = UDim2.new(0.5, -160, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- Закругление
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 16)
Corner.Parent = MainFrame

-- Градиентный фон
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 15, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 25, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 35, 45))
})
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- Анимация градиента
spawn(function()
    local angle = 0
    while wait(0.05) do
        angle = (angle + 0.5) % 360
        Gradient.Rotation = angle
    end
end)

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✦ Vibe Farm ✦"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Разделитель
local Line = Instance.new("Frame")
Line.Size = UDim2.new(0.9, 0, 0, 2)
Line.Position = UDim2.new(0.05, 0, 0, 45)
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BackgroundTransparency = 0.3
Line.Parent = MainFrame

-- ========== ПЕРЕКЛЮЧАТЕЛЬ 1 ==========
local FarmFrame = Instance.new("Frame")
FarmFrame.Size = UDim2.new(0.9, 0, 0, 45)
FarmFrame.Position = UDim2.new(0.05, 0, 0, 60)
FarmFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
FarmFrame.BackgroundTransparency = 0.3
FarmFrame.BorderSizePixel = 0
FarmFrame.Parent = MainFrame

local FarmCorner = Instance.new("UICorner")
FarmCorner.CornerRadius = UDim.new(0, 10)
FarmCorner.Parent = FarmFrame

local FarmLabel = Instance.new("TextLabel")
FarmLabel.Size = UDim2.new(0.6, 0, 1, 0)
FarmLabel.Position = UDim2.new(0.05, 0, 0, 0)
FarmLabel.BackgroundTransparency = 1
FarmLabel.Text = "⚙️ Авто-фарм"
FarmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmLabel.TextScaled = true
FarmLabel.Font = Enum.Font.Gotham
FarmLabel.TextXAlignment = Enum.TextXAlignment.Left
FarmLabel.Parent = FarmFrame

local FarmBtn = Instance.new("TextButton")
FarmBtn.Size = UDim2.new(0, 50, 0, 28)
FarmBtn.Position = UDim2.new(0.85, -25, 0.5, -14)
FarmBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
FarmBtn.Text = "OFF"
FarmBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
FarmBtn.TextScaled = true
FarmBtn.Font = Enum.Font.GothamBold
FarmBtn.Parent = FarmFrame

local FarmBtnCorner = Instance.new("UICorner")
FarmBtnCorner.CornerRadius = UDim.new(0, 8)
FarmBtnCorner.Parent = FarmBtn

local AutoFarm = false
FarmBtn.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    if AutoFarm then
        FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        FarmBtn.Text = "ON"
        FarmBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        FarmBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        FarmBtn.Text = "OFF"
        FarmBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- ========== ПЕРЕКЛЮЧАТЕЛЬ 2 ==========
local RescueFrame = Instance.new("Frame")
RescueFrame.Size = UDim2.new(0.9, 0, 0, 45)
RescueFrame.Position = UDim2.new(0.05, 0, 0, 115)
RescueFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
RescueFrame.BackgroundTransparency = 0.3
RescueFrame.BorderSizePixel = 0
RescueFrame.Parent = MainFrame

local RescueCorner = Instance.new("UICorner")
RescueCorner.CornerRadius = UDim.new(0, 10)
RescueCorner.Parent = RescueFrame

local RescueLabel = Instance.new("TextLabel")
RescueLabel.Size = UDim2.new(0.6, 0, 1, 0)
RescueLabel.Position = UDim2.new(0.05, 0, 0, 0)
RescueLabel.BackgroundTransparency = 1
RescueLabel.Text = "🆘 Авто-спасение"
RescueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RescueLabel.TextScaled = true
RescueLabel.Font = Enum.Font.Gotham
RescueLabel.TextXAlignment = Enum.TextXAlignment.Left
RescueLabel.Parent = RescueFrame

local RescueBtn = Instance.new("TextButton")
RescueBtn.Size = UDim2.new(0, 50, 0, 28)
RescueBtn.Position = UDim2.new(0.85, -25, 0.5, -14)
RescueBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
RescueBtn.Text = "OFF"
RescueBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
RescueBtn.TextScaled = true
RescueBtn.Font = Enum.Font.GothamBold
RescueBtn.Parent = RescueFrame

local RescueBtnCorner = Instance.new("UICorner")
RescueBtnCorner.CornerRadius = UDim.new(0, 8)
RescueBtnCorner.Parent = RescueBtn

local AutoRescue = false
RescueBtn.MouseButton1Click:Connect(function()
    AutoRescue = not AutoRescue
    if AutoRescue then
        RescueBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        RescueBtn.Text = "ON"
        RescueBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        RescueBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        RescueBtn.Text = "OFF"
        RescueBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- ========== СТАТУС ==========
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(0.9, 0, 0, 36)
StatusFrame.Position = UDim2.new(0.05, 0, 0, 175)
StatusFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
StatusFrame.BackgroundTransparency = 0.6
StatusFrame.BorderSizePixel = 0
StatusFrame.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 10)
StatusCorner.Parent = StatusFrame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Ожидание..."
StatusText.TextColor3 = Color3.fromRGB(180, 180, 255)
StatusText.TextScaled = true
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = StatusFrame

-- ========== КНОПКА ЗАКРЫТИЯ ==========
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -30, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BackgroundTransparency = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local MenuVisible = true
CloseBtn.MouseButton1Click:Connect(function()
    MenuVisible = not MenuVisible
    MainFrame.Visible = MenuVisible
end)

-- ========== ОТКРЫТИЕ/ЗАКРЫТИЕ ПО INSERT ==========
UserInputService.InputBegan:Connect(function(Input, Processed)
    if Processed then return end
    if Input.KeyCode == Enum.KeyCode.Insert then
        MenuVisible = not MenuVisible
        MainFrame.Visible = MenuVisible
    end
end)

-- ========== ФУНКЦИЯ ОБНОВЛЕНИЯ СТАТУСА ==========
local function UpdateStatus(Text)
    StatusText.Text = Text
end

-- ========== ЯДРО СКРИПТА ==========

local function IsKiller(Player)
    if not Player then return false end
    if Player.Team then
        local TeamName = Player.Team.Name:lower()
        if TeamName:find("killer") or TeamName:find("maniac") or TeamName:find("kill") then
            return true
        end
    end
    return false
end

local function IsKillerNearby(Position, Radius)
    Radius = Radius or 25
    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and IsKiller(Player) then
            local Char = Player.Character
            if Char and Char:FindFirstChild("HumanoidRootPart") then
                local dist = (Position - Char.HumanoidRootPart.Position).Magnitude
                if dist < Radius then
                    return true
                end
            end
        end
    end
    return false
end

local function AutoSkillCheck()
    local skillCheckFrame = nil
    local whiteZone = nil
    
    for _, v in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if v.Name == "SkillCheckFrame" then
            skillCheckFrame = v
        end
        if v.Name == "WhiteZone" or v.Name == "PerfectZone" then
            whiteZone = v
        end
    end
    
    if not skillCheckFrame or not whiteZone then
        return false
    end
    
    local arrow = skillCheckFrame:FindFirstChild("Arrow")
    if not arrow then return false end
    
    local arrowPos = arrow.Position.X.Scale
    local whitePos = whiteZone.Position.X.Scale
    local whiteSize = whiteZone.Size.X.Scale
    
    local isInWhite = arrowPos >= whitePos and arrowPos <= whitePos + whiteSize
    
    if isInWhite then
        VirtualInput:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        wait(0.05)
        VirtualInput:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        return true
    end
    return false
end

local LastTeleportPos = nil
local LastTeleportTime = 0

local function TeleportTo(Position)
    if not Position then return false end
    
    if LastTeleportPos and LastTeleportTime then
        local dist = (Position - LastTeleportPos).Magnitude
        if dist < 2 and tick() - LastTeleportTime < 3 then
            UpdateStatus("⏳ Уже телепортировался сюда")
            return false
        end
    end
    
    if IsKillerNearby(Position, 25) then
        UpdateStatus("⚠️ Убийца рядом! Телепорт отменён")
        return false
    end
    
    local Char = LocalPlayer.Character
    if not Char then return false end
    local RootPart = Char:FindFirstChild("HumanoidRootPart")
    if not RootPart then return false end
    
    RootPart.CFrame = CFrame.new(Position)
    LastTeleportPos = Position
    LastTeleportTime = tick()
    UpdateStatus("✅ Телепорт выполнен")
    return true
end

local function FindNearestBrokenGen(Radius)
    Radius = Radius or 500
    local Char = LocalPlayer.Character
    if not Char then return nil end
    local RootPart = Char:FindFirstChild("HumanoidRootPart")
    if not RootPart then return nil end
    
    local nearestGen = nil
    local nearestDist = math.huge
    
    for _, Gen in pairs(workspace:GetDescendants()) do
        if Gen.Name == "Generator" and Gen:FindFirstChild("Broken") and Gen.Broken.Value == true then
            if Gen:FindFirstChild("Position") then
                local dist = (RootPart.Position - Gen.Position.Value).Magnitude
                if dist < Radius and dist < nearestDist then
                    nearestDist = dist
                    nearestGen = Gen
                end
            end
        end
    end
    return nearestGen
end

local function FindNearestDownedPlayer()
    local Char = LocalPlayer.Character
    if not Char then return nil end
    local RootPart = Char:FindFirstChild("HumanoidRootPart")
    if not RootPart then return nil end
    
    local nearestPlayer = nil
    local nearestDist = math.huge
    
    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and not IsKiller(Player) then
            local TargetChar = Player.Character
            if TargetChar and TargetChar:FindFirstChild("HumanoidRootPart") and TargetChar:FindFirstChild("Humanoid") then
                local Humanoid = TargetChar.Humanoid
                
                if IsKillerNearby(TargetChar.HumanoidRootPart.Position, 20) then
                    continue
                end
                
                local dist = (RootPart.Position - TargetChar.HumanoidRootPart.Position).Magnitude
                local IsInjured = Humanoid.Health > 0 and Humanoid.Health < Humanoid.MaxHealth
                local IsHooked = TargetChar:FindFirstChild("Hooked") ~= nil
                
                if (IsInjured or IsHooked) and dist < nearestDist then
                    nearestDist = dist
                    nearestPlayer = Player
                end
            end
        end
    end
    return nearestPlayer
end

local function AreAllGensFixed(Radius)
    Radius = Radius or 500
    local Char = LocalPlayer.Character
    if not Char then return true end
    local RootPart = Char:FindFirstChild("HumanoidRootPart")
    if not RootPart then return true end
    
    for _, Gen in pairs(workspace:GetDescendants()) do
        if Gen.Name == "Generator" and Gen:FindFirstChild("Broken") and Gen.Broken.Value == true then
            if Gen:FindFirstChild("Position") then
                local dist = (RootPart.Position - Gen.Position.Value).Magnitude
                if dist < Radius then
                    return false
                end
            end
        end
    end
    return true
end

-- ========== АНТИ-AFK ==========
local function AntiAFK()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end
AntiAFK()

-- ========== ГЛАВНЫЙ ЦИКЛ ==========
local function MainLoop()
    while wait(0.5) do
        UpdateStatus("🔄 Сканирование карты...")
        
        if AutoFarm then
            local Gen = FindNearestBrokenGen(500)
            if Gen then
                UpdateStatus("🔧 Чиню генератор...")
                local Success = TeleportTo(Gen.Position.Value)
                if Success then
                    local RepairStart = tick()
                    while tick() - RepairStart < 30 do
                        AutoSkillCheck()
                        wait(0.1)
                        if Gen:FindFirstChild("Broken") and Gen.Broken.Value == false then
                            break
                        end
                    end
                    if Gen:FindFirstChild("Broken") then
                        Gen.Broken.Value = false
                        UpdateStatus("✅ Генератор починен!")
                    end
                end
            else
                if AreAllGensFixed(500) then
                    UpdateStatus("⚡ Все генераторы починены!")
                    
                    local AllAlive = true
                    for _, Player in pairs(Players:GetPlayers()) do
                        if Player ~= LocalPlayer and not IsKiller(Player) then
                            local Char = Player.Character
                            if Char and Char:FindFirstChild("Humanoid") then
                                if Char.Humanoid.Health <= 0 then
                                    AllAlive = false
                                end
                            end
                        end
                    end
                    
                    if AllAlive then
                        local GateFound = false
                        for _, Gate in pairs(workspace:GetDescendants()) do
                            if Gate.Name:lower():find("gate") or Gate.Name:lower():find("exit") then
                                if Gate:FindFirstChild("Position") then
                                    local dist = (LocalPlayer.Character.HumanoidRootPart.Position - Gate.Position.Value).Magnitude
                                    if dist < 500 then
                                        UpdateStatus("🚪 Телепорт к выходу!")
                                        TeleportTo(Gate.Position.Value)
                                        GateFound = true
                                        break
                                    end
                                end
                            end
                        end
                        if not GateFound then
                            UpdateStatus("🚪 Выход не найден")
                        end
                    end
                else
                    UpdateStatus("⏳ Поиск генераторов...")
                end
            end
        end
        
        if AutoRescue then
            local TargetPlayer = FindNearestDownedPlayer()
            if TargetPlayer then
                local TargetChar = TargetPlayer.Character
                if TargetChar then
                    local Humanoid = TargetChar:FindFirstChild("Humanoid")
                    if Humanoid then
                        if TargetChar:FindFirstChild("Hooked") then
                            UpdateStatus("🆘 Снимаю " .. TargetPlayer.Name)
                            TeleportTo(TargetChar.HumanoidRootPart.Position + Vector3.new(0, 2, 0))
                            wait(1)
                            local Hook = TargetChar:FindFirstChild("Hooked")
                            if Hook then Hook:Destroy() end
                        elseif Humanoid.Health > 0 and Humanoid.Health < Humanoid.MaxHealth then
                            UpdateStatus("💊 Лечу " .. TargetPlayer.Name)
                            TeleportTo(TargetChar.HumanoidRootPart.Position + Vector3.new(0, 2, 0))
                            wait(2)
                            Humanoid.Health = Humanoid.MaxHealth
                        end
                    end
                end
            else
                UpdateStatus("💚 Все здоровы и свободны")
            end
        end
    end
end

spawn(MainLoop)

print("✦ Vibe Farm Script with custom UI loaded!")
