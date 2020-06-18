local character_info = {
    first_name = "temp",
    last_name = "temp",
    job_name = "temp",
}

RegisterNetEvent('bm:updateCharInfo', first_name, last_name, job_name)
AddEventHandler('bm:updateCharInfo', function(first_name, last_name, job_name)
    
    character_info.first_name = first_name
    character_info.last_name = last_name
    character_info.job_name = job_name

end)

RegisterNetEvent('bm:updateCharInfoJob', job_name)
AddEventHandler('bm:updateCharInfoJob', function(job_name)
    
    character_info.job_name = job_name

end)

RegisterNetEvent('bm:firstTimeCharInfo', first_name, last_name)
AddEventHandler('bm:firstTimeCharInfo', function(first_name, last_name)
    
    character_info.first_name = first_name
    character_info.last_name = last_name
    character_info.job_name = "Unemployed"

end)


exports("character_info", function()
    return character_info
end)