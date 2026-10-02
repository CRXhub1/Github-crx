-- Rise Blade Ball v2.1.9 UI Replica
-- Luau Script for Roblox

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==================== COLORES ====================
local COLORS = {
    BG_DARK = Color3.fromRGB(18, 18, 20),
    ACCENT = Color3.fromRGB(255, 59, 0),
    TEXT_PRIMARY = Color3.fromRGB(255, 255, 255),
    TEXT_SECONDARY = Color3.fromRGB(180, 180, 180),
    ELEMENT_BG = Color3.fromRGB(30, 30, 35),
    ELEMENT_HOVER = Color3.fromRGB(40, 40, 50),
}

-- ==================== VARIABLES GLOBALES ====================
local menuOpen = true
local menuLocked = false
local currentTab = "Combat"

local Settings = {
    Combat = {
        PerModeCurves = false,
        DribblePreClick = false,
        SlashOfFuryCounter = false,
        SlashSpeed = "Instant",
        SlashDelay = 50,
        PullEscape = false,
        AutoSpam = false,
        AutoSpamMode = "Unknown",
        ManualSpam = false,
        AutoAbility = false,
        AutoAbilityMode = "Unknown",
        OnlyAboveSpeed = 500,
        CooldownProtection = false,
        CooldownProtectionMode = "Unknown",
        ThunderDashNoCooldown = false,
    },
    BanRisk = {
        UnlockAll = false,
        UnlockAllMode = "None",
        AutoLoadLastLoadout = false,
        EmoteWhileMoving = false,
        ForceEmote = false,
        EmoteSpam = false,
        EmoteOnSpawn = false,
        SwordSkin = "sword name",
        ExplosionSkin = "explosion name",
        EmotesOnly = false,
    },
    Visuals = {
        PlayerTrail = false,
        PlayerTrailMode = "None",
        PlayerTrailRainbow = false,
        PlayerTrailColor = Color3.fromRGB(255, 59, 0),
        PlayerTrailLifetime = 1.5,
        PlayerTrailWidth = 1.5,
        Visualizer = false,
        VisualizerMode = "None",
        VisualizerColor = Color3.fromRGB(255, 59, 0),
        BallTrail = false,
        BallTrailMode = "None",
        BallTrailRainbow = false,
        BallParticles = false,
        BallGlow = false,
        AbilityESP = false,
        AbilityESPMode = "None",
        ShowCooldown = false,
        ShowPlayerName = false,
        BallHUD = false,
        BallHUDMode = "None",
        SpeedColour = false,
        ShowDistance = false,
        ShowPeakSpeed = false,
        HUDAccent = Color3.fromRGB(255, 59, 0),
        FPSPing = false,
    },
    Player = {
        Headless = false,
        KorbloxLeg = false,
        Device = "PC",
        VIPTag = false,
        WalkSpeed = false,
        WalkSpeedValue = 60,
        JumpPower = false,
        JumpPowerValue = 125,
    },
    World = {
        Skybox = "Default",
        TimeOfDay = "Day",
        Fullbright = false,
        NoFog = false,
        CustomFOV = false,
        FOV = 60,
        CustomGravity = false,
        Gravity = 200,
        FPSBoost = false,
        NoBattleEffects = false,
        FPSCap = false,
        MaxFPS = 180,
        AutoAntiLag = false,
        AntiLagThreshold = 60,
        CinematicShaders = false,
        ShaderPreset = "Noir",
        DepthOfField = false,
        Bloom = 1.5,
        Saturation = 1,
        Brightness = 0.15,
        Contrast = 0.25,
        RainEffect = false,
        RainIntensity = 200,
        EnableFFlags = false,
        CustomFFlags = false,
        FFlagsPreset = "Gray World",
        Region = "Auto",
        Music = false,
        MusicMode = "None",
        MusicTrack = "Solo",
        MusicVolume = 5,
        MusicCustomID = "Roblox audio ID",
        AntiAFK = false,
        AutoExecuteOnTeleport = false,
        AutoRematch = false,
        GrindMode = false,
    },
    Settings = {
        OpenKeybindMenu = false,
        NotificationSide = "Left",
        UIAccentColor = Color3.fromRGB(255, 59, 0),
        SendLaunchCount = false,
        ToggleUIKey = "Unknown",
        StaffDetection = false,
        StaffAction = "Close Game",
        CurrentAutoloadConfig = "none",
    },
}

-- ==================== CREAR GUI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RiseBladeballUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- ==================== BOTONES FLOTANTES ====================
local floatingButtonsFrame = Instance.new("Frame")
floatingButtonsFrame.Name = "FloatingButtons"
floatingButtonsFrame.Size = UDim2.new(0, 0, 0, 0)
floatingButtonsFrame.BackgroundTransparency = 1
floatingButtonsFrame.Parent = screenGui

-- Toggle Button (Draggable)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 15, 0, 15)
toggleBtn.Text = "≡"
toggleBtn.TextScaled = true
toggleBtn.TextColor3 = COLORS.TEXT_PRIMARY
toggleBtn.BackgroundColor3 = COLORS.ACCENT
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = floatingButtonsFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleCorner.Parent = toggleBtn

local toggleDragging = false
local toggleDragStart
local toggleStartPos

toggleBtn.MouseEnter:Connect(function()
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 50)
end)

toggleBtn.MouseLeave:Connect(function()
    toggleBtn.BackgroundColor3 = COLORS.ACCENT
end)

toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleDragging = true
        toggleDragStart = input.Position
        toggleStartPos = toggleBtn.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if toggleDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - toggleDragStart
        toggleBtn.Position = UDim2.new(
            toggleStartPos.X.Scale,
            toggleStartPos.X.Offset + delta.X,
            toggleStartPos.Y.Scale,
            toggleStartPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleDragging = false
    end
end)

toggleBtn.MouseButton1Click:Connect(function()
    if not toggleDragging then
        menuOpen = not menuOpen
        mainPanel.Visible = menuOpen
    end
end)

-- Lock Button
local lockBtn = Instance.new("TextButton")
lockBtn.Name = "LockBtn"
lockBtn.Size = UDim2.new(0, 50, 0, 50)
lockBtn.Position = UDim2.new(0, 70, 0, 15)
lockBtn.Text = "🔓"
lockBtn.TextScaled = true
lockBtn.TextColor3 = COLORS.TEXT_PRIMARY
lockBtn.BackgroundColor3 = COLORS.ELEMENT_BG
lockBtn.BorderSizePixel = 0
lockBtn.Parent = floatingButtonsFrame

local lockCorner = Instance.new("UICorner")
lockCorner.CornerRadius = UDim.new(0, 10)
lockCorner.Parent = lockBtn

lockBtn.MouseEnter:Connect(function()
    lockBtn.BackgroundColor3 = COLORS.ELEMENT_HOVER
end)

lockBtn.MouseLeave:Connect(function()
    lockBtn.BackgroundColor3 = COLORS.ELEMENT_BG
end)

lockBtn.MouseButton1Click:Connect(function()
    menuLocked = not menuLocked
    lockBtn.Text = menuLocked and "🔒" or "🔓"
    lockBtn.BackgroundColor3 = menuLocked and Color3.fromRGB(100, 180, 100) or COLORS.ELEMENT_BG
end)

-- ==================== PANEL PRINCIPAL ====================
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 800, 0, 600)
mainPanel.Position = UDim2.new(0, 200, 0, 100)
mainPanel.BackgroundColor3 = COLORS.BG_DARK
mainPanel.BorderSizePixel = 0
mainPanel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 15)
panelCorner.Parent = mainPanel

-- Panel movible
local panelDragging = false
local panelDragStart
local panelStartPos

mainPanel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not menuLocked then
        panelDragging = true
        panelDragStart = input.Position
        panelStartPos = mainPanel.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if panelDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - panelDragStart
        mainPanel.Position = UDim2.new(
            panelStartPos.X.Scale,
            panelStartPos.X.Offset + delta.X,
            panelStartPos.Y.Scale,
            panelStartPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        panelDragging = false
    end
end)

-- ==================== ENCABEZADO ====================
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 70)
header.BackgroundColor3 = COLORS.ELEMENT_BG
header.BorderSizePixel = 0
header.Parent = mainPanel

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

-- Título
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(0, 400, 0, 35)
titleLabel.Position = UDim2.new(0, 20, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Rise Blade Ball"
titleLabel.TextColor3 = COLORS.ACCENT
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = header

-- Subtítulo
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "Subtitle"
subtitleLabel.Size = UDim2.new(0, 400, 0, 25)
subtitleLabel.Position = UDim2.new(0, 20, 0, 35)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "Parry, curves, spam and abilities"
subtitleLabel.TextColor3 = COLORS.TEXT_SECONDARY
subtitleLabel.TextSize = 12
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subtitleLabel.Parent = header

-- Search Box
local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBox"
searchBox.Size = UDim2.new(0, 300, 0, 35)
searchBox.Position = UDim2.new(1, -320, 0, 15)
searchBox.PlaceholderText = "Search..."
searchBox.Text = ""
searchBox.TextColor3 = COLORS.TEXT_PRIMARY
searchBox.PlaceholderColor3 = COLORS.TEXT_SECONDARY
searchBox.BackgroundColor3 = COLORS.ELEMENT_BG
searchBox.BorderSizePixel = 0
searchBox.TextSize = 14
searchBox.Font = Enum.Font.Gotham
searchBox.Parent = header

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 8)
searchCorner.Parent = searchBox

-- ==================== CONTENIDO PRINCIPAL ====================
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -220, 1, -140)
contentFrame.Position = UDim2.new(0, 210, 0, 70)
contentFrame.BackgroundColor3 = COLORS.BG_DARK
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainPanel

-- ScrollingFrame para contenido
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, 0, 1, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = COLORS.ACCENT
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
scrollFrame.Parent = contentFrame

-- ==================== SIDEBAR ====================
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 200, 1, -70)
sidebar.Position = UDim2.new(0, 0, 0, 70)
sidebar.BackgroundColor3 = COLORS.ELEMENT_BG
sidebar.BorderSizePixel = 0
sidebar.Parent = mainPanel

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 15)
sidebarCorner.Parent = sidebar

-- Tab Buttons
local tabs = {
    { name = "Combat", icon = "⚔" },
    { name = "Ban Risk", icon = "⚠" },
    { name = "Visuals", icon = "🎨" },
    { name = "Player", icon = "👤" },
    { name = "World", icon = "🌐" },
    { name = "Settings", icon = "⚙" },
}

for i, tab in ipairs(tabs) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tab.name .. "Tab"
    tabBtn.Size = UDim2.new(1, -10, 0, 50)
    tabBtn.Position = UDim2.new(0, 5, 0, (i-1) * 55 + 10)
    tabBtn.Text = tab.icon .. " " .. tab.name
    tabBtn.TextColor3 = COLORS.TEXT_PRIMARY
    tabBtn.BackgroundColor3 = COLORS.ELEMENT_BG
    tabBtn.BorderSizePixel = 0
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.Parent = sidebar

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabBtn

    tabBtn.MouseEnter:Connect(function()
        tabBtn.BackgroundColor3 = COLORS.ELEMENT_HOVER
    end)

    tabBtn.MouseLeave:Connect(function()
        if currentTab ~= tab.name then
            tabBtn.BackgroundColor3 = COLORS.ELEMENT_BG
        end
    end)

    tabBtn.MouseButton1Click:Connect(function()
        currentTab = tab.name
        subtitleLabel.Text = getTabSubtitle(tab.name)
        titleLabel.Text = "Rise Blade Ball - " .. tab.name
        updateTabContent(tab.name)
        
        for _, btn in ipairs(sidebar:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = COLORS.ELEMENT_BG
            end
        end
        tabBtn.BackgroundColor3 = COLORS.ACCENT
    end)
end

-- ==================== PIE DE PÁGINA ====================
local footer = Instance.new("Frame")
footer.Name = "Footer"
footer.Size = UDim2.new(1, 0, 0, 35)
footer.Position = UDim2.new(0, 0, 1, -35)
footer.BackgroundColor3 = COLORS.ELEMENT_BG
footer.BorderSizePixel = 0
footer.Parent = mainPanel

local footerCorner = Instance.new("UICorner")
footerCorner.CornerRadius = UDim.new(0, 15)
footerCorner.Parent = footer

local footerLabel = Instance.new("TextLabel")
footerLabel.Size = UDim2.new(1, 0, 1, 0)
footerLabel.BackgroundTransparency = 1
footerLabel.Text = "Rise Blade Ball ~ v2.1.9 ~ https://discord.gg/risebb"
footerLabel.TextColor3 = COLORS.TEXT_SECONDARY
footerLabel.TextSize = 11
footerLabel.Font = Enum.Font.Gotham
footerLabel.Parent = footer

-- ==================== FUNCIONES AUXILIARES ====================
function getTabSubtitle(tabName)
    local subtitles = {
        Combat = "Parry, curves, spam and abilities",
        ["Ban Risk"] = "Cosmetic unlocks and skins. Use an alt.",
        Visuals = "Trails, ball HUD, ball colours and ability ESP",
        Player = "Avatar, movement and chat tag",
        World = "Sky, lighting, performance, music and server",
        Settings = "Menu, keybinds, configs and staff detection",
    }
    return subtitles[tabName] or ""
end

function createToggle(parent, label, callback, yPos)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 35)
    toggleFrame.Position = UDim2.new(0, 10, 0, yPos)
    toggleFrame.BackgroundColor3 = COLORS.ELEMENT_BG
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = parent

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleFrame

    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.7, 0, 1, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = COLORS.TEXT_PRIMARY
    labelText.TextSize = 13
    labelText.Font = Enum.Font.Gotham
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = toggleFrame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 25)
    toggleBtn.Position = UDim2.new(1, -60, 0.5, -12)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = COLORS.TEXT_PRIMARY
    toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.TextSize = 11
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = toggleFrame

    local toggleBtnCorner = Instance.new("UICorner")
    toggleBtnCorner.CornerRadius = UDim.new(0, 6)
    toggleBtnCorner.Parent = toggleBtn

    local isOn = false
    toggleBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        toggleBtn.Text = isOn and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = isOn and COLORS.ACCENT or Color3.fromRGB(100, 100, 100)
        if callback then callback(isOn) end
    end)

    return toggleFrame, toggleBtn
end

function createSlider(parent, label, minVal, maxVal, defaultVal, callback, yPos)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -20, 0, 50)
    sliderFrame.Position = UDim2.new(0, 10, 0, yPos)
    sliderFrame.BackgroundColor3 = COLORS.ELEMENT_BG
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = parent

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = sliderFrame

    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.6, 0, 0.4, 0)
    labelText.Position = UDim2.new(0, 10, 0, 5)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = COLORS.TEXT_PRIMARY
    labelText.TextSize = 13
    labelText.Font = Enum.Font.Gotham
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = sliderFrame

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.3, 0, 0.4, 0)
    valueLabel.Position = UDim2.new(1, -50, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.TextColor3 = COLORS.ACCENT
    valueLabel.TextSize = 12
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = sliderFrame

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -20, 0, 6)
    sliderBg.Position = UDim2.new(0, 10, 0, 30)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = sliderFrame

    local sliderBgCorner = Instance.new("UICorner")
    sliderBgCorner.CornerRadius = UDim.new(0, 3)
    sliderBgCorner.Parent = sliderBg

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = COLORS.ACCENT
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg

    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 3)
    sliderFillCorner.Parent = sliderFill

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = input.Position.X
            local sliderPos = sliderBg.AbsolutePosition.X
            local sliderSize = sliderBg.AbsoluteSize.X
            local percent = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
            local value = math.floor(minVal + (maxVal - minVal) * percent)
            
            sliderFill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = tostring(value)
            if callback then callback(value) end
        end
    end)

    return sliderFrame
end

function createDropdown(parent, label, options, defaultOption, callback, yPos)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, -20, 0, 40)
    dropdownFrame.Position = UDim2.new(0, 10, 0, yPos)
    dropdownFrame.BackgroundColor3 = COLORS.ELEMENT_BG
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.Parent = parent

    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 8)
    dropdownCorner.Parent = dropdownFrame

    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.5, 0, 1, 0)
    labelText.Position = UDim2.new(0, 10, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = COLORS.TEXT_PRIMARY
    labelText.TextSize = 13
    labelText.Font = Enum.Font.Gotham
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = dropdownFrame

    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(0, 150, 0, 30)
    dropdownBtn.Position = UDim2.new(1, -160, 0.5, -15)
    dropdownBtn.Text = defaultOption
    dropdownBtn.TextColor3 = COLORS.TEXT_PRIMARY
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    dropdownBtn.BorderSizePixel = 0
    dropdownBtn.TextSize = 12
    dropdownBtn.Font = Enum.Font.Gotham
    dropdownBtn.Parent = dropdownFrame

    local dropdownCornerBtn = Instance.new("UICorner")
    dropdownCornerBtn.CornerRadius = UDim.new(0, 6)
    dropdownCornerBtn.Parent = dropdownBtn

    return dropdownFrame, dropdownBtn
end

function createSubmenu(parent, label, yPos)
    local submenuFrame = Instance.new("Frame")
    submenuFrame.Size = UDim2.new(1, -20, 0, 40)
    submenuFrame.Position = UDim2.new(0, 10, 0, yPos)
    submenuFrame.BackgroundColor3 = COLORS.ELEMENT_BG
    submenuFrame.BorderSizePixel = 0
    submenuFrame.Parent = parent

    local submenuCorner = Instance.new("UICorner")
    submenuCorner.CornerRadius = UDim.new(0, 8)
    submenuCorner.Parent = submenuFrame

    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.9, 0, 1, 0)
    labelText.Position = UDim2.new(0, 10, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label .. " >"
    labelText.TextColor3 = COLORS.ACCENT
    labelText.TextSize = 13
    labelText.Font = Enum.Font.GothamBold
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = submenuFrame

    return submenuFrame
end

function updateTabContent(tabName)
    scrollFrame:ClearAllChildren()

    if tabName == "Combat" then
        createCombatTab()
    elseif tabName == "Ban Risk" then
        createBanRiskTab()
    elseif tabName == "Visuals" then
        createVisualsTab()
    elseif tabName == "Player" then
        createPlayerTab()
    elseif tabName == "World" then
        createWorldTab()
    elseif tabName == "Settings" then
        createSettingsTab()
    end
end

-- ==================== TABS CONTENT ====================
function createCombatTab()
    local yPos = 10
    
    createToggle(scrollFrame, "Per-Mode Curves", function(val)
        Settings.Combat.PerModeCurves = val
    end, yPos)
    yPos = yPos + 40

    createSubmenu(scrollFrame, "Combo & Counters", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Dribble Pre-Click", function(val)
        Settings.Combat.DribblePreClick = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Slash of Fury Counter", function(val)
        Settings.Combat.SlashOfFuryCounter = val
    end, yPos)
    yPos = yPos + 40

    createDropdown(scrollFrame, "Slash Speed", {"Instant", "Fast", "Normal"}, "Instant", function(val)
        Settings.Combat.SlashSpeed = val
    end, yPos)
    yPos = yPos + 45

    createSlider(scrollFrame, "Slash Delay (ms)", 0, 100, 50, function(val)
        Settings.Combat.SlashDelay = val
    end, yPos)
    yPos = yPos + 55

    createToggle(scrollFrame, "Pull Escape [BLATANT]", function(val)
        Settings.Combat.PullEscape = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Auto Spam", function(val)
        Settings.Combat.AutoSpam = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Manual Spam", function(val)
        Settings.Combat.ManualSpam = val
    end, yPos)
    yPos = yPos + 40

    createSubmenu(scrollFrame, "Ability", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Auto Ability", function(val)
        Settings.Combat.AutoAbility = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Only Above Speed", 0, 1000, 500, function(val)
        Settings.Combat.OnlyAboveSpeed = val
    end, yPos)
    yPos = yPos + 55

    createToggle(scrollFrame, "Cooldown Protection", function(val)
        Settings.Combat.CooldownProtection = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Thunder Dash No Cooldown", function(val)
        Settings.Combat.ThunderDashNoCooldown = val
    end, yPos)

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 40)
end

function createBanRiskTab()
    local yPos = 10
    
    createSubmenu(scrollFrame, "Unlock All", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Unlock All", function(val)
        Settings.BanRisk.UnlockAll = val
    end, yPos)
    yPos = yPos + 40

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -20, 0, 40)
    infoLabel.Position = UDim2.new(0, 10, 0, yPos)
    infoLabel.BackgroundColor3 = COLORS.ELEMENT_BG
    infoLabel.BorderSizePixel = 0
    infoLabel.Text = "Turn this on, then open your in-game inventory and equip anything."
    infoLabel.TextColor3 = COLORS.TEXT_SECONDARY
    infoLabel.TextSize = 11
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextWrapped = true
    infoLabel.Parent = scrollFrame
    yPos = yPos + 45

    createToggle(scrollFrame, "Auto Load Last Loadout", function(val)
        Settings.BanRisk.AutoLoadLastLoadout = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Emote While Moving", function(val)
        Settings.BanRisk.EmoteWhileMoving = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Force Emote", function(val)
        Settings.BanRisk.ForceEmote = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Emote Spam", function(val)
        Settings.BanRisk.EmoteSpam = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Emote On Spawn", function(val)
        Settings.BanRisk.EmoteOnSpawn = val
    end, yPos)
    yPos = yPos + 40

    createSubmenu(scrollFrame, "Skins", yPos)
    yPos = yPos + 45

    local swordInputFrame = Instance.new("Frame")
    swordInputFrame.Size = UDim2.new(1, -20, 0, 40)
    swordInputFrame.Position = UDim2.new(0, 10, 0, yPos)
    swordInputFrame.BackgroundColor3 = COLORS.ELEMENT_BG
    swordInputFrame.BorderSizePixel = 0
    swordInputFrame.Parent = scrollFrame

    local swordInputCorner = Instance.new("UICorner")
    swordInputCorner.CornerRadius = UDim.new(0, 8)
    swordInputCorner.Parent = swordInputFrame

    local swordInput = Instance.new("TextBox")
    swordInput.Size = UDim2.new(0.6, 0, 0.8, 0)
    swordInput.Position = UDim2.new(0, 10, 0.1, 0)
    swordInput.PlaceholderText = "sword name"
    swordInput.Text = ""
    swordInput.TextColor3 = COLORS.TEXT_PRIMARY
    swordInput.PlaceholderColor3 = COLORS.TEXT_SECONDARY
    swordInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    swordInput.BorderSizePixel = 0
    swordInput.TextSize = 12
    swordInput.Font = Enum.Font.Gotham
    swordInput.Parent = swordInputFrame

    local swordInputCornerUI = Instance.new("UICorner")
    swordInputCornerUI.CornerRadius = UDim.new(0, 6)
    swordInputCornerUI.Parent = swordInput

    local swordBtn = Instance.new("TextButton")
    swordBtn.Size = UDim2.new(0.3, 0, 0.8, 0)
    swordBtn.Position = UDim2.new(1, -35, 0.1, 0)
    swordBtn.Text = "Apply"
    swordBtn.TextColor3 = COLORS.TEXT_PRIMARY
    swordBtn.BackgroundColor3 = COLORS.ACCENT
    swordBtn.BorderSizePixel = 0
    swordBtn.TextSize = 11
    swordBtn.Font = Enum.Font.GothamBold
    swordBtn.Parent = swordInputFrame

    local swordBtnCorner = Instance.new("UICorner")
    swordBtnCorner.CornerRadius = UDim.new(0, 6)
    swordBtnCorner.Parent = swordBtn

    yPos = yPos + 45

    local explosionInputFrame = Instance.new("Frame")
    explosionInputFrame.Size = UDim2.new(1, -20, 0, 40)
    explosionInputFrame.Position = UDim2.new(0, 10, 0, yPos)
    explosionInputFrame.BackgroundColor3 = COLORS.ELEMENT_BG
    explosionInputFrame.BorderSizePixel = 0
    explosionInputFrame.Parent = scrollFrame

    local explosionInputCorner = Instance.new("UICorner")
    explosionInputCorner.CornerRadius = UDim.new(0, 8)
    explosionInputCorner.Parent = explosionInputFrame

    local explosionInput = Instance.new("TextBox")
    explosionInput.Size = UDim2.new(0.6, 0, 0.8, 0)
    explosionInput.Position = UDim2.new(0, 10, 0.1, 0)
    explosionInput.PlaceholderText = "explosion name"
    explosionInput.Text = ""
    explosionInput.TextColor3 = COLORS.TEXT_PRIMARY
    explosionInput.PlaceholderColor3 = COLORS.TEXT_SECONDARY
    explosionInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    explosionInput.BorderSizePixel = 0
    explosionInput.TextSize = 12
    explosionInput.Font = Enum.Font.Gotham
    explosionInput.Parent = explosionInputFrame

    local explosionInputCornerUI = Instance.new("UICorner")
    explosionInputCornerUI.CornerRadius = UDim.new(0, 6)
    explosionInputCornerUI.Parent = explosionInput

    local explosionBtn = Instance.new("TextButton")
    explosionBtn.Size = UDim2.new(0.3, 0, 0.8, 0)
    explosionBtn.Position = UDim2.new(1, -35, 0.1, 0)
    explosionBtn.Text = "Apply"
    explosionBtn.TextColor3 = COLORS.TEXT_PRIMARY
    explosionBtn.BackgroundColor3 = COLORS.ACCENT
    explosionBtn.BorderSizePixel = 0
    explosionBtn.TextSize = 11
    explosionBtn.Font = Enum.Font.GothamBold
    explosionBtn.Parent = explosionInputFrame

    local explosionBtnCorner = Instance.new("UICorner")
    explosionBtnCorner.CornerRadius = UDim.new(0, 6)
    explosionBtnCorner.Parent = explosionBtn

    yPos = yPos + 45

    createToggle(scrollFrame, "Emotes Only", function(val)
        Settings.BanRisk.EmotesOnly = val
    end, yPos)

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 40)
end

function createVisualsTab()
    local yPos = 10
    
    createSubmenu(scrollFrame, "Player Trail", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Player Trail", function(val)
        Settings.Visuals.PlayerTrail = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Rainbow", function(val)
        Settings.Visuals.PlayerTrailRainbow = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Lifetime", 0, 3, 1.5, function(val)
        Settings.Visuals.PlayerTrailLifetime = val / 10
    end, yPos)
    yPos = yPos + 55

    createSlider(scrollFrame, "Width", 0, 3, 1.5, function(val)
        Settings.Visuals.PlayerTrailWidth = val / 10
    end, yPos)
    yPos = yPos + 55

    createSubmenu(scrollFrame, "Visualizer", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Visualizer", function(val)
        Settings.Visuals.Visualizer = val
    end, yPos)
    yPos = yPos + 40

    createSubmenu(scrollFrame, "Ball Trail", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Ball Trail", function(val)
        Settings.Visuals.BallTrail = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Rainbow", function(val)
        Settings.Visuals.BallTrailRainbow = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Particles", function(val)
        Settings.Visuals.BallParticles = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Glow", function(val)
        Settings.Visuals.BallGlow = val
    end, yPos)
    yPos = yPos + 40

    createSubmenu(scrollFrame, "Ability ESP", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Ability ESP", function(val)
        Settings.Visuals.AbilityESP = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Show Cooldown", function(val)
        Settings.Visuals.ShowCooldown = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Show Player Name", function(val)
        Settings.Visuals.ShowPlayerName = val
    end, yPos)
    yPos = yPos + 40

    createSubmenu(scrollFrame, "Ball HUD", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Ball HUD", function(val)
        Settings.Visuals.BallHUD = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Speed Colour", function(val)
        Settings.Visuals.SpeedColour = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Show Distance", function(val)
        Settings.Visuals.ShowDistance = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Show Peak Speed", function(val)
        Settings.Visuals.ShowPeakSpeed = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "FPS + Ping", function(val)
        Settings.Visuals.FPSPing = val
    end, yPos)

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 40)
end

function createPlayerTab()
    local yPos = 10

    createSubmenu(scrollFrame, "Avatar", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Headless", function(val)
        Settings.Player.Headless = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Korblox Leg", function(val)
        Settings.Player.KorbloxLeg = val
    end, yPos)
    yPos = yPos + 40

    createSubmenu(scrollFrame, "Device Spoofer", yPos)
    yPos = yPos + 45

    createDropdown(scrollFrame, "Device", {"PC", "Mobile", "Console"}, "PC", function(val)
        Settings.Player.Device = val
    end, yPos)
    yPos = yPos + 45

    local rejoinBtn = Instance.new("TextButton")
    rejoinBtn.Size = UDim2.new(1, -20, 0, 35)
    rejoinBtn.Position = UDim2.new(0, 10, 0, yPos)
    rejoinBtn.Text = "Set Device & Rejoin"
    rejoinBtn.TextColor3 = COLORS.TEXT_PRIMARY
    rejoinBtn.BackgroundColor3 = COLORS.ACCENT
    rejoinBtn.BorderSizePixel = 0
    rejoinBtn.TextSize = 12
    rejoinBtn.Font = Enum.Font.GothamBold
    rejoinBtn.Parent = scrollFrame

    local rejoinCorner = Instance.new("UICorner")
    rejoinCorner.CornerRadius = UDim.new(0, 8)
    rejoinCorner.Parent = rejoinBtn

    yPos = yPos + 40

    createSubmenu(scrollFrame, "VIP Chat Tag", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "VIP Tag", function(val)
        Settings.Player.VIPTag = val
    end, yPos)
    yPos = yPos + 40

    createSubmenu(scrollFrame, "Movement", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Walk Speed", function(val)
        Settings.Player.WalkSpeed = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Speed", 0, 120, 60, function(val)
        Settings.Player.WalkSpeedValue = val
    end, yPos)
    yPos = yPos + 55

    createToggle(scrollFrame, "Jump Power", function(val)
        Settings.Player.JumpPower = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Power", 0, 250, 125, function(val)
        Settings.Player.JumpPowerValue = val
    end, yPos)

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 55)
end

function createWorldTab()
    local yPos = 10

    createSubmenu(scrollFrame, "Skybox", yPos)
    yPos = yPos + 45

    createDropdown(scrollFrame, "Skybox", {"Default", "Night", "Space"}, "Default", function(val)
        Settings.World.Skybox = val
    end, yPos)
    yPos = yPos + 45

    createDropdown(scrollFrame, "Time of Day", {"Day", "Night", "Sunset"}, "Day", function(val)
        Settings.World.TimeOfDay = val
    end, yPos)
    yPos = yPos + 45

    createSubmenu(scrollFrame, "Lighting", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Fullbright", function(val)
        Settings.World.Fullbright = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "No Fog", function(val)
        Settings.World.NoFog = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Custom FOV", function(val)
        Settings.World.CustomFOV = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Field of View", 0, 120, 60, function(val)
        Settings.World.FOV = val
    end, yPos)
    yPos = yPos + 55

    createToggle(scrollFrame, "Custom Gravity", function(val)
        Settings.World.CustomGravity = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Gravity", 0, 400, 200, function(val)
        Settings.World.Gravity = val
    end, yPos)
    yPos = yPos + 55

    createSubmenu(scrollFrame, "Performance", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "FPS Boost", function(val)
        Settings.World.FPSBoost = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "No Battle Effects", function(val)
        Settings.World.NoBattleEffects = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "FPS Cap", function(val)
        Settings.World.FPSCap = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Max FPS", 0, 360, 180, function(val)
        Settings.World.MaxFPS = val
    end, yPos)
    yPos = yPos + 55

    createToggle(scrollFrame, "Auto Anti-Lag", function(val)
        Settings.World.AutoAntiLag = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Anti-Lag Threshold", 0, 120, 60, function(val)
        Settings.World.AntiLagThreshold = val
    end, yPos)
    yPos = yPos + 55

    createSubmenu(scrollFrame, "Shaders", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Cinematic Shaders", function(val)
        Settings.World.CinematicShaders = val
    end, yPos)
    yPos = yPos + 40

    createDropdown(scrollFrame, "Preset", {"Noir", "Warm", "Cool"}, "Noir", function(val)
        Settings.World.ShaderPreset = val
    end, yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Depth of Field", function(val)
        Settings.World.DepthOfField = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Bloom", 0, 3, 1.5, function(val)
        Settings.World.Bloom = val / 10
    end, yPos)
    yPos = yPos + 55

    createSlider(scrollFrame, "Saturation", 0, 2, 1, function(val)
        Settings.World.Saturation = val / 10
    end, yPos)
    yPos = yPos + 55

    createSlider(scrollFrame, "Brightness", 0, 0.3, 0.15, function(val)
        Settings.World.Brightness = val / 100
    end, yPos)
    yPos = yPos + 55

    createSlider(scrollFrame, "Contrast", 0, 0.5, 0.25, function(val)
        Settings.World.Contrast = val / 100
    end, yPos)
    yPos = yPos + 55

    createToggle(scrollFrame, "Rain Effect", function(val)
        Settings.World.RainEffect = val
    end, yPos)
    yPos = yPos + 40

    createSlider(scrollFrame, "Rain Intensity", 0, 400, 200, function(val)
        Settings.World.RainIntensity = val
    end, yPos)
    yPos = yPos + 55

    createSubmenu(scrollFrame, "FFlags", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Enable & Rejoin", function(val)
        Settings.World.EnableFFlags = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Custom FFlags", function(val)
        Settings.World.CustomFFlags = val
    end, yPos)
    yPos = yPos + 40

    createDropdown(scrollFrame, "Preset", {"Gray World", "Bright", "Dark"}, "Gray World", function(val)
        Settings.World.FFlagsPreset = val
    end, yPos)
    yPos = yPos + 45

    createDropdown(scrollFrame, "Region", {"Auto", "US", "EU", "Asia"}, "Auto", function(val)
        Settings.World.Region = val
    end, yPos)
    yPos = yPos + 45

    local joinRegionBtn = Instance.new("TextButton")
    joinRegionBtn.Size = UDim2.new(1, -20, 0, 35)
    joinRegionBtn.Position = UDim2.new(0, 10, 0, yPos)
    joinRegionBtn.Text = "Join Region"
    joinRegionBtn.TextColor3 = COLORS.TEXT_PRIMARY
    joinRegionBtn.BackgroundColor3 = COLORS.ACCENT
    joinRegionBtn.BorderSizePixel = 0
    joinRegionBtn.TextSize = 12
    joinRegionBtn.Font = Enum.Font.GothamBold
    joinRegionBtn.Parent = scrollFrame

    local joinRegionCorner = Instance.new("UICorner")
    joinRegionCorner.CornerRadius = UDim.new(0, 8)
    joinRegionCorner.Parent = joinRegionBtn

    yPos = yPos + 40

    createSubmenu(scrollFrame, "Music", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Music", function(val)
        Settings.World.Music = val
    end, yPos)
    yPos = yPos + 40

    createDropdown(scrollFrame, "Track", {"Solo", "Chill", "Epic"}, "Solo", function(val)
        Settings.World.MusicTrack = val
    end, yPos)
    yPos = yPos + 45

    createSlider(scrollFrame, "Volume", 0, 10, 5, function(val)
        Settings.World.MusicVolume = val
    end, yPos)
    yPos = yPos + 55

    local customIdFrame = Instance.new("Frame")
    customIdFrame.Size = UDim2.new(1, -20, 0, 40)
    customIdFrame.Position = UDim2.new(0, 10, 0, yPos)
    customIdFrame.BackgroundColor3 = COLORS.ELEMENT_BG
    customIdFrame.BorderSizePixel = 0
    customIdFrame.Parent = scrollFrame

    local customIdCorner = Instance.new("UICorner")
    customIdCorner.CornerRadius = UDim.new(0, 8)
    customIdCorner.Parent = customIdFrame

    local customIdInput = Instance.new("TextBox")
    customIdInput.Size = UDim2.new(1, -20, 0.8, 0)
    customIdInput.Position = UDim2.new(0, 10, 0.1, 0)
    customIdInput.PlaceholderText = "Roblox audio ID"
    customIdInput.Text = ""
    customIdInput.TextColor3 = COLORS.TEXT_PRIMARY
    customIdInput.PlaceholderColor3 = COLORS.TEXT_SECONDARY
    customIdInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    customIdInput.BorderSizePixel = 0
    customIdInput.TextSize = 12
    customIdInput.Font = Enum.Font.Gotham
    customIdInput.Parent = customIdFrame

    local customIdInputCorner = Instance.new("UICorner")
    customIdInputCorner.CornerRadius = UDim.new(0, 6)
    customIdInputCorner.Parent = customIdInput

    yPos = yPos + 45

    createSubmenu(scrollFrame, "Server", yPos)
    yPos = yPos + 45

    local serverButtonsFrame = Instance.new("Frame")
    serverButtonsFrame.Size = UDim2.new(1, -20, 0, 40)
    serverButtonsFrame.Position = UDim2.new(0, 10, 0, yPos)
    serverButtonsFrame.BackgroundTransparency = 1
    serverButtonsFrame.Parent = scrollFrame

    local rejoinServerBtn = Instance.new("TextButton")
    rejoinServerBtn.Size = UDim2.new(0.3, 0, 1, 0)
    rejoinServerBtn.Position = UDim2.new(0, 0, 0, 0)
    rejoinServerBtn.Text = "Rejoin"
    rejoinServerBtn.TextColor3 = COLORS.TEXT_PRIMARY
    rejoinServerBtn.BackgroundColor3 = COLORS.ACCENT
    rejoinServerBtn.BorderSizePixel = 0
    rejoinServerBtn.TextSize = 11
    rejoinServerBtn.Font = Enum.Font.GothamBold
    rejoinServerBtn.Parent = serverButtonsFrame

    local rejoinServerCorner = Instance.new("UICorner")
    rejoinServerCorner.CornerRadius = UDim.new(0, 8)
    rejoinServerCorner.Parent = rejoinServerBtn

    local hopServerBtn = Instance.new("TextButton")
    hopServerBtn.Size = UDim2.new(0.3, 0, 1, 0)
    hopServerBtn.Position = UDim2.new(0.35, 0, 0, 0)
    hopServerBtn.Text = "Server Hop"
    hopServerBtn.TextColor3 = COLORS.TEXT_PRIMARY
    hopServerBtn.BackgroundColor3 = COLORS.ACCENT
    hopServerBtn.BorderSizePixel = 0
    hopServerBtn.TextSize = 11
    hopServerBtn.Font = Enum.Font.GothamBold
    hopServerBtn.Parent = serverButtonsFrame

    local hopServerCorner = Instance.new("UICorner")
    hopServerCorner.CornerRadius = UDim.new(0, 8)
    hopServerCorner.Parent = hopServerBtn

    local resetCharBtn = Instance.new("TextButton")
    resetCharBtn.Size = UDim2.new(0.3, 0, 1, 0)
    resetCharBtn.Position = UDim2.new(0.7, 0, 0, 0)
    resetCharBtn.Text = "Reset Char"
    resetCharBtn.TextColor3 = COLORS.TEXT_PRIMARY
    resetCharBtn.BackgroundColor3 = COLORS.ACCENT
    resetCharBtn.BorderSizePixel = 0
    resetCharBtn.TextSize = 11
    resetCharBtn.Font = Enum.Font.GothamBold
    resetCharBtn.Parent = serverButtonsFrame

    local resetCharCorner = Instance.new("UICorner")
    resetCharCorner.CornerRadius = UDim.new(0, 8)
    resetCharCorner.Parent = resetCharBtn

    yPos = yPos + 45

    createToggle(scrollFrame, "Anti AFK", function(val)
        Settings.World.AntiAFK = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Auto Execute on Teleport", function(val)
        Settings.World.AutoExecuteOnTeleport = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Auto Rematch", function(val)
        Settings.World.AutoRematch = val
    end, yPos)
    yPos = yPos + 40

    createToggle(scrollFrame, "Grind Mode", function(val)
        Settings.World.GrindMode = val
    end, yPos)

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 40)
end

function createSettingsTab()
    local yPos = 10

    createSubmenu(scrollFrame, "Menu", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Open Keybind Menu", function(val)
        Settings.Settings.OpenKeybindMenu = val
    end, yPos)
    yPos = yPos + 40

    createDropdown(scrollFrame, "Notification Side", {"Left", "Right", "Center"}, "Left", function(val)
        Settings.Settings.NotificationSide = val
    end, yPos)
    yPos = yPos + 45

    local resetAccentBtn = Instance.new("TextButton")
    resetAccentBtn.Size = UDim2.new(1, -20, 0, 35)
    resetAccentBtn.Position = UDim2.new(0, 10, 0, yPos)
    resetAccentBtn.Text = "Reset Accent"
    resetAccentBtn.TextColor3 = COLORS.TEXT_PRIMARY
    resetAccentBtn.BackgroundColor3 = COLORS.ACCENT
    resetAccentBtn.BorderSizePixel = 0
    resetAccentBtn.TextSize = 12
    resetAccentBtn.Font = Enum.Font.GothamBold
    resetAccentBtn.Parent = scrollFrame

    local resetAccentCorner = Instance.new("UICorner")
    resetAccentCorner.CornerRadius = UDim.new(0, 8)
    resetAccentCorner.Parent = resetAccentBtn

    yPos = yPos + 40

    local resetSettingsBtn = Instance.new("TextButton")
    resetSettingsBtn.Size = UDim2.new(1, -20, 0, 35)
    resetSettingsBtn.Position = UDim2.new(0, 10, 0, yPos)
    resetSettingsBtn.Text = "Reset All Settings"
    resetSettingsBtn.TextColor3 = COLORS.TEXT_PRIMARY
    resetSettingsBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
    resetSettingsBtn.BorderSizePixel = 0
    resetSettingsBtn.TextSize = 12
    resetSettingsBtn.Font = Enum.Font.GothamBold
    resetSettingsBtn.Parent = scrollFrame

    local resetSettingsCorner = Instance.new("UICorner")
    resetSettingsCorner.CornerRadius = UDim.new(0, 8)
    resetSettingsCorner.Parent = resetSettingsBtn

    yPos = yPos + 40

    createToggle(scrollFrame, "Send Launch Count", function(val)
        Settings.Settings.SendLaunchCount = val
    end, yPos)
    yPos = yPos + 40

    local unloadBtn = Instance.new("TextButton")
    unloadBtn.Size = UDim2.new(1, -20, 0, 35)
    unloadBtn.Position = UDim2.new(0, 10, 0, yPos)
    unloadBtn.Text = "Unload"
    unloadBtn.TextColor3 = COLORS.TEXT_PRIMARY
    unloadBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
    unloadBtn.BorderSizePixel = 0
    unloadBtn.TextSize = 12
    unloadBtn.Font = Enum.Font.GothamBold
    unloadBtn.Parent = scrollFrame

    local unloadCorner = Instance.new("UICorner")
    unloadCorner.CornerRadius = UDim.new(0, 8)
    unloadCorner.Parent = unloadBtn

    unloadBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    yPos = yPos + 40

    createSubmenu(scrollFrame, "Staff Detection", yPos)
    yPos = yPos + 45

    createToggle(scrollFrame, "Staff Detection", function(val)
        Settings.Settings.StaffDetection = val
    end, yPos)
    yPos = yPos + 40

    createDropdown(scrollFrame, "Staff Action", {"Close Game", "Teleport Away", "Hide", "Warn"}, "Close Game", function(val)
        Settings.Settings.StaffAction = val
    end, yPos)
    yPos = yPos + 45

    createSubmenu(scrollFrame, "Configuration", yPos)
    yPos = yPos + 45

    local configFrame = Instance.new("Frame")
    configFrame.Size = UDim2.new(1, -20, 0, 40)
    configFrame.Position = UDim2.new(0, 10, 0, yPos)
    configFrame.BackgroundColor3 = COLORS.ELEMENT_BG
    configFrame.BorderSizePixel = 0
    configFrame.Parent = scrollFrame

    local configCorner = Instance.new("UICorner")
    configCorner.CornerRadius = UDim.new(0, 8)
    configCorner.Parent = configFrame

    local configInput = Instance.new("TextBox")
    configInput.Size = UDim2.new(0.7, 0, 0.8, 0)
    configInput.Position = UDim2.new(0, 10, 0.1, 0)
    configInput.PlaceholderText = "Config name"
    configInput.Text = ""
    configInput.TextColor3 = COLORS.TEXT_PRIMARY
    configInput.PlaceholderColor3 = COLORS.TEXT_SECONDARY
    configInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    configInput.BorderSizePixel = 0
    configInput.TextSize = 12
    configInput.Font = Enum.Font.Gotham
    configInput.Parent = configFrame

    local configInputCorner = Instance.new("UICorner")
    configInputCorner.CornerRadius = UDim.new(0, 6)
    configInputCorner.Parent = configInput

    local createConfigBtn = Instance.new("TextButton")
    createConfigBtn.Size = UDim2.new(0.25, 0, 0.8, 0)
    createConfigBtn.Position = UDim2.new(1, -35, 0.1, 0)
    createConfigBtn.Text = "Create"
    createConfigBtn.TextColor3 = COLORS.TEXT_PRIMARY
    createConfigBtn.BackgroundColor3 = COLORS.ACCENT
    createConfigBtn.BorderSizePixel = 0
    createConfigBtn.TextSize = 11
    createConfigBtn.Font = Enum.Font.GothamBold
    createConfigBtn.Parent = configFrame

    local createConfigCorner = Instance.new("UICorner")
    createConfigCorner.CornerRadius = UDim.new(0, 6)
    createConfigCorner.Parent = createConfigBtn

    yPos = yPos + 45

    local importFrame = Instance.new("Frame")
    importFrame.Size = UDim2.new(1, -20, 0, 40)
    importFrame.Position = UDim2.new(0, 10, 0, yPos)
    importFrame.BackgroundColor3 = COLORS.ELEMENT_BG
    importFrame.BorderSizePixel = 0
    importFrame.Parent = scrollFrame

    local importCorner = Instance.new("UICorner")
    importCorner.CornerRadius = UDim.new(0, 8)
    importCorner.Parent = importFrame

    local importInput = Instance.new("TextBox")
    importInput.Size = UDim2.new(0.7, 0, 0.8, 0)
    importInput.Position = UDim2.new(0, 10, 0.1, 0)
    importInput.PlaceholderText = "Paste config data"
    importInput.Text = ""
    importInput.TextColor3 = COLORS.TEXT_PRIMARY
    importInput.PlaceholderColor3 = COLORS.TEXT_SECONDARY
    importInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    importInput.BorderSizePixel = 0
    importInput.TextSize = 12
    importInput.Font = Enum.Font.Gotham
    importInput.Parent = importFrame

    local importInputCorner = Instance.new("UICorner")
    importInputCorner.CornerRadius = UDim.new(0, 6)
    importInputCorner.Parent = importInput

    local importConfigBtn = Instance.new("TextButton")
    importConfigBtn.Size = UDim2.new(0.25, 0, 0.8, 0)
    importConfigBtn.Position = UDim2.new(1, -35, 0.1, 0)
    importConfigBtn.Text = "Import"
    importConfigBtn.TextColor3 = COLORS.TEXT_PRIMARY
    importConfigBtn.BackgroundColor3 = COLORS.ACCENT
    importConfigBtn.BorderSizePixel = 0
    importConfigBtn.TextSize = 11
    importConfigBtn.Font = Enum.Font.GothamBold
    importConfigBtn.Parent = importFrame

    local importConfigCorner = Instance.new("UICorner")
    importConfigCorner.CornerRadius = UDim.new(0, 6)
    importConfigCorner.Parent = importConfigBtn

    yPos = yPos + 45

    local autoloadInfoLabel = Instance.new("TextLabel")
    autoloadInfoLabel.Size = UDim2.new(1, -20, 0, 30)
    autoloadInfoLabel.Position = UDim2.new(0, 10, 0, yPos)
    autoloadInfoLabel.BackgroundColor3 = COLORS.ELEMENT_BG
    autoloadInfoLabel.BorderSizePixel = 0
    autoloadInfoLabel.Text = "Current autoload config: none"
    autoloadInfoLabel.TextColor3 = COLORS.TEXT_SECONDARY
    autoloadInfoLabel.TextSize = 11
    autoloadInfoLabel.Font = Enum.Font.Gotham
    autoloadInfoLabel.TextWrapped = true
    autoloadInfoLabel.Parent = scrollFrame

    yPos = yPos + 35

    createSubmenu(scrollFrame, "Discord", yPos)
    yPos = yPos + 45

    local discordBtn = Instance.new("TextButton")
    discordBtn.Size = UDim2.new(1, -20, 0, 40)
    discordBtn.Position = UDim2.new(0, 10, 0, yPos)
    discordBtn.Text = "Join Discord Server"
    discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    discordBtn.BorderSizePixel = 0
    discordBtn.TextSize = 12
    discordBtn.Font = Enum.Font.GothamBold
    discordBtn.Parent = scrollFrame

    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 8)
    discordCorner.Parent = discordBtn

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)
end

-- Inicializar con Combat tab
updateTabContent("Combat")

print("✓ Rise Blade Ball v2.1.9 UI cargado correctamente!")
