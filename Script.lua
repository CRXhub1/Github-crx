-- crxhub
-- Blade Ball Auto Barry Pro
-- All functions included

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Settings = {
    AutoBarry = true,
    ParryRange = 25,
    PingBoost = 0,
    Visible = true,
    Version = "1.0"
}

local lastParry = 0
local parryDelay = 0.1

-- UI Principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "crxhubUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Panel Principal
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 360, 0, 450)
mainPanel.Position = UDim2.new(0, 20, 0, 20)
mainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainPanel

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
topBar.BorderSizePixel = 0
topBar.Parent = mainPanel

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "crxhub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -35, 0, 3)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = topBar

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 6)
closeBtnCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    Settings.Visible = not Settings.Visible
    mainPanel.Visible = Settings.Visible
end)

-- Scroll Frame para contenido
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -35)
scrollFrame.Position = UDim2.new(0, 0, 0, 35)
scrollFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 100)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
scrollFrame.Parent = mainPanel

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 10)
scrollCorner.Parent = scrollFrame

-- AUTO BARRY TOGGLE
local barryFrame = Instance.new("Frame")
barryFrame.Size = UDim2.new(1, -20, 0, 45)
barryFrame.Position = UDim2.new(0, 10, 0, 10)
barryFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
barryFrame.BorderSizePixel = 0
barryFrame.Parent = scrollFrame

local barryCorner = Instance.new("UICorner")
barryCorner.CornerRadius = UDim.new(0, 8)
barryCorner.Parent = barryFrame

local barryLabel = Instance.new("TextLabel")
barryLabel.Size = UDim2.new(0, 200, 1, 0)
barryLabel.Position = UDim2.new(0, 10, 0, 0)
barryLabel.BackgroundTransparency = 1
barryLabel.Text = "Auto Barry"
barryLabel.TextColor3 = Color3.fromRGB(255,255,255)
barryLabel.TextSize = 15
barryLabel.Font = Enum.Font.GothamBold
barryLabel.TextXAlignment = Enum.TextXAlignment.Left
barryLabel.Parent = barryFrame

local barryToggle = Instance.new("TextButton")
barryToggle.Size = UDim2.new(0, 70, 0, 28)
barryToggle.Position = UDim2.new(1, -80, 0.5, -14)
barryToggle.Text = "ON"
barryToggle.TextColor3 = Color3.fromRGB(255,255,255)
barryToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
barryToggle.BorderSizePixel = 0
barryToggle.Font = Enum.Font.GothamBold
barryToggle.TextSize = 12
barryToggle.Parent = barryFrame

local barryToggleCorner = Instance.new("UICorner")
barryToggleCorner.CornerRadius = UDim.new(0, 6)
barryToggleCorner.Parent = barryToggle

barryToggle.MouseButton1Click:Connect(function()
    Settings.AutoBarry = not Settings.AutoBarry
    barryToggle.Text = Settings.AutoBarry and "ON" or "OFF"
    barryToggle.BackgroundColor3 = Settings.AutoBarry and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(120, 120, 120)
end)

-- RANGO DE PARRY
local rangeFrame = Instance.new("Frame")
rangeFrame.Size = UDim2.new(1, -20, 0, 45)
rangeFrame.Position = UDim2.new(0, 10, 0, 65)
rangeFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
rangeFrame.BorderSizePixel = 0
rangeFrame.Parent = scrollFrame

local rangeCorner = Instance.new("UICorner")
rangeCorner.CornerRadius = UDim.new(0, 8)
rangeCorner.Parent = rangeFrame

local rangeLabel = Instance.new("TextLabel")
rangeLabel.Size = UDim2.new(0, 200, 1, 0)
rangeLabel.Position = UDim2.new(0, 10, 0, 0)
rangeLabel.BackgroundTransparency = 1
rangeLabel.Text = "Rango Parry: 25"
rangeLabel.TextColor3 = Color3.fromRGB(255,255,255)
rangeLabel.TextSize = 15
rangeLabel.Font = Enum.Font.GothamBold
rangeLabel.TextXAlignment = Enum.TextXAlignment.Left
rangeLabel.Parent = rangeFrame

local rangeInput = Instance.new("TextBox")
rangeInput.Size = UDim2.new(0, 70, 0, 28)
rangeInput.Position = UDim2.new(1, -80, 0.5, -14)
rangeInput.Text = "25"
rangeInput.TextColor3 = Color3.fromRGB(255,255,255)
rangeInput.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
rangeInput.BorderSizePixel = 1
rangeInput.BorderColor3 = Color3.fromRGB(80, 80, 90)
rangeInput.Font = Enum.Font.Gotham
rangeInput.TextSize = 12
rangeInput.Parent = rangeFrame

rangeInput.FocusLost:Connect(function()
    local value = tonumber(rangeInput.Text)
    if value and value > 0 then
        Settings.ParryRange = value
        rangeLabel.Text = "Rango Parry: " .. tostring(value)
    else
        rangeInput.Text = tostring(Settings.ParryRange)
    end
end)

-- PING BOOST
local pingFrame = Instance.new("Frame")
pingFrame.Size = UDim2.new(1, -20, 0, 45)
pingFrame.Position = UDim2.new(0, 10, 0, 120)
pingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
pingFrame.BorderSizePixel = 0
pingFrame.Parent = scrollFrame

local pingCorner = Instance.new("UICorner")
pingCorner.CornerRadius = UDim.new(0, 8)
pingCorner.Parent = pingFrame

local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(0, 200, 1, 0)
pingLabel.Position = UDim2.new(0, 10, 0, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "Ping Boost: 0ms"
pingLabel.TextColor3 = Color3.fromRGB(255,255,255)
pingLabel.TextSize = 15
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.Parent = pingFrame

local pingInput = Instance.new("TextBox")
pingInput.Size = UDim2.new(0, 70, 0, 28)
pingInput.Position = UDim2.new(1, -80, 0.5, -14)
pingInput.Text = "0"
pingInput.TextColor3 = Color3.fromRGB(255,255,255)
pingInput.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
pingInput.BorderSizePixel = 1
pingInput.BorderColor3 = Color3.fromRGB(80, 80, 90)
pingInput.Font = Enum.Font.Gotham
pingInput.TextSize = 12
pingInput.Parent = pingFrame

pingInput.FocusLost:Connect(function()
    local value = tonumber(pingInput.Text)
    if value and value >= 0 then
        Settings.PingBoost = value
        pingLabel.Text = "Ping Boost: " .. tostring(value) .. "ms"
    else
        pingInput.Text = tostring(Settings.PingBoost)
    end
end)

-- ESPADAS DISPONIBLES
local swordsLabel = Instance.new("TextLabel")
swordsLabel.Size = UDim2.new(1, -20, 0, 25)
swordsLabel.Position = UDim2.new(0, 10, 0, 175)
swordsLabel.BackgroundTransparency = 1
swordsLabel.Text = "Espadas Disponibles:"
swordsLabel.TextColor3 = Color3.fromRGB(0, 180, 100)
swordsLabel.TextSize = 14
swordsLabel.Font = Enum.Font.GothamBold
swordsLabel.TextXAlignment = Enum.TextXAlignment.Left
swordsLabel.Parent = scrollFrame

local swords = {"Katana", "Cleaver", "Longsword", "Rapier", "Broadsword", "Dagger", "Scythe", "Greatsword"}

for i, sword in ipairs(swords) do
    local swordBtn = Instance.new("TextButton")
    swordBtn.Size = UDim2.new(1, -20, 0, 35)
    swordBtn.Position = UDim2.new(0, 10, 0, 200 + (i-1) * 40)
    swordBtn.Text = sword
    swordBtn.TextColor3 = Color3.fromRGB(255,255,255)
    swordBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    swordBtn.BorderSizePixel = 0
    swordBtn.Font = Enum.Font.Gotham
    swordBtn.TextSize = 13
    swordBtn.Parent = scrollFrame
    
    local swordCorner = Instance.new("UICorner")
    swordCorner.CornerRadius = UDim.new(0, 6)
    swordCorner.Parent = swordBtn
    
    swordBtn.MouseButton1Click:Connect(function()
        swordBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    end)
    
    swordBtn.MouseEnter:Connect(function()
        if swordBtn.BackgroundColor3 ~= Color3.fromRGB(0, 180, 100) then
            swordBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
        end
    end)
    
    swordBtn.MouseLeave:Connect(function()
        if swordBtn.BackgroundColor3 ~= Color3.fromRGB(0, 180, 100) then
            swordBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
    end)
end

-- STATUS
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(1, -20, 0, 40)
statusFrame.Position = UDim2.new(0, 10, 0, 540)
statusFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
statusFrame.BorderSizePixel = 0
statusFrame.Parent = scrollFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 1, 0)
statusLabel.Position = UDim2.new(0, 5, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "✓ Listo"
statusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
statusLabel.TextSize = 13
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = statusFrame

-- MOVER PANEL
local dragging = false
local dragStart
local startPos

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainPanel.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainPanel.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- FUNCIONES DE JUEGO
local function findBall()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local name = v.Name:lower()
            if name:find("ball") then
                return v
            end
        end
    end
    return nil
end

local function doParry()
    local now = tick()
    if now - lastParry < parryDelay then
        return
    end

    lastParry = now

    local pc = player.Character
    if not pc then return end

    local remote = pc:FindFirstChild("Parry") or pc:FindFirstChild("AutoParry")
    if remote and remote:IsA("RemoteEvent") then
        pcall(function()
            remote:FireServer()
        end)
    end
end

-- LOOP PRINCIPAL
RunService.RenderStepped:Connect(function()
    if not Settings.AutoBarry then
        statusLabel.Text = "⊘ Desactivado"
        statusLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
        return
    end

    local char = player.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local ball = findBall()
    if ball then
        local dist = (hrp.Position - ball.Position).Magnitude
        if dist < Settings.ParryRange then
            doParry()
            statusLabel.Text = "⚡ Parry! " .. math.floor(dist) .. "m"
            statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
            
            if Settings.PingBoost > 0 then
                wait(Settings.PingBoost / 1000)
            end
        else
            statusLabel.Text = "👀 Esperando... " .. math.floor(dist) .. "m"
            statusLabel.TextColor3 = Color3.fromRGB(180, 220, 255)
        end
    else
        statusLabel.Text = "? Sin bola detectada"
        statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    end
end)

print("✓ crxhub cargado correctamente!")
