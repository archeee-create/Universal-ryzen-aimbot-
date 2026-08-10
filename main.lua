if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local Mouse = LocalPlayer:GetMouse()

-- ========== UI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VibeFarmUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 320)
MainFrame.Position = UDim2.new(0.5, -160, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 16)
Corner.Parent = MainFrame

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 15, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 25, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 35, 45))
})
Gradient.Rotation = 45
Gradient.Parent = MainFrame

spawn(function()
    local angle = 0
    while wait(0.05) do
        angle = (angle + 0.5) % 360
        Gradient.Rotation = angle
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✦ Vibe Farm ✦"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Line = Instance.new("Frame")
Line.Size = UDim2.new(0.9, 0, 0, 2)
Line.Position = UDim2.new(0.05, 0, 0, 45)
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BackgroundTransparency = 0.3
Line.Parent = MainFrame

-- Переключатель 1 (Авто-фарм)
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

-- Переключатель 2 (Авто-спасение)
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

-- Статус
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

-- Кнопка закрытия
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

UserInputService.InputBegan:Connect(function(Input, Processed)
    if Processed then return end
    if Input.KeyCode == Enum.KeyCode.Insert then
        MenuVisible = not MenuVisible
        MainFrame.Visible = MenuVisible
    end
end)

local function UpdateStatus(Text)
    StatusText.Text = Text
end

-- ========== ЯДРО СКРИПТА ==========

-- Проверка на убийцу
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
    Radius = Radius or 15
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

-- ========== АВТО-СКИЛЛЧЕК (НАЖАТИЕ ПРОБЕЛ НА БЕЛОМ) ==========
local function AutoSkillCheck()
    local skillCheckFrame = nil
    local whiteZone = nil
    local arrow = nil
    
    -- Ищем элементы скиллчека в GUI
    for _, v in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if v.Name == "SkillCheckFrame" then
            skillCheckFrame = v
        end
        if v.Name == "WhiteZone" or v.Name == "PerfectZone" then
            whiteZone = v
        end
        if v.Name == "Arrow" then
            arrow = v
        end
    end
    
    if not skillCheckFrame or not whiteZone or not arrow then
        return false
    end
    
    -- Определяем позицию стрелки и белой зоны
    local arrowPos = arrow.Position.X.Scale
    local whitePos = whiteZone.Position.X.Scale
    local whiteSize = whiteZone.Size.X.Scale
    
    local isInWhite = arrowPos >= whitePos and arrowPos <= whitePos + whiteSize
    
    if isInWhite then
        -- Нажимаем пробел
        VirtualInput:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        wait(0.05)
        VirtualInput:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        return true
    end
    return false
end

-- ========== ТЕЛЕПОРТ ==========
local LastTeleportPos = nil
local LastTeleportTime = 0
local ReturnPosition = nil

local function TeleportTo(Position)
    if not Position then return false end
    
    if LastTeleportPos and LastTeleportTime then
        local dist = (Position - LastTeleportPos).Magnitude
        if dist < 2 and tick() - LastTeleportTime < 3 then
            return false
        end
    end
    
    if IsKillerNearby(Position, 15) then
        UpdateStatus("⚠️ Убийца рядом!")
        return false
    end
    
    local Char = LocalPlayer.Character
    if not Char then return false end
    local RootPart = Char:FindFirstChild("HumanoidRootPart")
    if not RootPart then return false end
    
    -- Запоминаем позицию (только для спасения)
    if AutoRescue then
        ReturnPosition = RootPart.Position
    end
    
    RootPart.CFrame = CFrame.new(Position)
    LastTeleportPos = Position
    LastTeleportTime = tick()
    return true
end

local function TeleportBack()
    if not ReturnPosition then return false end
    
    local Char = LocalPlayer.Character
    if not Char then return false end
    local RootPart = Char:FindFirstChild("HumanoidRootPart")
    if not RootPart then return false end
    
    RootPart.CFrame = CFrame.new(ReturnPosition)
    UpdateStatus("↩️ Вернулся на позицию")
    ReturnPosition = nil
    return true
end

-- ========== ПОИСК ГЕНЕРАТОРОВ ==========
local function FindNearestBrokenGen()
    local Char = LocalPlayer.Character
    if not Char then return nil end
    local RootPart = Char:FindFirstChild("HumanoidRootPart")
    if not RootPart then return nil end
    
    local nearestGen = nil
    local nearestDist = math.huge
    
    for _, Gen in pairs(workspace:GetDescendants()) do
        if Gen.Name == "Generator" and Gen:FindFirstChild("Broken") and Gen.Broken.Value == true then
            local pos = Gen:FindFirstChild("Position") or Gen:FindFirstChild("HumanoidRootPart") or Gen:FindFirstChild("PrimaryPart")
            if not pos then continue end
            local dist = (RootPart.Position - pos.Position).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearestGen = Gen
            end
        end
    end
    return nearestGen
end

-- ========== ПОИСК ВЫЖИВШИХ С HP <= 50 ИЛИ НА КОЛУ ==========
local function FindNearestSurvivorInNeed()
    local Char = LocalPlayer.Character
    if not Char then return nil end
    local RootPart = Char:FindFirstChild("HumanoidRootPart")
    if not RootPart then return nil end
    
    local nearestPlayer = nil
    local nearestDist = math.huge
    
    for _, Player in pairs(Players:GetPlayers()) do
        if Player == LocalPlayer then continue end
        if IsKiller(Player) then continue end
        
        local TargetChar = Player.Character
        if not TargetChar then continue end
        local Humanoid = TargetChar:FindFirstChild("Humanoid")
        if not Humanoid then continue end
        
        local Health = Humanoid.Health
        if Health <= 0 then continue end
        
        -- Проверяем: HP <= 50 или на колу
        local IsHooked = TargetChar:FindFirstChild("Hooked") or TargetChar:FindFirstChild("Spike")
        local IsInjured = Health <= 50
        
        if not IsHooked and not IsInjured then continue end
        
        local TargetPos = TargetChar:FindFirstChild("HumanoidRootPart")
        if not TargetPos then continue end
        
        if IsKillerNearby(TargetPos.Position, 15) then
            continue
        end
        
        local dist = (RootPart.Position - TargetPos.Position).Magnitude
        if dist < nearestDist then
            nearestDist = dist
            nearestPlayer = Player
        end
    end
    return nearestPlayer
end

-- ========== СНЯТИЕ С КОЛА ==========
local function UnhookPlayer(Player)
    local TargetChar = Player.Character
    if not TargetChar then return false end
    
    local Hook = TargetChar:FindFirstChild("Hooked") or TargetChar:FindFirstChild("Spike")
    if Hook then
        Hook:Destroy()
        UpdateStatus("✅ Снял " .. Player.Name .. " с кола!")
        return true
    end
    
    -- Пытаемся нажать правую кнопку для снятия
    if Mouse then
        VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton2, true, Mouse.X, Mouse.Y, 0)
        wait(0.1)
        VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton2, false, Mouse.X, Mouse.Y, 0)
        UpdateStatus("🖱️ Нажал правую кнопку для снятия")
        wait(0.5)
        if Hook then Hook:Destroy() end
        return true
    end
    return false
end

-- ========== ЛЕЧЕНИЕ ==========
local function HealPlayer(Player)
    local TargetChar = Player.Character
    if not TargetChar then return false end
    local Humanoid = TargetChar:FindFirstChild("Humanoid")
    if not Humanoid then return false end
    
    if Humanoid.Health > 0 and Humanoid.Health < Humanoid.MaxHealth then
        Humanoid.Health = Humanoid.MaxHealth
        UpdateStatus("💊 Вылечил " .. Player.Name)
        return true
    end
    return false
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
    while wait(1) do
        UpdateStatus("🔄 Сканирование...")
        
        -- ===== АВТО-ФАРМ (без возврата) =====
        if AutoFarm then
            local Gen = FindNearestBrokenGen()
            if Gen then
                UpdateStatus("🔧 Ищу генератор...")
                local pos = Gen:FindFirstChild("Position") or Gen:FindFirstChild("HumanoidRootPart") or Gen:FindFirstChild("PrimaryPart")
                if pos then
                    if TeleportTo(pos.Position) then
                        UpdateStatus("🔧 Чиню генератор (авто-скиллчек)...")
                        local repairTime = 0
                        local success = false
                        while repairTime < 30 and Gen.Parent and Gen.Broken and Gen.Broken.Value == true do
                            if AutoSkillCheck() then
                                UpdateStatus("✅ Идеальный скиллчек!")
                            end
                            wait(0.3)
                            repairTime = repairTime + 0.3
                        end
                        if Gen.Broken and Gen.Broken.Value == false then
                            UpdateStatus("✅ Генератор починен!")
                        else
                            UpdateStatus("⏳ Генератор ещё чинится...")
                        end
                        -- НЕ ВОЗВРАЩАЕМСЯ
                    end
                end
            else
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
                    for _, Gate in pairs(workspace:GetDescendants()) do
                        if Gate.Name:lower():find("gate") or Gate.Name:lower():find("exit") then
                            if Gate:FindFirstChild("Position") then
                                UpdateStatus("🚪 Телепорт к выходу!")
                                TeleportTo(Gate.Position.Value)
                                break
                            end
                        end
                    end
                end
            end
        end
        
        -- ===== АВТО-СПАСЕНИЕ (с возвратом) =====
        if AutoRescue then
            local TargetPlayer = FindNearestSurvivorInNeed()
            if TargetPlayer then
                local TargetChar = TargetPlayer.Character
                if TargetChar then
                    local Humanoid = TargetChar:FindFirstChild("Humanoid")
                    if Humanoid then
                        local Health = Humanoid.Health
                        local IsHooked = TargetChar:FindFirstChild("Hooked") or TargetChar:FindFirstChild("Spike")
                        
                        if IsHooked then
                            UpdateStatus("🆘 Снимаю " .. TargetPlayer.Name .. " (HP: " .. math.floor(Health) .. ")")
                            local pos = TargetChar:FindFirstChild("HumanoidRootPart")
                            if pos and TeleportTo(pos.Position + Vector3.new(0, 2, 0)) then
                                UnhookPlayer(TargetPlayer)
                                wait(0.5)
                                TeleportBack()
                            end
                        elseif Health <= 50 then
                            UpdateStatus("💊 Лечу " .. TargetPlayer.Name .. " (HP: " .. math.floor(Health) .. ")")
                            local pos = TargetChar:FindFirstChild("HumanoidRootPart")
                            if pos and TeleportTo(pos.Position + Vector3.new(0, 2, 0)) then
                                HealPlayer(TargetPlayer)
                                wait(0.5)
                                TeleportBack()
                            end
                        end
                    end
                end
            else
                UpdateStatus("💚 Все здоровы (HP > 50) или никто не нуждается")
            end
        end
    end
end

spawn(MainLoop)

print("✦ Vibe Farm Script (финальная версия) загружен!")
