local core = require('openmw.core')
local input = require('openmw.input')
local self = require('openmw.self')
local I = require('openmw.interfaces')
local configPlayer = require('scripts.smartInterfaceMenuOpening.config.player')
local ui = require('openmw.ui')

local menu_opened = false
local menus_opened = {}
local menus_requiring_pause = {}

local function menuAlreadyOpened(menusOpened, menusToOpen)
   for opened_key,opened_value in pairs(menusOpened) do
      for to_open_key,to_open_value in pairs(menusToOpen) do
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

local function sendMenuEvent(menus_to_open)
   if not menu_opened or not menuAlreadyOpened(menus_opened, menus_to_open) then
      self:sendEvent('AddUiMode', {mode = 'Interface', windows = menus_to_open})
   else
      self:sendEvent('SetUiMode', {})
   end
end

local function detectModesPauseSettings()
   menus_requiring_pause = {}
   menus_requiring_pause['Inventory'] = configPlayer.options_pauses.b_Pause_Inventory
   menus_requiring_pause['Map'] = configPlayer.options_pauses.b_Pause_Map
   menus_requiring_pause['Magic'] = configPlayer.options_pauses.b_Pause_Magic
   menus_requiring_pause['Stats'] = configPlayer.options_pauses.b_Pause_Stats
end

local function handlePauseForMenusToOpen(menus_to_open)
   I.UI.setPauseOnMode("Interface", false)
   for key,value in pairs(menus_to_open) do
      if menus_requiring_pause[value] then
         I.UI.setPauseOnMode("Interface", true)
         return      
      end
   end
end

local function onKeyPress(key)
   detectModesPauseSettings()

   if key.code == input.KEY.Escape then
      menu_opened = false
   end

   if not isDisplayMenuAuthorized() then
      return
   end

   menus_to_open = {}
   if key.code == configPlayer.options_atoms.s_Key_Inventory then
      table.insert(menus_to_open, 'Inventory')      
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_atoms.s_Key_Map then
      table.insert(menus_to_open, 'Map')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_atoms.s_Key_Magic then
      table.insert(menus_to_open, 'Magic')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_atoms.s_Key_Stats then
      table.insert(menus_to_open, 'Stats')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_pairs.s_Key_Inventory_Map then
      table.insert(menus_to_open, 'Inventory')
      table.insert(menus_to_open, 'Map')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Magic then
      table.insert(menus_to_open, 'Inventory')
      table.insert(menus_to_open, 'Magic')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Stats then
      table.insert(menus_to_open, 'Inventory')
      table.insert(menus_to_open, 'Stats')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Map_Magic then
      table.insert(menus_to_open, 'Map')
      table.insert(menus_to_open, 'Magic')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_pairs.s_Key_Magic_Stats then
      table.insert(menus_to_open, 'Magic')
      table.insert(menus_to_open, 'Stats')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Magic then
      table.insert(menus_to_open, 'Inventory')
      table.insert(menus_to_open, 'Map')
      table.insert(menus_to_open, 'Magic')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Stats then
      table.insert(menus_to_open, 'Inventory')
      table.insert(menus_to_open, 'Map')
      table.insert(menus_to_open, 'Stats')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Magic_Stats then
      table.insert(menus_to_open, 'Inventory')
      table.insert(menus_to_open, 'Magic')
      table.insert(menus_to_open, 'Stats')
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end
end

local function addUiMode(options)
   menu_opened = true
   menus_opened = options.windows
end

local function setUiMode(options)
   menu_opened = false
end

local function resetInventoryForContainer(data)
   if menus_opened['Inventory'] == nil and data.newMode == "Container" then
      menus_opened = {'Inventory', 'Container'}
      I.UI.setMode('Container', menus_opened)
   end
end

local function resetMenuForInterface(data)
   if data.oldMode ~= nil and data.oldMode ~= 'Interface' and data.newMode == "Interface" then
      self:sendEvent('AddUiMode', {mode = 'Interface', windows = menus_opened})
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
