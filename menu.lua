local menu = {}

local Engine = require("engine")

local menuTimer = 0

local zoomTranslateX = 0
local zoomTranslateY = 0
local menuLoaded = false
local slideOffsetVector1 = 0
local slideOffsetVector2 = 1

local function loadAssets()
    menuIntroSound = love.audio.newSource("menu/menuIntroSound.mp3", "stream")
    menuIntroSound:setVolume(4)
    menuBackground = {
        image = love.graphics.newImage("menu/menuBackground2.png"),
        scale = 25,
        alpha = 0.01,
        alphaMax = 0.5,
        alphaDone = false
    }
    menuBackground.w = menuBackground.image:getWidth()
    menuBackground.h = menuBackground.image:getHeight()
    menuContinue = {
        button = {
            image = love.graphics.newImage("menu/continueButton.png"),
            x = 0,
            y = 0,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        },
        text = {
            image = love.graphics.newImage("menu/continueText.png"),
            x = 0,
            y = 0,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        }
    }
    menuContinue.button.w = menuContinue.button.image:getWidth()
    menuContinue.button.h = menuContinue.button.image:getHeight()
    menuContinue.button.y = maxResolution.h / 9
    menuContinue.text.w = menuContinue.text.image:getWidth()
    menuContinue.text.h = menuContinue.text.image:getHeight()
    menuNewgame = {
        button = {
            image = love.graphics.newImage("menu/newgameButton.png"),
            x = 0,
            y = 0,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        },
        text = {
            image = love.graphics.newImage("menu/newgameText.png"),
            x = 0,
            y = 0,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
       }
    }
    menuNewgame.button.w = menuNewgame.button.image:getWidth()
    menuNewgame.button.h = menuNewgame.button.image:getHeight()
    menuNewgame.text.w = menuNewgame.text.image:getWidth()
    menuNewgame.text.h = menuNewgame.text.image:getHeight()
    menuLoadgame = {
        button = {
            image = love.graphics.newImage("menu/loadgameButton.png"),
            x = 0,
            y = 0,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        },
        text = {
            image = love.graphics.newImage("menu/loadgameText.png"),
            x = 0,
            y = 0,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        }
    }
    menuLoadgame.button.w = menuLoadgame.button.image:getWidth()
    menuLoadgame.button.h = menuLoadgame.button.image:getHeight()
    menuLoadgame.text.w = menuLoadgame.text.image:getWidth()
    menuLoadgame.text.h = menuLoadgame.text.image:getHeight()
    menuSettings = {
        button = {
            image = love.graphics.newImage("menu/settingsButton.png"),
            x = 0,
            y = 0,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        },
        text = {
            image = love.graphics.newImage("menu/settingsText.png"),
            x = 0,
            y = 0,
            scale = 1,
            alpha = 1,
            alphaSpeed = 1,
            start = 1
        }
    }
    menuSettings.button.w = menuSettings.button.image:getWidth()
    menuSettings.button.h = menuSettings.button.image:getHeight()
    menuSettings.text.w = menuSettings.text.image:getWidth()
    menuSettings.text.h = menuSettings.text.image:getHeight()
end

menu.load = function()
    loadAssets()
    Engine.load()
end


local function updateZoomEnter(dt)
    menuBackground.scale = 1 + (menuBackground.scale - 1) * math.pow(0.1, dt)
    zoomTranslateX = love.graphics.getWidth() / 2 - love.graphics.getWidth() / 2 * menuBackground.scale
    zoomTranslateY = love.graphics.getHeight() / 2 - love.graphics.getHeight() / 2 * menuBackground.scale
end

local function updateAlphaEnter(dt)
    menuBackground.alpha = menuBackground.alpha + menuBackground.alpha * 1 * dt
    if menuBackground.alpha >= menuBackground.alphaMax then
        menuBackground.alpha = menuBackground.alphaMax
        menuBackground.alphaDone = true
    end
end

local function buttonSlideLeft(dt)
    slideOffsetVector1 = 1 + (slideOffsetVector1 - 1) * math.pow(0.1, dt)
    print(slideOffsetVector1)
    slideOffsetVector2 = 1 + (slideOffsetVector2 - 1) * math.pow(0.1, dt)
    print(slideOffsetVector2)
end

local function buttonSlideRight(dt)

end

menu.update = function(dt)
    menuTimer = menuTimer + dt
    updateZoomEnter(dt)
    updateAlphaEnter(dt)
    if menuTimer >= 2 then
        buttonSlideLeft(dt)
        buttonSlideRight(dt)
    end
    --Engine.update(dt)
end

local function drawMenuIntro()
    love.graphics.push()
    love.graphics.translate(zoomTranslateX, zoomTranslateY)
    love.graphics.scale(menuBackground.scale)
    love.graphics.setColor(1, 1, 1, menuBackground.alpha)
    love.graphics.draw(menuBackground.image, 0, 0, 0, maxResolution.w/menuBackground.w, maxResolution.h/menuBackground.h)
    love.graphics.pop()
end

local function drawButton()
    love.graphics.scale(1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(menuContinue.button.image, menuContinue.button.x, menuContinue.button.y, 0, 1, 1)
end

menu.draw = function()
    drawMenuIntro()
    if menuTimer >= 2 then
        --drawButton()
    end
    --Engine.draw()
end

menu.keypressed = function(key)
    if (key) then
        love.audio.play(menuIntroSound)
    end
end

return menu