local truckMarker = { name="trucker_truck", id=23, x=1179.14, y=-3302.11, z=5.50, dirX=0, dirY=0, dirZ=0, rotX=0, rotY=0, rotZ=0, scaleX=1.0001, scaleY=1.0001, scaleZ=1.5001, red=255, green=0, blue=0, alpha=100, upDown=false, unknown1=false, unknown2=0,unknown3=0 }


Citizen.CreateThread(function()
    while true do
        Wait(0)
        if exports.bm_utility:character_info().job_name == "Truck Driver" then
            DrawMarker(truckMarker.id, truckMarker.x, truckMarker.y, truckMarker.z, truckMarker.dirX, truckMarker.dirY, truckMarker.dirZ, truckMarker.rotX, truckMarker.rotY, truckMarker.rotZ, truckMarker.scaleX, truckMarker.scaleY, truckMarker.scaleZ, truckMarker.red, truckMarker.green, truckMarker.blue, truckMarker.alpha, truckMarker.upDown, truckMarker.unknown1, truckMarker.unknown2, truckMarker.unknown3)
            if GetDistanceBetweenCoords( truckMarker.x, truckMarker.y, truckMarker.z, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then
                if IsControlJustPressed(1, 51) then
                    TriggerEvent('bm:spawnTruck')
                end
                exports.bm_utility:Draw3DText( truckMarker.x, truckMarker.y, truckMarker.z-1.00, "Press 'E' to get your truck cab.", 4, 0.1, 0.1) 
            end
        end
    end
end)

RegisterNetEvent('bm:spawnTruck')
AddEventHandler('bm:spawnTruck', function()
    
    if not IsModelInCdimage('packer') or not IsModelAVehicle('packer') then
        TriggerEvent('chat:addMessage', {
            args = { 'bad vehicle' }
        })

        return
    end
    RequestModel('packer')

    while not HasModelLoaded('packer') do
        Wait(250)
    end

    local vehicle = CreateVehicle('packer', 1178.49, -3297.22, 5.72, 87.75, true, false)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if GetVehicleEngineHealth(vehicle) == -4000 then
                SetEntityAsNoLongerNeeded(vehicle)
            end
        end
    end)

end)