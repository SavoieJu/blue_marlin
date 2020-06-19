local arrived = false
local enRoute = false

RegisterNetEvent('bm:setDestination')
AddEventHandler('bm:setDestination', function()
    -- Sets the destination
    local destinations = {
        {id=1, x=1018.91, y=-3197.10, z=5.89},
        {id=2, x=1090.51, y=-3113.81, z=5.89}
    }

    local destination = destinations[math.random(2)]

    local blip = AddBlipForCoord(destination.x, destination.y, destination.z)
    SetBlipSprite(blip, 478)
    SetBlipAsShortRange(blip, false)
    SetBlipRoute(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Shipment Destination")
    EndTextCommandSetBlipName(blip)
    enRoute = true

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if GetDistanceBetweenCoords(destination.x, destination.y, destination.z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 and arrived == false then 
                RemoveBlip(blip)
                arrived = true
                TriggerEvent('bm:arrivedAtDestination')
            end
            if enRoute == true and GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId())) < 0 then
                TriggerEvent('bm:shipmentFail')
            end
        end
    end)

end)

RegisterNetEvent('bm:arrivedAtDestination')
AddEventHandler('bm:arrivedAtDestination', function()
    -- Check if conditions are OK
    local cab = GetVehiclePedIsIn(PlayerPedId())

    TriggerEvent('chat:addMessage', {
        args = { 'Arrived at destination' }
    })

    TriggerEvent('bm:shipmentSuccess')
end)

RegisterNetEvent('bm:shipmentSuccess')
AddEventHandler('bm:shipmentSuccess', function()
    -- Goes back to trailer (New trailer)
    TriggerEvent('chat:addMessage', {
        args = { 'Shipment successfull, the goods were delivered.' }
    })
    enRoute = false
    arrived = false
    TriggerEvent('bm:spawnTruck')
    
end)

RegisterNetEvent('bm:shipmentFail')
AddEventHandler('bm:shipmentFail', function()

    TriggerEvent('chat:addMessage', {
        args = { 'Shipment fail, the goods were damaged.' }
    })

    -- New truck
    enRoute = false
    arrived = false
    TriggerEvent('bm:spawnTruck')
end)