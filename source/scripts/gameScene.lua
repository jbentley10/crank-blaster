import "gameOverScene"
import "sprites/bullet"
import "sprites/player"
import "sprites/enemy"

GameScene = {}

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
    print("Scene update: Game scene")
    PlayerScore = 0
    PlayerLives = 3
    EnemiesLeft = 5
    
    -- Store player reference in the scene
    self.player = Player()
    
    -- LOAD THE GAME
    -- Add the background image
    local backgroundImage = gfx.image.new("images/main-ui-background")
    local backgroundSprite = gfx.sprite.new(backgroundImage)
    backgroundSprite:moveTo(200, 120)
    backgroundSprite:add()

    -- Create initial enemy with player position
    local enemy = Enemy(self.player.x, self.player.y)

    -- Draw collision rects around UI elements
    local chargeUICollisionRect = gfx.sprite.new()
    local powerUpSelectUICollisionRect = gfx.sprite.new()
    chargeUICollisionRect.type = "ui"
    powerUpSelectUICollisionRect.type = "ui"

    chargeUICollisionRect:moveTo(370, 215)
    powerUpSelectUICollisionRect:moveTo(30, 215)

    chargeUICollisionRect:setSize(80, 60)
    powerUpSelectUICollisionRect:setSize(80, 60)
    
    chargeUICollisionRect:setCollideRect(0, 0, 80, 60)
    powerUpSelectUICollisionRect:setCollideRect(0, 0, 80, 60)

    chargeUICollisionRect:add()
    powerUpSelectUICollisionRect:add()

    -- Store scene reference for timer callback
    local scene = self
    
    -- Spawn enemies at regular intervals
    pd.timer.keyRepeatTimerWithDelay(3000, 2000, function()
        -- Add another enemy with current player position
        local newEnemy = Enemy(scene.player.x, scene.player.y)
    end)
end

return GameScene