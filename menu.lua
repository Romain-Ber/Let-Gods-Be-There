local menu = {}

local Engine = require("engine")

local menuTimer = 0

local function loadAssets()
    menuIntroSound = love.audio.newSource("menu/menuIntroSound.mp3", "stream")
    menuIntroSound:setVolume(4)
    menuContinue = {
        button = {
            image = love.graphics.newImage("menu/continueButton.png"),
            w = 1024,
            h = 264,
            x = 1,
            y = 1,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        },
        text = {
            image = love.graphics.newImage("menu/continueText.png"),
            w = 600,
            h = 164,
            x = 1,
            y = 1,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        }
    }
    menuNewgame = {
        button = {
            image = love.graphics.newImage("menu/newgameButton.png"),
            w = 1024,
            h = 264,
            x = 1,
            y = 1,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        },
        text = {
            image = love.graphics.newImage("menu/newgameText.png"),
            w = 600,
            h = 155,
            x = 1,
            y = 1,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
       }
    }
    menuLoadgame = {
        button = {
            image = love.graphics.newImage("menu/loadgameButton.png"),
            w = 1024,
            h = 264,
            x = 1,
            y = 1,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        },
        text = {
            image = love.graphics.newImage("menu/loadgameText.png"),
            w = 600,
            h = 163,
            x = 1,
            y = 1,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        }
    }
    menuSettings = {
        button = {
            image = love.graphics.newImage("menu/settingsButton.png"),
            w = 1024,
            h = 264,
            x = 1,
            y = 1,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        },
        text = {
            image = love.graphics.newImage("menu/settingsText.png"),
            w = 569,
            h = 173,
            x = 1,
            y = 1,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        }
    }
end

menu.load = function()
    loadAssets()
    --Engine.load()
end


local function menuLeftSlide(dt)

end

local function menuRightSlide(dt)

end

local function menuFade(dt)

end

menu.update = function(dt)
    menuTimer = menuTimer + dt
    --Engine.update(dt)
end

menu.draw = function(x,y)
    love.audio.play(menuIntroSound)
    --Engine.draw(x,y)
end

menu.keypressed = function(key)
    if (key) then love.audio.play(menuIntroSound) end
end

return menu