local QBCore = exports['qb-core']:GetCoreObject()

local TimeOuts = {
  [1] = false,
  [2] = false,
  [3] = false
}

local CachedPoliceAmount = {}
local Flags = {}

-------------------------------- FUNCTIONS --------------------------------

local function randomNum(min, max)
  math.randomseed(os.time())
  return math.floor((math.random() * (max - min) + min) + 0.5)
end

local function exploitBan(id, reason)
  MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)',
    {
      GetPlayerName(id),
      QBCore.Functions.GetIdentifier(id, 'license'),
      QBCore.Functions.GetIdentifier(id, 'discord'),
      QBCore.Functions.GetIdentifier(id, 'ip'),
      reason,
      2147483647,
      'qb-weedshop'
    }
  )
  TriggerEvent('qb-log:server:CreateLog', 'weedshop-Exploiting', 'Player Banned', 'red',
  string.format('%s was banned by %s for %s', GetPlayerName(id), 'qb-weedshop', reason), true)
  DropPlayer(id, 'You were permanently banned by the server for: Exploiting')
end

-------------------------------- EVENTS --------------------------------

RegisterServerEvent('qb-weedshop:server:RemoveDoorItem', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local item = Config.DoorItem
  if not Player then return end
  Player.Functions.RemoveItem(item, 1)
end)

RegisterServerEvent('qb-weedshop:server:SetVitrineState', function(stateType, state, k)
  if stateType == 'isBusy' and type(state) == 'boolean' and Config.Vitrines[k] then
    Config.Vitrines[k][stateType] = state
    TriggerClientEvent('qb-weedshop:client:SetVitrineState', -1, stateType, state, k)
  end
end)

RegisterServerEvent('qb-weedshop:server:StoreHit', function(storeIndex, bool)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Player then return end
  TriggerClientEvent('qb-weedshop:client:StoreHit', -1, storeIndex, bool)
  if storeIndex == 'all' then Config.Stores[1].hacked = bool end
  for i = 1, #Config.Stores do
    if storeIndex == 'all' then
      Config.Stores[i].hit = bool
    else
      if i == storeIndex then
        Config.Stores[storeIndex].hit = bool
      end
    end
  end
end)

RegisterServerEvent('qb-weedshop:server:ToggleDoorlocks', function(store, locked, allStores)
  local src = source
  if not allStores then
    if not Config.Stores[store] then return end
    if Config.DoorLock == 'qb' then
      TriggerClientEvent('qb-doorlock:client:setState', -1, src, Config.Stores[store]['Doors'].main, locked, src, false, false)
    elseif Config.DoorLock == 'ox' then
      local door = exports['ox_doorlock']:getDoorFromName('Weedshoplery_stores ' .. Config.Stores[store]['Doors'].main) or exports['ox_doorlock']:getDoorFromName(Config.DoorGroup .. Config.Stores[store]['Doors'].main)
      TriggerEvent('ox_doorlock:setState', door.id, locked)
    elseif Config.DoorLock == 'cd' then
      TriggerClientEvent('cd_doorlock:SetDoorState_name', -1, locked, Config.Stores[store]['Doors'].main, 'Weedshoplery Stores')
    end
  else
    for i = 1, #Config.Stores do
      if Config.DoorLock == 'qb' then
        TriggerClientEvent('qb-doorlock:client:setState', -1, src, Config.Stores[i]['Doors'].main, locked, src, false, false)
        TriggerClientEvent('qb-doorlock:client:setState', -1, src, Config.Stores[i]['Doors'].sec, locked, src, false, false)
      elseif Config.DoorLock == 'ox' then
        local main = exports['ox_doorlock']:getDoorFromName('Weedshoplery_stores ' .. Config.Stores[i]['Doors'].main) or exports['ox_doorlock']:getDoorFromName(Config.DoorGroup .. Config.Stores[i]['Doors'].main)
        local sec = exports['ox_doorlock']:getDoorFromName('Weedshoplery_stores ' .. Config.Stores[i]['Doors'].sec) or exports['ox_doorlock']:getDoorFromName(Config.DoorGroup .. Config.Stores[i]['Doors'].sec)
        TriggerEvent('ox_doorlock:setState', main.id, locked)
        TriggerEvent('ox_doorlock:setState', sec.id, locked)
      elseif Config.DoorLock == 'cd' then
        TriggerClientEvent('cd_doorlock:SetDoorState_name', -1, locked, Config.Stores[i]['Doors'].main, 'Weedshoplery Stores')
        TriggerClientEvent('cd_doorlock:SetDoorState_name', -1, locked, Config.Stores[i]['Doors'].sec, 'Weedshoplery Stores')
      end
    end
  end
end)

RegisterServerEvent('qb-weedshop:server:VitrineReward', function(vitrineIndex)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local cheating = false
  if not Config.Vitrines[vitrineIndex] or Config.Vitrines[vitrineIndex].isOpened then 
    exploitBan(src, 'Trying to trigger an exploitable event \"qb-weedshop:server:VitrineReward\"') 
    return 
  end
  if not CachedPoliceAmount[src] then DropPlayer(src, 'Exploiting') return end

  local plrPed = GetPlayerPed(src)
  local plrCoords = GetEntityCoords(plrPed)
  local vitrineCoords = Config.Vitrines[vitrineIndex].coords
  if CachedPoliceAmount[src] >= Config.RequiredCops then
    if plrPed then
      local dist = #(plrCoords - vitrineCoords)
      if dist <= 25.0 then
        Config.Vitrines[vitrineIndex].isOpened = true
        Config.Vitrines[vitrineIndex].isBusy = false
        TriggerClientEvent('qb-weedshop:client:SetVitrineState', -1, 'isOpened', true, vitrineIndex)
        TriggerClientEvent('qb-weedshop:client:SetVitrineState', -1, 'isBusy', false, vitrineIndex)

        local reward = Config.VitrineRewards[randomNum(1, #Config.VitrineRewards)]
        local amount = randomNum(reward['Amounts'].min, reward['Amounts'].max)
        if Player.Functions.AddItem(reward.item, amount) then
          TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[reward.item], 'add')
          TriggerEvent('qb-log:server:CreateLog', 'weedshop-robbery', 'weedshop-robbery', 'red', ('**Name:** %s | **License:** ||(%s)||\n **Info:** Robbed a [weedshop Case] and received (%s) %s '):format(GetPlayerName(src), Player.PlayerData.license, amount, reward.item))
        else
          TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
        end
      else
        cheating = true
      end
    end
  else
    cheating = true
  end

  if cheating then
    local license = Player.PlayerData.license
    if Flags[license] then
      Flags[license] = Flags[license] + 1
    else
      Flags[license] = 1
    end
    if Flags[license] >= 3 then
      exploitBan('Getting flagged many times from exploiting the \"qb-weedshop:server:VitrineReward\" event')
    else
      DropPlayer(src, 'Exploiting')
    end
  end
end)

RegisterServerEvent('qb-weedshop:server:SetTimeout', function(vitrine)
  local store = 0
  if vitrine >= 1 and vitrine <= 20 then
    store = 1
  elseif vitrine >= 21 and vitrine <= 26 then
    store = 2
  elseif vitrine >= 27 and vitrine <= 32 then
    store = 3
  end
  if not TimeOuts[store] then
    TimeOuts[store] = true
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', 'WeedShop', true)
    CreateThread(function()
      Wait(Config.Timeout)
      Config.Stores[1].hacked = false
      for i = 1, #Config.Stores do
        Config.Stores[i].hit = false
      end
      TriggerClientEvent('qb-weedshop:client:StoreHit', -1, 'all', false)
      for i = 1, #Config.Vitrines do
        Config.Vitrines[i].isOpened = false
        TriggerClientEvent('qb-weedshop:client:SetVitrineState', -1, 'isOpened', false, i)
        TriggerClientEvent('qb-weedshop:client:SetAlertState', -1, false)
        TriggerEvent('qb-scoreboard:server:SetActivityBusy', 'WeedShop', false)
      end
      TimeOuts[store] = false
    end)
  end
end)

-------------------------------- CALLBACKS --------------------------------

QBCore.Functions.CreateCallback('qb-weedshop:server:GetCops', function(source, cb)
  local src = source
	local amount = 0
  for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
    if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
      amount = amount + 1
    end
  end
  CachedPoliceAmount[src] = amount
  cb(amount)
end)

QBCore.Functions.CreateCallback('qb-weedshop:server:GetWeedshopleryState', function(_, cb)
  local data = {Locations = Config.Vitrines, Hacks = Config.Stores}
	cb(data)
end)
