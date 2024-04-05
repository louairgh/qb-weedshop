# qb-weedshop-hiest

Weedshop Robbery for QBCore, Thermite, VarHack and auto-lock/unlock doors!



## Dependencies

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)
- [ps-ui](https://github.com/Project-Sloth/ps-ui)

### *Optional Dependancies*

- [qb-policejob](https://github.com/qbcore-framework/qb-policejob)
- [cd_dispatch](https://forum.cfx.re/t/paid-codesign-police-dispatch/2007097)
- [ps-dispatch](https://github.com/Project-Sloth/ps-dispatch)
- [qb-doorlock](https://github.com/qbcore-framework/qb-doorlock)
- [ox_doorlock](https://github.com/overextended/ox_doorlock)
- [cd_doorlock](https://forum.cfx.re/t/paid-codesign-door-lock/5005862)
- [mz-skills](https://github.com/MrZainRP/mz-skills)

## Previews
- comming sooon

## Translations

- Please open an issue for translations, I'll add them in a following update.

## Store MLO's

It's a free map Weed shop, link below:

- [Legion Weed Clinic Interior](https://www.gta5-mods.com/maps/mlo-legion-weed-clinic)

```

- **It's important these cameras keep the same index as above and if you alter it, you should know what your doing.**

### If you're using the config option for one store, and don't plan to use all three

- Don't install the store MLO's or the Legion Weed Clinic Interior -fix to your server.
- Don't add the new Cam ID's to qb-policejob.
- Set Config.OneStore = true.

## Setup Logs

Head over to qb-smallresources/server/logs.lua and add this underneath your last log

```lua
['weedshop-robbery'] = '',
['weedshop-Exploiting'] = '',
```

Once you've added that go over to your logs server and create a channel, create a webhook and then place it inbetween the ''.
If you do not know how to create a webhook follow this guide [Creating Webhooks](https://www.youtube.com/watch?v=fKksxz2Gdnc).

## Important Config

### 1. Intial Setup

#### 1.1. Store Times

```lua
Config.weedshopHours = { -- Store Hours
    range = {
        open = 6, -- When the doors unlock
        close = 18 -- When they lock for the night
    },
    alertnight = {
        start = 18, -- The start of higher chance alerts in the evening
        fin = 20 -- The end of higher chance alerts in the evening
    },
    alertmorn = {
        start = 4, -- The start of higher chance alerts in the morning
        fin = 6 -- The end of higher chance alerts in the morning
    }
}
```

- The range is the time the store is open, and the alert times are the times the police will have a higher chance of getting an alert.
- By setting open and close to 0, the store will always be locked and robbable.

#### 1.2. Variables

```lua
Config.OneStore = false -- Set to true if using just the main weedshop-robbery
Config.Cooldown = 5 * (60 * 2000) -- where x is minutes ie. x * (60 * 2000) \\ For door auto lock function
Config.Timeout = 5 * (60 * 2000) -- where x is minutes ie. x * (60 * 2000) \\ For case smashing cooldown
Config.AutoLock = true -- Set to false if you don't want the doors to auto lock/lock at all
Config.RequiredCops = 3
Config.Dispatch = 'ps' --[[ 'ps' for ps-dispatch, 'qb' for base qb-policejob alerts, 'cd' for cd_dispatch ]]--
```

- The cooldown is the time (in minutes) the doors will auto lock after a hack.
- The timeout is the time (in minutes) the cases will reset after smashing.
- If `Config.AutoLock` is set to false, the doors will always be unlocked.
- The required cops is the amount of cops online required for the store to be "thievable".
- Set `Config.Dispatch` to; 'ps' for ps-dispatch, 'qb' for base qb-policejob alerts, 'cd' for cd_dispatch.

#### 1.3. Door Locks

```lua

Config.DoorLock = 'qb' --[[ Doorlock System ]]--

Config.Stores = {
  [1] = { -- City weedshop's
    label = 'weedshop\'s Jewellers',
    coords = vector3(380.95, -826.64, 30.5),
    ['Doors'] = {
      main = 'weed_shop_door_1',
      sec = 'weed_hiest_2'
    },
    ...
  }
}
```

- Set to `qb` for qb-doorlock  
- // Create a file named `weed_shop_door` in qb-doorlock/config/ and copy the Door Config from the README into it.

- Set to `ox` for ox_doorlock
- // Uncomment '@ox_lib/init.lua' from the fxmanifest.lua, create a file named `weed_shop_door` in ox_doorlock/convert/ and copy the Door Config from the README into it.

- Set to `cd` for cd_doorlock
- // Create a Group named `weed_shop_door` through the in-game menu and add the copy the Door Config from the README into it.
- Ensure the names of the doors correspond to the names of the doors below.

#### 1.5. Hacks

```lua
Config.DoorItem = 'thermite' -- Item to remove\check for when placing a charge
Config.ThermiteSettings = {
  time = 60, -- time the hack displays for
  gridsize = 5, -- (5, 6, 7, 8, 9, 10) size of grid by square units, ie. gridsize = 5 is a 5 * 5 (25) square grid
  incorrectBlocks = 10 -- incorrectBlocks = number of incorrect blocks after which the game will fail
}

Config.HackItem = 'phone' -- Item to remove\check for when hacking
Config.VarHackSettings = {
  blocks = 2, -- time the hack displays for
  time = 20 -- time the hack displays for
}
```

- The door item is the item you want to remove from the player when placing a charge.
- The thermite settings are the settings for the thermite hack.
- The hack item is the item you want to *check* for when hacking.
- The var hack settings are the settings for the variable hack.

#### 1.6. Skills

```lua
Config.Skills = {
  enabled = false, -- Enable Skills
  system = 'mz-skills', 
  ['Thermite'] = {
    skill = 'Heist Reputation', -- Skill to Use
    ['Limits'] = {
      xp = 800 -- XP Required to do the Task
    },
    ['Rewards'] = {
      xp = 10, -- XP to give on success
      multi = 1.5 -- Multiplier Based on Players Level
    }
  },
  ...
}
```

- Set `Config.Skills.enabled` to true to enable skills.
- Set `Config.Skills.system` to the name of the skills system you are using.
- Set `Config.Skills.[Task].skill` to the name of the skill you want to use.
- Set `Config.Skills.[Task].Limits.xp` to the amount of xp required to do the task.
- Set `Config.Skills.[Task].Rewards.xp` to the amount of xp you want to give on success.
- Set `Config.Skills.[Task].Rewards.multi` to the multiplier based on the players level/ current xp.

### 2. Door Configs

- Make a copy of the door config below and place it inside `qb-doorlocks/configs/` in it's own .lua file.

- **If using ox_doorlock, the file must be named `weed_shop_door` and can be placed in the convert folder.**

```lua
Config.DoorList['weed_hiest_2'] = {
    doorRate = 1.0,
    objCoords = vec3(375.830414, -821.028564, 29.448849),
    objYaw = 180.00001525879,
    locked = true,
    doorLabel = 'main',
    doorType = 'door',
    distance = 2,
    authorizedJobs = { ['police'] = 0 },
    objName = -311575617,
    fixText = false,
    lockpick = true,
}
Config.DoorList['weed_shop_door_1'] = {
    doorRate = 1.0,
    objCoords = vec3(381.421570, -825.162842, 29.453222),
    distance = 2,
    objYaw = 180.00003051758,
    fixText = false,
    pickable = true,
    authorizedJobs = { ['police'] = 0 },
    needsAllItems = false,
    locked = true,
    objName = -538477509,
    doorType = 'door',
}
```


