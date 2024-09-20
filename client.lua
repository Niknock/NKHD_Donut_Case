local isNearDonutCase = false
local showingPrompt = false
local targetAdded = false 

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local donutCase = GetClosestObjectOfType(playerCoords, 2.0, GetHashKey(Config.DonutCaseProp), false, false, false)
        
        if DoesEntityExist(donutCase) then
            isNearDonutCase = true

            if Config.UseQTarget and not targetAdded then
                exports['qtarget']:AddTargetEntity(donutCase, {
                    options = {
                        {
                            event = 'donut:pickup',
                            icon = 'fas fa-donut',
                            label = Config.TargetText,
                        }
                    },
                    distance = 2.0
                })
                targetAdded = true 
            end

            if Config.UseOxTarget and not targetAdded then
                exports['ox_target']:addLocalEntity(donutCase, {
                    {
                        event = 'donut:pickup',
                        icon = 'fas fa-donut',
                        label = Config.TargetText,
                    }
                })
                targetAdded = true 
            end

        else

            if targetAdded then

                if Config.UseQTarget then
                    exports['qtarget']:RemoveTargetEntity(donutCase)
                elseif Config.UseOxTarget then
                    exports['ox_target']:removeLocalEntity(donutCase)
                end
                targetAdded = false
            end
            isNearDonutCase = false
            showingPrompt = false
        end

        Citizen.Wait(500)
    end
end)

RegisterNetEvent('donut:pickup')
AddEventHandler('donut:pickup', function()
    if Config.Framework == 'ESX' then
        TriggerServerEvent('donut:giveDonut')
    elseif Config.Framework == 'QBCore' then
        TriggerServerEvent('donut:giveDonut')
    end
end)
