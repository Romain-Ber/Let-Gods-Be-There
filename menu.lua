local menu = {}

local Engine = require("engine")

local menuTimer = 0
local zoomTranslateX = 0
local zoomTranslateY = 0
local menuLoaded = false

local function loadAssets()
    menuIntroSound = love.audio.newSource("menu/menuIntroSound.mp3", "stream")
    menuIntroSound:setVolume(4)
    menuBackground = {
        image = love.graphics.newImage("menu/menuBackground2.png"),
        scale = 25,
    }
    menuBackground.w = menuBackground.image:getWidth()
    menuBackground.h = menuBackground.image:getHeight()
    menuContinue = {
        button = {
            image = love.graphics.newImage("menu/continueButton.png"),
        },
        text = {
            image = love.graphics.newImage("menu/continueText.png"),
        }
    }
    menuNewgame = {
        button = {
            image = love.graphics.newImage("menu/newgameButton.png"),
        },
        text = {
            image = love.graphics.newImage("menu/newgameText.png"),
        }
    }
    menuLoadgame = {
        button = {
            image = love.graphics.newImage("menu/loadgameButton.png"),
        },
        text = {
            image = love.graphics.newImage("menu/loadgameText.png"),
        }
    }
    menuSettings = {
        button = {
            image = love.graphics.newImage("menu/settingsButton.png"),
        },
        text = {
            image = love.graphics.newImage("menu/settingsText.png"),
        }
    }
end

local function initializePosition(object, y)
    object.button.scale = 0.5
    object.button.w = object.button.image:getWidth()
    object.button.h = object.button.image:getHeight()
    object.button.x = -(object.button.w * object.button.scale)
    object.button.y = y
    object.text.scale = 0.5
    object.text.w = object.text.image:getWidth()
    object.text.h = object.text.image:getHeight()
    object.text.x = -(object.text.w * object.text.scale)
    object.text.y = y
end

local function initializeAlpha(object, alphaStart, alphaMax)
    object.alpha = alphaStart
    object.alphaMax = alphaMax
end

menu.load = function()
    loadAssets()
    initializeAlpha(menuBackground, 0.01, 0.5)
    initializeAlpha(menuContinue, 0.01, 1)
    initializePosition(menuContinue, maxResolution.h/9)
    initializeAlpha(menuNewgame, 0.01, 1)
    initializePosition(menuNewgame, maxResolution.h/9 * 3)
    initializeAlpha(menuLoadgame, 0.01, 1)
    initializePosition(menuLoadgame, maxResolution.h/9 * 5)
    initializeAlpha(menuSettings, 0.01, 1)
    initializePosition(menuSettings, maxResolution.h/9 * 7)
    Engine.load()
end


local function updateZoomEnter(dt, object)
    object.scale = 1 + (object.scale - 1) * math.pow(0.1, dt)
    zoomTranslateX = love.graphics.getWidth() / 2 - love.graphics.getWidth() / 2 * object.scale
    zoomTranslateY = love.graphics.getHeight() / 2 - love.graphics.getHeight() / 2 * object.scale
end

local function updateAlphaEnter(dt, object)
    object.alpha = object.alpha + 0.25 * dt
    if object.alpha >= object.alphaMax then
        object.alpha = object.alphaMax
    end
end

local function buttonSlideLeft(dt, object)
    local startValue = -(object.button.w * object.button.scale)
    local endValue = maxResolution.w/2 - (object.button.w*object.button.scale)/2
    local midValue = (startValue + endValue) / 2
    if object.button.x == startValue then
        object.button.x = startValue + (object.button.x + math.abs(startValue) + 1) / math.pow(0.1, dt)
    elseif  object.button.x > startValue and  object.button.x <= midValue then
        object.button.x = startValue + (object.button.x + math.abs(startValue)) / math.pow(0.1, dt)
    elseif object.button.x > midValue and object.button.x <= endValue then
        object.button.x = math.abs(endValue) + (object.button.x - math.abs(endValue)) * math.pow(0.1, dt)
    end
end

local function buttonSlideRight(dt, object)

end

local function buttonStart(time, object)
    if time > object.start then
        
    end
end

menu.update = function(dt)
    menuTimer = menuTimer + dt
    updateZoomEnter(dt, menuBackground)
    updateAlphaEnter(dt, menuBackground)
    if menuTimer >= 0.5 then
        updateAlphaEnter(dt, menuContinue)
        buttonSlideLeft(dt, menuContinue)
    end
    if menuTimer >= 0.75 then
        updateAlphaEnter(dt, menuNewgame)
        buttonSlideRight(dt, menuNewgame)
    end
    if menuTimer >= 1 then
        updateAlphaEnter(dt, menuLoadgame)
        buttonSlideLeft(dt, menuLoadgame)
    end
    if menuTimer >= 1.25 then
        updateAlphaEnter(dt, menuSettings)
        buttonSlideRight(dt, menuSettings)
    end
    --Engine.update(dt)
end

local function drawBackground()
    love.graphics.push()
    love.graphics.translate(zoomTranslateX, zoomTranslateY)
    love.graphics.scale(menuBackground.scale)
    love.graphics.setColor(1, 1, 1, menuBackground.alpha)
    love.graphics.draw(menuBackground.image, 0, 0, 0, maxResolution.w/menuBackground.w, maxResolution.h/menuBackground.h)
    love.graphics.pop()
end

local function drawButton(object)
    love.graphics.scale(1)
    love.graphics.setColor(1, 1, 1, object.alpha)
    love.graphics.draw(object.button.image, object.button.x, object.button.y, 0, object.button.scale, object.button.scale)
end

menu.draw = function()
    drawBackground()
    drawButton(menuContinue)
    drawButton(menuNewgame)
    drawButton(menuLoadgame)
    drawButton(menuSettings)
    --Engine.draw()
end

menu.keypressed = function(key)
    if (key) then
        love.audio.play(menuIntroSound)
    end
end

return menu