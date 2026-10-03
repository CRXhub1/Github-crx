-- ========================================================
-- 1. MEJORA MECÁNICA: FIJAR DISTANCIA DE PARRY A 25
-- ========================================================
getgenv().RiseDistance = 25
getgenv().ParryRange = 25

task.spawn(function()
    while task.wait() do 
        pcall(function()
            if getgenv().RiseConfig then
                getgenv().RiseConfig.Distance = 25
                getgenv().RiseConfig.Range = 25
                getgenv().RiseConfig.AutoParryDistance = 25
            end
            if getgenv().Settings then
                getgenv().Settings.Distance = 25
            end
        end)
    end
end)

-- ========================================================
-- 2. MEJORA MECÁNICA DE PING: DETECTOR Y TELEPORT
-- ========================================================
local function OptimizarRegionYPing()
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local PlaceId = game.PlaceId

    print("[Optimización] Buscando servidor con mejor ancho de banda...")
    
    local url = "https://roblox.com" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, result = pcall(function() return game:HttpGet(url) end)
    
    if success and result then
        local data = HttpService:JSONDecode(result)
        if data and data.data then
            for _, server in pairs(data.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    print("[Optimización] Redirigiendo para mejorar MS...")
                    TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
                    break
                end
            end
        end
    end
end

-- Monitor de Ping Automático (Si pasa de 180ms busca un servidor más fluido)
task.spawn(function()
    while task.wait(5) do
        pcall(function()
            local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
            if ping > 180 then 
                OptimizarRegionYPing()
            end
        end)
    end
end)

-- ========================================================
-- 3. MEJORA MECÁNICA DE RED (Anti-Lag Visual)
-- ========================================================
task.spawn(function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
        end
        if v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
end)

-- ========================================================
-- 4. CARGA DEL SCRIPT ORIGINAL PROTEGIDO DE RISE
-- ========================================================
print("Inyectando puente mecánico. Cargando Rise original...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/loader.lua"))()
