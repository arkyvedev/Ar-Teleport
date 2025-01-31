RegisterCommand("toggleTpUi", function()
    if not isUIOpen then
        SendNUIMessage({ action = "open" })
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
    local locations = Config.TeleportLocations[data.location]
    if locations then
        SetEntityCoords(PlayerPedId(), locations.x, locations.y, locations.z)
        SetEntityHeading(PlayerPedId(), locations.heading)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.ToggleTpUiKey) then
            ExecuteCommand("toggleTpUi")
        elseif IsControlJustReleased(0, 322) and isUIOpen then
            SendNUIMessage({ action = "closeSmooth" })
            isUIOpen = false
        end
    end
end)
