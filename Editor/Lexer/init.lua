local L = Object:extend()

function L:new()
    self.lookup = {
        ["and"]      = "keyword",
        ["break"]    = "keyword",
        ["do"]       = "keyword",
        ["else"]     = "keyword",
        ["elseif"]   = "keyword",
        ["end"]      = "keyword",
        ["false"]    = "keyword",
        ["for"]      = "keyword",
        ["function"] = "keyword",
        ["if"]       = "keyword",
        ["in"]       = "keyword",
        ["local"]    = "keyword",
        ["nil"]      = "keyword",
        ["not"]      = "keyword",
        ["or"]       = "keyword",
        ["repeat"]   = "keyword",
        ["return"]   = "keyword",
        ["then"]     = "keyword",
        ["true"]     = "keyword",
        ["until"]    = "keyword",
        ["while"]    = "keyword",
        ["+"]        = "operator",
        ["-"]        = "operator",
        ["*"]        = "operator",
        ["/"]        = "operator",
        ["%"]        = "operator",
        ["^"]        = "operator",
        ["#"]        = "operator",
        ["=="]       = "operator",
        ["~="]       = "operator",
        ["<="]       = "operator",
        [">="]       = "operator",
        ["<"]        = "operator",
        ["<"]        = "operator",
        ["="]        = "operator",
        ["("]        = "operator",
        [")"]        = "operator",
        ["{"]        = "operator",
        ["}"]        = "operator",
        ["["]        = "operator",
        ["]"]        = "operator",
        [";"]        = "operator",
        [":"]        = "operator",
        [","]        = "operator",
        ["."]        = "operator",
        [".."]       = "operator",
        ["..."]      = "operator",
        ["--"]       = "comment"
    }
    self.syntaxColors = {
        ["keyword"]  = colors:to_rgb(colors.default[8], true),
        ["operator"] = colors:to_rgb(colors.default[11], true),
        ["comment"]  = colors:to_rgb(colors.default[10], true),
        ["other"]    = colors:to_rgb(colors.default[7], true)
    }
end

-- get syntax takes table of lines -> Editor stores table of lines
function L:getColoredText(file)
    local coloredText = {}
    for _, line in ipairs(file) do
        if line ~= "" then
            for word in line:gmatch("%S+") do
                local type = self.lookup[word] and self.lookup[word] or "other"
                table.insert(coloredText, self.syntaxColors[type])
                table.insert(coloredText, word)
                -- for loop, line -> table of words
                -- adding back the empty spaces for "rendering"
                table.insert(coloredText, self.syntaxColors[type])
                table.insert(coloredText, " ")
            end
        end
        table.insert(coloredText, self.syntaxColors["other"])
        table.insert(coloredText, "\n")
    end

    return #coloredText > 2 and coloredText or ""
end

return L