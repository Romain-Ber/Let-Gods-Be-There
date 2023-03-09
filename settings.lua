local settings = {}

local fullscreen = {mode=false, w=0, h=0}
gamescreen = {w=800, h=600, scale=1, offsetX=0, offsetY=0}

function changeScreenMode()
    if (fullscreen.mode == false) then
        fullscreen.mode = true
        love.window.setFullscreen(true)
        fullscreen.w, fullscreen.h = love.window.getMode()
        if fullscreen.w / gamescreen.w > fullscreen.h / gamescreen.h then
            gamescreen.scale = fullscreen.h / gamescreen.h
            gamescreen.offsetX = (fullscreen.w - gamescreen.w * gamescreen.scale) / gamescreen.scale / 2
            gamescreen.offsetY = 0
        else
            gamescreen.scale = fullscreen.w / gamescreen.w
            gamescreen.offsetX = 0
            gamescreen.offsetY = (fullscreen.h - gamescreen.h * gamescreen.scale) / gamescreen.scale / 2
        end
    else
        fullscreen.mode = false
        love.window.setFullscreen(false)
        gamescreen.scale = 1
        gamescreen.offsetX = 0
        gamescreen.offsetY = 0
    end
end

settings.load = function()
    changeScreenMode()
end

settings.update = function(dt)

end

settings.draw = function()

end

settings.keypressed = function(key)
    if key == "f11" then
        changeScreenMode()
        print(gamescreen.scale, gamescreen.offsetX, gamescreen.offsetY)
    end
end

return settings