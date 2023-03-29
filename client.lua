local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local DealerPed = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

CreateThread(function()
    for k, v in pairs(Config.Seller) do
        if not DealerPed[k] then DealerPed[k] = {} end
        local current = v.pedhash
        current = type(current) == 'string' and GetHashKey(current) or current
        RequestModel(current)

        while not HasModelLoaded(current) do Wait(0) end

        DealerPed[k] = CreatePed(0, current, v.coords.x, v.coords.y, v.coords.z - 1, v.coords.w, false, false)
        FreezeEntityPosition(DealerPed[k], true)
        SetEntityInvincible(DealerPed[k], true)
        SetBlockingOfNonTemporaryEvents(DealerPed[k], true)

        exports["qb-target"]:AddTargetEntity(DealerPed[k], {
            options = {
                {
                    type = 'client',
                    action = function()
                        openMenu()
                    end,
                    label = v.targetLabel,
                    icon = v.targetIcon,
                },
            },
            distance = 1.5
        })
    end
end)

function openMenu()
    local hours = GetClockHours()
    if hours >= Config.MinimumTime and hours <= Config.MaximumTime then
        local menu = {
            {
                header = Lang:t('menu.header'),
                icon = 'fa-solid fa-shop',
                isMenuHeader = true,
            },
            {
                header = Lang:t('menu.orderHeader'),
                txt = Lang:t('menu.orderTxt'),
                icon = 'fas fa-box-open',
                params = {
                    event = 'nkoBlackMarket:openShop'
                }
            },
            {
                header = Lang:t('menu.finalHeader'),
                txt = Lang:t('menu.finalTxt'),
                icon = 'fas fa-list',
                params = {
                    event = 'nkoBlackMarket:getShipment'
                }
            }
        }
        exports['qb-menu']:openMenu(menu)
    else
        QBCore.Functions.Notify(Lang:t('menu.notify'), 'error')
    end
end

RegisterNetEvent('nkoBlackMarket:openShop')
AddEventHandler('nkoBlackMarket:openShop', function()
    local menu = {
        {
            header = Lang:t('shop.header'),
            txt = Lang:t('shop.txt'),
            icon = 'fas fa-tools',
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Items) do
        menu[ #menu + 1 ] = {
            header = v.label,
            txt = '<span style="color:#50bb46; font-weight: bold;">'..v.price..'$</span> '..Lang:t('shop.price'),
            icon = v.icon,
            params = {
                event = 'nkoBlackMarket:checkItem',
                args = {
                    item = v.hash,
                    label = v.label,
                    count = 1, -- in development..
                    price = v.price,
                }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

AddEventHandler('nkoBlackMarket:checkItem', function(args)
    local item = args.item
    local label = args.label
    local count = args.count
    local price = args.price
    TriggerServerEvent('nkoBlackMarket:MakeShipment', item, label, count, price)
end)

RegisterNetEvent('nkoBlackMarket:getShipment')
AddEventHandler('nkoBlackMarket:getShipment', function()
    QBCore.Functions.TriggerCallback('nkoBlackMarket:getTime', function(time)
        QBCore.Functions.TriggerCallback('nkoBlackMarket:getAllShipments', function(items)
            local menu = {
                {
                    header = Lang:t('shipment.header'),
                    txt = Lang:t('shipment.txt'),
                    icon = 'fas fa-box-open',
                    isMenuHeader = true
                }
            }
            for i = 1, #items, 1 do
                times = time - items[i].time
                if times <= Config.DeliveryTime then
                    menu[ #menu + 1 ] = {
                        header = items[i].label,
                        icon = 'fas fa-tools',
                        txt = (Config.DeliveryTime - times)..' '..Lang:t('shipment.timeTxt'),
                        disabled = true
                    }
                end

                if times >= Config.DeliveryTime then
                    menu[ #menu + 1 ] = {
                        header = items[i].label..' | '..items[i].price..'$',
                        txt = Lang:t('shipment.takeTxt'),
                        icon = 'fas fa-hourglass-start',
                        params = {
                            event = 'nkoBlackMarket:checkStatus'
                        }
                    }
                end
            end
            exports['qb-menu']:openMenu(menu)
        end)
    end)
end)

AddEventHandler('nkoBlackMarket:checkStatus', function()
    QBCore.Functions.TriggerCallback('nkoBlackMarket:GetAllItems')
end)