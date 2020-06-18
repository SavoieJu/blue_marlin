Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local ped = PlayerPedId()

        disableCrosshair()
        enableRadarInCar(ped)
        disableAirControl(veh)
        disableVehicleRoll(ped, veh)
    end
end)

function disableCrosshair()
    HideHudComponentThisFrame(14)
end

function enableRadarInCar(ped)
    
    if not IsPedInAnyVehicle(ped, false) then
        DisplayRadar(false)
    else
        DisplayRadar(true)
    end
end

function disableAirControl(veh)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        local model = GetEntityModel(veh)
        if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABike(model) and IsEntityInAir(veh) then
            DisableControlAction(0, 59) -- leaning left/right
            DisableControlAction(0, 60) -- leaning up/down
        end
    end
end

function disableVehicleRoll(ped, veh)
    local roll = GetEntityRoll(veh)
    local model = GetEntityModel(veh)

    if GetPedInVehicleSeat(veh, -1) == ped then
        if (roll > 75.0 or roll < -75.0) and not IsThisModelABike(model) then
            DisableControlAction(2,59,true)
            DisableControlAction(2,60,true)
        end
    end
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
	local scale = (1/dist)*20
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov   
	SetTextScale(scaleX*scale, scaleY*scale)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextColour(250, 250, 250, 255)
	SetTextDropshadow(1, 1, 1, 1, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(textInput)
	SetDrawOrigin(x,y,z+2, 0)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
end



exports('Draw3DText', Draw3DText)