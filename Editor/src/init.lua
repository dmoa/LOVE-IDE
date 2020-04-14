local TextEditor = Object:extend()

local Font = love.graphics.newFont("Editor/src/FiraCode-Regular.ttf")

function TextEditor:new(w, h)
	self.cursor = {
		pos = 1,
		line = 1
	}
	self.file = {""}

	return textEditor
end

function TextEditor:update(dt)
end

function TextEditor:draw(...)
	love.graphics.push("all")
		love.graphics.clear(0, 0, 0, 0)
		love.graphics.setFont(Font)

		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.print(table.concat(self.file, "\n"))
	love.graphics.pop()
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
		self.cursor.pos = self.cursor.pos - 1
		local line = self.file[self.cursor.line]
        line = string.sub(line, 0, self.cursor.pos - 2) .. string.sub(line, self.cursor.pos + 1)
        self.file[self.cursor.line] = line
	end
end

return TextEditor