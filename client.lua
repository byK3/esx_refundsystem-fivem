local firstspawn = true


AddEventHandler('playerSpawned', function(spawn)

    if Config.EachSpawn then
        if firstspawn then
            firstspawn = false

            ESX.TriggerServerCallback('checkrefund:data', function(cb)
            end)
            
        end
    end
end)