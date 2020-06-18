RegisterServerEvent("bm:setCharJobToTruckDriver", source)
AddEventHandler("bm:setCharJobToTruckDriver", function(source)
    local license = GetPlayerLicense(source)
    GetPlayerID(source, license)
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

function GetPlayerID(source, license)
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
            SetJobTruckDriver(source, result[1].char_id) 
        else 
            print(result)
        end
    end)
end

function SetJobTruckDriver(source, char_id)
	MySQL.Async.execute('UPDATE character_job SET job_id = 2 WHERE char_id = @char_id',
        { ['@char_id'] = char_id },
        function(affectedRows)
            if affectedRows ~= 0 then
                TriggerClientEvent('bm:updateCharInfoJob', source, "Truck Driver")
                TriggerClientEvent('bm:updatedToTruckDriver', source)
                
            else
                print(affectedRows)
            end
    end)
end