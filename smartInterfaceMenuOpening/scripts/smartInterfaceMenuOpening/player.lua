local core = require('openmw.core')
local input = require('openmw.input')
local self = require('openmw.self')
local I = require('openmw.interfaces')
local configPlayer = require('scripts.smartInterfaceMenuOpening.config.player')
local ui = require('openmw.ui')

local menu_opened = false
local windows_opened = {}

local function windowAlreadyOpened(windowsOpened, windowsToOpen)
   for opened_key,opened_value in pairs(windowsOpened) do
      for to_open_key,to_open_value in pairs(windowsToOpen) do
         if opened_value == to_open_value then
            return true
         end
      end
   end
   return false
end

local function isDisplayMenuAuthorized()
   if I.UI.getMode() ~= nil and I.UI.getMode() ~= 'Interface'  then
      return false
   end
   return true
end

local function sendWindowEvent(windows_to_open)
   if not menu_opened or not windowAlreadyOpened(windows_opened, windows_to_open) then
      self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows_to_open})
   else
      self:sendEvent('SetUiMode', {})
   end
end

local function onKeyPress(key)
   
   if key.code == input.KEY.Escape then
      menu_opened = false
   end

   if not isDisplayMenuAuthorized() then
      return
   end

   windows_to_open = {}
   if key.code == configPlayer.options_atoms.s_Key_Inventory then
      table.insert(windows_to_open, 'Inventory')      
      sendWindowEvent(windows_to_open)
   end

   if key.code == configPlayer.options_atoms.s_Key_Map then
      table.insert(windows_to_open, 'Map')
      sendWindowEvent(windows_to_open)
   end

   if key.code == configPlayer.options_atoms.s_Key_Magic then
      table.insert(windows_to_open, 'Magic')
      sendWindowEvent(windows_to_open)
   end

   if key.code == configPlayer.options_atoms.s_Key_Stats then
      table.insert(windows_to_open, 'Stats')
      sendWindowEvent(windows_to_open)
   end

   if key.code == configPlayer.options_pairs.s_Key_Inventory_Map then
      table.insert(windows_to_open, 'Inventory')
      table.insert(windows_to_open, 'Map')
      sendWindowEvent(windows_to_open)
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Magic then
      table.insert(windows_to_open, 'Inventory')
      table.insert(windows_to_open, 'Magic')
      sendWindowEvent(windows_to_open)
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Stats then
      table.insert(windows_to_open, 'Inventory')
      table.insert(windows_to_open, 'Stats')
      sendWindowEvent(windows_to_open)
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Map_Magic then
      table.insert(windows_to_open, 'Map')
      table.insert(windows_to_open, 'Magic')
      sendWindowEvent(windows_to_open)
   end

   if key.code == configPlayer.options_pairs.s_Key_Magic_Stats then
      table.insert(windows_to_open, 'Magic')
      table.insert(windows_to_open, 'Stats')
      sendWindowEvent(windows_to_open)
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Magic then
      table.insert(windows_to_open, 'Inventory')
      table.insert(windows_to_open, 'Map')
      table.insert(windows_to_open, 'Magic')
      sendWindowEvent(windows_to_open)
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Stats then
      table.insert(windows_to_open, 'Inventory')
      table.insert(windows_to_open, 'Map')
      table.insert(windows_to_open, 'Stats')
      sendWindowEvent(windows_to_open)
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Magic_Stats then
      table.insert(windows_to_open, 'Inventory')
      table.insert(windows_to_open, 'Magic')
      table.insert(windows_to_open, 'Stats')
      sendWindowEvent(windows_to_open)
   end
end

local function addUiMode(options)
   menu_opened = true
   windows_opened = options.windows
end

local function setUiMode(options)
   menu_opened = false
end

local function resetInventoryForContainer(data)
   if windows_opened['Inventory'] == nil and data.newMode == "Container" then
      windows_opened = {'Inventory', 'Container'}
      I.UI.setMode('Container', windows_opened)
   end
end

local function resetMenuForInterface(data)
   if data.oldMode ~= nil and data.oldMode ~= 'Interface' and data.newMode == "Interface" then
      self:sendEvent('AddUiMode', {mode = 'Interface', windows = windows_opened})
   end
end

local function uiModeChanged(data)
   resetInventoryForContainer(data)
   resetMenuForInterface(data)
end

return {
   engineHandlers = {
      onKeyPress = onKeyPress
   },
   eventHandlers = {      
      AddUiMode = addUiMode,
      SetUiMode = setUiMode,
      UiModeChanged = uiModeChanged
   }
}
