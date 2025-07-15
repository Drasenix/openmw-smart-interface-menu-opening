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
    key = 'Settings/OpenOneInterface/KeyBindings/Atoms',
    page = 'OpenOneInterface',
    l10n = 'OpenOneInterface',
    name = 'ConfigKeybindingsAtoms',
    permanentStorage = true,
    settings = {        
        {
            key = 's_Key_Inventory',
            renderer = 'inputKeySelection',            
            name = 'Key_Inventory',
            description = 'Inventory',
            default = 0,
        },
        {
            key = 's_Key_Map',
            renderer = 'inputKeySelection',            
            name = 'Key_Map',
            description = 'Map',
            default = 0,
        },
        {
            key = 's_Key_Magic',
            renderer = 'inputKeySelection',            
            name = 'Key_Magic',
            description = 'Magic',
            default = 0,
        },
        {
            key = 's_Key_Stats',
            renderer = 'inputKeySelection',            
            name = 'Key_Stats',
            description = 'Stats',
            default = 0,
        },
    },
}

I.Settings.registerGroup {
    key = 'Settings/OpenOneInterface/KeyBindings/Pairs',
    page = 'OpenOneInterface',
    l10n = 'OpenOneInterface',
    name = 'ConfigKeybindingsPairs',
    permanentStorage = true,
    settings = {                
        {
            key = 's_Key_Inventory_Map',
            renderer = 'inputKeySelection',            
            name = 'Key_Inventory_Map',
            description = 'Inventory_Map',
            default = 0,           
        },
        {
            key = 's_Key_Inventory_Magic',
            renderer = 'inputKeySelection',            
            name = 'Key_Inventory_Magic',
            description = 'Inventory_Magic',
            default = 0,                        
        },
        {
            key = 's_Key_Inventory_Stats',
            renderer = 'inputKeySelection',            
            name = 'Key_Inventory_Stats',
            description = 'Inventory_Stats',
            default = 0,
        },
        {
            key = 's_Key_Map_Magic',
            renderer = 'inputKeySelection',            
            name = 'Key_Map_Magic',
            description = 'Map_Magic',
            default = 0,
        },
        {
            key = 's_Key_Magic_Stats',
            renderer = 'inputKeySelection',            
            name = 'Key_Magic_Stats',
            description = 'Magic_Stats',
            default = 0,
        },
    },
}

I.Settings.registerGroup {
    key = 'Settings/OpenOneInterface/KeyBindings/Trios',
    page = 'OpenOneInterface',
    l10n = 'OpenOneInterface',
    name = 'ConfigKeybindingsTrios',
    permanentStorage = true,
    settings = {                
        {
            key = 's_Key_Inventory_Map_Magic',
            renderer = 'inputKeySelection',            
            name = 'Key_Inventory_Map_Magic',
            description = 'Inventory_Map_Magic',
            default = 0,
        },
        {
            key = 's_Key_Inventory_Map_Stats',
            renderer = 'inputKeySelection',            
            name = 'Key_Inventory_Map_Stats',
            description = 'Inventory_Map_Stats',
            default = 0,
        },
        {
            key = 's_Key_Inventory_Magic_Stats',
            renderer = 'inputKeySelection',            
            name = 'Key_Inventory_Magic_Stats',
            description = 'Inventory_Magic_Stats',
            default = 0,
        },
    },
}
