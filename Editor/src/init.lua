local Font = love.graphics.newFont("FiraCode-Regular.ttf")

local TextEditor = {}
TextEditor.mt = {__index = TextEditor}

function TextEditor.new(w, h)
	local textEditor = setmetatable({
		cursor = {
			pos = 1,
			line = 1,
		},

		canvas = nil,
		file = {""}
	}, TextEditor.mt)

	textEditor:__rebuildCanvas(w, h)

	return textEditor
end

function TextEditor:__rebuildCanvas(w, h)
	if (self.canvas) then
		self.canvas:release()
		self.canvas = nil
	end

	self.canvas = love.graphics.newCanvas(w, h)
end

function TextEditor:update(dt)
	print(self.cursor.pos)
end

function TextEditor:draw(...)
	love.graphics.push("all")
		love.graphics.setCanvas(self.canvas)
		love.graphics.clear(0, 0, 0, 0)
		love.graphics.setFont(Font)

		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.print(table.concat(self.file, "\n"))
	love.graphics.pop()

	love.graphics.draw(self.canvas, ...)
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

function TextEditor:resize(w, h)
	self:__rebuildCanvas(w, h)
end

return setmetatable(TextEditor, {
	__call = function(_, ...) return TextEditor.new(...) end,
})