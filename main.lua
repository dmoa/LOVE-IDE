Object       = require "Util/classic"
range        = require "Util/Range"

local Colors = require "Util/Colors"
local Window = require "Util/Window"
local Editor = require "Editor"

local window = Window()
      colors = Colors()
local editor = Editor()

function love.load()
    love.keyboard.setKeyRepeat(true)
end

function love.draw()
    editor:draw(colors)
end

function love.update(dt)
    editor:update(dt)
end

function love.keypressed(key)
    editor:keyPressed(key)
end

function love.textinput(t)
    editor:textInput(t)
end

function love.resize(w, h)
    window:resize(w, h)
end