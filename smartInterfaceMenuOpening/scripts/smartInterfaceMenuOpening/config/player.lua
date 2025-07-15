local async = require('openmw.async')
local storage = require('openmw.storage')

local options_atoms = storage.playerSection('Settings/SmartInterfaceMenuOpening/KeyBindings/Atoms')
local options_pairs = storage.playerSection('Settings/SmartInterfaceMenuOpening/KeyBindings/Pairs')
local options_trios = storage.playerSection('Settings/SmartInterfaceMenuOpening/KeyBindings/Trios')
local options_pauses = storage.playerSection('Settings/SmartInterfaceMenuOpening/PauseMenu')
local configPlayer = {}

local function updateConfig()
	configPlayer.options_atoms = options_atoms:asTable()
	configPlayer.options_pairs = options_pairs:asTable()
	configPlayer.options_trios = options_trios:asTable()
	configPlayer.options_pauses = options_pauses:asTable()
end

updateConfig()
options_atoms:subscribe(async:callback(updateConfig))
options_pairs:subscribe(async:callback(updateConfig))
options_trios:subscribe(async:callback(updateConfig))
options_pauses:subscribe(async:callback(updateConfig))

return configPlayer