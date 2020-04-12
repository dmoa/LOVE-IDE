local Luacheck = require("luacheck")

local file = {}
local cursor = {
    line = 1,
    pos  = 1,
}

local logs = {}

function love.load()
end

function love.update(dt)
end

function love.draw()
    for i, line in ipairs(file) do
        love.graphics.print(line, 5, (i - 1) * 14 + 5)
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
end