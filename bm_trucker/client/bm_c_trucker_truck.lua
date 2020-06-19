local truckMarker = { name="trucker_truck", id=23, x=1179.14, y=-3302.11, z=5.50, dirX=0, dirY=0, dirZ=0, rotX=0, rotY=0, rotZ=0, scaleX=1.0001, scaleY=1.0001, scaleZ=1.5001, red=255, green=0, blue=0, alpha=100, upDown=false, unknown1=false, unknown2=0,unknown3=0 }
local canSpawnTruck = true
local truckBlip = {
    { name="Shipment Truck", color=4, id=545, x=1182.60, y=-3307.79, z=5.53}, 
}



local truckDestinationMarker = { name="trucker_destination", id=23, x=935.49, y=-3225.40, z=5.90, dirX=0, dirY=0, dirZ=0, rotX=0, rotY=0, rotZ=0, scaleX=1.0001, scaleY=1.0001, scaleZ=1.5001, red=255, green=0, blue=0, alpha=100, upDown=false, unknown1=false, unknown2=0,unknown3=0 }

local trailer = nil
local truckCab = nil
local shipmentOngoing = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if exports.bm_utility:character_info().job_name == "Truck Driver" and canSpawnTruck == true then
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
    
    if not IsModelInCdimage('pounder') or not IsModelAVehicle('pounder') then
        TriggerEvent('chat:addMessage', {
            args = { 'bad vehicle' }
        })

        return
    end
    RequestModel('pounder')

    while not HasModelLoaded('pounder') do
        Wait(250)
    end

    local vehicle = CreateVehicle('pounder', 1178.49, -3297.22, 5.72, 87.75, true, false)
    truckCab = vehicle

    -- TriggerEvent('bm:spawnTrailer')

    canSpawnTruck = false

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(250)
            if GetVehicleEngineHealth(vehicle) > -4000 then
                RemoveBlip(truckb)
                truckb = AddBlipForCoord(GetEntityCoords(vehicle))
                SetBlipSprite(truckb, truckBlip[1].id)
                SetBlipAsShortRange(truckb, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(truckBlip[1].name)
                EndTextCommandSetBlipName(truckb)
            end
            if GetVehicleEngineHealth(vehicle) == -4000 then
                SetEntityAsNoLongerNeeded(vehicle)
                canSpawnTruck = true
                RemoveBlip(truckb)
            end
            if not DoesEntityExist(vehicle) then
                canSpawnTruck = true
            end
        end
    end)
end)

RegisterNetEvent('bm:checkIfEnteredTruckNearLoc', enteredVehicle, car_name)
AddEventHandler('bm:checkIfEnteredTruckNearLoc', function(currentVehicle, car_name)
    local currentPedVehicle = GetVehiclePedIsIn(PlayerPedId())

    if car_name == "POUNDER" and GetDistanceBetweenCoords(1178.49, -3297.22, 5.72, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then 
        TriggerEvent('bm:setDestination')
    end
end)






















-- RegisterNetEvent('bm:spawnTrailer')
-- AddEventHandler('bm:spawnTrailer', function()
--     if not IsModelInCdimage('trailers3') or not IsModelAVehicle('trailers3') then
--         TriggerEvent('chat:addMessage', {
--             args = { 'bad vehicle' }
--         })

--         return
--     end
--     RequestModel('trailers3')

--     while not HasModelLoaded('trailers3') do
--         Wait(250)
--     end

--     local vehicle = CreateVehicle('trailers3', 1273.72, -3190.14, 5.9, 90.00, true, false)

--     Citizen.CreateThread(function()
--         while true do
--             Citizen.Wait(250)
--             if GetVehicleEngineHealth(vehicle) == -4000 then
--                 SetEntityAsNoLongerNeeded(vehicle)
--             end
--         end
--     end)
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Wait(0)
--         if  shipmentOngoing == true then
--             DrawMarker(truckDestinationMarker.id, truckDestinationMarker.x, truckDestinationMarker.y, truckDestinationMarker.z, truckDestinationMarker.dirX, truckDestinationMarker.dirY, truckDestinationMarker.dirZ, truckDestinationMarker.rotX, truckDestinationMarker.rotY, truckDestinationMarker.rotZ, truckDestinationMarker.scaleX, truckDestinationMarker.scaleY, truckDestinationMarker.scaleZ, truckDestinationMarker.red, truckDestinationMarker.green, truckDestinationMarker.blue, truckDestinationMarker.alpha, truckDestinationMarker.upDown, truckDestinationMarker.unknown1, truckDestinationMarker.unknown2, truckDestinationMarker.unknown3)
--             if GetDistanceBetweenCoords( truckDestinationMarker.x, truckDestinationMarker.y, truckDestinationMarker.z, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
--                 if IsVehicleAttachedToTrailer(truckCab) then
--                     if GetDistanceBetweenCoords( truckDestinationMarker.x, truckDestinationMarker.y, truckDestinationMarker.z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
--                         DetachVehicleFromTrailer(truckCab)
--                         TriggerEvent('bm:shipmentSuccess')
--                     end
--                 end
--             end
--         end
--     end
-- end)

-- RegisterNetEvent('bm:startShipment')
-- AddEventHandler('bm:startShipment', function()
--     Citizen.CreateThread(function()
--         while true do
--             Wait(0)
--             if not IsVehicleAttachedToTrailer(truckCab) then
--                 shipmentOngoing = false
--                 TriggerEvent('bm:shipmentFail')
--             end
--         end
--     end)
-- end)

-- RegisterNetEvent('bm:shipmentFail')
-- AddEventHandler('bm:shipmentFail', function()
    
-- end)

-- RegisterNetEvent('bm:shipmentSuccess')
-- AddEventHandler('bm:shipmentSuccess', function()
--     TriggerEvent('chat:addMessage', {
--         args = { 'Delivered' }
--     })
--     Citizen.CreateThread(function()
--         Citizen.Wait(2000)
--     end)
--     shipmentOngoing = false
-- end)