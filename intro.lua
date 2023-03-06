local intro = {}

local introTimer = 0
local introVideoPlayed = false
local introSoundPlayed = false
local introSound2Played = false


local function loadAssets()
    introVideo = love.graphics.newVideo("intro/introVideo.ogv")
    alphaFade = 1
    introSound = love.audio.newSource("intro/introSound.mp3", "stream")
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
    introBackground = {
        image1 = love.graphics.newImage("intro/heaven.png"),
        image2 = love.graphics.newImage("intro/hell.png"),
        start = 13.5,
        alpha = 0,
        alphaSpeed = 0.1
    }
    introGameLogo = {
        image = love.graphics.newImage("intro/GameLogo.png"),
        start = 14.6,
        alpha = 0,
        alphaSpeed = 1
    }
    introPressKey = {
        image = love.graphics.newImage("intro/presskey2.png"),
        start = 17.5,
        alpha = 0,
        alphaSpeed = 0.75
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
        love.graphics.draw(introPressKey.image, 760, 745, 0, 0.2, 0.2)
    end
end


intro.draw = function (x,y)
    love.graphics.setColor(1, 1, 1, alphaFade)
    playIntro()
end

return intro