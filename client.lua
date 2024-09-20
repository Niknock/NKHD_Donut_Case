local isNearDonutCase = false
local showingPrompt = false
local targetAdded = false
local donutCaseEntity = nil 

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        donutCaseEntity = GetClosestObjectOfType(playerCoords, 2.0, GetHashKey(Config.DonutCaseProp), false, false, false)
        
        if DoesEntityExist(donutCaseEntity) then
            isNearDonutCase = true

            if Config.UseQTarget and not targetAdded then
                exports['qtarget']:AddTargetEntity(donutCaseEntity, {
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
                exports['ox_target']:addLocalEntity(donutCaseEntity, {
                    {
                        event = 'donut:pickup',
                        icon = 'fas fa-donut',
                        label = Config.TargetText,
                    }
                })
                targetAdded = true 
            end

        else
            isNearDonutCase = false
            showingPrompt = false
        end

        Citizen.Wait(500)
    end
end)

RegisterNetEvent('donut:pickup')
AddEventHandler('donut:pickup', function()
    TriggerServerEvent('donut:giveDonut')
end)
