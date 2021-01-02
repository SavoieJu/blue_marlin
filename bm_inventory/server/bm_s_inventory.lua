RegisterServerEvent("bm:InventoryKeyPressed", source)
AddEventHandler("bm:InventoryKeyPressed", function(source)
    -- Load the inventory Data
    local license = GetPlayerLicense(source)
    GetPlayerDBID(source, license)
    -- Check for nearby inventories (maybe do that in client before activting this event) 
    -- Open inventory
end)


function GetPlayerLicense(source)
    local license = ""
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)
        if string.find(id, "license") then
            license = id
        end
    end
    return license
end

function GetPlayerDBID(source, license)
	MySQL.ready(function ()
		MySQL.Async.fetchAll('SELECT * FROM players WHERE license = @license', { ['@license'] = license }, function(result)
              if next(result) ~= nil then
                GetLastCharacter(source, result[1].id)
		  	else 
                print(result)
		  	end
		end)
	end)
end

function GetLastCharacter(source, player_id)
	MySQL.Async.fetchAll('SELECT * FROM last_character WHERE player_id = @player_id', { ['@player_id'] = player_id }, function(result)
        if next(result) ~= nil then
            GetCharInventory(source, result[1].char_id)
        else 
            print(result)
        end
    end)
end

function GetCharInventory(source, player_id)
	MySQL.Async.fetchAll('SELECT * FROM character_inventory WHERE char_id = @player_id', { ['@player_id'] = player_id }, function(result)
        if next(result) ~= nil then
            GetAllInventoryItem(source, result[1].inventory_id) 
        else 
            print(result)
        end
    end)
end

function GetAllInventoryItem(source, inventory_id)
	MySQL.Async.fetchAll('SELECT * FROM character_item RIGHT JOIN items ON character_item.item_id = items.item_id WHERE character_item.inventory_id = @inventory_id', { ['@inventory_id'] = inventory_id }, function(result)
        if next(result) ~= nil then
            TriggerClientEvent('bm:openInventory', source, json.encode(result))
        else 
            print("Error while loading items")
        end
    end)
end