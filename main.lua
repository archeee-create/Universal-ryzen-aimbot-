-- RYZEN AIMBOT + ULTRA ESP НА RAYFIELD
-- ФИОЛЕТОВАЯ ТЕМА + FOV ВИЗУАЛИЗАЦИЯ + ПРИЦЕЛЫ

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
    },
    Crosshair = {
        Enabled = false,
        Style = "Классический",
        Color = Color3.fromRGB(0, 255, 0),
        Size = 20,
        Thickness = 2
    }
}

-- СОЗДАНИЕ ОКНА RAYFIELD
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
-- ВКЛАДКА "CROSSHAIR" (ПРИЦЕЛ)
-- ============================================
local CrosshairTab = Window:CreateTab("🎯 Crosshair", 0)

CrosshairTab:CreateSection("Настройки прицела")

CrosshairTab:CreateToggle({
    Name = "Включить прицел",
    CurrentValue = false,
    Callback = function(Value)
        Settings.Crosshair.Enabled = Value
    end
})

CrosshairTab:CreateDropdown({
    Name = "Стиль прицела",
    Options = {"Классический", "Точка", "Круг", "Крест", "X", "Стрелка", "Ромб"},
    CurrentOption = "Классический",
    Callback = function(Option)
        Settings.Crosshair.Style = Option
    end
})

CrosshairTab:CreateSlider({
    Name = "Размер прицела",
    Range = {5, 50},
    Increment = 1,
    Suffix = "px",
    CurrentValue = 20,
    Callback = function(Value)
        Settings.Crosshair.Size = Value
    end
})

CrosshairTab:CreateSlider({
    Name = "Толщина прицела",
    Range = {1, 5},
    Increment = 1,
    Suffix = "px",
    CurrentValue = 2,
    Callback = function(Value)
        Settings.Crosshair.Thickness = Value
    end
})

-- ============================================
-- ВКЛАДКА "CROSSHAIR COLOR"
-- ============================================
local CrosshairColorTab = Window:CreateTab("🎨 Crosshair Color", 0)

CrosshairColorTab:CreateSection("Выберите цвет прицела")

local crosshairColors = {
    {"Зелёный", Color3.fromRGB(0, 255, 0)},
    {"Красный", Color3.fromRGB(255, 0, 0)},
    {"Синий", Color3.fromRGB(0, 0, 255)},
    {"Жёлтый", Color3.fromRGB(255, 255, 0)},
    {"Фиолетовый", Color3.fromRGB(255, 0, 255)},
    {"Голубой", Color3.fromRGB(0, 255, 255)},
    {"Оранжевый", Color3.fromRGB(255, 165, 0)},
    {"Розовый", Color3.fromRGB(255, 105, 180)},
    {"Белый", Color3.fromRGB(255, 255, 255)},
    {"Чёрный", Color3.fromRGB(0, 0, 0)}
}

for _, colorData in ipairs(crosshairColors) do
    local colorName = colorData[1]
    local colorValue = colorData[2]
    
    CrosshairColorTab:CreateButton({
        Name = colorName .. " ●",
        Callback = function()
            Settings.Crosshair.Color = colorValue
            Rayfield:Notify({
                Title = "Цвет прицела",
                Content = "Выбран: " .. colorName,
                Duration = 1.5
            })
        end
    })
end

-- ============================================
-- ВКЛАДКА "FOV COLOR"
-- ============================================
local FOVColorTab = Window:CreateTab("🎨 FOV Color", 0)

FOVColorTab:CreateSection("Выберите цвет для FOV")

local fovColors = {
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

for _, colorData in ipairs(fovColors) do
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
        Settings.Crosshair.Enabled = false
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
-- РИСОВАНИЕ ПРИЦЕЛА
-- ============================================
local crosshairObjects = {}

local function clearCrosshair()
    for _, obj in pairs(crosshairObjects) do
        if obj and obj.Remove then
            obj:Remove()
        end
    end
    crosshairObjects = {}
end

local function createCrosshairObject(type, props)
    local obj = Drawing.new(type)
    for k, v in pairs(props) do
        obj[k] = v
    end
    table.insert(crosshairObjects, obj)
    return obj
end

local function drawCrosshair()
    clearCrosshair()
    
    if not Settings.Crosshair.Enabled then return end
    
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local size = Settings.Crosshair.Size
    local thick = Settings.Crosshair.Thickness
    local color = Settings.Crosshair.Color
    local style = Settings.Crosshair.Style
    
    -- КЛАССИЧЕСКИЙ (+)
    if style == "Классический" then
        -- Горизонтальная линия (левая)
        createCrosshairObject("Line", {
            From = Vector2.new(center.X - size, center.Y),
            To = Vector2.new(center.X - thick/2, center.Y),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        -- Горизонтальная линия (правая)
        createCrosshairObject("Line", {
            From = Vector2.new(center.X + thick/2, center.Y),
            To = Vector2.new(center.X + size, center.Y),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        -- Вертикальная линия (верхняя)
        createCrosshairObject("Line", {
            From = Vector2.new(center.X, center.Y - size),
            To = Vector2.new(center.X, center.Y - thick/2),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        -- Вертикальная линия (нижняя)
        createCrosshairObject("Line", {
            From = Vector2.new(center.X, center.Y + thick/2),
            To = Vector2.new(center.X, center.Y + size),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        
    -- ТОЧКА
    elseif style == "Точка" then
        createCrosshairObject("Circle", {
            Position = center,
            Radius = size/3,
            Thickness = thick,
            Color = color,
            Filled = true,
            Visible = true
        })
        
    -- КРУГ
    elseif style == "Круг" then
        createCrosshairObject("Circle", {
            Position = center,
            Radius = size/1.5,
            Thickness = thick,
            Color = color,
            Filled = false,
            Visible = true
        })
        -- Точка в центре
        createCrosshairObject("Circle", {
            Position = center,
            Radius = 2,
            Thickness = thick,
            Color = color,
            Filled = true,
            Visible = true
        })
        
    -- КРЕСТ (X)
    elseif style == "Крест" then
        local offset = size * 0.7
        -- Линия 1 (\)
        createCrosshairObject("Line", {
            From = Vector2.new(center.X - offset, center.Y - offset),
            To = Vector2.new(center.X + offset, center.Y + offset),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        -- Линия 2 (/)
        createCrosshairObject("Line", {
            From = Vector2.new(center.X + offset, center.Y - offset),
            To = Vector2.new(center.X - offset, center.Y + offset),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        
    -- СТРЕЛКА (↑)
    elseif style == "Стрелка" then
        -- Вертикальная линия
        createCrosshairObject("Line", {
            From = Vector2.new(center.X, center.Y + size/2),
            To = Vector2.new(center.X, center.Y - size/2),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        -- Верхняя стрелка (левая)
        createCrosshairObject("Line", {
            From = Vector2.new(center.X - size/3, center.Y - size/3),
            To = Vector2.new(center.X, center.Y - size/2),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        -- Верхняя стрелка (правая)
        createCrosshairObject("Line", {
            From = Vector2.new(center.X + size/3, center.Y - size/3),
            To = Vector2.new(center.X, center.Y - size/2),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        
    -- РОМБ (◇)
    elseif style == "Ромб" then
        local s = size/2
        createCrosshairObject("Line", {
            From = Vector2.new(center.X, center.Y - s),
            To = Vector2.new(center.X + s, center.Y),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        createCrosshairObject("Line", {
            From = Vector2.new(center.X + s, center.Y),
            To = Vector2.new(center.X, center.Y + s),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        createCrosshairObject("Line", {
            From = Vector2.new(center.X, center.Y + s),
            To = Vector2.new(center.X - s, center.Y),
            Thickness = thick,
            Color = color,
            Visible = true
        })
        createCrosshairObject("Line", {
            From = Vector2.new(center.X - s, center.Y),
            To = Vector2.new(center.X, center.Y - s),
            Thickness = thick,
            Color = color,
            Visible = true
        })
    end
end

RunService.RenderStepped:Connect(drawCrosshair)

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

local function drawStatsBox(plr, headPos, espColor)
    local char = plr.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end
    
    local health = math.floor(hum.Health)
    local maxHealth =
