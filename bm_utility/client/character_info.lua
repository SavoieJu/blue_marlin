local character_info = {
    char_id = "temp",
    first_name = "temp",
    last_name = "temp",
    job_name = "temp",
}

RegisterNetEvent('bm:updateCharInfo', first_name, last_name, job_name, char_id)
AddEventHandler('bm:updateCharInfo', function(first_name, last_name, job_name, char_id)
    
    character_info.first_name = first_name
    character_info.last_name = last_name
    character_info.job_name = job_name
    character_info.char_id = char_id

end)

RegisterNetEvent('bm:updateCharInfoJob', job_name)
AddEventHandler('bm:updateCharInfoJob', function(job_name)
    
    character_info.job_name = job_name

end)

RegisterNetEvent('bm:firstTimeCharInfo', first_name, last_name, job_name, char_id)
AddEventHandler('bm:firstTimeCharInfo', function(first_name, last_name, job_name, char_id)
    
    character_info.first_name = first_name
    character_info.last_name = last_name
    character_info.job_name = job_name
    character_info.char_id = char_id

end)


exports("character_info", function()
    return character_info
end)