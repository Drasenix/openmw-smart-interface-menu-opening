local core = require('openmw.core')
local I = require('openmw.interfaces')
local input = require("openmw.input")

local l10n = core.l10n('OpenOneInterface')
local versionString = "1.0.0"

-- Settings page
I.Settings.registerPage {
    key = 'OpenOneInterface',
    l10n = 'OpenOneInterface',
    name = 'ConfigTitle',
    description = l10n('ConfigSummary'):gsub('%%{version}', versionString),
}

I.Settings.registerGroup {
    key = 'Settings/OpenOneInterface/ClientOptions',
    page = 'OpenOneInterface',
    l10n = 'OpenOneInterface',
    name = 'ConfigCategoryClientOptions',
    permanentStorage = true,
    settings = {        
        {
            key = 's_Key_Inventory',
            renderer = 'inputKeySelection',
            argument = {},
            name = 'Key_Inventory',
            description = 'Inventory',
            default = input.KEY.I,
        },
        {
            key = 's_Key_Map',
            renderer = 'inputKeySelection',
            argument = {},
            name = 'Key_Map',
            description = 'Map',
            default = input.KEY.M,
        },
        {
            key = 's_Key_Spells',
            renderer = 'inputKeySelection',
            argument = {},
            name = 'Key_Spells',
            description = 'Spells',
            default = input.KEY.O,
        },
        {
            key = 's_Key_Stats',
            renderer = 'inputKeySelection',
            argument = {},
            name = 'Key_Stats',
            description = 'Stats',
            default = input.KEY.H,
        },
    },
}