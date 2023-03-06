io.stdout:setvbuf('no')
--Empèche love de filtrer les contours de l'image quand elle est redimensionnées (pixel art)
love.graphics.setDefaultFilter("nearest")

local Intro = require("intro")
local Settings = require("settings")
local Menu = require("menu")


function love.load()
    Settings.load()
    Intro.load()
    Menu.load()
end

function love.update(dt)
    Intro.update(dt)
    Settings.update(dt)
    Menu.update(dt)
end

function love.draw()
    Intro.draw(gamescreen.offsetX, gamescreen.offsetY)
    love.graphics.scale(gamescreen.scale,gamescreen.scale)
    Settings.draw()
    Menu.draw(gamescreen.offsetX, gamescreen.offsetY)
end

function love.keypressed(key)
    Settings.keypressed(key)
    Menu.keypressed(key)
end