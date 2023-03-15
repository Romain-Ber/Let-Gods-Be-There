local menu = {}

local Engine = require("engine")
local NewgameIntro = require("newgameintro")

local menuTimer = 0
local zoomTranslateX = 0
local zoomTranslateY = 0
local continueSelection = false
local newgameSelection = false
local loadgameSelection = false
local settingsSelection = false
local quitMenu = false

local function loadAssets()
    menuIntroSound = love.audio.newSource("menu/menuIntroSound.mp3", "stream")
    menuIntroSound:setVolume(4)
    menuBackground = {
        image = love.graphics.newImage("menu/menuBackground2.png"),
        scale = 25,
    }
    menuBackground.w = menuBackground.image:getWidth()
    menuBackground.h = menuBackground.image:getHeight()
    menuBackgroundVideo = {
        video = love.graphics.newVideo("menu/menuBackgroundVideo.ogv"),
        scale = 0.09,
        timer = 0
    }
    menuBackgroundVideo.w = menuBackgroundVideo.video:getWidth()
    menuBackgroundVideo.h = menuBackgroundVideo.video:getHeight()
    menuContinue = {
        name = "Continue",
        button = {
            image = love.graphics.newImage("menu/continueButton2.png"),
        },
        text = {
            image = love.graphics.newImage("menu/continueText.png"),
        }
    }
    menuNewgame = {
        name = "Newgame",
        button = {
            image = love.graphics.newImage("menu/newgameButton2.png"),
        },
        text = {
            image = love.graphics.newImage("menu/newgameText.png"),
        }
    }
    menuLoadgame = {
        name = "Loadgame",
        button = {
            image = love.graphics.newImage("menu/loadgameButton2.png"),
        },
        text = {
            image = love.graphics.newImage("menu/loadgameText.png"),
        }
    }
    menuSettings = {
        name = "Settings",
        button = {
            image = love.graphics.newImage("menu/settingsButton2.png"),
        },
        text = {
            image = love.graphics.newImage("menu/settingsText.png"),
        }
    }
    menuButtonGlow = love.audio.newSource("menu/menuButtonGlow.mp3", "static")
    menuButtonPreselect = love.audio.newSource("menu/menuButtonPreselect.mp3", "static")
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
        object.text.x = object.button.x
    elseif object.name == "Newgame" or object.name == "Settings" then
        object.button.x = maxResolution.w
        object.text.x = object.button.x
    end
    object.text.offsetX = ((object.button.w - object.text.w) / 2) * object.text.scale
    object.text.offsetY = ((object.button.h - object.text.h) / 2) * object.text.scale
end

local function initializeAlpha(object, alphaStart, alphaMax)
    object.alpha = alphaStart
    object.alphaMax = alphaMax
end

menu.load = function()
    loadAssets()
    initializeAlpha(menuBackground, 0, 0.3)
    initializeAlpha(menuContinue, 1, 1)
    initializePosition(menuContinue, maxResolution.h/9)
    initializeAlpha(menuNewgame, 1, 1)
    initializePosition(menuNewgame, maxResolution.h/9 * 3)
    initializeAlpha(menuLoadgame, 1, 1)
    initializePosition(menuLoadgame, maxResolution.h/9 * 5)
    initializeAlpha(menuSettings, 1, 1)
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
            object.text.x = object.button.x + object.text.offsetX
        elseif  object.button.x > startValue and  object.button.x <= midValue then
            object.button.x = startValue + (object.button.x + math.abs(startValue)) / math.pow(0.1, dt)
            object.text.x = object.button.x + object.text.offsetX
        elseif object.button.x > midValue and object.button.x <= endValue then
            object.button.x = math.abs(endValue) + (object.button.x - math.abs(endValue)) * math.pow(0.1, dt)
            object.text.x = object.button.x + object.text.offsetX
        end
    elseif object.name == "Newgame" or object.name == "Settings" then
        local startValue = maxResolution.w
        local endValue = maxResolution.w/2 - (object.button.w*object.button.scale)/2
        local midValue = (startValue + endValue) / 2
        if object.button.x == startValue then
            object.button.x = startValue - (math.abs(startValue) - object.button.x + 1) / math.pow(0.1, dt)
            object.text.x = object.button.x + object.text.offsetX
        elseif  object.button.x < startValue and  object.button.x >= midValue then
            object.button.x = startValue - (math.abs(startValue) - object.button.x) / math.pow(0.1, dt)
            object.text.x = object.button.x + object.text.offsetX
        elseif object.button.x < midValue and object.button.x >= endValue then
            object.button.x = math.abs(endValue) - (math.abs(endValue) - object.button.x) * math.pow(0.1, dt)
            object.text.x = object.button.x + object.text.offsetX
        end
    end
end

--TODO: function that adds a golden glow to a menu button and plays a sound if the mouse is hovering over it
--passes a boolean to true for mousepressed function
local function mousehover(dt, object)
    local mouseX, mouseY = love.mouse.getPosition()
    if mouseX >= object.button.x and mouseX <= object.button.x + object.button.w * object.button.scale and mouseY >= object.button.y and mouseY <= object.button.y + object.button.h * object.button.scale then
        continueSelection = true
    else
        continueSelection = false
    end
end

menu.update = function(dt)
    if quitMenu == false then
        menuTimer = menuTimer + dt
        updateZoomEnter(dt, menuBackground)
        updateAlphaEnter(dt, menuBackground)
        if menuBackground.scale >= 1 then
            menuBackgroundVideo.timer = menuBackgroundVideo.timer + dt
        end
        if menuTimer >= 0.5 then
            updateAlphaEnter(dt, menuContinue)
            buttonSlide(dt, menuContinue)
            mousehover(dt, menuContinue)
        end
        if menuTimer >= 0.75 then
            updateAlphaEnter(dt, menuNewgame)
            buttonSlide(dt, menuNewgame)
            mousehover(dt, menuNewgame)
        end
        if menuTimer >= 1 then
            updateAlphaEnter(dt, menuLoadgame)
            buttonSlide(dt, menuLoadgame)
            mousehover(dt, menuLoadgame)
        end
        if menuTimer >= 1.25 then
            updateAlphaEnter(dt, menuSettings)
            buttonSlide(dt, menuSettings)
            mousehover(dt, menuSettings)
        end
    else
        NewgameIntro.update(dt)
        --Engine.update(dt)
    end
end

local function drawBackground()
    love.graphics.push()
    love.graphics.translate(zoomTranslateX, zoomTranslateY)
    love.graphics.scale(menuBackground.scale)
    love.graphics.setColor(1, 1, 1, menuBackground.alpha)
    love.graphics.draw(menuBackground.image, 0, 0, 0, maxResolution.w/menuBackground.w, maxResolution.h/menuBackground.h)
    love.graphics.pop()
end

local function drawBackgroundVideo()
    if menuBackground.scale >= 1 then
        menuBackgroundVideo.video:play()
        love.graphics.setColor(1, 1, 1, 0.8)
        love.graphics.draw(menuBackgroundVideo.video, maxResolution.w / 2 - menuBackgroundVideo.w / 2 * menuBackgroundVideo.scale, maxResolution.h / 2 - menuBackgroundVideo.h / 2 * menuBackgroundVideo.scale, 0, menuBackgroundVideo.scale, menuBackgroundVideo.scale)
        if menuBackgroundVideo.timer >= 5 then
            menuBackgroundVideo.timer = 0
            menuBackgroundVideo.video:seek(5.1)
        end
    end
end

local function drawButton(object)
    love.graphics.scale(1)
    love.graphics.setColor(1, 1, 1, object.alpha)
    love.graphics.draw(object.button.image, object.button.x, object.button.y, 0, object.button.scale, object.button.scale)
    love.graphics.draw(object.text.image, object.text.x, object.text.y + object.text.offsetY, 0, object.text.scale, object.text.scale)
end

menu.draw = function()
    if quitMenu == false then
        drawBackground()
        drawBackgroundVideo()
        drawButton(menuContinue)
        drawButton(menuNewgame)
        drawButton(menuLoadgame)
        drawButton(menuSettings)
    else
        NewgameIntro.draw()
        --Engine.draw()
    end
end

menu.keypressed = function(key)
    if (key) then
        --love.audio.play(menuIntroSound)
    end
end

menu.mousepressed = function(x, y)
    if love.mouse.isDown(1) then
        if continueSelection == true then
            quitMenu = true
        end
        if newgameSelection == true then
            quitMenu = true
        end
        if loadgameSelection == true then
            quitMenu = true
        end
        if settingsSelection == true then
            quitMenu = true
        end
    end
end

return menu