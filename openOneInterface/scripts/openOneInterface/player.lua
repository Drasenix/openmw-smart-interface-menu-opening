local core = require('openmw.core')
local input = require('openmw.input')
local I = require('openmw.interfaces')
local configPlayer = require('scripts.clickToCloseMenu.config.player')
local l10n = core.l10n('clickToCloseMenu')
local ui = require('openmw.ui')

local windows = {}

local function onKeyPress(key)      
   if key.code == input.KEY.I then
      table.insert(windows, 'Inventory')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == input.KEY.M then
      table.insert(windows, 'Map')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == input.KEY.O then
      table.insert(windows, 'Magic')
      I.UI.setMode('Interface', {windows = windows})
   end

   if key.code == input.KEY.H then
      table.insert(windows, 'Stats')
      I.UI.setMode('Interface', {windows = windows})
   end
end

return {
   engineHandlers = {
      onKeyPress = onKeyPress
   }
}
