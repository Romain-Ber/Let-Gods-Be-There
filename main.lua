io.stdout:setvbuf('no')
--Empèche love de filtrer les contours de l'image quand elle est redimensionnées (pixel art)
love.graphics.setDefaultFilter("nearest")
-----VARIABLES-----
fullScreen = true

-----REQUIRES-----
local Engine = require("engine")
-----LOAD----- : ACTION DU JEU AU DEMARAGE
function love.load()
    if (fullScreen) then
        love.window.setFullscreen(true)
        screenWidth, screenHeight = love.window.getMode()
        scale_x = screenWidth / 800
        scale_y = screenHeight / 600
    end
end

function love.update(dt)

end

function love.draw()
    
end