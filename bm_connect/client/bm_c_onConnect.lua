AddEventHandler('onClientGameTypeStart', function()
    local playerServerID = GetPlayerServerId(PlayerId())
    DisplayRadar(false)
    SwitchOutPlayer(PlayerPedId(), 1, 2)

    Citizen.CreateThread(function()
    	while GetPlayerSwitchState() ~= 5 do
	        Citizen.Wait(0)
	    end
	end)

	TriggerServerEvent("bm:playerConnect", playerServerID)

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

	TriggerEvent('chat:addMessage', {
		args = { data.char_id }
	})

    cb('ok')
end)

RegisterNUICallback('bm:startCC', function(data, cb)
	
	SetNuiFocus(false, false)
	TriggerEvent('bm:startCharCreate')

    cb('ok')
end)

RegisterNetEvent('bm:getChars', result)
AddEventHandler('bm:getChars', function(result)

	local resultsLua = json.decode(result)
	local char_1 = resultsLua[1]
	local char_2 = resultsLua[2]
	local char_3 = resultsLua[3]
	local char_4 = resultsLua[4]

	SendNUIMessage({
        type = "character_selection_open",
        char_1 = char_1,
        char_2 = char_2,
        char_3 = char_3,
        char_4 = char_4,
    })

    Citizen.CreateThread(function()
    	ShutdownLoadingScreenNui()
    end)

    SetNuiFocus(true, true)

end)