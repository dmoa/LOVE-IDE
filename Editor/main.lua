local TextEditor = require("src.textEditor")

local textEditor = TextEditor(love.graphics.getDimensions())

function love.update(dt)
	textEditor:update(dt)
end

function love.draw()
	textEditor:draw()
end

function love.resize(w, h)
	textEditor:resize(w, h)
end