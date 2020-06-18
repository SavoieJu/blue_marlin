RegisterServerEvent("bm:addCharToDB", source, fname, lname, modelNum)
AddEventHandler("bm:addCharToDB", function(source, fname, lname, modelNum)
    local license = GetPlayerLicense(source)
    print(modelNum)
	GetPlayerDBID(source, license, fname, lname, modelNum)
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

function GetPlayerDBID(source, license, fname, lname, modelNum)
	MySQL.ready(function ()
		MySQL.Async.fetchAll('SELECT * FROM players WHERE license = @license', { ['@license'] = license }, function(result)
		  	if next(result) ~= nil then
                AddCharacterToDB(source, result[1].id, fname, lname, modelNum) 
		  	else 
		  		print('Error while trying to get ID to add new character')
		  	end
		end)
	end)
end

function AddCharacterToDB(source, id, fname, lname, modelNum)
	MySQL.Async.insert('INSERT INTO characters (player_id, first_name, last_name, birth_date) VALUES (@player_id, @first_name, @last_name, CURDATE())',
	  	{ ['@player_id'] = id, ['@first_name'] = fname, ['@last_name'] = lname },
	  	function(insertId)
		    if insertId ~= 0 then
                print("Added new character succesfully.")
				AddOutfitToDB(source, modelNum, id, insertId)
				AddCharFinanceToDB(insertId)
				AddCharJobToDB(insertId)
				UpdateLastCharacter(id, insertId)
				AddCharHouse(insertId)
				print(insertId)
				TriggerClientEvent('bm:firstTimeCharInfo', source, fname, lname, "Unemployed", insertId)
		    else
		    	print("Error while adding new character")
		end
	end)
end

function AddCharFinanceToDB(char_id)
	MySQL.Async.insert('INSERT INTO character_finance (char_id) VALUES (@char_id)',
	  	{ ['@char_id'] = char_id },
	  	function(insertId)
            if insertId ~= 0 then
                print("Added default character finance")
		    else
		    	print("Error while adding default character finance")
		end
	end)
end

function AddCharJobToDB(char_id)
	MySQL.Async.insert('INSERT INTO character_job (char_id) VALUES (@char_id)',
	  	{ ['@char_id'] = char_id },
	  	function(insertId)
            if insertId ~= 0 then
                print("Added default character job")
		    else
		    	print("Error while adding default character job")
		end
	end)
end

function AddOutfitToDB(source, modelNum, id, char_id)
	MySQL.Async.insert('INSERT INTO character_outfits (outfit_name, outfit) VALUES (@outfit_name, @modelNum)',
	  	{ ['@outfit_name'] = "default", ['@modelNum'] = modelNum },
	  	function(insertId)
            if insertId ~= 0 then
                print(insertId)
                AddCharAppToDB(source, insertId, char_id)
		    else
		    	print("Error while adding new outfit")
		end
	end)
end

function AddCharAppToDB(source, outfit_id, char_id)
	MySQL.Async.insert('INSERT INTO character_appearance (char_id, outfit_id) VALUES (@char_id, @outfit_id)',
	  	{ ['@char_id'] = char_id, ['@outfit_id'] = outfit_id },
	  	function(insertId)
		    if insertId ~= 0 then
		    	-- print(insertId)
		    else
		    	-- print("Error while adding new character outfit")
		end
	end)
end

function UpdateLastCharacter(player_id, char_id)
	MySQL.Async.execute('UPDATE last_character SET char_id = @char_id WHERE player_id = @player_id',
		{ ['@player_id'] =player_id, ['@char_id'] = char_id },
		function(affectedRows)
			if affectedRows ~= 0 then
				print(affectedRows)
			else
				MySQL.Async.insert('INSERT INTO last_character (player_id, char_id) VALUES (@player_id, @char_id)',
					{ ['@player_id'] = player_id, ['@char_id'] = char_id },
					function(insertId)
					if insertId ~= 0 then
						print("Added last character succesfully.")
					else
						print("Error while adding last character")
					end
				end)
			end
	end)
end

function AddCharHouse(char_id)
	MySQL.Async.insert('INSERT INTO character_house (char_id) VALUES (@char_id)',
	  	{ ['@char_id'] = char_id },
	  	function(insertId)
		    if insertId ~= 0 then
		    	print("Added character house")
		    else
		    	print("Error while adding new character house")
		end
	end)
end