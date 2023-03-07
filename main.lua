io.stdout:setvbuf('no')
--Empèche love de filtrer les contours de l'image quand elle est redimensionnées (pixel art)
love.graphics.setDefaultFilter("nearest")

local Intro = require("intro")
local Settings = require("settings")

function love.load()
    Settings.load()
    Intro.load()
end

function love.update(dt)
    Intro.update(dt)
    Settings.update(dt)
end

function love.draw()
    Intro.draw()
    love.graphics.scale(gamescreen.scale,gamescreen.scale)
    Settings.draw()
end

function love.keypressed(key)
    --Settings.keypressed(key)
    Intro.keypressed(key)
end

function love.mousepressed(x, y, key)

end