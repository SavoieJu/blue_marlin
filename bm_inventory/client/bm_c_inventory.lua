local isInventoryOpen = false

RegisterNetEvent('bm:openInventory', result)
AddEventHandler('bm:openInventory', function(result)
    local itemData = json.decode(result)
    Citizen.CreateThread(function()
        if isInventoryOpen == false then 
            SendNUIMessage({
                type = "openInventory",
                items = itemData
            })
            isInventoryOpen = true
            SetNuiFocus(true, true)
        end
    end)
end)

Citizen.CreateThread(function() 
    while true do
        Wait(0)
        if IsControlJustPressed(0, 288) then
            TriggerServerEvent('bm:InventoryKeyPressed', GetPlayerServerId(PlayerId()))
        end
    end
end)

RegisterNUICallback('bm:closeInv', function(data, cb)

    SetNuiFocus(false, false)

    isInventoryOpen = false

    cb('ok')
end)