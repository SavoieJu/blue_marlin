local isShopUIOpen = false

RegisterNetEvent('bm:startCharCreate')
AddEventHandler('bm:startCharCreate', function()

    local ped = PlayerPedId()

    SetEntityCoords(ped, -1037.77, -2737.81, 20.17, false, false, false, true)

    TriggerEvent('bm:openCharCreateUI')

end)

RegisterNUICallback('bm:closeCharCreate', function(data, cb)

    TriggerEvent('chat:addMessage', {
		args = { 'received' }
    })
    
    isShopUIOpen = false

    Citizen.CreateThread(function()
        ClampGameplayCamYaw(-180, 180)
        ClampGameplayCamPitch(-90, 90)
    end)
    
    SetNuiFocus(false, false)
    
    cb('ok')
end)

RegisterNetEvent('bm:openCharCreateUI')
AddEventHandler('bm:openCharCreateUI', function()
    
    SwitchInPlayer(PlayerPedId())

	Citizen.CreateThread(function()
		while IsPlayerSwitchInProgress() do
			Citizen.Wait(0)
		end
        DisplayRadar(true)
        SendNUIMessage({
            type = "character_creation"
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