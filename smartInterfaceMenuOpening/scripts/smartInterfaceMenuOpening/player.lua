local core = require('openmw.core')
local input = require('openmw.input')
local self = require('openmw.self')
local I = require('openmw.interfaces')
local configPlayer = require('scripts.smartInterfaceMenuOpening.config.player')
local ui = require('openmw.ui')

local menu_opened = false
local function onKeyPress(key)
   
   if key.code == input.KEY.Escape then
      menu_opened = false
   end

   if I.UI.getMode() ~= nil and I.UI.getMode() ~= 'Interface'  then
      return
   end

   windows = {}
   if key.code == configPlayer.options_atoms.s_Key_Inventory then
      table.insert(windows, 'Inventory')      
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else         
         self:sendEvent('SetUiMode', {})
      end
   end

   if key.code == configPlayer.options_atoms.s_Key_Map then
      table.insert(windows, 'Map')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end

   if key.code == configPlayer.options_atoms.s_Key_Magic then
      table.insert(windows, 'Magic')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end

   if key.code == configPlayer.options_atoms.s_Key_Stats then
      table.insert(windows, 'Stats')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end

   if key.code == configPlayer.options_pairs.s_Key_Inventory_Map then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Map')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Magic then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Magic')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Stats then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Stats')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Map_Magic then
      table.insert(windows, 'Map')
      table.insert(windows, 'Magic')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end

   if key.code == configPlayer.options_pairs.s_Key_Magic_Stats then
      table.insert(windows, 'Magic')
      table.insert(windows, 'Stats')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Magic then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Map')
      table.insert(windows, 'Magic')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Stats then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Map')
      table.insert(windows, 'Stats')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Magic_Stats then
      table.insert(windows, 'Inventory')
      table.insert(windows, 'Magic')
      table.insert(windows, 'Stats')
      if not menu_opened then
         self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows})
      else
         self:sendEvent('SetUiMode', {})
      end
   end
end

local function addUiMode(options)
   menu_opened = not menu_opened
end

local function setUiMode(options)
   if I.UI.getMode() ~= nil and I.UI.getMode() ~= 'Interface' then
      return
   end
   menu_opened = not menu_opened
end


return {
   engineHandlers = {
      onKeyPress = onKeyPress
   },
   eventHandlers = {      
      AddUiMode = addUiMode,
      SetUiMode = setUiMode
   },
}
