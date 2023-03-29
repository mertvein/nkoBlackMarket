local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('nkoBlackMarket:getTime', function(source, cb)
    cb(os.time())
end)

QBCore.Functions.CreateCallback('nkoBlackMarket:getAllShipments', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('SELECT * FROM blackmarket WHERE citizenid = @citizenid', {
        ['@citizenid'] = xPlayer.PlayerData.citizenid,
    }, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback('nkoBlackMarket:GetAllItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    exports.oxmysql:execute('SELECT * FROM blackmarket WHERE citizenid = @citizenid', {
        ['@citizenid'] = Player.PlayerData.citizenid
    }, function(result)
        exports.oxmysql:execute('DELETE FROM blackmarket WHERE item = @item', {
            ['@item'] = result[1].item
        })
        if math.random(0, 1) >= Config.Chance then
            if Player.Functions.AddItem(result[1].item, result[1].count) then
                TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, result[1].count..'x '..result[1].label..' '..Lang:t('server.order'), 'success')
            end
            cb(true)
        else
            TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('server.war')..' ('..result[1].label..')', 'error')
            cb(false)
        end
    end)
end)

RegisterServerEvent('nkoBlackMarket:MakeShipment')
AddEventHandler('nkoBlackMarket:MakeShipment', function(item, label, count, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney(Config.PaymentType, price) then
        exports.oxmysql:execute('INSERT INTO blackmarket (citizenid, label, item, price, count, time) VALUES (@citizenid, @label, @item, @price, @count, @time)',{
            ['@citizenid'] = Player.PlayerData.citizenid,
            ['@label'] = label,
            ['@item'] = item,
            ['@price'] = price,
            ['@count'] = count,
            ['@time'] = os.time()
        })
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('server.pay')..' ($'..price..') ('..count..'x) ('..label..').', 'success')
    else
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('server.noMoney'), 'error')
    end
end)