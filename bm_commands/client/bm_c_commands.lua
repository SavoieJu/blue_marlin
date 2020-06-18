RegisterCommand('addspawn', function(source, args)
    local coords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    TriggerServerEvent('bm:addSpawnPoint', coords, heading, args[1])
end, false)

TriggerEvent("chat:addSuggestion", "/addspawn", "Creates a new spawnpoint in the database",
{
    { name="Spawnpoint Name", help="The name of the spawnpoint" }
});

RegisterCommand('charchange', function(source, args)
    local playerServerID = GetPlayerServerId(PlayerId())
    DisplayRadar(false)
    SwitchOutPlayer(PlayerPedId(), 1, 2)

    Citizen.CreateThread(function()
    	while GetPlayerSwitchState() ~= 5 do
	        Citizen.Wait(0)
	    end
    end)
    
    TriggerServerEvent('bm:playerConnect', playerServerID)
end, false)

TriggerEvent("chat:addSuggestion", "/charchange", "Takes you back to character select screen", {});