local Core = exports[Config.core]:GetCoreObject()


RegisterServerEvent('qb-skydiving:cash', function()
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= 3500 then
    Player.Functions.RemoveMoney('cash', Config.price)
    TriggerClientEvent('qb-skydiving:client', src)
    else
        TriggerClientEvent('Core:Notify', src, "You don't have enough money to skydiving!", "error")
    end
end)

RegisterServerEvent('qb-skydiving:server:cash2', function()
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= 3500 then
    Player.Functions.RemoveMoney('cash', Config.price)
    TriggerClientEvent('qb-skydiving:client2', src)
    else
        TriggerClientEvent('Core:Notify', src, "You don't have enough money to skydiving!", "error")
    end
end)

RegisterServerEvent('qb-skydiving:server:cash3', function()
    local src = source
    local Player = Core.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= 3500 then
    Player.Functions.RemoveMoney('cash', Config.price)
    TriggerClientEvent('qb-skydiving:client3', src)
    else
        TriggerClientEvent('Core:Notify', src, "You don't have enough money to skydiving!", "error")
    end
end)