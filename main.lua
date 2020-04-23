local TextEditor = require "src.textEditor"
local Window = require "src.util.Window"

local textEditor = TextEditor()
local window = Window()

function love.load()
    love.keyboard.setKeyRepeat(true)
end

function love.draw()
    textEditor:draw()
end

function love.update(dt)
    textEditor:update(dt)
end

function love.keypressed(key)
    textEditor:keypressed(key)
end

function love.textinput(t)
    textEditor:textInput(t)
end

function love.resize(w, h)
    textEditor:resize(w, h)
end