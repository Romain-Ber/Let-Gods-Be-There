io.stdout:setvbuf('no')
--Empèche love de filtrer les contours de l'image quand elle est redimensionnées (pixel art)
love.graphics.setDefaultFilter("nearest")

fullScreen = false


local Engine = require("engine")

function love.load()
    if (fullScreen) then
        love.window.setFullscreen(true)
        screenWidth, screenHeight = love.window.getMode()
        scale_x = screenWidth / 800
        scale_y = screenHeight / 600
    end
    Engine.load()
end

function love.update(dt)
    Engine.update(dt)
end

function love.draw()
    Engine.draw()
end