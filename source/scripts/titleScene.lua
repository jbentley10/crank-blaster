import "gameScene"

class('TitleScene').extends(playdate.graphics.sprite)

function TitleScene:init()
    print("Scene update: Title scene")
    local gfx = playdate.graphics
    
    -- Create title text
    local titleImage = gfx.image.new(gfx.getTextSize("SPACE SHOOTER"))
    gfx.pushContext(titleImage)
        gfx.drawText("SPACE SHOOTER", 0, 0)
    gfx.popContext()
    
    -- Create prompt text
    local promptImage = gfx.image.new(gfx.getTextSize("Press A to Start"))
    gfx.pushContext(promptImage)
        gfx.drawText("Press A to Start", 0, 0)
    gfx.popContext()
    
    -- Create and position sprites
    local titleSprite = gfx.sprite.new(titleImage)
    local promptSprite = gfx.sprite.new(promptImage)
    
    titleSprite:moveTo(200, 100)
    promptSprite:moveTo(200, 160)
    
    titleSprite:add()
    promptSprite:add()
    
    self:add()
end

function TitleScene:update()
    if playdate.buttonJustPressed(playdate.kButtonA) then
        SCENE_MANAGER:switchScene(GameScene)
    end
end