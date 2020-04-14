-- global class module
Object = require "Util/classic"

local Window = require "Util/window"
local Editor = require "Editor"

local window = Window()
local editor = Editor()

function love.draw()
    editor:draw()
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