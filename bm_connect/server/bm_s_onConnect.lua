RegisterServerEvent("bm:playerConnect", source)
AddEventHandler("bm:playerConnect", function(source)
    local license = GetPlayerLicense(source)
	DoesPlayerExist(source, license)
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

function DoesPlayerExist(source, license)
	MySQL.ready(function ()
		MySQL.Async.fetchAll('SELECT * FROM players WHERE license = @license', { ['@license'] = license }, function(result)
		  	if next(result) ~= nil then
			  	GetPlayerCharacters(source, result[1].id) 
		  	else 
		  		AddPlayerToDB(source, license)
		  	end
		end)
	end)
end

function AddPlayerToDB(source, license)
	MySQL.Async.insert('INSERT INTO players (license) VALUES (@license)',
	  	{ ['@license'] = license },
	  	function(insertId)
		    if insertId ~= 0 then
		    	print("Added new player succesfully.")
		    	DoesPlayerExist(source, license)
		    else
		    	print("Error while adding new player")
		end
	end)
end

function GetPlayerCharacters(source, db_id)
	MySQL.Async.fetchAll('SELECT * FROM characters RIGHT JOIN character_finance ON characters.char_id = character_finance.char_id RIGHT JOIN character_job ON characters.char_id = character_job.char_id RIGHT JOIN jobs ON jobs.job_id = character_job.job_id RIGHT JOIN character_appearance ON characters.char_id = character_appearance.char_id RIGHT JOIN character_outfits ON character_appearance.outfit_id = character_outfits.outfit_id WHERE player_id = @db_id', { ['@db_id'] = db_id }, function(result)
	  	if next(result) ~= nil then
	  		print("Player has character(s).")
		  	TriggerClientEvent('bm:getChars', source, json.encode(result))
	  	else 
	  		print("Player has no character.")
	  		TriggerClientEvent('bm:getChars', source, json.encode(result))
	  	end
	end)
end