local core = require('openmw.core')
local async = require('openmw.async')
local input = require('openmw.input')
local types = require('openmw.types')
local self = require('openmw.self')
local I = require('openmw.interfaces')
local configPlayer = require('scripts.smartInterfaceMenuOpening.config.player')
local ui = require('openmw.ui')

local menu_opened = false
local menus_opened = {}
local menus_requiring_pause = {}

local autoMove = false

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
   if I.UI.getMode() ~= nil and I.UI.getMode() ~= I.UI.MODE.Interface  then
      return false
   end
   return true
end

local function sendMenuEvent(menus_to_open)
   if not menu_opened or not menuAlreadyOpened(menus_opened, menus_to_open) then
      self:sendEvent('AddUiMode', {mode = I.UI.MODE.Interface, windows = menus_to_open})
   else
      self:sendEvent('SetUiMode', {})
   end
end

local function detectModesPauseSettings()
   menus_requiring_pause = {}
   menus_requiring_pause[I.UI.WINDOW.Inventory] = configPlayer.options_pauses.b_Pause_Inventory
   menus_requiring_pause[I.UI.WINDOW.Map] = configPlayer.options_pauses.b_Pause_Map
   menus_requiring_pause[I.UI.WINDOW.Magic] = configPlayer.options_pauses.b_Pause_Magic
   menus_requiring_pause[I.UI.WINDOW.Stats] = configPlayer.options_pauses.b_Pause_Stats
end

local function handlePauseForMenusToOpen(menus_to_open)
   I.UI.setPauseOnMode(I.UI.MODE.Interface, false)
   for key,value in pairs(menus_to_open) do
      if menus_requiring_pause[value] then
         I.UI.setPauseOnMode(I.UI.MODE.Interface, true)
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
      table.insert(menus_to_open, I.UI.WINDOW.Inventory)      
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_atoms.s_Key_Map then
      table.insert(menus_to_open, I.UI.WINDOW.Map)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_atoms.s_Key_Magic then
      table.insert(menus_to_open, I.UI.WINDOW.Magic)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_atoms.s_Key_Stats then
      table.insert(menus_to_open, I.UI.WINDOW.Stats)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_pairs.s_Key_Inventory_Map then
      table.insert(menus_to_open, I.UI.WINDOW.Inventory)
      table.insert(menus_to_open, I.UI.WINDOW.Map)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Magic then
      table.insert(menus_to_open, I.UI.WINDOW.Inventory)
      table.insert(menus_to_open, I.UI.WINDOW.Magic)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Inventory_Stats then
      table.insert(menus_to_open, I.UI.WINDOW.Inventory)
      table.insert(menus_to_open, I.UI.WINDOW.Stats)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end
   
   if key.code == configPlayer.options_pairs.s_Key_Map_Magic then
      table.insert(menus_to_open, I.UI.WINDOW.Map)
      table.insert(menus_to_open, I.UI.WINDOW.Magic)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_pairs.s_Key_Magic_Stats then
      table.insert(menus_to_open, I.UI.WINDOW.Magic)
      table.insert(menus_to_open, I.UI.WINDOW.Stats)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Magic then
      table.insert(menus_to_open, I.UI.WINDOW.Inventory)
      table.insert(menus_to_open, I.UI.WINDOW.Map)
      table.insert(menus_to_open, I.UI.WINDOW.Magic)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Map_Stats then
      table.insert(menus_to_open, I.UI.WINDOW.Inventory)
      table.insert(menus_to_open, I.UI.WINDOW.Map)
      table.insert(menus_to_open, I.UI.WINDOW.Stats)
      sendMenuEvent(menus_to_open)
      handlePauseForMenusToOpen(menus_to_open)
   end

   if key.code == configPlayer.options_trios.s_Key_Inventory_Magic_Stats then
      table.insert(menus_to_open, I.UI.WINDOW.Inventory)
      table.insert(menus_to_open, I.UI.WINDOW.Magic)
      table.insert(menus_to_open, I.UI.WINDOW.Stats)
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
   if menus_opened[I.UI.WINDOW.Inventory] == nil and data.newMode == I.UI.MODE.Container then
      menus_opened = {I.UI.WINDOW.Inventory, I.UI.WINDOW.Container}
      I.UI.setMode(I.UI.MODE.Container, menus_opened)
   end
end

local function resetMenuForInterface(data)
   if data.oldMode ~= nil and data.oldMode ~= I.UI.MODE.Interface and data.newMode == I.UI.MODE.Interface then
      self:sendEvent('AddUiMode', {mode = I.UI.MODE.Interface, windows = menus_opened})
   end
end

local function uiModeChanged(data)
   resetInventoryForContainer(data)
   resetMenuForInterface(data)
end

-- code taken from the open mw playercontrols.lua
local function controlsAllowed()
   return not core.isWorldPaused()
      and types.Player.getControlSwitch(self, types.Player.CONTROL_SWITCH.Controls)
      -- here i removed cndition
      -- and not I.UI.getMode()
end

-- code taken from the open mw playercontrols.lua
local function movementAllowed()
   return controlsAllowed() and not movementControlsOverridden
end

-- code taken from the open mw playercontrols.lua
input.registerTriggerHandler('AutoMove', async:callback(function()
   -- adding my condition not to control AutoMove from Interface Menu
   if not movementAllowed() or menu_opened then return end
      autoMove = not autoMove
   end)
)

local function handleMovement()
   if autoMove then
      self.controls.movement = 1
   end
end

return {
   engineHandlers = {
      onKeyPress = onKeyPress,
      onFrame = handleMovement
   },
   eventHandlers = {      
      AddUiMode = addUiMode,
      SetUiMode = setUiMode,
      UiModeChanged = uiModeChanged
   }
}
