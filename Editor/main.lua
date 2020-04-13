local Luacheck = require("luacheck")
local Lexer = require("luacheck.lexer")
local CheckState = require("luacheck.check_state")
local Decoder = require("luacheck.decoder")

love.graphics.setBackgroundColor(0.18, 0.20, 0.25)
love.graphics.setFont(love.graphics.newFont("FiraCode-Regular.ttf", 30))

local file = {}
local cursor = {
    line = 1,
    pos  = 1,
}

local logs = {}
local tokens = {}

function love.load()
end

function love.update(dt)
end

local colors = {
    ["keyword"] = {0.71, 0.56, 0.68},
    ["name"] = {0.92, 0.80, 0.55},
    ["operator"] = {0.93, 0.94, 0.96},
    ["text"] = {0.93, 0.94, 0.96},
    ["number"] = {0.64, 0.75, 0.55},
    ["string"] = {0.64, 0.75, 0.55},
}

local lookup = {
    ["name"] = "name",
    ["local"] = "keyword",
    ["="] = "operator",
    ["number"] = "number",
    ["("] = "operator",
    [")"] = "operator",
    ["while"] = "keyword",
    ["for"] = "keyword",
    [","] = "text",
    ["do"] = "keyword",
    ["end"] = "keyword",
    ["string"] = "string",
    [">"] = "operator",
    ["if"] = "keyword",
    ["then"] = "keyword",
    [">="] = "operator",
    ["=="] = "operator",
}

function love.draw()
    local src = ""
    for i, line in ipairs(file) do
        if i ~= 1 then
            src = src .. " "
        end
        src = src .. line
    end

    local x = 0
    local y = 0

    local startPos = 1
    local currLine = 1

    local drawPos = 0

    for i, token in ipairs(tokens) do
        local type = colors["text"]

        if (token.token == nil) then
            type = "string"
        end
        if (lookup[token.token]) then
            type = lookup[token.token]
        end

        local color = colors[type]
        love.graphics.setColor(color)

        local cStartPos = startPos
        if (token.line ~= currLine) then
            currLine = token.line
            cStartPos = cStartPos + 1
            --startPos = 1
            drawPos = 0
        end

        local line = currLine
        local endPos = token.pos

        local str = src:sub(cStartPos, endPos - 1)

        if (line == 2) then
            print("<"..str..">", endPos)
        end

        startPos = token.pos

        love.graphics.print(str, drawPos, (line - 1) * 32 + 5)
        drawPos = drawPos + love.graphics.getFont():getWidth(str)

        
    end

    for i, log in ipairs(logs) do
        love.graphics.print(log, 5, (i - 1) * 14 + 150)
    end
end

function love.textinput(t)
    if not file[cursor.line] then
        file[cursor.line] = ""
    end

    local line = file[cursor.line]
    line = string.sub(line, 1, cursor.pos - 1) .. t .. string.sub(line, cursor.pos)
    file[cursor.line] = line

    cursor.pos = cursor.pos + 1

    lint()
end

function love.keypressed(key)
    if (key == "return") then
        cursor.line = cursor.line + 1

        table.insert(file, cursor.line, "")
        cursor.pos = 1

        lint()
    end

    if (key == "backspace") then
        local line = file[cursor.line]
        line = string.sub(line, 1, cursor.pos - 2) .. string.sub(line, cursor.pos)
        file[cursor.line] = line

        cursor.pos = cursor.pos - 1

        lint()
    end
end

function lint()
    logs = {}

    local src = ""
    for i, line in ipairs(file) do
        if i ~= 1 then
            src = src .. "\n"
        end
        src = src .. line
    end

    local report = Luacheck.get_report(src)
    for _, warning in pairs(report.warnings) do
        table.insert(logs, warning.msg)
    end

    local checkState = CheckState.new(src)
    local real_src = Decoder.decode(checkState.source_bytes)

    local lexer = Lexer.new_state(real_src)
    tokens = {}

    while true do
        local full_token = {}

        token = Lexer.next_token(lexer)
        full_token.token = token

        if token == "eof" then
            break
        end

        full_token.line = lexer.line
        full_token.pos = lexer.offset

        table.insert(tokens, full_token)
    end
end