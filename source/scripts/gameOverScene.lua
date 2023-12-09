import "gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameOverScene').extends(gfx.sprite)

function GameOverScene:init(text)
    print('Scene update: Game over screen')
    -- Generate prompt text
    local text2 = "Press A to play again!"

    -- Set images 
    local scoreImage = gfx.image.new(gfx.getTextSize(text))
    local promptImage = gfx.image.new(gfx.getTextSize(text2))

    -- Push context and draw
    -- SCORE
    gfx.pushContext(scoreImage)
    gfx.drawText(text, 0, 0)
    gfx.popContext()
    -- PROMPT
    gfx.pushContext(promptImage)
    gfx.drawText(text2, 0, 0)
    gfx.popContext()

    -- Add the sprites
    local scoreSprite = gfx.sprite.new(scoreImage)
    local promptSprite = gfx.sprite.new(promptImage)

    -- Move sprites
    scoreSprite:moveTo(200, 120)
    scoreSprite:add()
    promptSprite:moveTo(200, 160)
    promptSprite:add()

    self:add()
end

function GameOverScene:update()
    if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameScene)
    end
end