-- RYZEN AIMBOT + ULTRA ESP НА RAYFIELD
-- КРУТОЙ ESP С ЭФФЕКТАМИ + ЧИСЛОВОЕ HP НАД ПОЛОСКОЙ

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- НАСТРОЙКИ
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
        TeamColor = false,
        Glow = false,
        Skeleton = false,
        Chams = false,
        Name = false,
        Rainbow = false
    }
}

-- СОЗДАНИЕ ОКНА
local Window = Rayfield:CreateWindow({
    Name = "🤑 Ryzen Aimbot Ultra",
    Icon = 0,
    LoadingTitle = "Ryzen System",
    LoadingSubtitle = "Ultra ESP Edition",
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

local AimbotSection = AimbotTab:CreateSection("Настройки аимбота")

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
-- ВКЛАДКА ULTRA ESP
-- ============================================
local ESPTab = Window:CreateTab("👁️ Ultra ESP", 0)

local ESPSection = ESPTab:CreateSection("Основные настройки")

ESPTab:CreateToggle({
    Name = "ESP Total",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Enabled = Value
    end
})

ESPTab:CreateToggle({
    Name = "🌈 Rainbow ESP (все цвета радуги)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Rainbow = Value
    end
})

ESPTab:CreateToggle({
    Name = "🏷️ Имена игроков",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Name = Value
    end
})

local BoxSection = ESPTab:CreateSection("Box ESP")

ESPTab:CreateToggle({
    Name = "📦 Box ESP (рамка)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Box = Value
    end
})

ESPTab:CreateToggle({
    Name = "✨ Glow Effect (свечение)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Glow = Value
    end
})

local LineSection = ESPTab:CreateSection("Линии")

ESPTab:CreateToggle({
    Name = "📏 Tracers (линии к игроку)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Tracers = Value
    end
})

ESPTab:CreateToggle({
    Name = "🦴 Skeleton (скелет)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Skeleton = Value
    end
})

local InfoSection = ESPTab:CreateSection("Информация")

ESPTab:CreateToggle({
    Name = "❤️ Health Bar (здоровье + числа)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Health = Value
    end
})

ESPTab:CreateToggle({
    Name = "📏 Distance (дистанция)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.Distance = Value
    end
})

ESPTab:CreateToggle({
    Name = "🎨 Team Colors (цвет команды)",
    CurrentValue = false,
    Callback = function(Value)
        Settings.ESP.TeamColor = Value
    end
})

-- ============================================
-- ВКЛАДКА УПРАВЛЕНИЯ
-- ============================================
local ControlTab = Window:CreateTab("⚙️ Управление", 0)

local ControlSection = ControlTab:CreateSection("Управление скриптом")

ControlTab:CreateButton({
    Name = "OFF ALL (отключить всё)",
    Callback = function()
        Settings.AimBot.Enabled = false
        Settings.AimBot.WallCheck = false
        Settings.AimBot.TeamCheck = false
        Settings.ESP.Enabled = false
        Settings.ESP.Box = false
        Settings.ESP.Tracers = false
        Settings.ESP.Health = false
        Settings.ESP.Distance = false
        Settings.ESP.TeamColor = false
        Settings.ESP.Glow = false
        Settings.ESP.Skeleton = false
        Settings.ESP.Chams = false
        Settings.ESP.Name = false
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
-- УЛЬТРА ESP + ЭФФЕКТЫ
-- ============================================

-- РАДУЖНЫЙ ЦВЕТ
local function getRainbowColor(time)
    local r = math.sin(time) * 0.5 + 0.5
    local g = math.sin(time + 2.094) * 0.5 + 0.5
    local b = math.sin(time + 4.188) * 0.5 + 0.5
    return Color3.new(r, g, b)
end

-- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
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

-- AIMBOT
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
-- УЛЬТРА ESP
-- ============================================
local drawingObjects = {}
local glowObjects = {}

local function clearDrawings()
    for _, obj in pairs(drawingObjects) do
        if obj and obj.Remove then
            obj:Remove()
        end
    end
    drawingObjects = {}
    
    for _, obj in pairs(glowObjects) do
        if obj and obj.Remove then
            obj:Remove()
        end
    end
    glowObjects = {}
end

local function createDrawing(type, props)
    local obj = Drawing.new(type)
    for k, v in pairs(props) do
        obj[k] = v
    end
    table.insert(drawingObjects, obj)
    return obj
end

-- ФУНКЦИЯ ДЛЯ РИСОВАНИЯ СКЕЛЕТА
local function drawSkeleton(char, espColor)
    local joints = {
        {"Head", "UpperTorso"},
        {"UpperTorso", "LowerTorso"},
        {"UpperTorso", "LeftUpperArm"},
        {"LeftUpperArm", "LeftLowerArm"},
        {"UpperTorso", "RightUpperArm"},
        {"RightUpperArm", "RightLowerArm"},
        {"LowerTorso", "LeftUpperLeg"},
        {"LeftUpperLeg", "LeftLowerLeg"},
        {"LowerTorso", "RightUpperLeg"},
        {"RightUpperLeg", "RightLowerLeg"}
    }
    
    for _, joint in pairs(joints) do
        local part1 = char:FindFirstChild(joint[1])
        local part2 = char:FindFirstChild(joint[2])
        if part1 and part2 then
            local pos1, onScreen1 = Camera:WorldToViewportPoint(part1.Position)
            local pos2, onScreen2 = Camera:WorldToViewportPoint(part2.Position)
            if onScreen1 and onScreen2 then
                createDrawing("Line", {
                    From = Vector2.new(pos1.X, pos1.Y),
                    To = Vector2.new(pos2.X, pos2.Y),
                    Thickness = 2,
                    Color = espColor,
                    Visible = true
                })
            end
        end
    end
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

        -- ВЫБОР ЦВЕТА
        local teamCol = getTeamColor(plr)
        local espColor = Settings.ESP.TeamColor and teamCol or Color3.new(1, 1, 1)
        if Settings.ESP.Rainbow then
            espColor = rainbowColor
        end

        -- ============================================
        -- GLOW ЭФФЕКТ (СВЕЧЕНИЕ)
        -- ============================================
        if Settings.ESP.Glow then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    local glow = Instance.new("Highlight")
                    glow.Parent = part
                    glow.Adornee = part
                    glow.FillColor = espColor
                    glow.FillTransparency = 0.5
                    glow.OutlineColor = espColor
                    glow.OutlineTransparency = 0.3
                    table.insert(glowObjects, glow)
                end
            end
        end

        -- ============================================
        -- NAME (ИМЯ)
        -- ============================================
        if Settings.ESP.Name then
            createDrawing("Text", {
                Position = Vector2.new(headPos.X, headPos.Y - 50),
                Text = plr.Name,
                Size = 16,
                Color = espColor,
                Center = true,
                Visible = true,
                Outline = true,
                OutlineColor = Color3.new(0, 0, 0)
            })
        end

        -- ============================================
        -- BOX (РАМКА)
        -- ============================================
        if Settings.ESP.Box then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local bottomPos, _ = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                local topPos, _ = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0))
                local height = topPos.Y - bottomPos.Y
                local width = height * 0.4
                local x = headPos.X - width/2
                local y = headPos.Y

                -- ОСНОВНАЯ РАМКА
                createDrawing("Square", {
                    Position = Vector2.new(x, y),
                    Size = Vector2.new(width, height),
                    Thickness = 2,
                    Color = espColor,
                    Filled = false,
                    Visible = true
                })
                
                -- ДОПОЛНИТЕЛЬНАЯ РАМКА (3D ЭФФЕКТ)
                createDrawing("Square", {
                    Position = Vector2.new(x + 2, y + 2),
                    Size = Vector2.new(width - 4, height - 4),
                    Thickness = 1,
                    Color = Color3.new(0, 0, 0),
                    Filled = false,
                    Visible = true,
                    Transparency = 0.5
                })
            end
        end

        -- ============================================
        -- TRACERS (ЛИНИИ)
        -- ============================================
        if Settings.ESP.Tracers then
            local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            
            -- ОСНОВНАЯ ЛИНИЯ
            createDrawing("Line", {
                From = center,
                To = Vector2.new(headPos.X, headPos.Y),
                Thickness = 2,
                Color = espColor,
                Visible = true
            })
            
            -- ДОПОЛНИТЕЛЬНАЯ ТЕНЬ
            createDrawing("Line", {
                From = center + Vector2.new(1, 1),
                To = Vector2.new(headPos.X + 1, headPos.Y + 1),
                Thickness = 2,
                Color = Color3.new(0, 0, 0),
                Visible = true,
                Transparency = 0.5
            })
        end

        -- ============================================
        -- SKELETON (СКЕЛЕТ)
        -- ============================================
        if Settings.ESP.Skeleton then
            drawSkeleton(char, espColor)
        end

        -- ============================================
        -- HEALTH BAR (ЗДОРОВЬЕ) С ЧИСЛАМИ НАД ПОЛОСКОЙ
        -- ============================================
        if Settings.ESP.Health then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                local healthPercent = hum.Health / hum.MaxHealth
                local barWidth = 50
                local barX = headPos.X - barWidth/2
                local barY = headPos.Y - 45
                
                -- ТЕКСТ HP НАД ПОЛОСКОЙ
                createDrawing("Text", {
                    Position = Vector2.new(headPos.X, barY - 10),
                    Text = math.floor(hum.Health) .. " / " .. math.floor(hum.MaxHealth),
                    Size = 13,
                    Color = Color3.new(1, 1, 1),
                    Center = true,
                    Visible = true,
                    Outline = true,
                    OutlineColor = Color3.new(0, 0, 0)
                })
                
                -- ФОН ПОЛОСКИ
                createDrawing("Line", {
                    From = Vector2.new(barX, barY),
                    To = Vector2.new(barX + barWidth, barY),
                    Thickness = 5,
                    Color = Color3.new(0.2, 0.2, 0.2),
                    Visible = true
                })
                
                -- ЗАПОЛНЕНИЕ ПОЛОСКИ (ЦВЕТ МЕНЯЕТСЯ)
                local healthColor = Color3.new(1 - healthPercent, healthPercent, 0)
                createDrawing("Line", {
                    From = Vector2.new(barX, barY),
                    To = Vector2.new(barX + barWidth * healthPercent, barY),
                    Thickness = 5,
                    Color = healthColor,
                    Visible = true
                })
            end
        end

        -- ============================================
        -- DISTANCE (ДИСТАНЦИЯ)
        -- ============================================
        if Settings.ESP.Distance then
            local dist = math.floor((Camera.CFrame.Position - head.Position).Magnitude)
            createDrawing("Text", {
                Position = Vector2.new(headPos.X, headPos.Y + 35),
                Text = "📏 " .. dist .. "m",
                Size = 14,
                Color = Color3.new(1, 1, 1),
                Center = true,
                Visible = true,
                Outline = true,
                OutlineColor = Color3.new(0, 0, 0)
            })
        end
    end
end)

game:GetService("BindableEvent").Destroying:Connect(clearDrawings)

print("Ryzen Aimbot + Ultra ESP загружен!")
