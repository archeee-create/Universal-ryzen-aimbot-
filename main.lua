-- RAYFIELD ПУСТОЕ МЕНЮ
-- ТОЛЬКО ОКНО, БЕЗ ФУНКЦИЙ

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Ryzen Aimbot",
    Icon = 0,
    LoadingTitle = "Ryzen System",
    LoadingSubtitle = "Loading...",
    Theme = "Dark",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "Ryzen"
    }
})

local MainTab = Window:CreateTab("Главная", 0)

MainTab:CreateSection("Настройки")

print("Rayfield пустое меню загружено!")
