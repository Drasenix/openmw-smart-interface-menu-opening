local async = require('openmw.async')
local storage = require('openmw.storage')

local options_atoms = storage.playerSection('Settings/OpenOneInterface/KeyBindings/Atoms')
local options_pairs = storage.playerSection('Settings/OpenOneInterface/KeyBindings/Pairs')
local options_trios = storage.playerSection('Settings/OpenOneInterface/KeyBindings/Trios')
local options_quatuors = storage.playerSection('Settings/OpenOneInterface/KeyBindings/Quatuors')
local configPlayer = {}

local function updateConfig()
	configPlayer.options_atoms = options_atoms:asTable()
	configPlayer.options_pairs = options_pairs:asTable()
	configPlayer.options_trios = options_trios:asTable()
	configPlayer.options_quatuors = options_quatuors:asTable()
end

updateConfig()
options_atoms:subscribe(async:callback(updateConfig))
options_pairs:subscribe(async:callback(updateConfig))
options_trios:subscribe(async:callback(updateConfig))
options_quatuors:subscribe(async:callback(updateConfig))

return configPlayer