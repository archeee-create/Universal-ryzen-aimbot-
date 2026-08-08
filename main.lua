-- RYZEN AIMBOT + ULTRA ESP С RAYFIELD
-- ФИКС ДЛЯ DELTA

-- ЗАГРУЗКА RAYFIELD С ПРОВЕРКОЙ
local Rayfield = nil
local loadSuccess = false

for i = 1, 3 do
    local success, result = pcall(function()
        return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    end)
    if success and result then
        Rayfield = result
        loadSuccess = true
        break
    end
    task.wait(0.5)
end

if not loadSuccess or not Rayfield then
    -- ЕСЛИ RAYFIELD НЕ ЗАГРУЗИЛСЯ, ИСПОЛЬЗУЕМ ПРОСТОЕ МЕНЮ
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RyzenFallback"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 100)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
    Frame.BackgroundTransparency = 0.2
    Frame.BorderSizePixel = 2
    Frame.BorderColor3 = Color3.fromRGB(150, 60, 220)
    Frame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "⚠️ Rayfield не загрузился\nНо скрипт продолжает работу!\nИспользуйте меню UNIVERSAL"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.SourceSansBold
    Label.Parent = Frame
    
    task.wait(3)
    Frame:Destroy()
end

-- ЕСЛИ RAYFIELD ЗАГРУЗИЛСЯ, ЗАПУСКАЕМ ПОЛНУЮ ВЕРСИЮ
if Rayfield then
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local LocalPlayer = Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")

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
        },
        FPSBoost = {
            RemoveParticles = false,
            GrayTextures = false,
            GraySky = false
        }
    }

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

    -- ВКЛАДКА AIMBOT
    local AimbotTab = Window:CreateTab("🎯 Aimbot", 0)
    AimbotTab:CreateSection("Настройки аимбота")
    
    AimbotTab:CreateToggle({
        Name = "Aimbot",
        CurrentValue = false,
        Callback = function(Value) Settings.AimBot.Enabled = Value end
    })
    AimbotTab:CreateToggle({
        Name = "Wall Check",
        CurrentValue = false,
        Callback = function(Value) Settings.AimBot.WallCheck = Value end
    })
    AimbotTab:CreateToggle({
        Name = "Team Check",
        CurrentValue = false,
        Callback = function(Value) Settings.AimBot.TeamCheck = Value end
    })
    AimbotTab:CreateToggle({
        Name = "Show FOV",
        CurrentValue = false,
        Callback = function(Value) Settings.AimBot.ShowFOV = Value end
    })
    AimbotTab:CreateSlider({
        Name = "FOV Range",
        Range = {10, 360},
        Increment = 1,
        Suffix = "°",
        CurrentValue = 120,
        Callback = function(Value) Settings.AimBot.FOV = Value end
    })
    AimbotTab:CreateDropdown({
        Name = "Цель",
        Options = {"Head", "Torso"},
        CurrentOption = "Head",
        Callback = function(Option)
            Settings.AimBot.TargetPart = (Option == "Torso") and "UpperTorso" or "Head"
        end
    })

    -- ВКЛАДКА CROSSHAIR
    local CrosshairTab = Window:CreateTab("🎯 Crosshair", 0)
    CrosshairTab:CreateSection("Настройки прицела")
    
    CrosshairTab:CreateToggle({
        Name = "Включить прицел",
        CurrentValue = false,
        Callback = function(Value) Settings.Crosshair.Enabled = Value end
    })
    CrosshairTab:CreateDropdown({
        Name = "Стиль прицела",
        Options = {"Классический", "Точка", "Круг", "Крест", "X", "Стрелка", "Ромб"},
        CurrentOption = "Классический",
        Callback = function(Option) Settings.Crosshair.Style = Option end
    })
    CrosshairTab:CreateSlider({
        Name = "Размер прицела",
        Range = {5, 50},
        Increment = 1,
        Suffix = "px",
        CurrentValue = 20,
        Callback = function(Value) Settings.Crosshair.Size = Value end
    })
    CrosshairTab:CreateSlider({
        Name = "Толщина прицела",
        Range = {1, 5},
        Increment = 1,
        Suffix = "px",
        CurrentValue = 2,
        Callback = function(Value) Settings.Crosshair.Thickness = Value end
    })

    -- ВКЛАДКА CROSSHAIR COLOR
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
        {"Белый", Color3.fromRGB(255, 255, 255)}
    }
    for _, colorData in ipairs(crosshairColors) do
        CrosshairColorTab:CreateButton({
            Name = colorData[1] .. " ●",
            Callback = function()
                Settings.Crosshair.Color = colorData[2]
                Rayfield:Notify({Title = "Цвет прицела", Content = "Выбран: " .. colorData[1], Duration = 1.5})
            end
        })
    end

    -- ВКЛАДКА FOV COLOR
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
        FOVColorTab:CreateButton({
            Name = colorData[1] .. " ●",
            Callback = function()
                Settings.AimBot.FOVColor = colorData[2]
                Rayfield:Notify({Title = "Цвет FOV", Content = "Выбран: " .. colorData[1], Duration = 1.5})
            end
        })
    end

    -- ВКЛАДКА FPS BOOST
    local FPSBoostTab = Window:CreateTab("⚡ FPS Boost", 0)
    FPSBoostTab:CreateSection("Оптимизация производительности")
    
    FPSBoostTab:CreateToggle({
        Name = "Убрать кастомные частицы",
        CurrentValue = false,
        Callback = function(Value)
            Settings.FPSBoost.RemoveParticles = Value
            Rayfield:Notify({Title = "FPS Boost", Content = Value and "Частицы удалены!" or "Частицы восстановлены!", Duration = 1.5})
        end
    })
    FPSBoostTab:CreateToggle({
        Name = "Сделать текстуры серыми",
        CurrentValue = false,
        Callback = function(Value)
            Settings.FPSBoost.GrayTextures = Value
            Rayfield:Notify({Title = "FPS Boost", Content = Value and "Текстуры обесцвечены!" or "Текстуры восстановлены!", Duration = 1.5})
        end
    })
    FPSBoostTab:CreateToggle({
        Name = "Сделать небо серым",
        CurrentValue = false,
        Callback = function(Value)
            Settings.FPSBoost.GraySky = Value
            Rayfield:Notify({Title = "FPS Boost", Content = Value and "Небо стало серым!" or "Небо восстановлено!", Duration = 1.5})
        end
    })

    -- ВКЛАДКА ESP
    local ESPTab = Window:CreateTab("👁️ ESP", 0)
    ESPTab:CreateSection("Основные настройки")
    
    ESPTab:CreateToggle({
        Name = "ESP Total",
        CurrentValue = false,
        Callback = function(Value) Settings.ESP.Enabled = Value end
    })
    ESPTab:CreateToggle({
        Name = "🌈 Rainbow ESP",
        CurrentValue = false,
        Callback = function(Value) Settings.ESP.Rainbow = Value end
    })
    ESPTab:CreateSection("Боксы")
    ESPTab:CreateToggle({
        Name = "📦 Box ESP",
        CurrentValue = false,
        Callback = function(Value) Settings.ESP.Box = Value end
    })
    ESPTab:CreateToggle({
        Name = "📊 Stats Box",
        CurrentValue = false,
        Callback = function(Value) Settings.ESP.StatsBox = Value end
    })
    ESPTab:CreateSection("Линии")
    ESPTab:CreateToggle({
        Name = "📏 Tracers",
        CurrentValue = false,
        Callback = function(Value) Settings.ESP.Tracers = Value end
    })
    ESPTab:CreateSection("Информация")
    ESPTab:CreateToggle({
        Name = "❤️ Health Bar",
        CurrentValue = false,
        Callback = function(Value) Settings.ESP.Health = Value end
    })
    ESPTab:CreateToggle({
        Name = "📏 Distance",
        CurrentValue = false,
        Callback = function(Value) Settings.ESP.Distance = Value end
    })
    ESPTab:CreateToggle({
        Name = "🎨 Team Colors",
        CurrentValue = false,
        Callback = function(Value) Settings.ESP.TeamColor = Value end
    })

    -- ВКЛАДКА УПРАВЛЕНИЯ
    local ControlTab = Window:CreateTab("⚙️ Управление", 0)
    ControlTab:CreateSection("Управление скриптом")
    
    ControlTab:CreateButton({
        Name = "OFF ALL",
        Callback = function()
            for k, v in pairs(Settings.AimBot) do
                if type(v) == "boolean" then Settings.AimBot[k] = false end
            end
            for k, v in pairs(Settings.ESP) do
                if type(v) == "boolean" then Settings.ESP[k] = false end
            end
            for k, v in pairs(Settings.Crosshair) do
                if type(v) == "boolean" then Settings.Crosshair[k] = false end
            end
            for k, v in pairs(Settings.FPSBoost) do
                if type(v) == "boolean" then Settings.FPSBoost[k] = false end
            end
            Rayfield:Notify({Title = "Ryzen System", Content = "Все функции отключены!", Duration = 2})
        end
    })
    ControlTab:CreateButton({
        Name = "!DESTROY!",
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
    -- ОСНОВНАЯ ЛОГИКА (ВСЕ ФУНКЦИИ)
    -- ============================================

    local fovCircle = nil
    local crosshairObjects = {}
    local drawingObjects = {}
    local particlesList = {}
    local originalTextures = {}
    local originalSky = nil

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

    local function getRainbowColor(time)
        return Color3.new(
            math.sin(time) * 0.5 + 0.5,
            math.sin(time + 2.094) * 0.5 + 0.5,
            math.sin(time + 4.188) * 0.5 + 0.5
        )
    end

    -- FPS BOOST
    RunService.RenderStepped:Connect(function()
        if Settings.FPSBoost.RemoveParticles then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    if not v:IsDescendantOf(LocalPlayer.Character) then
                        v.Enabled = false
                    end
                end
            end
        end
        
        if Settings.FPSBoost.GrayTextures then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Material ~= Enum.Material.Plastic and not v:IsDescendantOf(LocalPlayer.Character) then
                    v.Material = Enum.Material.Plastic
                    v.Color = Color3.fromRGB(128, 128, 128)
                end
                if v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                end
            end
        end
        
        if Settings.FPSBoost.GraySky then
            local sky = Lighting:FindFirstChild("Sky")
            if sky then
                sky.SkyboxBk = "rbxassetid://1382515588"
                sky.SkyboxDn = "rbxassetid://1382515588"
                sky.SkyboxFt = "rbxassetid://1382515588"
                sky.SkyboxLf = "rbxassetid://1382515588"
                sky.SkyboxRt = "rbxassetid://1382515588"
                sky.SkyboxUp = "rbxassetid://1382515588"
            end
        end
    end)

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

    -- FOV
    RunService.RenderStepped:Connect(function()
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
    end)

    -- CROSSHAIR
    local function clearCrosshair()
        for _, obj in pairs(crosshairObjects) do
            if obj and obj.Remove then obj:Remove() end
        end
        crosshairObjects = {}
    end

    local function createCrosshairObject(type, props)
        local obj = Drawing.new(type)
        for k, v in pairs(props) do obj[k] = v end
        table.insert(crosshairObjects, obj)
        return obj
    end

    RunService.RenderStepped:Connect(function()
        clearCrosshair()
        
        if not Settings.Crosshair.Enabled then return end
        
        local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        local size = Settings.Crosshair.Size
        local thick = Settings.Crosshair.Thickness
        local color = Settings.Crosshair.Color
        local style = Settings.Crosshair.Style
        
        if style == "Классический" then
            createCrosshairObject("Line", {From = Vector2.new(center.X - size, center.Y), To = Vector2.new(center.X - thick/2, center.Y), Thickness = thick, Color = color, Visible = true})
            createCrosshairObject("Line", {From = Vector2.new(center.X + thick/2, center.Y), To = Vector2.new(center.X + size, center.Y), Thickness = thick, Color = color, Visible = true})
            createCrosshairObject("Line", {From = Vector2.new(center.X, center.Y - size), To = Vector2.new(center.X, center.Y - thick/2), Thickness = thick, Color = color, Visible = true})
            createCrosshairObject("Line", {From = Vector2.new(center.X, center.Y + thick/2), To = Vector2.new(center.X, center.Y + size), Thickness = thick, Color = color, Visible = true})
        elseif style == "Точка" then
            createCrosshairObject("Circle", {Position = center, Radius = size/3, Thickness = thick, Color = color, Filled = true, Visible = true})
        elseif style == "Круг" then
            createCrosshairObject("Circle", {Position = center, Radius = size/1.5, Thickness = thick, Color = color, Filled = false, Visible = true})
            createCrosshairObject("Circle", {Position = center, Radius = 2, Thickness = thick, Color = color, Filled = true, Visible = true})
        elseif style == "Крест" then
            local offset = size * 0.7
            createCrosshairObject("Line", {From = Vector2.new(center.X - offset, center.Y - offset), To = Vector2.new(center.X + offset, center.Y + offset), Thickness = thick, Color = color, Visible = true})
            createCrosshairObject("Line", {From = Vector2.new(center.X + offset, center.Y - offset), To = Vector2.new(center.X - offset, center.Y + offset), Thickness = thick, Color = color, Visible = true})
        elseif style == "Стрелка" then
            createCrosshairObject("Line", {From = Vector2.new(center.X, center.Y + size/2), To = Vector2.new(center.X, center.Y - size/2), Thickness = thick, Color = color, Visible = true})
            createCrosshairObject("Line", {From = Vector2.new(center.X - size/3, center.Y - size/3), To = Vector2.new(center.X, center.Y - size/2), Thickness = thick, Color = color, Visible = true})
            createCros
