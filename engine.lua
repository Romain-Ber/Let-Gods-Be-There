local engine = {}

local UI = require("ui")
local Classes = require("classes")
local Keywords = require("keywords")

engine.load = function()
    UI.load()
end

engine.update = function(dt)
    UI.update(dt)
end

engine.draw = function()
    UI.draw()
end

return engine