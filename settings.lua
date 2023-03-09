local settings = {}

fullscreen = false
gameResolution = {w=800, h=600, scale=1, offsetX=0, offsetY=0}
maxResolution = {w=0, h=0}

local function calculateMaxResolution()
    love.window.setFullscreen(true)
    maxResolution.w, maxResolution.h = love.window.getMode()
    love.window.setFullscreen(false)
end

function changeScreenMode()
    if (fullscreen == false) then
        fullscreen = true
        love.window.setFullscreen(true)
        if maxResolution.w / gameResolution.w > maxResolution.h / gameResolution.h then
            gameResolution.scale = maxResolution.h / gameResolution.h
            gameResolution.offsetX = (maxResolution.w - gameResolution.w * gameResolution.scale) / gameResolution.scale / 2
            gameResolution.offsetY = 0
        else
            gameResolution.scale = maxResolution.w / gameResolution.w
            gameResolution.offsetX = 0
            gameResolution.offsetY = (maxResolution.h - gameResolution.h * gameResolution.scale) / gameResolution.scale / 2
        end
    else
        fullscreen = false
        love.window.setFullscreen(false)
        gameResolution.scale = 1
        gameResolution.offsetX = 0
        gameResolution.offsetY = 0
    end
end

settings.load = function()
    love.graphics.setDefaultFilter("linear")
    calculateMaxResolution()
    changeScreenMode()
end

settings.update = function(dt)

end

settings.draw = function()

end

settings.keypressed = function(key)
    if key == "f11" then
        changeScreenMode()
    end
end

return settings