local isUIOpen = false

RegisterCommand("toggleTpUi", function()
    if not isUIOpen then
        SendNUIMessage({ 
            action = "open", 
            locations = Config.TeleportLocations
        })
        SetNuiFocus(true, true)
        isUIOpen = true
    end
end, false)

RegisterNUICallback("closeUI", function()
    SetNuiFocus(false, false)
    isUIOpen = false
end)

RegisterNUICallback("closeSmoothUI", function()
    SetTimeout(300, function()
        SetNuiFocus(false, false)
        isUIOpen = false
    end)
end)

RegisterNUICallback("teleportPlayer", function(data)
    local index = tonumber(data.location) 
    if index and Config.TeleportLocations[index] then
        local location = Config.TeleportLocations[index]
        SetEntityCoords(PlayerPedId(), location.coords.x, location.coords.y, location.coords.z, false, false, false, true)
        SetEntityHeading(PlayerPedId(), location.heading or 0.0)
    end
end)


RegisterKeyMapping('toggleTpUi', 'Toggle Teleport UI', 'keyboard', Config.ToggleTpUiKey)