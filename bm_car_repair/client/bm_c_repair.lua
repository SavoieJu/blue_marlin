local repairMarker = {
    { name="city", id=23, x=-337.36, y=-136.39, z=38.50, dirX=0, dirY=0, dirZ=0, rotX=0, rotY=0, rotZ=0, scaleX=1.0001, scaleY=1.0001, scaleZ=1.5001, red=0, green=50, blue=255, alpha=100, upDown=false, unknown1=false, unknown2=0,unknown3=0 },
    { name="airport", id=23, x=-1155.50, y=-2006.41, z=12.65, dirX=0, dirY=0, dirZ=0, rotX=0, rotY=0, rotZ=0, scaleX=1.0001, scaleY=1.0001, scaleZ=1.5001, red=0, green=50, blue=255, alpha=100, upDown=false, unknown1=false, unknown2=0,unknown3=0 },
    { name="senora", id=23, x=1174.92, y=2639.39, z=37.00, dirX=0, dirY=0, dirZ=0, rotX=0, rotY=0, rotZ=0, scaleX=1.0001, scaleY=1.0001, scaleZ=1.5001, red=0, green=50, blue=255, alpha=100, upDown=false, unknown1=false, unknown2=0,unknown3=0 },
    { name="paleto", id=23, x=110.08, y=6627.69, z=31.20, dirX=0, dirY=0, dirZ=0, rotX=0, rotY=0, rotZ=0, scaleX=1.0001, scaleY=1.0001, scaleZ=1.5001, red=0, green=50, blue=255, alpha=100, upDown=false, unknown1=false, unknown2=0,unknown3=0 }, 
    { name="eastside", id=23, x=731.57, y=-1088.74, z=21.30, dirX=0, dirY=0, dirZ=0, rotX=0, rotY=0, rotZ=0, scaleX=1.0001, scaleY=1.0001, scaleZ=1.5001, red=0, green=50, blue=255, alpha=100, upDown=false, unknown1=false, unknown2=0,unknown3=0 },
}

-- 87.38
-- 333.68
-- 37.75
-- 219.77


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)

        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) then
                DrawMarker(repairMarker[1].id, repairMarker[1].x, repairMarker[1].y, repairMarker[1].z, repairMarker[1].dirX, repairMarker[1].dirY, repairMarker[1].dirZ, repairMarker[1].rotX, repairMarker[1].rotY, repairMarker[1].rotZ, repairMarker[1].scaleX, repairMarker[1].scaleY, repairMarker[1].scaleZ, repairMarker[1].red, repairMarker[1].green, repairMarker[1].blue, repairMarker[1].alpha, repairMarker[1].upDown, repairMarker[1].unknown1, repairMarker[1].unknown2, repairMarker[1].unknown3)
                DrawMarker(repairMarker[2].id, repairMarker[2].x, repairMarker[2].y, repairMarker[2].z, repairMarker[2].dirX, repairMarker[2].dirY, repairMarker[2].dirZ, repairMarker[2].rotX, repairMarker[2].rotY, repairMarker[2].rotZ, repairMarker[2].scaleX, repairMarker[2].scaleY, repairMarker[2].scaleZ, repairMarker[2].red, repairMarker[2].green, repairMarker[2].blue, repairMarker[2].alpha, repairMarker[2].upDown, repairMarker[2].unknown1, repairMarker[2].unknown2, repairMarker[2].unknown3)
                DrawMarker(repairMarker[3].id, repairMarker[3].x, repairMarker[3].y, repairMarker[3].z, repairMarker[3].dirX, repairMarker[3].dirY, repairMarker[3].dirZ, repairMarker[3].rotX, repairMarker[3].rotY, repairMarker[3].rotZ, repairMarker[3].scaleX, repairMarker[3].scaleY, repairMarker[3].scaleZ, repairMarker[3].red, repairMarker[3].green, repairMarker[3].blue, repairMarker[3].alpha, repairMarker[3].upDown, repairMarker[3].unknown1, repairMarker[3].unknown2, repairMarker[3].unknown3)
                DrawMarker(repairMarker[4].id, repairMarker[4].x, repairMarker[4].y, repairMarker[4].z, repairMarker[4].dirX, repairMarker[4].dirY, repairMarker[4].dirZ, repairMarker[4].rotX, repairMarker[4].rotY, repairMarker[4].rotZ, repairMarker[4].scaleX, repairMarker[4].scaleY, repairMarker[4].scaleZ, repairMarker[4].red, repairMarker[4].green, repairMarker[4].blue, repairMarker[4].alpha, repairMarker[4].upDown, repairMarker[4].unknown1, repairMarker[4].unknown2, repairMarker[4].unknown3)
                DrawMarker(repairMarker[5].id, repairMarker[5].x, repairMarker[5].y, repairMarker[5].z, repairMarker[5].dirX, repairMarker[5].dirY, repairMarker[5].dirZ, repairMarker[5].rotX, repairMarker[5].rotY, repairMarker[5].rotZ, repairMarker[5].scaleX, repairMarker[5].scaleY, repairMarker[5].scaleZ, repairMarker[5].red, repairMarker[5].green, repairMarker[5].blue, repairMarker[5].alpha, repairMarker[5].upDown, repairMarker[5].unknown1, repairMarker[5].unknown2, repairMarker[5].unknown3)
                if GetDistanceBetweenCoords( repairMarker[5].x, repairMarker[5].y, repairMarker[5].z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
                    if IsControlJustPressed(1, 51) then
                        SetEntityHeading(PlayerPedId(), 87.00)
                        SetEntityVelocity(GetVehiclePedIsIn(PlayerPedId(), false), 0.00, 0.00, 0.00)
                        TriggerEvent('bm:repairCar')
                    end
                    exports.bm_utility:Draw3DText( repairMarker[5].x, repairMarker[5].y, repairMarker[5].z-1.00, "Press 'E' to pay 0$ to repair car.", 4, 0.1, 0.1) 
                end                
                if GetDistanceBetweenCoords( repairMarker[4].x, repairMarker[4].y, repairMarker[4].z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
                    if IsControlJustPressed(1, 51) then
                        SetEntityHeading(PlayerPedId(), 219.77)
                        SetEntityVelocity(GetVehiclePedIsIn(PlayerPedId(), false), 0.00, 0.00, 0.00)
                        TriggerEvent('bm:repairCar')
                    end
                    exports.bm_utility:Draw3DText( repairMarker[4].x, repairMarker[4].y, repairMarker[4].z-1.00, "Press 'E' to pay 0$ to repair car.", 4, 0.1, 0.1) 
                end
                if GetDistanceBetweenCoords( repairMarker[3].x, repairMarker[3].y, repairMarker[3].z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
                    if IsControlJustPressed(1, 51) then
                        SetEntityHeading(PlayerPedId(), 356.97)
                        SetEntityVelocity(GetVehiclePedIsIn(PlayerPedId(), false), 0.00, 0.00, 0.00)
                        TriggerEvent('bm:repairCar')
                    end
                    exports.bm_utility:Draw3DText( repairMarker[3].x, repairMarker[3].y, repairMarker[3].z-1.00, "Press 'E' to pay 0$ to repair car.", 4, 0.1, 0.1) 
                end
                if GetDistanceBetweenCoords( repairMarker[2].x, repairMarker[2].y, repairMarker[2].z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
                    if IsControlJustPressed(1, 51) then
                        SetEntityHeading(PlayerPedId(), 333.68)
                        SetEntityVelocity(GetVehiclePedIsIn(PlayerPedId(), false), 0.00, 0.00, 0.00)
                        TriggerEvent('bm:repairCar')
                    end
                    exports.bm_utility:Draw3DText( repairMarker[2].x, repairMarker[2].y, repairMarker[2].z-1.00, "Press 'E' to pay 0$ to repair car.", 4, 0.1, 0.1) 
                end
                if GetDistanceBetweenCoords( repairMarker[1].x, repairMarker[1].y, repairMarker[1].z, GetEntityCoords(GetPlayerPed(-1))) < 5.0 then
                    if IsControlJustPressed(1, 51) then
                        TriggerEvent('chat:addMessage', {
                            args = { 'pressed e' }
                        })
                        SetEntityHeading(PlayerPedId(), 87.38)
                        SetEntityVelocity(GetVehiclePedIsIn(PlayerPedId(), false), 0.00, 0.00, 0.00)
                        TriggerEvent('bm:repairCar')
                    end
                    exports.bm_utility:Draw3DText( repairMarker[1].x, repairMarker[1].y, repairMarker[1].z-1.00, "Press 'E' to pay 0$ to repair car.", 4, 0.1, 0.1) 
                end
            end
        end
    end
end)

RegisterNetEvent("bm:repairCar")
AddEventHandler("bm:repairCar", function()

    TriggerEvent('chat:addMessage', {
        args = { 'Car should repair' }
    })

    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    if IsVehicleDamaged(vehicle) then
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
    end
    
end)