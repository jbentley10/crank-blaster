local pd <const> = playdate
local gfx <const> = playdate.graphics

LevelCompleteScene = {}

class('LevelCompleteScene').extends(gfx.sprite)

function LevelCompleteScene:init()
    print("Scene update: Level complete")

    gfx.image.new("images/main-ui-background"):draw(0,0)
    
    -- Create text content
    local titleText = "Level Complete!"
    local scoreText = "Score: " .. PlayerScore
    local promptText = "Press A to continue"
    
    -- Get text dimensions
    local titleWidth, titleHeight = gfx.getTextSize(titleText)
    local scoreWidth, scoreHeight = gfx.getTextSize(scoreText)
    local promptWidth, promptHeight = gfx.getTextSize(promptText)
    
    -- Create properly sized images
    local titleImage = gfx.image.new(titleWidth, titleHeight)
    local scoreImage = gfx.image.new(scoreWidth, scoreHeight)
    local promptImage = gfx.image.new(promptWidth, promptHeight)
    
    -- Verify images
    assert(titleImage, "Failed to create title image")
    assert(scoreImage, "Failed to create score image")
    assert(promptImage, "Failed to create prompt image")
    
    -- Draw text to images
    gfx.pushContext(titleImage)
        gfx.drawText(titleText, 0, 0)
    gfx.popContext()
    
    gfx.pushContext(scoreImage)
        gfx.drawText(scoreText, 0, 0)
    gfx.popContext()
    
    gfx.pushContext(promptImage)
        gfx.drawText(promptText, 0, 0)
    gfx.popContext()
    
    -- Create and position sprites
    local titleSprite = gfx.sprite.new(titleImage)
    local scoreSprite = gfx.sprite.new(scoreImage)
    local promptSprite = gfx.sprite.new(promptImage)
    
    titleSprite:moveTo(200, 80)
    scoreSprite:moveTo(200, 120)
    promptSprite:moveTo(200, 160)
    
    titleSprite:add()
    scoreSprite:add()
    promptSprite:add()
    
    self:add()
end

function LevelCompleteScene:update()
    if pd.buttonJustPressed(pd.kButtonA) then
        -- Reset enemies but keep score
        EnemiesLeft = 5  -- or increment for next level
        SCENE_MANAGER:switchScene(GameScene)
    end
end