ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('Shaz:GetEntityPosition', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local TableTarace = {}
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', { ["@identifier"] = xPlayer.identifier }, function(result)
        TriggerClientEvent('Shaz:GetEntityPosition', source, json.decode(result[1].position), result[1].vie)
    end)
end)

ESX.RegisterServerCallback("Shaz:GetInfos", function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', { ["@identifier"] = xPlayer.identifier }, function(result)
        callback(result)
    end)
end)