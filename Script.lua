-- ========================================================
-- 2. MEJORA MECÁNICA DE PING: DETECTOR Y TELEPORT
-- ========================================================
local function OptimizarRegionYPing()
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local PlaceId = game.PlaceId

    print("[Optimización] Buscando servidor con mejor ancho de banda...")
    
    -- LÍNEA CORREGIDA ABAJO: API oficial de servidores de Roblox
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
