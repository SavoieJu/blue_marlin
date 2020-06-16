AddEventHandler('onClientGameTypeStart', function()
    local playerServerID = GetPlayerServerId(PlayerId())
    SwitchOutPlayer(PlayerPedId(), 1, 2)
    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
    end
    TriggerServerEvent("bm:playerConnect", playerServerID)
    SendNUIMessage({
        type = "character_selection_open"
    })

    SetNuiFocus(true, true)
    ShutdownLoadingScreenNui()

end)