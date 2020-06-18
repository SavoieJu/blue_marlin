local signupMarker = { name="trucker_signup", id=23, x=1182.60, y=-3307.79, z=5.53, dirX=0, dirY=0, dirZ=0, rotX=0, rotY=0, rotZ=0, scaleX=1.0001, scaleY=1.0001, scaleZ=1.5001, red=255, green=0, blue=0, alpha=100, upDown=false, unknown1=false, unknown2=0,unknown3=0 }

local Blips = {
    { name="Trucker Job", color=4, id=477, x=1182.60, y=-3307.79, z=5.53}, 
}



Citizen.CreateThread(function()
    blip_trucker = AddBlipForCoord(Blips[1].x, Blips[1].y, Blips[1].z)
    SetBlipSprite(blip_trucker, Blips[1].id)
    SetBlipAsShortRange(blip_trucker, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Blips[1].name)
    EndTextCommandSetBlipName(blip_trucker)
    
    while true do
        Wait(0)
        DrawMarker(signupMarker.id, signupMarker.x, signupMarker.y, signupMarker.z, signupMarker.dirX, signupMarker.dirY, signupMarker.dirZ, signupMarker.rotX, signupMarker.rotY, signupMarker.rotZ, signupMarker.scaleX, signupMarker.scaleY, signupMarker.scaleZ, signupMarker.red, signupMarker.green, signupMarker.blue, signupMarker.alpha, signupMarker.upDown, signupMarker.unknown1, signupMarker.unknown2, signupMarker.unknown3)
        if GetDistanceBetweenCoords( signupMarker.x, signupMarker.y, signupMarker.z, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then
            if IsControlJustPressed(1, 51) then
                TriggerServerEvent('bm:setCharJobToTruckDriver', GetPlayerServerId(PlayerId()))
            end
            exports.bm_utility:Draw3DText( signupMarker.x, signupMarker.y, signupMarker.z-1.00, "Press 'E' to signup as a Truck Driver.", 4, 0.1, 0.1) 
        end
    end
end)


RegisterNetEvent('bm:alreadyTruckDriver')
AddEventHandler('bm:alreadyTruckDriver', function()
    
    TriggerEvent('chat:addMessage', {
		args = { 'You are already a Truck Driver' }
    })

end)

RegisterNetEvent('bm:updatedToTruckDriver')
AddEventHandler('bm:updatedToTruckDriver', function()
    
    TriggerEvent('chat:addMessage', {
		args = { 'You are now a Truck Driver' }
    })

    print(exports.bm_utility:character_info().job_name)

end)
