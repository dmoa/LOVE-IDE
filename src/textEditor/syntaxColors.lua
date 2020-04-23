local Colors = require("src.util.colors")

local SyntaxColors = {
    ["default"]  = Colors.HEXToRGB("#ECEFF4"),
    ["keyword"]  = Colors.HEXToRGB("#B48EAD"),
    ["operator"] = Colors.HEXToRGB("#ECEFF4"),
    ["string"]   = Colors.HEXToRGB("#A3BE8C"),
    ["name"]     = Colors.HEXToRGB("#BF616A"),
    ["number"]   = Colors.HEXToRGB("#A3BE8C")
}

function SyntaxColors.get(tokenKey)
    return SyntaxColors[tokenKey]
end

return SyntaxColors