local intro = {}

local Menu = require("menu")

local introTimer = 0
local introVideoPlayed = false
local introSoundPlayed = false
local introSound2Played = false
local introExit = false
local introToMenu = false
local zoomScale = 1
local zoomMaxScale = 50
local zoomSpeed = 0.01
local zoomTranslateX = 0
local zoomTranslateY = 0


local function loadAssets()
    introVideo = {
        video = love.graphics.newVideo("intro/introVideo.ogv")
    }
    introVideo.w = introVideo.video:getWidth()
    introVideo.h = introVideo.video:getHeight()
    alphaFade = 0
    introSound = love.audio.newSource("intro/introSound.mp3", "stream")
    introSound:setVolume(0.3)
    introSound2 = {
        sound = love.audio.newSource("intro/desert-stone-109342.mp3", "stream"),
        start = 9.5
    }
    introLogo = {
        image = love.graphics.newImage("intro/Origin Games.png"),
        start = 7.1,
        alpha = 0,
        alphaSpeed = 1
    }
    introLogo.w = introLogo.image:getWidth()
    introLogo.h = introLogo.image:getHeight()
    introBackground = {
        image1 = love.graphics.newImage("intro/heaven.png"),
        image2 = love.graphics.newImage("intro/hell.png"),
        start = 13.5,
        alpha = 0,
        alphaSpeed = 0.1
    }
    introBackground.w1 = introBackground.image1:getWidth()
    introBackground.h1 = introBackground.image1:getHeight()
    introBackground.w2 = introBackground.image2:getWidth()
    introBackground.h2 = introBackground.image2:getHeight()
    introGameLogo = {
        image = love.graphics.newImage("intro/GameLogo.png"),
        start = 14.58,
        alpha = 0,
        alphaSpeed = 1
    }
    introGameLogo.w = introGameLogo.image:getWidth()
    introGameLogo.h = introGameLogo.image:getHeight()
    introPressKey = {
        image = love.graphics.newImage("intro/presskey.png"),
        sound = love.audio.newSource("intro/presskey.mp3", "stream"),
        start = 17.67,
        alpha = 0,
        alphaSpeed = 0.75,
        shiftX = 960,
        shiftY = 607,
        scale = 1,
        maxCycle = 215,
        cycle1 = 215,
        cycle2 = 215,
        fullCycle = false,
    }
    introPressKey.w = introPressKey.image:getWidth()
    introPressKey.h = introPressKey.image:getHeight()
end

intro.load = function()
    loadAssets()
    Menu.load()
end

local function updateIntro(dt)
    introTimer = introTimer + dt
    if introTimer >= introLogo.start and introTimer < 8 then
        introLogo.alpha = introLogo.alpha + introLogo.alphaSpeed * dt
        if introLogo.alpha >= 1 then
            introLogo.alpha = 1
        end
    end
    if introTimer >= 1 and introTimer < 2 then
        alphaFade = alphaFade + 10 * dt
        if alphaFade >= 1 then
            alphaFade = 1
        end
    end
    if introTimer >= 9 and introTimer < 12 then
        alphaFade = alphaFade - introLogo.alphaSpeed * dt
        introLogo.alpha = introLogo.alpha - introLogo.alphaSpeed * dt
        if alphaFade <= 0 then
            alphaFade = 0
        end
        if introLogo.alpha <= 0 then
            introLogo.alpha = 0
        end        
    end
    if introTimer >= 12 then
        alphaFade = alphaFade + 0.2 * dt
        if alphaFade >= 1 then
            alphaFade = 1
        end
    end
    if introTimer >= introBackground.start then
        introBackground.alpha = introBackground.alpha + introBackground.alphaSpeed * dt
        if introBackground.alpha >= 1 then
            introBackground.alpha = 1
        end
    end
    
    if introTimer >= introGameLogo.start then
        introGameLogo.alpha = introGameLogo.alpha + introGameLogo.alphaSpeed * dt
        if introGameLogo.alpha >= 1 then
            introGameLogo.alpha = 1
        end
    end
    if introTimer >= introPressKey.start then
        introPressKey.alpha = introPressKey.alpha + introPressKey.alphaSpeed * dt
        if introPressKey.alpha >= 1 then
            introPressKey.alpha = 1
        end
        if introPressKey.cycle1 >= 1 and introPressKey.fullCycle == false then
            introPressKey.scale = introPressKey.scale + 0.0125 * dt
            introPressKey.cycle1 = introPressKey.cycle1 - 1
        elseif introPressKey.cycle1 < 1 and introPressKey.fullCycle == false then
            introPressKey.cycle1 = introPressKey.maxCycle
            introPressKey.fullCycle = true
        elseif introPressKey.cycle2 >= 1 and introPressKey.fullCycle == true then
            introPressKey.scale = introPressKey.scale - 0.0125 * dt
            introPressKey.cycle2 = introPressKey.cycle2 - 1
        elseif introPressKey.cycle2 < 1 and introPressKey.fullCycle == true then
            introPressKey.cycle2 = introPressKey.maxCycle
            introPressKey.fullCycle = false
        end
    end
end

local function updateAlphaExit(dt)
    introBackground.alpha = introBackground.alpha - introBackground.alpha * 2 * dt
    if introBackground.alpha <= 0.02 then
        introBackground.alpha = 0
    end
    introPressKey.alpha = introPressKey.alpha - introPressKey.alpha * 10 * dt
    if introPressKey.alpha <= 0.02 then
        introPressKey.alpha = 0
    end
    introGameLogo.alpha = introGameLogo.alpha - introGameLogo.alpha * 2 * dt
    if introGameLogo.alpha <= 0.02 then
        introGameLogo.alpha = 0
        introToMenu = true
    end
end

local function updateZoomExit(dt)
    zoomScale = zoomScale * (1 + 1.5 * dt)
    zoomTranslateX = love.graphics.getWidth() / 2 - love.graphics.getWidth() / 2 * zoomScale
    zoomTranslateY = love.graphics.getHeight() / 2 - love.graphics.getHeight() / 2 * zoomScale
end

local function updateZoomExit2(dt)
    zoomScale = 16 - (16 - zoomScale) * math.exp(0.1, dt)
    zoomTranslateX = love.graphics.getWidth() / 2 - love.graphics.getWidth() / 2 * zoomScale
    zoomTranslateY = love.graphics.getHeight() / 2 - love.graphics.getHeight() / 2 * zoomScale
end

local function updateZoomExit3(dt)
    local zoomDelta = zoomMaxScale - zoomScale
    zoomScale = zoomScale + zoomDelta * (1 - math.exp(-zoomSpeed * zoomDelta * dt))
    zoomTranslateX = love.graphics.getWidth() / 2 - love.graphics.getWidth() / 2 * zoomScale
    zoomTranslateY = love.graphics.getHeight() / 2 - love.graphics.getHeight() / 2 * zoomScale
end

intro.update = function(dt)
    if introExit == false then
        updateIntro(dt)
    elseif introExit == true and introToMenu == false then
        updateZoomExit(dt)
        updateAlphaExit(dt)
    else --if introExit == true and introToMenu == true then
        Menu.update(dt)
    end
end

local function drawIntro()
    if introSoundPlayed == false then
        introSoundPlayed = true
        love.audio.play(introSound)
    end
    if introTimer >= 1 and introVideoPlayed == false then
        introVideoPlayed = true
        introVideo.video:play()
    end
    if introTimer >= 1 and introTimer < 2 then
        love.graphics.setColor(1, 1, 1, alphaFade)
        love.graphics.draw(introVideo.video)
    end
    if introTimer >= 2 and introTimer < 12 then
        love.graphics.setColor(1, 1, 1, alphaFade)
        love.graphics.draw(introVideo.video)
    end
    if introTimer >= introLogo.start and introTimer < 12 then
        love.graphics.setColor(1, 1, 1, introLogo.alpha)
        love.graphics.draw(introLogo.image, 545, 750)
        love.graphics.print("Origin Games™, all rights reserved", 1685, 1060)
    end
    if introTimer >= introSound2.start and introSound2Played == false then
        introSound2Played = true
        love.audio.play(introSound2.sound)
        introVideo.video:seek(0)
        introVideo.video:pause()
    end
    if introTimer >= 11 and introTimer < 12 then
        love.graphics.setColor(1, 1, 1, alphaFade)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    end
    if introTimer >= introBackground.start then
        love.graphics.setColor(1, 1, 1, introBackground.alpha)
        love.graphics.draw(introBackground.image1, 448, 0)
        love.graphics.draw(introBackground.image2, 448, 568)
    end
    if introTimer >= introGameLogo.start then
        love.graphics.setColor(1, 1, 1, introGameLogo.alpha)
        love.graphics.draw(introGameLogo.image, 560, 187)
    end
    if introTimer >= introPressKey.start then
        love.graphics.setColor(1, 1, 1, introPressKey.alpha)
        love.graphics.draw(introPressKey.image, introPressKey.shiftX - (introPressKey.w * introPressKey.scale) / 2, introPressKey.shiftY - (introPressKey.h * introPressKey.scale) / 2, 0, introPressKey.scale, introPressKey.scale)
    end
end

local function drawIntroToMenu()
    love.graphics.push()
    love.graphics.translate(zoomTranslateX, zoomTranslateY)
    love.graphics.scale(zoomScale)
    love.graphics.setColor(1, 1, 1, introBackground.alpha)
    love.graphics.draw(introBackground.image1, 448, 0)
    love.graphics.draw(introBackground.image2, 448, 568)
    love.graphics.setColor(1, 1, 1, introGameLogo.alpha)
    love.graphics.draw(introGameLogo.image, 560, 187)
    love.graphics.setColor(1, 1, 1, introPressKey.alpha)
    love.graphics.draw(introPressKey.image, introPressKey.shiftX - (introPressKey.w * introPressKey.scale) / 2, introPressKey.shiftY - (introPressKey.h * introPressKey.scale) / 2)
    love.graphics.pop()
end


intro.draw = function ()
    if introExit == false then
        drawIntro()
    elseif introExit == true and introToMenu == false then
        drawIntroToMenu()
    else --if introExit == true and introToMenu == true then
        Menu.draw()
    end
end

intro.keypressed = function(key)
    if introExit == false then
        if (key) then
            if introTimer >= introPressKey.start then
                introExit = true
                love.audio.play(introPressKey.sound)
            end
        end
    else
        Menu.keypressed()
    end
end

intro.mousepressed = function(x, y)
    Menu.mousepressed(x, y)
end

return intro