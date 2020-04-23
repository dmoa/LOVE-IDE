local SyntaxLookup = {
    lookup = {},
}

local keywords = {
    "and",
    "break",
    "do",
    "else",
    "elseif",
    "end",
    "false",
    "for",
    "function",
    "if",
    "in",
    "local",
    "nil",
    "not",
    "or",
    "repeat",
    "return",
    "then",
    "true",
    "until",
    "while",
}

local operators = {
    "+",
    "-",
    "*",
    "/",
    "%",
    "^",
    "#",
    "==",
    "~=",
    "<=",
    ">=",
    "<",
    ">",
    "=",
    "(",
    ")",
    "{",
    "}",
    "[",
    "]",
    ";",
    ":",
    ",",
    ".",
    "..",
    "...",
}

function SyntaxLookup.loadTableIntoLookupTable(name, table)
    for _, tokenName in ipairs(table) do
        SyntaxLookup.lookup[tokenName] = name
    end
end

function SyntaxLookup.buildLookupTable()
    SyntaxLookup.lookup = {}

    SyntaxLookup.loadTableIntoLookupTable("keyword", keywords)
    SyntaxLookup.loadTableIntoLookupTable("operator", operators)
end

function SyntaxLookup.get(tokenName)
    return SyntaxLookup.lookup[tokenName]
end

SyntaxLookup.buildLookupTable()
return SyntaxLookup