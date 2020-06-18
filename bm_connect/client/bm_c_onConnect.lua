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
    print(tonumber(data.house_id))
    TriggerServerEvent("bm:getPlayerSpawnpoint", GetPlayerServerId(PlayerId()), tonumber(data.house_id), data)

    cb('ok')
end)

RegisterNetEvent('bm:setPlayerPosition', spawnpoints, data)
AddEventHandler('bm:setPlayerPosition', function(spawnpoints, data)

    if #spawnpoints >= 1 then
        local roomNumber = math.random(38)

        local coords = json.decode(spawnpoints[roomNumber].spawnpoint_coords)

        local ped = PlayerPedId()

        SetEntityCoords(ped, coords[1], coords[2], coords[3], false, false, false, true)
    end



    local modelName = exports.bm_connect:ModelListA()[tonumber(data.outfit_num)]

	local model = GetHashKey(modelName)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        if model ~= "mp_f_freemode_01" and model ~= "mp_m_freemode_01" then 
            SetPedRandomComponentVariation(PlayerPedId(), true)
        else
            SetPedComponentVariation(PlayerPedId(), 11, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 11, 6, 1, 0)
        end
        SetModelAsNoLongerNeeded(model)
    end
	
    TriggerEvent('bm:loadToPlayer')
    TriggerServerEvent('bm:setLastChar', GetPlayerServerId(PlayerId()), data.char_id)
end)

RegisterNetEvent('bm:loadToPlayer')
AddEventHandler('bm:loadToPlayer', function()
    SwitchInPlayer(PlayerPedId())
	SetNuiFocus(false, false)

	Citizen.CreateThread(function()
		while IsPlayerSwitchInProgress() do
			Citizen.Wait(0)
		end
		DisplayRadar(true)
	end)
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