if Config.Framework == 'ESX' then
    ESX = nil
    if Config.ESX == 'Old' then
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    elseif Config.ESX == 'New' then
        ESX = exports["es_extended"]:getSharedObject()
    else
        print('Wrong ESX Type!')
    end
end

if Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent('donut:giveDonut')
AddEventHandler('donut:giveDonut', function()
    local _source = source

    if Config.Framework == 'ESX' then
        local xPlayer = ESX.GetPlayerFromId(_source)
        local playerMoney = xPlayer.getMoney()

        if Config.PayForDonut then
            if playerMoney >= Config.DonutPrice then
                xPlayer.removeMoney(Config.DonutPrice)
                xPlayer.addInventoryItem(Config.DonutItem, 1)
                if Config.UseNotification then
                    TriggerClientEvent('esx:showNotification', _source, Config.Notification)
                end
            else
                if Config.UseNotification then
                    TriggerClientEvent('esx:showNotification', _source, Config.NotEnoughMoneyNotification)
                end
            end
        else
            xPlayer.addInventoryItem(Config.DonutItem, 1)
            if Config.UseNotification == true then
                TriggerClientEvent('esx:showNotification', _source, Config.Notification)
            end
        end

    elseif Config.Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(_source)
        local playerMoney = Player.PlayerData.money['cash']

        if Config.PayForDonut then
            if playerMoney >= Config.DonutPrice then
                Player.Functions.RemoveMoney('cash', Config.DonutPrice)
                Player.Functions.AddItem(Config.DonutItem, 1)
                if Config.UseNotification == true then
                    TriggerClientEvent('QBCore:Notify', _source, Config.Notification)
                end
            else
                if Config.UseNotification then
                    TriggerClientEvent('QBCore:Notify', _source, Config.NotEnoughMoneyNotification)
                end
            end
        else
            Player.Functions.AddItem(Config.DonutItem, 1)
            if Config.UseNotification == true then
                TriggerClientEvent('QBCore:Notify', _source, Config.Notification)
            end
        end
    end
end)
