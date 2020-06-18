local isShopUIOpen = false

RegisterNetEvent('bm:startCharCreate')
AddEventHandler('bm:startCharCreate', function()

    local ped = PlayerPedId()

    SetEntityCoords(ped, -1037.77, -2737.81, 20.17, false, false, false, true)

    TriggerEvent('bm:openCharCreateUI')

end)

RegisterNUICallback('bm:closeCharCreate', function(data, cb)

    TriggerEvent('chat:addMessage', {
		args = { data.model }
    })
    TriggerEvent('chat:addMessage', {
		args = { data.fname }
    })
    TriggerEvent('chat:addMessage', {
		args = { data.lname }
    })
    
    isShopUIOpen = false

    Citizen.CreateThread(function()
        ClampGameplayCamYaw(-180, 180)
        ClampGameplayCamPitch(-90, 90)
    end)
    
    SetNuiFocus(false, false)

    TriggerServerEvent('bm:addCharToDB', GetPlayerServerId(PlayerId()), data.fname, data.lname, tonumber(data.model))
    TriggerClientEvent('bm:firstTimeCharInfo', data.fname, data.lname)
    
    cb('ok')
end)

RegisterNetEvent('bm:openCharCreateUI')
AddEventHandler('bm:openCharCreateUI', function()

    local pedModels = json.encode(exports.bm_create_character:ModelList())
    
    SwitchInPlayer(PlayerPedId())

	Citizen.CreateThread(function()
		while IsPlayerSwitchInProgress() do
			Citizen.Wait(0)
		end
        DisplayRadar(true)
        SendNUIMessage({
            type = "character_creation",
            models = pedModels
        })
        SetNuiFocus(true, true)
    end)
    
    isShopUIOpen = true

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if isShopUIOpen then
				ClampGameplayCamYaw(-180, -180)
				ClampGameplayCamPitch(0, 0)
    			InvalidateIdleCam()
    		end
    	end
    end)

end)

RegisterNUICallback('bm:changeChar', function(data, cb)

    TriggerEvent('chat:addMessage', {
		args = { exports.bm_create_character:ModelList()[tonumber(data.model)] }
	})

    setModel(exports.bm_create_character:ModelList()[tonumber(data.model)])

    
    
    cb('ok')
end)

function setModel(_model)
    local model = _model
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
end