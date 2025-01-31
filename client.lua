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
    local location = Config.TeleportLocations[data.location]
    if location then
        SetEntityCoords(PlayerPedId(), location.coords.x, location.coords.y, location.coords.z)
        SetEntityHeading(PlayerPedId(), location.heading or 0.0)
    end
end)

RegisterKeyMapping('toggleTpUi', 'Toggle Teleport UI', 'keyboard', Config.ToggleTpUiKey)