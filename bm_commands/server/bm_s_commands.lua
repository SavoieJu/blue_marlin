RegisterServerEvent("bm:addSpawnPoint", coords, heading, name)
AddEventHandler("bm:addSpawnPoint", function(coords, heading, name)
    local coordsHeading = {coords.x, coords.y, coords.z, heading}
    AddSpawnpointToDB(json.encode(coordsHeading), name)
end)

function AddSpawnpointToDB(coords, name)
    MySQL.Async.insert('INSERT INTO spawnpoints (spawnpoint_name, spawnpoint_coords) VALUES (@name, @coords)',
	  	{ ['@name'] = name, ['@coords'] = coords},
	  	function(insertId)
		    if insertId ~= 0 then
		    	print("Added new spawnpoint succesfully.")
		    else
		    	print("Error while adding new spawnpoint")
		end
	end)
end

RegisterServerEvent("bm:changejob", source, job_id, char_id, job_name)
AddEventHandler("bm:changejob", function(source, job_id, char_id, job_name)
    setJobCommand(source, job_id, char_id, job_name)
end)

function setJobCommand(source, job_id, char_id, job_name)
	MySQL.Async.execute('UPDATE character_job SET job_id = @job_id WHERE char_id = @char_id',
		{ ['@job_id'] = job_id, ['@char_id'] = char_id },
		function(affectedRows)
			if affectedRows ~= 0 then
				TriggerClientEvent('bm:updateCharInfoJob', source, job_name)
				TriggerClientEvent('bm:confirmJobChangeCommand', source)
			else
				print(affectedRows)
			end
	end)
end