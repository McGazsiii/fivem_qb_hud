local QBCore = exports['qb-core']:GetCoreObject()
QBCore.Functions.CreateCallback('dlrms_hud:getAccounts', function(source, cb)
  local PlayerData = QBCore.Functions.GetPlayerData()
  local mySociety = nil
  local society = 0
  cb()
end)

RegisterServerEvent('GetPlayerData')
AddEventHandler('GetPlayerData', function()
  local src = source
  local license = QBCore.Functions.GetIdentifier(src, 'license')
  MySQL.scalar('SELECT `pp` FROM `playerdiscord` WHERE `license` = ? LIMIT 1', {
    license
  }, function(result)
    data = result
  TriggerClientEvent("GetPlayerData", src, data)
  end)
end)

QBCore.Commands.Add('givepp', 'Adj PP-t játékosnak', { { name = 'ID', help = 'Játékos ID-je' }, { name = 'Mennyiség', help = 'PP mennyisége' } }, true, function(source, args)
  local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
  if Player then
    local license = QBCore.Functions.GetIdentifier(tonumber(args[1]), 'license')
    local newpp = tonumber(args[2])
    MySQL.update('UPDATE playerdiscord SET pp = pp + ? WHERE license = ?', {
      newpp, license
    }, function()
    local playername = GetPlayerName(tonumber(args[1]))
    TriggerClientEvent('QBCore:Notify', source, 'Sikeresen adtál ' ..playername.. ' nevű játékosnak ' ..newpp.. ' PP-t!', 'success')
    end)
  else
    TriggerClientEvent('QBCore:Notify', source, 'Nem elérhető játékos!', 'error')
  end
end, 'god')

QBCore.Commands.Add('removepp', 'Vegyél el PP-t játékostól', { { name = 'ID', help = 'Játékos ID-je' }, { name = 'Mennyiség', help = 'PP mennyisége' } }, true, function(source, args)
  local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
  if Player then
    local license = QBCore.Functions.GetIdentifier(tonumber(args[1]), 'license')
    local newpp = tonumber(args[2])
    MySQL.update('UPDATE playerdiscord SET pp = pp - ? WHERE license = ?', {
      newpp, license
    }, function()
      TriggerClientEvent('QBCore:Notify', source, 'Sikeresen elvettél ' ..playername.. ' nevű játékostól ' ..newpp.. ' PP-t!', 'success')
    end)
  else
    TriggerClientEvent('QBCore:Notify', source, 'Nem elérhető játékos!', 'error')
  end
end, 'god')

QBCore.Commands.Add('setpp', 'Állíts be PP-t játékosnak', { { name = 'ID', help = 'Játékos ID-je' }, { name = 'Mennyiség', help = 'PP mennyisége' } }, true, function(source, args)
  local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
  if Player then
    local license = QBCore.Functions.GetIdentifier(tonumber(args[1]), 'license')
    local newpp = tonumber(args[2])
    MySQL.update('UPDATE playerdiscord SET pp = ? WHERE license = ?', {
      newpp, license
    }, function()
    local playername = GetPlayerName(tonumber(args[1]))
    TriggerClientEvent('QBCore:Notify', source, 'Sikeresen beállítottál ' ..playername.. ' nevű játékosnak ' ..newpp.. ' PP-t!', 'success')
    end)
  else
    TriggerClientEvent('QBCore:Notify', source, 'Nem elérhető játékos!', 'error')
  end
end, 'god')