local QBCore = exports['qb-core']:GetCoreObject()
local ui = false
local cash = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local PlayerData = QBCore.Functions.GetPlayerData()
        hunger = PlayerData.metadata['hunger']
        thirst = PlayerData.metadata['thirst']
    end
end)

local pp = nil

RegisterNetEvent("GetPlayerData")
AddEventHandler("GetPlayerData", function(data)
    pp = data
end)

RegisterNetEvent('dlrms_hud:ui')
AddEventHandler('dlrms_hud:ui', function(bool)
    ui = bool   
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = 'ui',
        ui = bool
    })
end)

RegisterNUICallback('dlrms_hud:close', function()
    TriggerEvent('dlrms_hud:ui', false)
end)

RegisterCommand('hud', function()
    ui = not ui
    if ui then 
        TriggerEvent('dlrms_hud:ui', true)
    else
        TriggerEvent('dlrms_hud:ui', false)
    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie('minimap')
    while not HasScaleformMovieLoaded(minimap) do
      Citizen.Wait(0)
    end

    SetMinimapComponentPosition('minimap', 'L', 'B', -0.0045, -0.008, 0.150, 0.188888)
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.020, 0.025, 0.111, 0.159)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.03, 0.017, 0.266, 0.237)

    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(500)
    SetRadarBigmapEnabled(false, false)
end)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Citizen.CreateThread(function()
        while true do 
            QBCore.Functions.GetPlayerData(function(PlayerData)
            local PlayerData = QBCore.Functions.GetPlayerData()
            hunger = PlayerData.metadata['hunger']
            thirst = PlayerData.metadata['thirst']
            local year, month, day, hour, minute, second = GetLocalTime()
            local clock = string.format("%02d. %02d. %02d. %02d:%02d:%02d", year, month, day, hour, minute, second)
            local bank = PlayerData.money['bank']
            local cash = PlayerData.money['cash']
            local grade = PlayerData.job.grade.name
            local label = PlayerData.job.label
            local ganglabel = PlayerData.gang.label
            local ganggrade = PlayerData.gang.grade.name
            local source = src
            TriggerServerEvent('GetPlayerData', src)
            Citizen.Wait(1000)
            SendNUIMessage({
              action = 'details',
                id = GetPlayerServerId(PlayerId()),
                label = label,
                grade = grade,
                ganglabel = ganglabel,
                ganggrade = ganggrade,
                bank = bank,
                clock = clock,
                cash = cash,
                pp = pp
            })
            end)
        end
    end)
end)

local resourceName = 'dlrms_hud'


AddEventHandler('onResourceStart', function(resourceName)
    Citizen.CreateThread(function()
        while true do 
            QBCore.Functions.GetPlayerData(function(PlayerData)
            local PlayerData = QBCore.Functions.GetPlayerData()
            local year, month, day, hour, minute, second = GetLocalTime()
            local clock = string.format("%02d. %02d. %02d. %02d:%02d:%02d", year, month, day, hour, minute, second)
            local bank = PlayerData.money['bank']
            local cash = PlayerData.money['cash']
            local grade = PlayerData.job.grade.name
            local label = PlayerData.job.label
            local ganglabel = PlayerData.gang.label
            local ganggrade = PlayerData.gang.grade.name
            local src = source
            TriggerServerEvent('GetPlayerData', source)
            Citizen.Wait(1000)
            SendNUIMessage({
              action = 'details',
                id = GetPlayerServerId(PlayerId()),
                label = label,
                grade = grade,
                ganglabel = ganglabel,
                ganggrade = ganggrade,
                bank = bank,
                clock = clock,
                cash = cash,
                pp = pp,
            })
            end)
        end
    end)
end)

local bigMap = false
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local pauseMenuOn = IsPauseMenuActive()
        if not pauseMenuOn then 
            local ped = PlayerPedId()
            local health = GetEntityHealth(ped) - 100
            local armor = GetPedArmour(ped)
            local swim = IsPedSwimming(ped)
            local breath = IsPedSwimmingUnderWater(ped)
            local vehicle = GetVehiclePedIsIn(ped, false)
            local hungerAlert = Config.HungerAlert
            local thirstAlert = Config.ThirstAlert
            local healthAlert = Config.HealthAlert
            local armorAlert = Config.ArmorAlert

            if IsPedInVehicle(ped, vehicle, false) then
                DisplayRadar(true)
                if IsControlPressed(0, 20)then 
                    bigMap = not bigMap
                    if bigMap then 
                        SetRadarBigmapEnabled(true, false)
                    else
                        SetRadarBigmapEnabled(false, false)
                    end
                end
            else
                DisplayRadar(false)
                if breath then
                    stamina = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
                else
                    stamina = GetPlayerSprintTimeRemaining(PlayerId()) * 10
                end
            end
            
            SendNUIMessage({
                action = 'hud',
                pauseMenuOn = false,
                health = health,
                healthAlert = healthAlert,
                armor = armor,
                armorAlert = armorAlert,

                hunger = hunger,
                hungerAlert = hungerAlert,
                thirst = thirst,
                thirstAlert = thirstAlert,

                stamina = stamina,
                swim = swim,
                breath = breath,

                bigMap = bigMap,
                vehicle = vehicle
            })
        else
            SendNUIMessage({
                pauseMenuOn = true
            })
        end
        Citizen.Wait(sleep)
    end
end)
