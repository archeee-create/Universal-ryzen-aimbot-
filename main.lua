-- RYZEN AIMBOT + ULTRA ESP НА RAYFIELD
-- ФИОЛЕТОВАЯ ТЕМА + FOV ВИЗУАЛИЗАЦИЯ + НАСТРОЙКА ЦВЕТА

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- ============================================
-- ФИОЛЕТОВАЯ ТЕМА RAYFIELD
-- ============================================
local PurpleTheme = {
    Background = Color3.fromRGB(20, 10, 30),
    Glow = Color3.fromRGB(120, 50, 200),
    Accent = Color3.fromRGB(150, 60, 220),
    Light = Color3.fromRGB(180, 100, 240),
    Dark = Color3.fromRGB(15, 5, 25),
    Text = Color3.fromRGB(220, 180, 255),
    Border = Color3.fromRGB(130, 60, 200)
}

-- НАСТРОЙКИ
local Settings = {
    AimBot = {
        Enabled = false,
        FOV = 120,
        Smoothness = 0.3,
        TargetPart = "Head",
        TeamCheck = false,
        WallCheck = false,
        ShowFOV = false,
        FOVColor = Color3.fromRGB(255, 0, 255)
    },
    ESP = {
        Enabled = false,
        Box = false,
        Tracers = false,
        Health = false,
        Distance = false,
        TeamColor = false,
        StatsBox = false,
        Rainbow = false
    }
}

-- СОЗДАНИЕ ОКНА RAYFIELD С ФИОЛЕТОВОЙ ТЕМОЙ
local Window = Rayfield:CreateWindow({
    Name = "🤑 Ryzen Aimbot Ultra",
    Icon = 0,
    LoadingTitle = "Ryzen System",
    LoadingSubtitle = "Purple Edition",
    Theme = "Dark",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "RyzenUltra"
    }
})

-- ПРИМЕНЯЕМ ФИОЛЕТОВУЮ ТЕМУ К GUI
local function applyPurpleTheme()
    for _, v in pairs(game.CoreGui:GetDescendants()) do
        if v:IsA("Frame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("ImageLabel") then
            if v.Name == "Background" or v.Name == "MainFrame" then
                v.BackgroundColor3 = PurpleTheme.Background
            end
            if v.Name == "Accent" or v.Name == "Glow" then
                v.BackgroundColor3 = PurpleTheme.Accent
            end
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                if v.TextColor3 == Color3.fromRGB(255, 255, 255) then
                    v.TextColor3 = PurpleTheme.Text
                end
            end
        end
    end
end

-- ============================================
-- ВКЛАДКА AIMBOT
-- ============================================
local AimbotTab = Window:CreateTab("🎯 Aimbot", 0)

AimbotTab:CreateSection("Настройки аимбота")

AimbotTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Callback = function(Value)
        Settings.AimBot.Enabled = Value
    end
})

AimbotTab:CreateToggle({
    Name = "Wall Check (сквозь стены)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.AimBot.WallCheck = Value
    end
})

AimbotTab:CreateToggle({
    Name = "Team Check (свои)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.AimBot.TeamCheck = Value
    end
})

AimbotTab:CreateToggle({
    Name = "Show FOV (визуализация)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.AimBot.ShowFOV = Value
    end
})

AimbotTab:CreateSlider({
    Name = "FOV Range",
    Range = {10, 360},
    Increment = 1,
    Suffix = "°",
    CurrentValue = 120,
    Callback = function(Value)
        Settings.AimBot.FOV = Value
    end
})

AimbotTab:CreateDropdown({
    Name = "Цель",
    Options = {"Head", "Torso"},
    CurrentOption = "Head",
    Callback = function(Option)
        if Option == "Torso" then
            Settings.AimBot.TargetPart = "UpperTorso"
        else
            Settings.AimBot.TargetPart = "Head"
        end
    end
})

-- ============================================
-- ВКЛАДКА "FOV COLOR" (ВЫБОР ЦВЕТА)
-- ============================================
local FOVColorTab = Window:CreateTab("🎨 FOV Color", 0)

FOVColorTab:CreateSection("Выберите цвет для FOV")

local colors = {
    {"Красный", Color3.fromRGB(255, 0, 0)},
    {"Зелёный", Color3.fromRGB(0, 255, 0)},
    {"Синий", Color3.fromRGB(0, 0, 255)},
    {"Жёлтый", Color3.fromRGB(255, 255, 0)},
    {"Фиолетовый", Color3.fromRGB(255, 0, 255)},
    {"Голубой", Color3.fromRGB(0, 255, 255)},
    {"Оранжевый", Color3.fromRGB(255, 165, 0)},
    {"Розовый", Color3.fromRGB(255, 105, 180)},
    {"Белый", Color3.fromRGB(255, 255, 255)}
}

for _, colorData in ipairs(colors) do
    local colorName = colorData[1]
    local colorValue = colorData[2]
    
    FOVColorTab:CreateButton({
        Name = colorName .. " ●",
        Callback = function()
            Settings.AimBot.FOVColor = colorValue
            Rayfield:Notify({
                Title = "Цвет FOV",
                Content = "Выбран: " .. colorName,
                Duration = 1.5
            })
        end
    })
end

-- ============================================
-- ВКЛАДКА ESP
-- ============================================
local ESPTab = Window:CreateTab("👁️ ESP", 0)

ESPTab:CreateSection("Основные настройки")

ESPTab:CreateToggle({
    Name = "ESP Total",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Enabled = Value
    end
})

ESPTab:CreateToggle({
    Name = "🌈 Rainbow ESP",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Rainbow = Value
    end
})

ESPTab:CreateSection("Боксы")

ESPTab:CreateToggle({
    Name = "📦 Box ESP (рамка)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Box = Value
    end
})

ESPTab:CreateToggle({
    Name = "📊 Stats Box (статистика)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.StatsBox = Value
    end
})

ESPTab:CreateSection("Линии")

ESPTab:CreateToggle({
    Name = "📏 Tracers (линии)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Tracers = Value
    end
})

ESPTab:CreateSection("Информация")

ESPTab:CreateToggle({
    Name = "❤️ Health Bar",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Health = Value
    end
})

ESPTab:CreateToggle({
    Name = "📏 Distance",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Distance = Value
    end
})

ESPTab:CreateToggle({
    Name = "🎨 Team Colors",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.TeamColor = Value
    end
})

-- ============================================
-- ВКЛАДКА УПРАВЛЕНИЯ
-- ============================================
local ControlTab = Window:CreateTab("⚙️ Управление", 0)

ControlTab:CreateSection("Управление скриптом")

ControlTab:CreateButton({
    Name = "OFF ALL (отключить всё)",
    Callback = function()
        Settings.AimBot.Enabled = false
        Settings.AimBot.WallCheck = false
        Settings.AimBot.TeamCheck = false
        Settings.AimBot.ShowFOV = false
        Settings.ESP.Enabled = false
        Settings.ESP.Box = false
        Settings.ESP.Tracers = false
        Settings.ESP.Health = false
        Settings.ESP.Distance = false
        Settings.ESP.TeamColor = false
        Settings.ESP.StatsBox = false
        Settings.ESP.Rainbow = false
        Rayfield:Notify({
            Title = "Ryzen System",
            Content = "Все функции отключены!",
            Duration = 2
        })
    end
})

ControlTab:CreateButton({
    Name = "!DESTROY! (удалить скрипт)",
    Callback = function()
        Rayfield:Destroy()
        for _, v in pairs(game.CoreGui:GetChildren()) do
            if v.Name == "Rayfield" or v.Name == "RyzenMobile" then
                v:Destroy()
            end
        end
    end
})

-- ============================================
-- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
-- ============================================

local function isAlive(plr)
    local char = plr.Character
    return char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0
end

local function getTeamColor(plr)
    if plr.Team and plr.Team.TeamColor then
        return plr.Team.TeamColor.Color
    end
    return Color3.new(1, 1, 1)
end

local function getTeamName(plr)
    if plr.Team and plr.Team.Name then
        return plr.Team.Name
    end
    return "No Team"
end

local function getPart(plr, partName)
    if not plr.Character then return nil end
    return plr.Character:FindFirstChild(partName)
end

local function isVisible(origin, targetPos)
    local ray = Ray.new(origin, (targetPos - origin).Unit * (targetPos - origin).Magnitude)
    local hit = workspace:FindPartOnRay(ray, LocalPlayer.Character, false, true)
    if hit then
        return false
    end
    return true
end

local function getRainbowColor(time)
    local r = math.sin(time) * 0.5 + 0.5
    local g = math.sin(time + 2.094) * 0.5 + 0.5
    local b = math.sin(time + 4.188) * 0.5 + 0.5
    return Color3.new(r, g, b)
end

-- ============================================
-- AIMBOT
-- ============================================

local function getClosestPlayerInFOV()
    if not Settings.AimBot.Enabled then return nil end
    
    local closest = nil
    local minDist = math.huge
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local cameraPos = Camera.CFrame.Position

    for _, plr in pairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        if Settings.AimBot.TeamCheck and plr.Team == LocalPlayer.Team then continue end
        if not isAlive(plr) then continue end

        local targetPart = getPart(plr, Settings.AimBot.TargetPart)
        if not targetPart then continue end

        if Settings.AimBot.WallCheck then
            if not isVisible(cameraPos, targetPart.Position) then
                continue
            end
        end

        local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
        if not onScreen then continue end

        local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        local fovLimit = (Settings.AimBot.FOV / 2) * (Camera.ViewportSize.X / 100)
        if dist < fovLimit and dist < minDist then
            minDist = dist
            closest = plr
        end
    end
    return closest
end

local function smoothAim(targetPos)
    local current = Camera.CFrame.Position
    local targetCF = CFrame.new(current, targetPos)
    Camera.CFrame = Camera.CFrame:Lerp(targetCF, Settings.AimBot.Smoothness)
end

RunService.RenderStepped:Connect(function()
    if not Settings.AimBot.Enabled then return end
    
    local target = getClosestPlayerInFOV()
    if target then
        local part = getPart(target, Settings.AimBot.TargetPart)
        if part then
            smoothAim(part.Position)
        end
    end
end)

-- ============================================
-- FOV ВИЗУАЛИЗАЦИЯ
-- ============================================
local fovCircle = nil

local function drawFOV()
    if not Settings.AimBot.ShowFOV then
        if fovCircle then
            fovCircle:Remove()
            fovCircle = nil
        end
        return
    end
    
    if not fovCircle then
        fovCircle = Drawing.new("Circle")
        fovCircle.Thickness = 2
        fovCircle.NumSides = 60
        fovCircle.Filled = false
    end
    
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local radius = (Settings.AimBot.FOV / 2) * (Camera.ViewportSize.X / 100)
    
    fovCircle.Position = center
    fovCircle.Radius = radius
    fovCircle.Color = Settings.AimBot.FOVColor
    fovCircle.Visible = true
end

RunService.RenderStepped:Connect(drawFOV)

-- ============================================
-- ESP С СИНИМ БОКСОМ И СТАТИСТИКОЙ
-- ============================================

local drawingObjects = {}

local function clearDrawings()
    for _, obj in pairs(drawingObjects) do
        if obj and obj.Remove then
            obj:Remove()
        end
    end
    drawingObjects = {}
end

local function createDrawing(type, props)
    local obj = Drawing.new(type)
    for k, v in pairs(props) do
        obj[k] = v
    end
    table.insert(drawingObjects, obj)
    return obj
end

-- ФУНКЦИЯ ДЛЯ РИСОВАНИЯ СИНЕГО БОКСА СО СТАТИСТИКОЙ
local function drawStatsBox(plr, headPos, espColor)
    local char = plr.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end
    
    local health = math.floor(hum.Health)
    local maxHealth = math.floor(hum.MaxHealth)
    local teamName = getTeamName(plr)
    local teamColor = getTeamColor(plr)
    local playerName = plr.Name
    
    local bottomPos, _ = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
    local topPos, _ = Camera:WorldToViewportPoint(headPos)
    local height = (topPos.Y - bottomPos.Y) + 30
    local width = height * 0.45
    local x = headPos.X - width/2
    local y = topPos.Y - 20
    
    local boxColor = Color3.fromRGB(30, 144, 255)
    local cornerRadius = 8
    
    createDrawing("Line", {
        From = Vector2.new(x + cornerRadius, y),
        To = Vector2.new(x + width - cornerRadius, y),
        Thickness = 2,
        Color = boxColor,
        Visible = true
    })
    
    createDrawing("Line", {
        From = Vector2.new(x + cornerRadius, y + height),
        To = Vector2.new(x + width - cornerRadius, y + height),
        Thickness = 2,
        Color = boxColor,
        Visible = true
    })
    
    createDrawing("Line", {
        From = Vector2.new(x, y + cornerRadius),
        To = Vector2.new(x, y + height - cornerRadius),
        Thickness = 2,
        Color = boxColor,
        Visible = true
    })
    
    createDrawing("Line", {
        From = Vector2.new(x + width, y + cornerRadius),
        To = Vector2.new(x + width, y + height - cornerRadius),
        Thickness = 2,
        Color = boxColor,
        Visible = true
    })
    
    createDrawing("Line", {
        From = Vector2.new(x, y + cornerRadius),
        To = Vector2.new(x + cornerRadius, y),
        Thickness = 2,
        Color = boxColor,
        Visible = true
    })
    
    createDrawing("Line", {
        From = Vector2.new(x + width - cornerRadius, y),
        To = Vector2.new(x + width, y + cornerRadius),
        Thickness = 2,
        Color = boxColor,
        Visible = true
    })
    
    createDrawing("Line", {
        From = Vector2.new(x, y + height - cornerRadius),
        To = Vector2.new(x + cornerRadius, y + height),
        Thickness = 2,
        Color = boxColor,
        Visible = true
    })
    
    createDrawing("Line", {
        From = Vector2.new(x + width - cornerRadius, y + height),
        To = Vector2.new(x + width, y + height - cornerRadius),
        Thickness = 2,
        Color = boxColor,
        Visible = true
    })
    
    createDrawing("Square", {
        Position = Vector2.new(x + 1, y + 1),
        Size = Vector2.new(width - 2, height - 2),
        Thickness = 0,
        Color = Color3.fromRGB(0, 0, 50),
        Filled = true,
        Visible = true,
        Transparency = 0.6
    })
    
    local textX = x + 5
    local textY = y + 5
    
    createDrawing("Text", {
        Position = Vector2.new(headPos.X, y - 18),
        Text = "🔴 " .. playerName,
        Size = 14,
        Color = Color3.fromRGB(255, 50, 50),
        Center = true,
        Visible = true,
        Outline = true,
        OutlineColor = Color3.new(0, 0, 0)
    })
    
    local healthColor = Color3.fromRGB(0, 255, 100)
    createDrawing("Text", {
        Position = Vector2.new(textX, textY + 5),
        Text = "🟢 Health: " .. health .. "/" .. maxHealth,
        Size = 13,
        Color = healthColor,
        Center = false,
        Visible = true,
        Outline = true,
        OutlineColor = Color3.new(0, 0, 0)
    })
    
    local teamTextColor = teamColor
    createDrawing("Text", {
        Position = Vector2.new(textX, textY + 25),
        Text = "🔵 Team: " .. teamName,
        Size = 13,
        Color = teamTextColor,
        Center = false,
        Visible = true,
        Outline = true,
        OutlineColor = Color3.new(0, 0, 0)
    })
    
    local dist = math.floor((Camera.CFrame.Position - headPos.Position).Magnitude)
    createDrawing("Text", {
        Position = Vector2.new(textX, textY + 45),
        Text = "📏 Distance: " .. dist .. "m",
        Size = 13,
        Color = Color3.new(1, 1, 1),
        Center = false,
        Visible = true,
        Outline = true,
        OutlineColor = Color3.new(0, 0, 0)
    })
end

-- ОСНОВНОЙ ЦИКЛ ESP
RunService.RenderStepped:Connect(function()
    clearDrawings()
    
    if not Settings.ESP.Enabled then return end
    
    local time = tick()
    local rainbowColor = getRainbowColor(time)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        if not isAlive(plr) then continue end

        local char = plr.Character
        local head = char:FindFirstChild("Head")
        if not head then continue end

        local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end

        local teamCol = getTeamColor(plr)
        local espColor = Settings.ESP.TeamColor and teamCol or Color3.new(1, 1, 1)
        if Settings.ESP.Rainbow then
            espColor = rainbowColor
        end

        if Settings.ESP.StatsBox then
            drawStatsBox(plr, headPos, espColor)
        end

        if Settings.ESP.Box then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local bottomPos, _ = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                local topPos, _ = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0))
                local height = topPos.Y - bottomPos.Y
                local width = height * 0.4
                local x = headPos.X - width/2
                local y = headPos.Y

                createDrawing("Square", {
                    Position = Vector2.new(x, y),
                    Size = Vector2.new(width, height),
                    Thickness = 2,
                    Color = espColor,
                    Filled = false,
                    Visible = true
                })
            end
        end

        if Settings.ESP.Tracers then
            local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            
            createDrawing("Line", {
                From = center,
                To = Vector2.new(headPos.X, headPos.Y),
                Thickness = 2,
                Color = espColor,
                Visible = true
            })
        end

        if Settings.ESP.Health then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                local healthPercent = hum.Health / hum.MaxHealth
                local barWidth = 40
                local barX = headPos.X - barWidth/2
                local barY = headPos.Y - 35
                
                createDrawing("Line", {
                    From = Vector2.new(barX, barY),
                    To = Vector2.new(barX + barWidth, barY),
                    Thickness = 4,
                    Color = Color3.new(0.2, 0.2, 0.2),
                    Visible = true
                })
                
                local healthColor = Color3.new(1 - healthPercent, healthPercent, 0)
                createDrawing("Line", {
                    From = Vector2.new(barX, barY),
                    To = Vector2.new(barX + barWidth * healthPercent, barY),
                    Thickness = 4,
                    Color = healthColor,
                    Visible = true
                })
            end
        end

        if Settings.ESP.Distance then
            local dist = math.floor((Camera.CFrame.Position - head.Position).Magnitude)
            createDrawing("Text", {
      
