-- DaniloKolyadenko WEB Key System v9.0
-- Website Key Verification
-- by @Dexter1938

if _G.DaniloWebLoaded then return end
_G.DaniloWebLoaded = true

-- ВАШ ПОСТОЯННЫЙ КЛЮЧ (не удалять!)
local PermanentKey = "AHEFH_PERMANENT_2024"

-- СПИСОК ВАЛИДНЫХ КЛЮЧЕЙ С СЕРВЕРА
local ServerKeys = {
    "AHEFH_PERMANENT_2024",  -- Твой вечный ключ
    -- Остальные будут грузиться с сайта
}

-- ПЕРЕМЕННЫЕ
local KeyVerified = false
local Attempts = 0

-- ЗАГРУЗКА КЛЮЧЕЙ С САЙТА
local function LoadKeysFromWebsite()
    local success, keys = pcall(function()
        -- Это примерный URL, тебе нужно создать реальный сайт
        local response = game:HttpGet("https://yourwebsite.com/getkeys.php")
        return game:GetService("HttpService"):JSONDecode(response)
    end)
    
    if success and keys then
        for _, key in pairs(keys) do
            table.insert(ServerKeys, key)
        end
        print("✅ Keys loaded from website")
    else
        print("⚠️ Using default keys")
    end
end

-- ОСНОВНОЙ ИНТЕРФЕЙС
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local Window = OrionLib:MakeWindow({
    Name = "🔐 DaniloKolyadenko Key System",
    HidePremium = false,
    SaveConfig = false,
    IntroEnabled = true,
    IntroText = "Key Verification Required",
    IntroIcon = "rbxassetid://4483345998"
})

-- KEY VERIFICATION TAB
local KeyTab = Window:MakeTab({
    Name = "🔑 Key Verification",
    Icon = "rbxassetid://4483345998"
})

KeyTab:AddLabel("🔒 Premium Access Required")
KeyTab:AddLabel("This script requires a valid key")
KeyTab:AddParagraph("How to get key:", "1. Visit our website\n2. Complete simple tasks\n3. Get your free key\n4. Enter it below")

-- КНОПКА ПЕРЕХОДА НА САЙТ
KeyTab:AddButton({
    Name = "🌐 Get Key from Website",
    Callback = function()
        -- Твой сайт где будут задания
        local website = "https://yourwebsite.com/getkey"
        OrionLib:MakeNotification({
            Name = "🌐 Open Website",
            Content = "Opening: " .. website,
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        
        -- Попытка открыть браузер (для ПК)
        pcall(function()
            setclipboard(website)
            OrionLib:MakeNotification({
                Name = "📋 Link Copied",
                Content = "Website link copied to clipboard!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end)
        
        -- Загрузка ключей с сайта
        LoadKeysFromWebsite()
    end
})

-- ПОЛЕ ДЛЯ ВВОДА КЛЮЧА
local KeyInput = ""
KeyTab:AddTextbox({
    Name = "Enter Your Key",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        KeyInput = string.upper(Value)
    end
})

-- КНОПКА ПРОВЕРКИ
KeyTab:AddButton({
    Name = "✅ Verify Key",
    Callback = function()
        if KeyInput == "" then
            OrionLib:MakeNotification({
                Name = "❌ Empty Key",
                Content = "Please enter a key first!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            return
        end
        
        Attempts = Attempts + 1
        
        -- ПРОВЕРКА НА ТВОЙ ПОСТОЯННЫЙ КЛЮЧ
        if KeyInput == PermanentKey then
            KeyVerified = true
            OrionLib:MakeNotification({
                Name = "🎉 PERMANENT ACCESS!",
                Content = "Welcome back, AHEFH!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            LoadPremiumFeatures()
            return
        end
        
        -- ПРОВЕРКА ОСТАЛЬНЫХ КЛЮЧЕЙ
        local valid = false
        for _, validKey in pairs(ServerKeys) do
            if KeyInput == validKey then
                valid = true
                break
            end
        end
        
        if valid then
            KeyVerified = true
            OrionLib:MakeNotification({
                Name = "✅ Key Accepted!",
                Content = "Loading premium features...",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            LoadPremiumFeatures()
        else
            OrionLib:MakeNotification({
                Name = "❌ Invalid Key",
                Content = "Attempts left: " .. (3 - Attempts),
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            
            if Attempts >= 3 then
                OrionLib:MakeNotification({
                    Name = "🚫 Too Many Attempts",
                    Content = "Please get a valid key from website",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
    end
})

-- ФУНКЦИЯ ЗАГРУЗКИ ПРЕМИУМ ФИЧЕЙ
function LoadPremiumFeatures()
    -- Закрываем окно ключей
    Window:Destroy()
    
    -- ЗАГРУЗКА ОСНОВНОГО ЧИТА
    OrionLib:MakeNotification({
        Name = "🎮 Loading Premium Features",
        Content = "Welcome to DaniloKolyadenko ULTRA!",
        Image = "rbxassetid://4483345998",
        Time = 3
    })
    
    -- СОЗДАЕМ НОВОЕ ОКНО С ФИЧАМИ
    local MainWindow = OrionLib:MakeWindow({
        Name = "🧠 DaniloKolyadenko ULTRA",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "DaniloConfig",
        IntroEnabled = true,
        IntroText = "Premium Features Unlocked!",
        IntroIcon = "rbxassetid://4483345998"
    })
    
    -- COMBAT TAB
    local CombatTab = MainWindow:MakeTab({
        Name = "⚔️ Combat",
        Icon = "rbxassetid://4483345998"
    })
    
    CombatTab:AddLabel("👊 Auto Actions")
    
    CombatTab:AddToggle({
        Name = "Auto Punch Players",
        Default = false,
        Callback = function(Value)
            _G.AutoPunch = Value
            if Value then
                spawn(function()
                    while _G.AutoPunch do
                        task.wait(0.2)
                        pcall(function()
                            for _, target in pairs(game.Players:GetPlayers()) do
                                if target ~= game.Players.LocalPlayer and target.Character then
                                    local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude
                                    if distance < 25 then
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                                    end
                                end
                            end
                        end)
                    end
                end)
            end
        end
    })
    
    CombatTab:AddToggle({
        Name = "Auto Kick Players",
        Default = false,
        Callback = function(Value)
            _G.AutoKick = Value
            if Value then
                spawn(function()
                    while _G.AutoKick do
                        task.wait(0.3)
                        pcall(function()
                            for _, target in pairs(game.Players:GetPlayers()) do
                                if target ~= game.Players.LocalPlayer and target.Character then
                                    local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Magnitude
                                    if distance < 20 then
                                        local bv = Instance.new("BodyVelocity")
                                        bv.Velocity = Vector3.new(0, 60, 0)
                                        bv.MaxForce = Vector3.new(10000, 10000, 10000)
                                        bv.Parent = target.Character.HumanoidRootPart
                                        task.wait(0.15)
                                        bv:Destroy()
                                    end
                                end
                            end
                        end)
                    end
                end)
            end
        end
    })
    
    CombatTab:AddToggle({
        Name = "Auto Collect Brainrots",
        Default = false,
        Callback = function(Value)
            _G.AutoCollect = Value
            if Value then
                spawn(function()
                    while _G.AutoCollect do
                        task.wait(0.5)
                        pcall(function()
                            for _, obj in pairs(game.Workspace:GetChildren()) do
                                if obj.Name:find("Brainrot") and obj:IsA("BasePart") then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                                end
                            end
                        end)
                    end
                end)
            end
        end
    })
    
    -- VISUALS TAB
    local VisualsTab = MainWindow:MakeTab({
        Name = "👁️ Visuals",
        Icon = "rbxassetid://4483345998"
    })
    
    VisualsTab:AddToggle({
        Name = "Player ESP",
        Default = false,
        Callback = function(Value)
            _G.PlayerESP = Value
            if Value then
                spawn(function()
                    while _G.PlayerESP do
                        task.wait(1)
                        pcall(function()
                            for _, player in pairs(game.Players:GetPlayers()) do
                                if player ~= game.Players.LocalPlayer and player.Character then
                                    local highlight = player.Character:FindFirstChild("DaniloESP") or Instance.new("Highlight")
                                    highlight.Name = "DaniloESP"
                                    highlight.Adornee = player.Character
                                    highlight.FillColor = Color3.fromRGB(255, 50, 50)
                                    highlight.OutlineColor = Color3.fromRGB(200, 0, 0)
                                    highlight.FillTransparency = 0.3
                                    highlight.Parent = player.Character
                                end
                            end
                        end)
                    end
                end)
            else
                pcall(function()
                    for _, obj in pairs(game.Workspace:GetDescendants()) do
                        if obj.Name == "DaniloESP" then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end
    })
    
    -- MOVEMENT TAB
    local MovementTab = MainWindow:MakeTab({
        Name = "🚀 Movement",
        Icon = "rbxassetid://4483345998"
    })
    
    MovementTab:AddSlider({
        Name = "WalkSpeed",
        Min = 16,
        Max = 200,
        Default = 16,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 5,
        ValueName = "speed",
        Callback = function(Value)
            pcall(function()
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
            end)
        end
    })
    
    MovementTab:AddSlider({
        Name = "JumpPower",
        Min = 50,
        Max = 300,
        Default = 50,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 10,
        ValueName = "power",
        Callback = function(Value)
            pcall(function()
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
            end)
        end
    })
    
    -- SERVER TAB
    local ServerTab = MainWindow:MakeTab({
        Name = "🌐 Servers",
        Icon = "rbxassetid://4483345998"
    })
    
    ServerTab:AddButton({
        Name = "Find Brainrot Servers",
        Callback = function()
            OrionLib:MakeNotification({
                Name = "🔍 Searching Servers",
                Content = "Looking for brainrot servers...",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            
            -- Имитация поиска
            local servers = {
                "Brainrot Heaven #1",
                "Fast Farm Server",
                "EZ Brainrots Lobby",
                "Premium Farm Server"
            }
            
            for i, server in ipairs(servers) do
                task.wait(1)
                ServerTab:AddLabel("✅ " .. server)
            end
        end
    })
    
    -- SETTINGS TAB
    local SettingsTab = MainWindow:MakeTab({
        Name = "⚙️ Settings",
        Icon = "rbxassetid://4483345998"
    })
    
    SettingsTab:AddLabel("👑 Premium User: AHEFH")
    SettingsTab:AddLabel("🔑 Key: " .. KeyInput)
    SettingsTab:AddLabel("⭐ Permanent Access")
    
    SettingsTab:AddButton({
        Name = "Copy Key",
        Callback = function()
            setclipboard(KeyInput)
            OrionLib:MakeNotification({
                Name = "📋 Copied",
                Content = "Key copied to clipboard!",
                Image = "rbxassetid://4483345998",
                Time = 2
            })
        end
    })
    
    SettingsTab:AddKeybind({
        Name = "Toggle UI",
        Default = Enum.KeyCode.RightControl,
        Hold = false,
        Callback = function()
            OrionLib:ToggleUI()
        end
    })
    
    OrionLib:MakeNotification({
        Name = "🎉 WELCOME AHEFH!",
        Content = "All premium features unlocked!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

-- ЗАГРУЗКА КЛЮЧЕЙ ПРИ СТАРТЕ
LoadKeysFromWebsite()

-- АВТО-ПРОВЕРКА ТВОЕГО КЛЮЧА (для теста)
spawn(function()
    task.wait(2)
    -- Если хочешь авто-вход своим ключом, раскомментируй:
    -- KeyInput = PermanentKey
    -- LoadPremiumFeatures()
end)

OrionLib:InitNotification({
    Name = "🔐 DaniloKolyadenko",
    Content = "Key system loaded. Enter your key!",
    Image = "rbxassetid://4483345998",
    Time = 5
})