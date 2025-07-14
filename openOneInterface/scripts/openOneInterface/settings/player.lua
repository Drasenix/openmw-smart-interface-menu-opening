local core = require('openmw.core')
local I = require('openmw.interfaces')

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
            key = 's_Click',
            renderer = 'select',
            name = 'Click',
            argument = {
                l10n = 'OpenOneInterface',
                items = {
                    'Right',
                    'Left',
                    'Middle',
                    'None'
                }
            },
            default = 'Right',
        }
    },
}