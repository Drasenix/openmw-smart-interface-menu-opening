local core = require('openmw.core')
local input = require('openmw.input')
local I = require('openmw.interfaces')
local configPlayer = require('scripts.openOneInterface.config.player')
local ui = require('openmw.ui')


local function onKeyPress(key)      
   windows = {}
   if key.code == configPlayer.options_atoms.s_Key_Inventory then
      table.insert(windows, 'Inventory')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == configPlayer.options_atoms.s_Key_Map then
      table.insert(windows, 'Map')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == configPlayer.options_atoms.s_Key_Spells then
      table.insert(windows, 'Magic')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == configPlayer.options_atoms.s_Key_Stats then
      table.insert(windows, 'Stats')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == configPlayer.options_pairs.s_Key_Inventory_Map then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Map')
      I.UI.setMode('Interface', {windows = windows})
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Magic then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Magic')
      I.UI.setMode('Interface', {windows = windows})
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Stats then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Stats')
      I.UI.setMode('Interface', {windows = windows})
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Map_Magic then
      table.insert(windows, 'Map')
      table.insert(windows, 'Magic')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == configPlayer.options_pairs.s_Key_Magic_Stats then
      table.insert(windows, 'Magic')
      table.insert(windows, 'Stats')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Magic then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Map')
      table.insert(windows, 'Magic')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Stats then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Map')
      table.insert(windows, 'Stats')
      I.UI.setMode('Interface', {windows = windows})
   end
end

return {
   engineHandlers = {
      onKeyPress = onKeyPress
   }
}
