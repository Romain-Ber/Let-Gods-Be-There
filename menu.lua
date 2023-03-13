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
        name = "Continue",
        button = {
            image = love.graphics.newImage("menu/continueButton.png"),
        },
        text = {
            image = love.graphics.newImage("menu/continueText.png"),
        }
    }
    menuNewgame = {
        name = "Newgame",
        button = {
            image = love.graphics.newImage("menu/newgameButton.png"),
        },
        text = {
            image = love.graphics.newImage("menu/newgameText.png"),
        }
    }
    menuLoadgame = {
        name = "Loadgame",
        button = {
            image = love.graphics.newImage("menu/loadgameButton.png"),
        },
        text = {
            image = love.graphics.newImage("menu/loadgameText.png"),
        }
    }
    menuSettings = {
        name = "Settings",
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
    object.text.scale = 0.5
    object.button.w = object.button.image:getWidth()
    object.button.h = object.button.image:getHeight()
    object.text.w = object.text.image:getWidth()
    object.text.h = object.text.image:getHeight()
    object.button.y = y
    object.text.y = y
    if object.name == "Continue" or object.name == "Loadgame" then
        object.button.x = -(object.button.w * object.button.scale)
        object.text.x = -(object.text.w * object.text.scale)
    elseif object.name == "Newgame" or object.name == "Settings" then
        object.button.x = maxResolution.w
        object.text.x = maxResolution.w
    end
end

local function initializeAlpha(object, alphaStart, alphaMax)
    object.alpha = alphaStart
    object.alphaMax = alphaMax
end

menu.load = function()
    loadAssets()
    initializeAlpha(menuBackground, 0, 0.5)
    initializeAlpha(menuContinue, 0, 1)
    initializePosition(menuContinue, maxResolution.h/9)
    initializeAlpha(menuNewgame, 0, 1)
    initializePosition(menuNewgame, maxResolution.h/9 * 3)
    initializeAlpha(menuLoadgame, 0, 1)
    initializePosition(menuLoadgame, maxResolution.h/9 * 5)
    initializeAlpha(menuSettings, 0, 1)
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

local function buttonSlide(dt, object)
    if object.name == "Continue" or object.name == "Loadgame" then
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
    elseif object.name == "Newgame" or object.name == "Settings" then
        local startValue = maxResolution.w
        local endValue = maxResolution.w/2 - (object.button.w*object.button.scale)/2
        local midValue = (startValue + endValue) / 2
        if object.button.x == startValue then
            object.button.x = startValue - (math.abs(startValue) - object.button.x + 1) / math.pow(0.1, dt)
        elseif  object.button.x < startValue and  object.button.x >= midValue then
            object.button.x = startValue - (math.abs(startValue) - object.button.x) / math.pow(0.1, dt)
        elseif object.button.x < midValue and object.button.x >= endValue then
            object.button.x = math.abs(endValue) - (math.abs(endValue) - object.button.x) * math.pow(0.1, dt)
        end
    end
end

menu.update = function(dt)
    menuTimer = menuTimer + dt
    updateZoomEnter(dt, menuBackground)
    updateAlphaEnter(dt, menuBackground)
    if menuTimer >= 0.5 then
        updateAlphaEnter(dt, menuContinue)
        buttonSlide(dt, menuContinue)
    end
    if menuTimer >= 0.75 then
        updateAlphaEnter(dt, menuNewgame)
        buttonSlide(dt, menuNewgame)
    end
    if menuTimer >= 1 then
        updateAlphaEnter(dt, menuLoadgame)
        buttonSlide(dt, menuLoadgame)
    end
    if menuTimer >= 1.25 then
        updateAlphaEnter(dt, menuSettings)
        buttonSlide(dt, menuSettings)
        
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