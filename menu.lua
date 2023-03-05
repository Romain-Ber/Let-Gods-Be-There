local menu = {}

local Engine = require("engine")

menu.load = function()
    Engine.load()
end

menu.update = function(dt)
    Engine.update(dt)
end

menu.draw = function(x,y)
    Engine.draw(x,y)
end

menu.keypressed = function(key)
    
end

return menu