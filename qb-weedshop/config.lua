Config = Config or {}

Config.OneStore = true -- Set to true if using just the main Vangelico's Weedshoplers
Config.Cooldown = 1 * (60 * 2000) -- where x is minutes ie. x * (60 * 2000) \\ For door auto lock function
Config.Timeout = 45 * (60 * 2000) -- where x is minutes ie. x * (60 * 2000) \\ For case smashing cooldown
Config.AutoLock = true -- Set to false if you don't want the doors to auto lock/lock at all
Config.RequiredCops = 0

Config.weedshopHours = { -- Store Hours
  range = { -- Set both to 0 if you want the store to be robbed 24/7
    open = 6, -- When the doors unlock // Default 6am
    close = 18 -- When they lock for the night // Default 6pm
  },
  alertnight = {
    start = 18, -- The start of higher chance alerts in the evening // Default 6pm
    fin = 20 -- The end of higher chance alerts in the evening // Default 8pm
  },
  alertmorn = {
    start = 4, -- The start of higher chance alerts in the morning // Default 4am
    fin = 6 -- The end of higher chance alerts in the morning // Default 6am
  }
}

Config.Dispatch = 'ps' -- Police Dispatch System 
--[[ 
  Set to 'ps' for police-script 
  Set to 'qb' for base qb-policejob alerts 
  Set to 'cd' for cd_policealerts
]]--

Config.DoorLock = 'qb' -- Doorlock System
if Config.DoorLock == 'ox' then -- Don't touch this
  Config.DoorGroup = 'weed_shop_door' -- Doorlock System Extra Name // For ox_doorlock of the default config provided doesn't work
end
--[[
  Set to 'qb' for qb-doorlock  
  // Create a file named `Weedshoplery_stores` in qb-doorlock/config/ and copy the Door Config from the README into it.
  Set to 'ox' for ox_doorlock 
  // Uncomment '@ox_lib/init.lua' from the fxmanifest.lua, create a file named `weed_shop_door` in ox_doorlock/config/ and copy the Door Config from the README into it.
]]--

if Config.OneStore then -- Don't touch this
  Config.HackEffect = 'disableCam' -- Set to 'disableAlarm' to disable police alerts or 'disableCam' to disable cameras
end -- Don't touch this

Config.Stores = {
  [1] = {
    label = 'Weed Shop ',
    coords = vector3(379.14, -830.94, 29.47),
    ['Doors'] = {
      main = 'weed_shop_door_1',
      sec = 'weed_hiest_2'
    },
    ['Thermite'] = {
      --  \\ Rooftop Thermite --
      coords = vector3(372.45, -825.18, 29.29),
      h = 300.0,
      minZ=26.69,
      maxZ=30.69,
      anim = vector4(372.0, -825.11, 29.29, 266.61), 
      effect = vector3(372.04, -825.1, 29.29)
    },
    ['Hack'] = {
      --\\ PC Hack  --
      coords = vector3(00.0, -821.35, 29.3),
      h = 2.93,
      minZ = 37.56,
      maxZ = 38.56,
      anim = vector4(00.0, -821.4, 29.3, 3.19)
    },
    hit = false, -- Don't touch this
    hacked = false -- Don't touch this
  }
}

Config.DoorItem = 'thermite' -- item to remove\check for when placing a charge
Config.ThermiteSettings = {
  time = 60, -- time the hack displays for \\ half being showing the puzzle and the other solving
  gridsize = 5, -- (5, 6, 7, 8, 9, 10) size of grid by square units, ie. gridsize = 5 is a 5 * 5 (25) square grid
  incorrectBlocks = 10 -- incorrectBlocks = number of incorrect blocks after which the game will fail
}

Config.HackItem = 'phone' -- item to remove\check for when hacking
Config.VarHackSettings = {
  blocks = 2, -- time the hack displays for \\ half being showing the puzzle and the other solving
  time = 20 -- time the hack displays for
}

Config.WhitelistedWeapons = {
  [`weapon_assaultrifle`] = {
    timeOut = 5000
  },
  [`weapon_carbinerifle`] = {
    timeOut = 5000
  },
  [`weapon_pumpshotgun`] = {
    timeOut = 5000
  },
  [`weapon_sawnoffshotgun`] = {
    timeOut = 5000
  },
  [`weapon_compactrifle`] = {
    timeOut = 5000
  },
  [`weapon_autoshotgun`] = {
    timeOut = 5000
  },
  [`weapon_crowbar`] = {
    timeOut = 5000
  },
  [`weapon_pistol`] = {
    timeOut = 5000
  },
  [`weapon_pistol_mk2`] = {
    timeOut = 5000
  },
  [`weapon_combatpistol`] = {
    timeOut = 5000
  },
  [`weapon_appistol`] = {
    timeOut = 5000
  },
  [`weapon_pistol50`] = {
    timeOut = 5000
  }, 
  [`weapon_microsmg`] = {
    timeOut = 5000
  },
}

Config.VitrineRewards = {
  [1] = {
    item = 'weed_white-widow',
    ['Amounts'] = {
      min = 19,
      max = 33
    }
  },
  [2] = {
    item = 'marijuana',
    ['Amounts'] = {
      min = 22,
      max = 50
    }
  },
  [3] = {
    item = 'cannabis',
    ['Amounts'] = {
      min = 90,
      max = 199
    }
  }
}

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
  ['Hack'] = {
    skill = 'Hacking',
    ['Limits'] = {
      xp = 1600
    },
    ['Rewards'] = {
      xp = 25,
      multi = 2.5
    }
  },
  ['Vitrine'] = {
    skill = 'Heist Reputation',
    ['Limits'] = {
      xp = 0
    },
    ['Rewards'] = {
      xp = 5,
      multi = 1.25
    }
  }
}

Config.Vitrines = {
  [1] = {
    coords = vector3(375.61, -826.79, 29.3),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [2] = {
    coords = vector3(380.15, -826.71, 29.3),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab4_start`,
    propEnd = `des_Weedshop_cab4_end`
  },
  [3] = {
    coords = vector3(382.66, -816.57, 29.3),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab_start`,
    propEnd = `des_Weedshop_cab_end`
  },
  [4] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab_start`,
    propEnd = `des_Weedshop_cab_end`
  },
  [5] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [6] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab2_start`,
    propEnd = `des_Weedshop_cab2_end`
  },
  [7] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab4_start`,
    propEnd = `des_Weedshop_cab4_end`
  },
  [8] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab_start`,
    propEnd = `des_Weedshop_cab_end`
  },
  [9] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab_start`,
    propEnd = `des_Weedshop_cab_end`
  },
  [10] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [11] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab4_start`,
    propEnd = `des_Weedshop_cab4_end`
  },
  [12] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab2_start`,
    propEnd = `des_Weedshop_cab2_end`
  },
  [13] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [14] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab_start`,
    propEnd = `des_Weedshop_cab_end`
  },
  [15] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [16] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab2_start`,
    propEnd = `des_Weedshop_cab2_end`
  },
  [17] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab_start`,
    propEnd = `des_Weedshop_cab_end`
  },
  [18] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab4_start`,
    propEnd = `des_Weedshop_cab4_end`
  },
  [19] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [20] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab2_start`,
    propEnd = `des_Weedshop_cab2_end`
  },
  [21] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab4_start`,
    propEnd = `des_Weedshop_cab4_end`
  },
  [22] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [23] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab_start`,
    propEnd = `des_Weedshop_cab_end`
  },
  [24] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab2_start`,
    propEnd = `des_Weedshop_cab2_end`
  },
  [25] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [26] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [27] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab4_start`,
    propEnd = `des_Weedshop_cab4_end`
  },
  [28] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [29] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab_start`,
    propEnd = `des_Weedshop_cab_end`
  },
  [30] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab2_start`,
    propEnd = `des_Weedshop_cab2_end`
  },
  [31] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  },
  [32] = {
    coords = vector3(0.0, -0, 0.0),
    isOpened = false,
    isBusy = false,
    propStart = `des_Weedshop_cab3_start`,
    propEnd = `des_Weedshop_cab3_end`
  }
}

Config.MaleNoHandshoes = {
  [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true
}

Config.FemaleNoHandshoes = {
  [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true
}
