if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHesiix/Rayfield/main/source.lua"))()

local Window = Rayfield:CreateWindow({
    Name = "Violence District | ESP",
    LoadingTitle = "",
    LoadingSubtitle = "",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "ViolenceDistrict_ESP"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

local ESPTab = Window:CreateTab("ESP")
local ESPSection = ESPTab:CreateSection("Настройки ESP")

local Settings = {
    ESP = false,
    Team = false,
    HPBar = false,
    HPText = false,
    State = false,
    Distance = false,
    Nickname = false
}

ESPTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Flag = "ESP_Enabled",
    Callback = function(Value)
        Settings.ESP = Value
        if Settings.ESP then
            for _, Player in pairs(Players:GetPlayers()) do
                if Player ~= LocalPlayer then
                    CreateESP(Player)
                end
            end
        else
            for Player, Objects in pairs(ESPObjects) do
                if Objects.Billboard then
                    Objects.Billboard:Destroy()
                end
            end
            ESPObjects = {}
        end
    end
})

ESPTab:CreateToggle({
    Name = "Team Check",
    CurrentValue = false,
    Flag = "ESP_Team",
    Callback = function(Value)
        Settings.Team = Value
    end
})

ESPTab:CreateToggle({
    Name = "HP Bar",
    CurrentValue = false,
    Flag = "ESP_HPBar",
    Callback = function(Value)
        Settings.HPBar = Value
    end
})

ESPTab:CreateToggle({
    Name = "HP Text",
    CurrentValue = false,
    Flag = "ESP_HPText",
    Callback = function(Value)
        Settings.HPText = Value
    end
})

ESPTab:CreateToggle({
    Name = "State",
    CurrentValue = false,
    Flag = "ESP_State",
    Callback = function(Value)
        Settings.State = Value
    end
})

ESPTab:CreateToggle({
    Name = "Distance",
    CurrentValue = false,
    Flag = "ESP_Distance",
    Callback = function(Value)
        Settings.Distance = Value
    end
})

ESPTab:CreateToggle({
    Name = "Nickname",
    CurrentValue = false,
    Flag = "ESP_Nickname",
    Callback = function(Value)
        Settings.Nickname = Value
    end
})

local Colors = {
    Friend = Color3.fromRGB(0, 255, 0),
    Enemy = Color3.fromRGB(255, 0, 0),
    HPBarBG = Color3.fromRGB(30, 30, 30),
    Healthy = Color3.fromRGB(0, 255, 0),
    Injured = Color3.fromRGB(255, 255, 0),
    Knocked = Color3.fromRGB(255, 165, 0),
    Hooked = Color3.fromRGB(255, 0, 255)
}

local ESPObjects = {}

local function GetPlayerState(Player)
    if not Player.Character then
        return "Dead", Color3.fromRGB(255, 0, 0)
    end
    local Humanoid = Player.Character:FindFirstChild("Humanoid")
    if not Humanoid then
        return "Dead", Color3.fromRGB(255, 0, 0)
    end
    local Health = Humanoid.Health
    local MaxHealth = Humanoid.MaxHealth
    
    if Player.Character:FindFirstChild("Hooked") then
        return "Hooked", Colors.Hooked
    end
    
    if Player.Character:FindFirstChild("Knocked") or Player.Character:FindFirstChild("Downed") then
        return "Knocked", Colors.Knocked
    end
    
    if Health <= 0 then
        return "Dead", Color3.fromRGB(255, 0, 0)
    elseif Health < MaxHealth then
        return "Injured", Colors.Injured
    else
        return "Healthy", Colors.Healthy
    end
end

local function GetTeamColor(Player)
    if Player.Team then
        return Player.Team.TeamColor.Color
    end
    return Color3.fromRGB(255, 255, 255)
end

local function CreateESP(Player)
    if not Player.Character or not Player.Character:FindFirstChild("Humanoid") then
        return
    end
    local RootPart = Player.Character:FindFirstChild("HumanoidRootPart") or Player.Character:FindFirstChild("Torso")
    if not RootPart then
        return
    end

    local Billboard = Instance.new("BillboardGui")
    Billboard.Size = UDim2.new(0, 250, 0, 150)
    Billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    Billboard.AlwaysOnTop = true
    Billboard.MaxDistance = 400
    Billboard.Parent = Player.Character

    local Frame1 = Instance.new("Frame")
    Frame1.Size = UDim2.new(1, 0, 1, 0)
    Frame1.BackgroundTransparency = 0.5
    Frame1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame1.BorderSizePixel = 0
    Frame1.ClipsDescendants = true
    Frame1.Parent = Billboard

    local Corner1 = Instance.new("UICorner")
    Corner1.CornerRadius = UDim.new(0, 8)
    Corner1.Parent = Frame1

    local Frame2 = Instance.new("Frame")
    Frame2.Size = UDim2.new(0.9, 0, 0.85, 0)
    Frame2.Position = UDim2.new(0.05, 0, 0.05, 0)
    Frame2.BackgroundTransparency = 0.3
    Frame2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame2.BorderSizePixel = 0
    Frame2.ClipsDescendants = true
    Frame2.Parent = Frame1

    local Corner2 = Instance.new("UICorner")
    Corner2.CornerRadius = UDim.new(0, 6)
    Corner2.Parent = Frame2

    local HPBarBG = Instance.new("Frame")
    HPBarBG.Size = UDim2.new(0.7, 0, 0.08, 0)
    HPBarBG.Position = UDim2.new(0.15, 0, 0.2, 0)
    HPBarBG.BackgroundColor3 = Colors.HPBarBG
    HPBarBG.BorderSizePixel = 0
    HPBarBG.Parent = Frame2

    local CornerHP = Instance.new("UICorner")
    CornerHP.CornerRadius = UDim.new(0, 4)
    CornerHP.Parent = HPBarBG

    local HPBar = Instance.new("Frame")
    HPBar.Size = UDim2.new(1, 0, 1, 0)
    HPBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    HPBar.BorderSizePixel = 0
    HPBar.Parent = HPBarBG

    local CornerHPFill = Instance.new("UICorner")
    CornerHPFill.CornerRadius = UDim.new(0, 4)
    CornerHPFill.Parent = HPBar

    local HPText = Instance.new("TextLabel")
    HPText.Size = UDim2.new(0.7, 0, 0.1, 0)
    HPText.Position = UDim2.new(0.15, 0, 0.3, 0)
    HPText.BackgroundTransparency = 1
    HPText.Text = "HP: 100/100"
    HPText.TextColor3 = Color3.fromRGB(255, 255, 255)
    HPText.TextScaled = true
    HPText.Font = Enum.Font.GothamBold
    HPText.Parent = Frame2

    local StateText = Instance.new("TextLabel")
    StateText.Size = UDim2.new(0.7, 0, 0.1, 0)
    StateText.Position = UDim2.new(0.15, 0, 0.42, 0)
    StateText.BackgroundTransparency = 1
    StateText.Text = "State: Healthy"
    StateText.TextColor3 = Color3.fromRGB(0, 255, 0)
    StateText.TextScaled = true
    StateText.Font = Enum.Font.Gotham
    StateText.Parent = Frame2

    local DistanceText = Instance.new("TextLabel")
    DistanceText.Size = UDim2.new(0.7, 0, 0.1, 0)
    DistanceText.Position = UDim2.new(0.15, 0, 0.54, 0)
    DistanceText.BackgroundTransparency = 1
    DistanceText.Text = "Dist: 0m"
    DistanceText.TextColor3 = Color3.fromRGB(255, 255, 255)
    DistanceText.TextScaled = true
    DistanceText.Font = Enum.Font.Gotham
    DistanceText.Parent = Frame2

    local TeamText = Instance.new("TextLabel")
    TeamText.Size = UDim2.new(0.7, 0, 0.1, 0)
    TeamText.Position = UDim2.new(0.15, 0, 0.66, 0)
    TeamText.BackgroundTransparency = 1
    TeamText.Text = "Team: Unknown"
    TeamText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeamText.TextScaled = true
    TeamText.Font = Enum.Font.Gotham
    TeamText.Parent = Frame2

    local NicknameText = Instance.new("TextLabel")
    NicknameText.Size = UDim2.new(0.9, 0, 0.12, 0)
    NicknameText.Position = UDim2.new(0.05, 0, 0.82, 0)
    NicknameText.BackgroundTransparency = 1
    NicknameText.Text = "PlayerName"
    NicknameText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NicknameText.TextScaled = true
    NicknameText.Font = Enum.Font.GothamBold
    NicknameText.Parent = Frame1

    ESPObjects[Player] = {
        Billboard = Billboard,
        Frame1 = Frame1,
        Frame2 = Frame2,
        HPBarBG = HPBarBG,
        HPBar = HPBar,
        HPText = HPText,
        StateText = StateText,
        DistanceText = DistanceText,
        TeamText = TeamText,
        NicknameText = NicknameText
    }
end

local function UpdateESP()
    for Player, Objects in pairs(ESPObjects) do
        if not Player or not Player.Character or not Player.Character:FindFirstChild("Humanoid") then
            if Objects.Billboard then
                Objects.Billboard:Destroy()
            end
            ESPObjects[Player] = nil
        else
            local Humanoid = Player.Character.Humanoid
            local Health = Humanoid.Health
            local MaxHealth = Humanoid.MaxHealth
            local HealthPercent = Health / MaxHealth
            local Distance = (Camera.CFrame.Position - Player.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude

            if Objects.HPBar then
                Objects.HPBar.Size = UDim2.new(HealthPercent, 0, 1, 0)
                if HealthPercent > 0.5 then
                    Objects.HPBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                elseif HealthPercent > 0.25 then
                    Objects.HPBar.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                else
                    Objects.HPBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                end
            end

            if Objects.HPText then
                Objects.HPText.Text = "HP: " .. math.floor(Health) .. "/" .. math.floor(MaxHealth)
            end

            local State, StateColor = GetPlayerState(Player)
            if Objects.StateText then
                Objects.StateText.Text = "State: " .. State
                Objects.StateText.TextColor3 = StateColor
            end

            if Objects.DistanceText then
                Objects.DistanceText.Text = "Dist: " .. math.floor(Distance) .. "m"
            end

            if Objects.TeamText then
                local TeamColor = GetTeamColor(Player)
                Objects.TeamText.Text = "Team: " .. (Player.Team and Player.Team.Name or "Unknown")
                Objects.TeamText.TextColor3 = TeamColor
            end

            if Objects.NicknameText then
                Objects.NicknameText.Text = Player.Name
                if Settings.Team and Player.Team == LocalPlayer.Team then
                    Objects.NicknameText.TextColor3 = Colors.Friend
                else
                    Objects.NicknameText.TextColor3 = Colors.Enemy
                end
            end

            if Objects.Frame1 then
                Objects.Frame1.Visible = Settings.ESP
            end
            if Objects.HPBarBG then
                Objects.HPBarBG.Visible = Settings.HPBar
            end
            if Objects.HPText then
                Objects.HPText.Visible = Settings.HPText
            end
            if Objects.StateText then
                Objects.StateText.Visible = Settings.State
            end
            if Objects.DistanceText then
                Objects.DistanceText.Visible = Settings.Distance
            end
            if Objects.NicknameText then
                Objects.NicknameText.Visible = Settings.Nickname
            end
        end
    end
end

local function RecreateESP(Player)
    if ESPObjects[Player] then
        if ESPObjects[Player].Billboard then
            ESPObjects[Player].Billboard:Destroy()
        end
        ESPObjects[Player] = nil
    end
    wait(0.5)
    if Settings.ESP then
        CreateESP(Player)
    end
end

Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function()
        RecreateESP(Player)
    end)
end)

Players.PlayerRemoving:Connect(function(Player)
    if ESPObjects[Player] then
        if ESPObjects[Player].Billboard then
            ESPObjects[Player].Billboard:Destroy()
        end
        ESPObjects[Player] = nil
    end
end)

for _, Player in pairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        Player.CharacterAdded:Connect(function()
            RecreateESP(Player)
        end)
    end
end

RunService.RenderStepped:Connect(function()
    UpdateESP()
end)

UserInputService.InputBegan:Connect(function(Input, Processed)
    if Processed then return end
    if Input.KeyCode == Enum.KeyCode.Insert then
        Settings.ESP = not Settings.ESP
        Rayfield:SetToggle("ESP_Enabled", Settings.ESP)
        if Settings.ESP then
            for _, Player in pairs(Players:GetPlayers()) do
                if Player ~= LocalPlayer then
                    CreateESP(Player)
                end
            end
        else
            for Player, Objects in pairs(ESPObjects) do
                if Objects.Billboard then
                    Objects.Billboard:Destroy()
                end
            end
            ESPObjects = {}
        end
    end
end)
