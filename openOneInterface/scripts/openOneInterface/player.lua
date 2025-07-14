local core = require('openmw.core')
local input = require('openmw.input')
local I = require('openmw.interfaces')
local configPlayer = require('scripts.clickToCloseMenu.config.player')
local l10n = core.l10n('clickToCloseMenu')
local ui = require('openmw.ui')

local function onKeyPress(key)
   
   if key.code == input.KEY.I then
      I.UI.setMode('Interface', {windows = {'Inventory'}})
   end

   if key.code == input.KEY.M then
      I.UI.setMode('Interface', {windows = {'Map'}})
   end

   if key.code == input.KEY.O then
      I.UI.setMode('Interface', {windows = {'Magic'}})
   end

   if key.code == input.KEY.H then
      I.UI.setMode('Interface', {windows = {'Stats'}})
   end

   
   
   
end

return {
   engineHandlers = {
      onKeyPress = onKeyPress
   }
}
