local core = require('openmw.core')
local UI = require('openmw.interfaces').UI
local configPlayer = require('scripts.clickToCloseMenu.config.player')
local l10n = core.l10n('clickToCloseMenu')


local function onMouseButtonPress(button)
   print("button pressed")  
end

return {
   engineHandlers = {
      onMouseButtonPress = onMouseButtonPress
   }
}
