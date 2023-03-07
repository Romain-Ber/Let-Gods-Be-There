local menu = {}

local Engine = require("engine")

local menuTimer = 0

menu.load = function()
    --Engine.load()
end

local function updateBackgroundAlpha(dt)
    local minAlpha = math.min(introBackground.alpha, introGameLogo.alpha)
    introBackground.alpha = introBackground.alpha - introBackground.alpha * 0.5 * dt
    if introBackground.alpha <= 0.25 then
        introBackground.alpha = 0.25
    end
    introGameLogo.alpha = introGameLogo.alpha - introGameLogo.alpha * dt
    if introGameLogo.alpha <= 0.25 then
        introGameLogo.alpha = 0.25
    end
end

menu.update = function(dt)
    updateBackgroundAlpha(dt)
    --Engine.update(dt)
end

local function backgroundFade()
    love.graphics.setColor(1, 1, 1, introBackground.alpha)
    love.graphics.draw(introBackground.image1, 448, 0)
    love.graphics.draw(introBackground.image2, 448, 568)
    love.graphics.setColor(1, 1, 1, introGameLogo.alpha)
    love.graphics.draw(introGameLogo.image, 560, 187)
end

menu.draw = function(x,y)
    backgroundFade()
    --Engine.draw(x,y)
end

menu.keypressed = function(key)
    
end

return menu