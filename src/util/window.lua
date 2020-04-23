local Object = require "lib.classic"

local W = Object:extend()

function W:new()
    self.width = 1080
    self.height = 720
    self.zoom = 1
    self.fullscreen = false
    self.resizable = true

    love.window.setMode(self.width, self.height, {fullscreen = self.fullscreen, resizable = self.resizable})
end

function W:resize(w, h)
end

return W