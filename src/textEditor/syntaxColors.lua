local Colors = require("src.util.colors")


-- Tjakka5!!!!!
-- make this load in from settings.lua, or a settingsparser.lua

local SyntaxColors = {
    ["default"]  = Colors.HEXToRGB("#ECEFF4"),
    ["keyword"]  = Colors.HEXToRGB("#B48EAD"),
    ["operator"] = Colors.HEXToRGB("#ECEFF4"),
    ["string"]   = Colors.HEXToRGB("#A3BE8C"),
    ["name"]     = Colors.HEXToRGB("#BF616A"),
    ["number"]   = Colors.HEXToRGB("#A3BE8C"),
    ["comment"]  = Colors.HEXToRGB("#4C556A"),
}

function SyntaxColors.get(tokenKey)
    return SyntaxColors[tokenKey]
end

return SyntaxColors