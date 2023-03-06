local intro = {}

local introTimer = 0
local introVideoPlayed = false
local introSoundPlayed = false
local introSound2Played = false

local alpha = 1
local alphaIntroPlayKey = 0

local function loadAssets()
    introVideo = love.graphics.newVideo("intro/introVideo.ogv")
    introSound = love.audio.newSource("intro/introSound.mp3", "stream")
    --introSound2 = love.audio.newSource("intro/introSound2.mp3", "stream")
    introSound2 = {
        sound = love.audio.newSource("intro/desert-stone-109342.mp3", "stream"),
        start = 9.5
    }
    introLogo = {
        image = love.graphics.newImage("intro/Origin Games.png"),
        start = 7.1,
        alpha = 0,
        alphaSpeed = 4
    }
    introBackground = {
        image1 = love.graphics.newImage("intro/heaven.png"),
        image2 = love.graphics.newImage("intro/hell.png"),
        start = 12.25,
        alpha = 0,
        alphaSpeed = 0.1
    }
    introGameLogo = {
        image = love.graphics.newImage("intro/GameLogo.png"),
        start = 14.6,
        alpha = 0,
        alphaSpeed = 1
    }
end

intro.load = function()
    loadAssets()
end

local function updateTimer(dt)
    introTimer = introTimer + dt
    if introTimer >= introLogo.start and introTimer < 8 then
        introLogo.alpha = introLogo.alpha + introLogo.alphaSpeed * dt
        if introLogo.alpha >= 1 then
            introLogo.alpha = 1
        end
    end
    if introTimer >= 9.6 and introTimer < 12 then
        alpha = alpha - 2 * dt
        introLogo.alpha = introLogo.alpha - introLogo.alphaSpeed * dt
        if alpha <= 0 then
            alpha = 0
        end
        if introLogo.alpha <= 0 then
            introLogo.alpha = 0
        end        
    end
    if introTimer >= 12 then
        alpha = alpha + 0.2 * dt
        if alpha >= 1 then
            alpha = 1
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
    if introTimer >= 14 then
        alphaIntroPlayKey = alphaIntroPlayKey + 1 * dt
        if alphaIntroPlayKey >= 1 then
            alphaIntroPlayKey = 1
        end
    end
end

intro.update = function(dt)
    updateTimer(dt)
end

local function playIntro()
    if introSoundPlayed == false then
        introSoundPlayed = true
        love.audio.play(introSound)
    end
    if introTimer >= 1 and introVideoPlayed == false then
        introVideoPlayed = true
        introVideo:play()
    end
    if introTimer >= 1 and introTimer < 12 then
        love.graphics.draw(introVideo)
    end
    --love.graphics.draw(introVideo)
    if introTimer >= introLogo.start and introTimer < 12 then
        love.graphics.setColor(1, 1, 1, introLogo.alpha)
        love.graphics.draw(introLogo.image, 545, 750)
        love.graphics.print("Origin Games™, all rights reserved", 1685, 1060)
    end
    if introTimer >= introSound2.start and introSound2Played == false then
        introSound2Played = true
        love.audio.play(introSound2.sound)
        introVideo:seek(0)
        introVideo:pause()
    end
    if introTimer >= 11 and introTimer < 12 then
        love.graphics.setColor(1, 1, 1, alpha)
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
end


intro.draw = function (x,y)
    love.graphics.setColor(1, 1, 1, alpha)
    playIntro()
end

return intro