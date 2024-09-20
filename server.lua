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
        xPlayer.addInventoryItem(Config.DonutItem, 1)
        if Config.UseNotification == true then
            TriggerClientEvent('esx:showNotification', _source, Config.Notification)
        end
    elseif Config.Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(_source)
        Player.Functions.AddItem(Config.DonutItem, 1)
        if Config.UseNotification == true then
            TriggerClientEvent('QBCore:Notify', _source, Config.Notification)
        end
    end
end)
