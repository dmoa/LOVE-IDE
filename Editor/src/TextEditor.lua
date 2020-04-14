local TextEditor = Object:extend()

function TextEditor:new(w, h)
	self.cursor = {
		pos = 1,
		line = 1
	}
	self.file = {""}
	self.fontSize = 20
	self.font = love.graphics.newFont("Editor/src/FiraCode-Regular.ttf", self.fontSize)
	self.mainText = love.graphics.newText(self.font, self.file[1])
	self.lineNumbers = love.graphics.newText(self.font, "1")
end

function TextEditor:update(dt)
	self.mainText:set(table.concat(self.file, "\n"))
	self.lineNumbers:set(table.concat(range(#self.file), "\n"))
end

function TextEditor:draw(colors)
	bg = colors.default[1]
	textColor = colors.default[12]
	lineNumColor = colors.default[2]

	love.graphics.clear(colors:to_rgb(bg))

	love.graphics.setColor(colors:to_rgb(textColor))
	love.graphics.draw(self.mainText, 50, 15)
	love.graphics.setColor(colors:to_rgb(lineNumColor))
	love.graphics.draw(self.lineNumbers, 15, 15)
end

function TextEditor:textInput(t)

    local line = self.file[self.cursor.line]
    line = string.sub(line, 1, self.cursor.pos - 1) .. t .. string.sub(line, self.cursor.pos)
    self.file[self.cursor.line] = line

	self.cursor.pos = self.cursor.pos + 1
end

function TextEditor:keyPressed(key)
	if key == "return" then
		self.cursor.pos = 1
		self.cursor.line = self.cursor.line + 1
		self.file[self.cursor.line] = ""
	end

	if key == "backspace" then
		self.cursor.pos = self.cursor.pos > 1 and self.cursor.pos - 1 or 1
		local line = self.file[self.cursor.line]

		if line == "" and self.cursor.line > 1 then
			table.remove(self.file, self.cursor.line)
			self.cursor.line = self.cursor.line - 1
			self.cursor.pos = #self.file[self.cursor.line]
		else
        	line = string.sub(line, 0, #line - 1)
			self.file[self.cursor.line] = line
		end
	end
end

return TextEditor