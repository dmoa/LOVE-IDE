local L = Object:extend()

function L:new()
    self.lookup = {
        ["and"]      = "name",
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
        ["..."]      = "operator"
    }
end

-- get syntax takes table of lines -> Editor stores table of lines
function L:getSyntax(lines)
    local syntax = {}

    for line in ipairs(lines) do
    end

    return syntax
end

return L