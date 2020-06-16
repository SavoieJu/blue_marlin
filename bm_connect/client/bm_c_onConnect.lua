AddEventHandler('onClientGameTypeStart', function()
    local playerServerID = GetPlayerServerId(PlayerId())
    DisplayRadar(false)
    SwitchOutPlayer(PlayerPedId(), 1, 2)
    

    Citizen.CreateThread(function()
    	while GetPlayerSwitchState() ~= 4 do
	        Citizen.Wait(0)
	    end
    
	    TriggerServerEvent("bm:playerConnect", playerServerID)

	    ShutdownLoadingScreenNui()

	    SendNUIMessage({
	        type = "character_selection_open"
	    })

	    SetNuiFocus(true, true)

	end)

	

end)

RegisterNUICallback('bm:start', function(data, cb)

	SwitchInPlayer(PlayerPedId())
	SetNuiFocus(false, false)
	
	Citizen.CreateThread(function()
		while IsPlayerSwitchInProgress() do
			Citizen.Wait(0)
		end
		DisplayRadar(true)
	end)
	

    cb('ok')
end)