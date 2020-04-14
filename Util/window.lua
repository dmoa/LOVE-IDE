local push = require "Util/push"

local W = Object:extend()

function W:new()
    self.width = 1080
    self.height = 720
    self.zoom = 1
    self.fullscreen = false
    self.resizable = true

    push:setupScreen(self.width * self.zoom, self.height * self.zoom, self.width, self.height,
                    {fullscreen = false, resizable = true})
end

function W:resize(w, h)
    push:resize(w, h)
end

return W