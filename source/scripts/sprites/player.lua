local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Player').extends(gfx.sprite)

function Player:init()
    Player.super.init(self)
    
    -- Load and verify image
    local playerImage = gfx.image.new("images/player--1.png")
    assert(playerImage, "Failed to load player image")
    print("Player image loaded:", playerImage:getSize())

    -- In Player:init(), replace the image loading with this test
    local testImage = gfx.image.new(32, 32)
    gfx.pushContext(testImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(0, 0, 32, 32)
    gfx.popContext()
    self:setImage(testImage)
    
    -- Set up sprite properties
    self:setImage(playerImage)
    self:setZIndex(100)  -- Ensure player is above background
    self:setCenter(0.5, 0.5)  -- Center the sprite's anchor point
    
    self.type = "player"
    self:setCollideRect(5, 9, 22, 15)
    self:moveTo(200, 120)
    print("Player moved to:", self.x, self.y)
    
    -- Add to sprite system
    self:add()
    print("Player added to sprite system")
    
    self.isCollidingWithEnemy = false
end

-- Separate update function
function Player:update()
    -- Store the crank position to inform player direction
    local crankPosition = pd.getCrankPosition()

    -- Set the power-ups
    gfx.setColor(gfx.kColorBlack)
    if pd.buttonIsPressed(pd.kButtonUp) then
        gfx.drawRect(30, 190, 15, 15)
        print('Power up active: Shield')
    end
    if pd.buttonIsPressed(pd.kButtonLeft) then
        gfx.drawRect(8, 208, 15, 15)
        print('Power up active: Infinite')
    end
    if pd.buttonIsPressed(pd.kButtonRight) then
        gfx.drawRect(47, 204, 15, 15)
        print('Power up active: Crosshair')
    end
    if pd.buttonIsPressed(pd.kButtonDown) then
        gfx.drawRect(30, 190, 15, 15)
        print('Power up active: ?')
    end

    -- Rotate the player sprite using the crank
    self:setRotation(crankPosition)

    if pd.buttonJustPressed(pd.kButtonA) then
        -- Fire a projectile
        local b = Bullet(self.x, self.y, crankPosition)
    end
end