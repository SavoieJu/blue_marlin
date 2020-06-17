RegisterCommand('addspawn', function(source, args)
    local coords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    TriggerServerEvent('bm:addSpawnPoint', coords, heading, args[1])
end, false)

TriggerEvent("chat:addSuggestion", "/addspawn", "Creates a new spawnpoint in the database",
{
    { name="Spawnpoint Name", help="The name of the spawnpoint" }
});