local ui = {}

local CONST = {
    backgroundBorder = {w=800, h=454},
    portraitBorder = {w=137, h=146},
    diceBorder = {w=252, h=146}
}

local imgBackgroundBorder = love.graphics.newImage("images/ui/ui-background-border.png")
local imgPortraitBorder = love.graphics.newImage("images/ui/ui-portrait-border.png")
local imgDiceBorder = love.graphics.newImage("images/ui/ui-dice-border.png")


function loadQuad()
    CONST.backgroundBorder.quad = love.graphics.newQuad(0, 0, CONST.backgroundBorder.w, CONST.backgroundBorder.h, imgBackgroundBorder)
    for i=1, 4, 1 do
        CONST.portraitBorder[i] = {}
        CONST.portraitBorder[i].quad = love.graphics.newQuad(0, 0, CONST.portraitBorder.w, CONST.portraitBorder.h, imgPortraitBorder)
    end
    CONST.diceBorder.quad = love.graphics.newQuad(0, 0, CONST.diceBorder.w, CONST.diceBorder.h, imgDiceBorder)
end

ui.load = function()
    loadQuad()
end

ui.update = function(dt)

end

ui.draw = function(x,y)
    love.graphics.draw(imgBackgroundBorder, CONST.backgroundBorder.quad, x, y)
    for i=1, 4, 1 do
        love.graphics.draw(imgPortraitBorder, CONST.portraitBorder[i].quad, (i-1)*CONST.portraitBorder.w + x, CONST.backgroundBorder.h + 1 + y)
    end
    love.graphics.draw(imgDiceBorder, CONST.diceBorder.quad, CONST.portraitBorder.w*4 + 1 + x, CONST.backgroundBorder.h + 1 + y)
end

return ui