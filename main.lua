-- DaniloKolyadenko ULTIMATE Brainrot Hack
-- by @Dexter1938

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "DaniloKolyadenko",
    LoadingTitle = "ULTIMATE BRAINROT HACK",
    LoadingSubtitle = "by @Dexter1938",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DaniloKolyadenkoConfig",
        FileName = "UltimateConfig"
    },
    KeySystem = false,
    KeySettings = {
        Title = "DaniloKolyadenko VIP",
        Subtitle = "Access System",
        Note = "No key required",
        FileName = "DaniloKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"DEXTER1938"}
    }
})

-- ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ
local Services = {
    Players = game:GetService("Players"),
    Workspace = game:GetService("Workspace"),
    TeleportService = game:GetService("TeleportService"),
    HttpService = game:GetService("HttpService"),
    RunService = game:GetService("RunService")
}

local Player = Services.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- СОСТОЯНИЯ АКТИВНЫХ ФУНКЦИЙ
local Active = {
    AutoPunch = false,
    AutoKick = false,
    AutoCollect = false,
    ServerHop = false,
    ESP = false,
    NoClip = false,
    Speed = false,
    Jump = false,
    AntiGrab = false
}

-- КОНФИГУРАЦИЯ
local Config = {
    PunchRange = 25,
    KickRange = 20,
    CollectRange = 50,
    PunchDelay = 0.1,
    KickDelay = 0.3,
    CollectDelay = 0.5,
    WalkSpeed = 50,
    JumpPower = 100
}

-- ТАБЫ (как на скриншоте)
local CombatTab = Window:CreateTab("Combat", "swords") -- Иконка мечей
local TrollTab = Window:CreateTab("Troll", "laugh") -- Иконка смеха
local ScreenTab = Window:CreateTab("Screen", "monitor") -- Иконка монитора
local MiscTab = Window:CreateTab("Misc", "settings") -- Иконка настроек
local SettingsTab = Window:CreateTab("Settings", "cog") -- Иконка шестеренки

-- ФУНКЦИЯ ДЛЯ ESP (Визуализация брейнротов и игроков)
local function CreateESP()
    if Active.ESP then
        for _, brainrot in pairs(Services.Workspace:GetChildren()) do
            if brainrot.Name:find("Brainrot") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "BrainrotESP"
                highlight.Adornee = brainrot
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.OutlineColor = Color3.fromRGB(0, 200, 0)
                highlight.FillTransparency = 0.5
                highlight.Parent = brainrot
            end
        end
        
        for _, player in pairs(Services.Players:GetPlayers()) do
            if player ~= Player and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "PlayerESP"
                highlight.Adornee = player.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(200, 0, 0)
                highlight.FillTransparency = 0.3
                highlight.Parent = player.Character
            end
        end
    end
end

-- ФУНКЦИЯ АВТО-УДАРА
local function AutoPunch()
    while Active.AutoPunch do
        task.wait(Config.PunchDelay)
        
        for _, target in pairs(Services.Players:GetPlayers()) do
            if target ~= Player and target.Character then
                local humanoid = target.Character:FindFirstChild("Humanoid")
                local root = target.Character:FindFirstChild("HumanoidRootPart")
                
                if humanoid and humanoid.Health > 0 and root then
                    local distance = (Player.Character.HumanoidRootPart.Position - root.Position).Magnitude
                    
                    if distance <= Config.PunchRange then
                        -- Симуляция удара
                        Player.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 0, -2)
                        task.wait(0.1)
                        -- Можно добавить реальный удар через RemoteEvent если известен
                    end
                end
            end
        end
    end
end

-- ФУНКЦИЯ АВТО-КИКА
local function AutoKick()
    while Active.AutoKick do
        task.wait(Config.KickDelay)
        
        for _, target in pairs(Services.Players:GetPlayers()) do
            if target ~= Player and target.Character then
                local humanoid = target.Character:FindFirstChild("Humanoid")
                local root = target.Character:FindFirstChild("HumanoidRootPart")
                
                if humanoid and humanoid.Health > 0 and root then
                    local distance = (Player.Character.HumanoidRootPart.Position - root.Position).Magnitude
                    
                    if distance <= Config.KickRange then
                        -- Симуляция кика (толчок)
                        local bodyVelocity = Instance.new("BodyVelocity")
                        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
                        bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                        bodyVelocity.Parent = root
                        task.wait(0.2)
                        bodyVelocity:Destroy()
                    end
                end
            end
        end
    end
end

-- ФУНКЦИЯ АВТО-СБОРА БРЕЙНРОТОВ
local function AutoCollectBrainrots()
    while Active.AutoCollect do
        task.wait(Config.CollectDelay)
        
        for _, item in pairs(Services.Workspace:GetChildren()) do
            if item.Name:find("Brainrot") and item:IsA("BasePart") then
                local distance = (Player.Character.HumanoidRootPart.Position - item.Position).Magnitude
                
                if distance <= Config.CollectRange then
                    Player.Character.HumanoidRootPart.CFrame = item.CFrame
                    task.wait(0.1)
                    -- Предполагаем, что сбор происходит при касании
                end
            end
        end
    end
end

-- ФУНКЦИЯ ПОИСКА СЕРВЕРОВ С БРЕЙНРОТАМИ
local function FindBrainrotServers()
    Rayfield:Notify({
        Title = "Server Search",
        Content = "Searching for servers with brainrots...",
        Duration = 3,
    })
    
    -- Это примерная логика, в реальности нужен доступ к API или список серверов
    local serverIds = {123456789, 987654321, 555555555} -- Пример ID серверов
    
    for _, serverId in pairs(serverIds) do
        local success, error = pcall(function()
            Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, tostring(serverId), Player)
        end)
        
        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "Teleporting to server " .. serverId,
                Duration = 3,
            })
            break
        end
    end
end

-- COMBAT TAB
local CombatSection = CombatTab:CreateSection("Auto Actions")

local AutoPunchToggle = CombatSection:CreateToggle({
    Name = "Auto Punch Players",
    CurrentValue = false,
    Flag = "AutoPunchToggle",
    Callback = function(Value)
        Active.AutoPunch = Value
        if Value then
            coroutine.wrap(AutoPunch)()
            Rayfield:Notify({
                Title = "Auto Punch",
                Content = "Started auto punching!",
                Duration = 2,
            })
        end
    end,
})

local AutoKickToggle = CombatSection:CreateToggle({
    Name = "Auto Kick Players",
    CurrentValue = false,
    Flag = "AutoKickToggle",
    Callback = function(Value)
        Active.AutoKick = Value
        if Value then
            coroutine.wrap(AutoKick)()
            Rayfield:Notify({
                Title = "Auto Kick",
                Content = "Started auto kicking!",
                Duration = 2,
            })
        end
    end,
})

local AutoCollectToggle = CombatSection:CreateToggle({
    Name = "Auto Collect Brainrots",
    CurrentValue = false,
    Flag = "AutoCollectToggle",
    Callback = function(Value)
        Active.AutoCollect = Value
        if Value then
            coroutine.wrap(AutoCollectBrainrots)()
            Rayfield:Notify({
                Title = "Auto Collect",
                Content = "Started collecting brainrots!",
                Duration = 2,
            })
        end
    end,
})

local ServerHopButton = CombatSection:CreateButton({
    Name = "Find Brainrot Servers",
    Callback = function()
        FindBrainrotServers()
    end,
})

-- TROLL TAB
local TrollSection = TrollTab:CreateSection("Trolling")

local NoClipToggle = TrollSection:CreateToggle({
    Name = "NoClip Mode",
    CurrentValue = false,
    Flag = "NoClipToggle",
    Callback = function(Value)
        Active.NoClip = Value
        if Value then
            for _, part in pairs(Player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        else
            for _, part in pairs(Player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end,
})

-- SCREEN TAB
local VisualSection = ScreenTab:CreateSection("Visuals")

local ESPToggle = VisualSection:CreateToggle({
    Name = "ESP (Brainrots & Players)",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        Active.ESP = Value
        if Value then
            CreateESP()
        else
            for _, obj in pairs(Services.Workspace:GetDescendants()) do
                if obj.Name == "BrainrotESP" or obj.Name == "PlayerESP" then
                    obj:Destroy()
                end
            end
        end
    end,
})

-- MISC TAB
local MovementSection = MiscTab:CreateSection("Movement")

local SpeedSlider = MovementSection:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 5,
    Suffix = "studs",
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        Config.WalkSpeed = Value
        Player.Character.Humanoid.WalkSpeed = Value
    end,
})

local JumpSlider = MovementSection:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 10,
    Suffix = "power",
    CurrentValue = 50,
    Flag = "JumpSlider",
    Callback = function(Value)
        Config.JumpPower = Value
        Player.Character.Humanoid.JumpPower = Value
    end,
})

-- SETTINGS TAB
local ConfigSection = SettingsTab:CreateSection("Configuration")

local RangeSlider = ConfigSection:CreateSlider({
    Name = "Punch/Kick Range",
    Range = {10, 100},
    Increment = 5,
    Suffix = "studs",
    CurrentValue = 25,
    Flag = "RangeSlider",
    Callback = function(Value)
        Config.PunchRange = Value
        Config.KickRange = Value - 5
    end,
})

local DelaySlider = ConfigSection:CreateSlider({
    Name = "Action Delay",
    Range = {0.1, 2},
    Increment = 0.1,
    Suffix = "seconds",
    CurrentValue = 0.3,
    Flag = "DelaySlider",
    Callback = function(Value)
        Config.PunchDelay = Value
        Config.KickDelay = Value + 0.2
        Config.CollectDelay = Value + 0.4
    end,
})

-- ЗАКРЫТИЕ ОКНА
Window:Prompt({
    Title = "DaniloKolyadenko Loaded",
    SubTitle = "by @Dexter1938",
    Content = "Ultimate Brainrot Hack activated!",
    Actions = {
        Accept = {
            Name = "Let's Go!",
            Callback = function()
                Rayfield:Notify({
                    Title = "Ready",
                    Content = "All features loaded successfully!",
                    Duration = 3,
                })
            end
        },
    }
})

-- АВТО-ОБНОВЛЕНИЕ ESP
Services.RunService.Heartbeat:Connect(function()
    if Active.ESP then
        pcall(CreateESP)
    end
end)

Rayfield:Notify({
    Title = "DaniloKolyadenko",
    Content = "ULTIMATE BRAINROT HACK LOADED!",
    Duration = 5,
})