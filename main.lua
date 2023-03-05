io.stdout:setvbuf('no')
--Empèche love de filtrer les contours de l'image quand elle est redimensionnées (pixel art)
love.graphics.setDefaultFilter("nearest")

local Settings = require("settings")
local Menu = require("menu")

local introTimer = 0
introVideo = love.graphics.newVideo("intro/introVideo.ogv")
introSound = love.audio.newSource("intro/introSound.mp3", "stream")

function love.load()
    introVideo:play()
    Settings.load()
    Menu.load()
end

function love.update(dt)
    introTimer = introTimer + dt
    Settings.update(dt)
    Menu.update(dt)
end

function love.draw()
    love.audio.play(introSound)
    if introTimer >= 1 then love.graphics.draw(introVideo) end
    love.graphics.scale(gamescreen.scale,gamescreen.scale)
    Settings.draw()
    Menu.draw(gamescreen.offsetX, gamescreen.offsetY)
end

function love.keypressed(key)
    Settings.keypressed(key)
    Menu.keypressed(key)
end