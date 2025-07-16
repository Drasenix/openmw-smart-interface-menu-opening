local core = require('openmw.core')
local async = require('openmw.async')
local input = require('openmw.input')
local types = require('openmw.types')
local self = require('openmw.self')
local storage = require('openmw.storage')
local I = require('openmw.interfaces')
local configPlayer = require('scripts.smartInterfaceMenuOpening.config.player')
local ui = require('openmw.ui')
local settings = storage.playerSection('SettingsOMWControls')

local menu_opened = false
local menus_opened = {}
local interface_menus_requiring_pause = {}
local other_modes_menus_requiring_pause = {}

local autoMove = false
local attemptToJump = false

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

local function detectInterfaceMenusPauseSettings()
   interface_menus_requiring_pause = {}
   interface_menus_requiring_pause[I.UI.WINDOW.Inventory] = configPlayer.options_pauses.b_Pause_Inventory
   interface_menus_requiring_pause[I.UI.WINDOW.Map] = configPlayer.options_pauses.b_Pause_Map
   interface_menus_requiring_pause[I.UI.WINDOW.Magic] = configPlayer.options_pauses.b_Pause_Magic
   interface_menus_requiring_pause[I.UI.WINDOW.Stats] = configPlayer.options_pauses.b_Pause_Stats   
end

local function detectOtherModesMenusPauseSettings()
   other_modes_menus_requiring_pause = {}
   other_modes_menus_requiring_pause[I.UI.WINDOW.Journal] = configPlayer.options_pauses.b_Pause_Journal
   other_modes_menus_requiring_pause[I.UI.WINDOW.Book] = configPlayer.options_pauses.b_Pause_Book
   other_modes_menus_requiring_pause[I.UI.WINDOW.Scroll] = configPlayer.options_pauses.b_Pause_Scroll
   other_modes_menus_requiring_pause[I.UI.WINDOW.Alchemy] = configPlayer.options_pauses.b_Pause_Alchemy
   other_modes_menus_requiring_pause[I.UI.WINDOW.QuickKeys] = configPlayer.options_pauses.b_Pause_QuickKeysMenu
   other_modes_menus_requiring_pause[I.UI.WINDOW.Repair] = configPlayer.options_pauses.b_Pause_Repair
end

local function handlePauseForMenusToOpen(menus_to_open)
   I.UI.setPauseOnMode(I.UI.MODE.Interface, false)
   for key,value in pairs(menus_to_open) do
      if interface_menus_requiring_pause[value] then
         I.UI.setPauseOnMode(I.UI.MODE.Interface, true)
         return      
      end
   end
end

local function handlePauseForModes()
   I.UI.setPauseOnMode(I.UI.MODE.Journal, other_modes_menus_requiring_pause[I.UI.WINDOW.Journal])
   I.UI.setPauseOnMode(I.UI.MODE.Book, other_modes_menus_requiring_pause[I.UI.WINDOW.Book])
   I.UI.setPauseOnMode(I.UI.MODE.Scroll, other_modes_menus_requiring_pause[I.UI.WINDOW.Scroll])
   I.UI.setPauseOnMode(I.UI.MODE.Alchemy, other_modes_menus_requiring_pause[I.UI.WINDOW.Alchemy])
   I.UI.setPauseOnMode(I.UI.MODE.QuickKeysMenu, other_modes_menus_requiring_pause[I.UI.WINDOW.QuickKeys])
   I.UI.setPauseOnMode(I.UI.MODE.Repair, other_modes_menus_requiring_pause[I.UI.WINDOW.Repair])
end


local function onKeyPress(key)
   detectInterfaceMenusPauseSettings()
   detectOtherModesMenusPauseSettings()
   
   if key.code == input.KEY.Escape then
      menu_opened = false
   end

   if not isDisplayMenuAuthorized() then
      return
   end

   handlePauseForModes()

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
   mode = I.UI.getMode()
   isModeForbiden = false
   if mode then
      isModeForbiden = 
      mode ~= I.UI.MODE.Interface and 
      mode ~= I.UI.MODE.Journal and 
      mode ~= I.UI.MODE.Book and 
      mode ~= I.UI.MODE.Scroll and 
      mode ~= I.UI.MODE.Alchemy and 
      mode ~= I.UI.MODE.QuickKeysMenu and 
      mode ~= I.UI.MODE.Repair
   end
   
   return not core.isWorldPaused()
      and types.Player.getControlSwitch(self, types.Player.CONTROL_SWITCH.Controls)
      and not isModeForbiden
end

-- code taken from the open mw playercontrols.lua
local function movementAllowed()   
   return controlsAllowed() and not movementControlsOverridden
end

-- code taken from the open mw playercontrols.lua
input.registerTriggerHandler('AutoMove', async:callback(function()
   if not movementAllowed() then return end
   autoMove = not autoMove
end))

-- code taken from the open mw playercontrols.lua
input.registerTriggerHandler('Jump', async:callback(function()
   if not movementAllowed() then return end
   attemptToJump = types.Player.getControlSwitch(self, types.Player.CONTROL_SWITCH.Jumping)
end))

-- code taken from the open mw playercontrols.lua
input.registerTriggerHandler('AlwaysRun', async:callback(function()
   if not movementAllowed() then return end
   settings:set('alwaysRun', not settings:get('alwaysRun'))
end))

-- code taken from the open mw playercontrols.lua
local function handleMovement()
   if not movementAllowed() then
      return
   end
   local movement = input.getRangeActionValue('MoveForward') - input.getRangeActionValue('MoveBackward')
   local sideMovement = input.getRangeActionValue('MoveRight') - input.getRangeActionValue('MoveLeft')
   local run = input.getBooleanActionValue('Run') ~= settings:get('alwaysRun')

   if movement ~= 0 then
      autoMove = false
   elseif autoMove then
      movement = 1
   end

   self.controls.movement = movement
   self.controls.sideMovement = sideMovement
   self.controls.run = run
   self.controls.jump = attemptToJump

   attemptToJump = false
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
