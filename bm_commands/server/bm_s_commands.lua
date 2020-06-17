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