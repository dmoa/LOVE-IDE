local Luacheck   = require("luacheck")
local Lexer      = require("luacheck.lexer")
local CheckState = require("luacheck.check_state")
local Decoder    = require("luacheck.decoder")

local Object = require("lib.classic")

local SyntaxLookup = require("src.textEditor.syntaxLookup")
local SyntaxColors = require("src.textEditor.syntaxColors")
local TextEditor = Object:extend()

function TextEditor:new()
	self.cursor = {
		position = 1,
		line     = 1,
	}
    self.file = {""}
    self.tokens = {}
    self.logs = {}

	self.fontSize = 32
	self.font = love.graphics.newFont("assets/fonts/FiraCode-Regular.ttf", self.fontSize)

    self.mainText = love.graphics.newText(self.font, self.file[1])
	self.lineNumbers = love.graphics.newText(self.font, "1")
end

function TextEditor:update(dt)
    --[=[
	local coloredText = self.lexer:getColoredText(self.file)
	self.mainText:set(coloredText)
    self.lineNumbers:set(table.concat(range(#self.file), "\n"))
    ]=]
end

function TextEditor:draw()
    love.graphics.push("all")

    love.graphics.setFont(self.font)

    local src = ""
    for i, line in ipairs(self.file) do
        if i ~= 1 then
            src = src .. " "
        end
        src = src .. line
    end

    local startPos = 1
    local currLine = 1

    local drawPos = 0

    for i, token in ipairs(self.tokens) do
        local type = "default"

        if (token.token == nil) then
            type = "string"
        elseif (token.token == "name") then
            type = "name"
        elseif (token.token == "number") then
            type = "number"
        else
            type = SyntaxLookup.get(token.token) or type
        end

        print(token.token.. " " ..type)

        local color = SyntaxColors.get(type)
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

        startPos = token.pos

        love.graphics.print(str, drawPos, (line - 1) * 34 + 5)
        drawPos = drawPos + love.graphics.getFont():getWidth(str)


    end

    for i, log in ipairs(self.logs) do
        love.graphics.print(log, 5, (i - 1) * 34 + 150)
    end

    love.graphics.pop()
    --[=[
	bg = colors.default[1]
	textColor = colors.default[7]
	lineNumColor = colors.default[4]

	love.graphics.clear(colors:to_rgb(bg))

	love.graphics.setColor(colors:to_rgb(textColor, false))
	love.graphics.draw(self.mainText, 50, 15)
	love.graphics.setColor(colors:to_rgb(lineNumColor))
    love.graphics.draw(self.lineNumbers, 15, 15)
    ]=]
end

function TextEditor:textInput(t)
    if not self.file[self.cursor.line] then
        self.file[self.cursor.line] = ""
    end

    local line = self.file[self.cursor.line]
    line = string.sub(line, 1, self.cursor.position - 1) .. t .. string.sub(line, self.cursor.position)
    self.file[self.cursor.line] = line

    self.cursor.position = self.cursor.position + 1

    self:lint()

    --[=[
    local line = self.file[self.cursor.line]
    line = string.sub(line, 1, self.cursor.pos - 1) .. t .. string.sub(line, self.cursor.pos)
    self.file[self.cursor.line] = line

    self.cursor.pos = self.cursor.pos + 1
    ]=]
end

function TextEditor:keypressed(key)
	if key == "return" then
		self.cursor.position = 1
		self.cursor.line = self.cursor.line + 1
		self.file[self.cursor.line] = ""
	end

	if key == "backspace" then
		self.cursor.position = self.cursor.position > 1 and self.cursor.position - 1 or 1
		local line = self.file[self.cursor.line]

		if line == "" and self.cursor.line > 1 then
			table.remove(self.file, self.cursor.line)
			self.cursor.line = self.cursor.line - 1
			self.cursor.position = #self.file[self.cursor.line]
		else
            line = string.sub(line, 0, #line - 1)
			self.file[self.cursor.line] = line
		end
    end
    
    self:lint()
end

function TextEditor:lint()
    self.logs = {}

    local src = ""
    for i, line in ipairs(self.file) do
        if i ~= 1 then
            src = src .. "\n"
        end
        src = src .. line
    end

    local report = Luacheck.get_report(src)
    for _, warning in pairs(report.warnings) do
        table.insert(self.logs, warning.msg)
    end

    local checkState = CheckState.new(src)
    local real_src = Decoder.decode(checkState.source_bytes)

    local lexer = Lexer.new_state(real_src)
    self.tokens = {}

    while true do
        local full_token = {}

        local token = Lexer.next_token(lexer)
        full_token.token = token

        if token == "eof" then
            break
        end

        full_token.line = lexer.line
        full_token.pos = lexer.offset

        table.insert(self.tokens, full_token)
    end
end

return TextEditor