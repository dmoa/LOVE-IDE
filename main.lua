Object = require "Util/classic"

local Window = require "Util/Window"
local Colors = require "Util/Colors"
local Editor = require "Editor"

local window = Window()
local editor = Editor()
local colors = Colors()

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