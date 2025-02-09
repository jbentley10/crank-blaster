local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameOverScene').extends(gfx.sprite)

function GameOverScene:init(scoreText)
    print('Scene update: Game over screen')
    
    -- Set default text if none provided
    scoreText = scoreText or "Game Over! Score: " .. PlayerScore
    local promptText = "Press A to play again!"

    -- Calculate text dimensions first
    local textWidth, textHeight = gfx.getTextSize(scoreText)
    local promptWidth, promptHeight = gfx.getTextSize(promptText)

    -- Create images with proper dimensions
    local scoreImage = gfx.image.new(textWidth, textHeight)
    local promptImage = gfx.image.new(promptWidth, promptHeight)

    -- Verify images were created successfully
    assert(scoreImage, "Failed to create score image")
    assert(promptImage, "Failed to create prompt image")

    -- Draw text to images
    gfx.pushContext(scoreImage)
        gfx.drawText(scoreText, 0, 0)
    gfx.popContext()

    gfx.pushContext(promptImage)
        gfx.drawText(promptText, 0, 0)
    gfx.popContext()

    -- Create sprites with the images
    local scoreSprite = gfx.sprite.new(scoreImage)
    local promptSprite = gfx.sprite.new(promptImage)

    -- Position sprites
    scoreSprite:moveTo(200, 120)
    promptSprite:moveTo(200, 160)

    -- Add sprites to the display list
    scoreSprite:add()
    promptSprite:add()

    -- Add self to the display list
    self:add()
end

function GameOverScene:update()
    if pd.buttonJustPressed(pd.kButtonA) then
        -- Reset game variables
        PlayerScore = 0
        PlayerLives = 3
        EnemiesLeft = 5
        SCENE_MANAGER:switchScene(GameScene)
    end
end