-- Import libs
local gfx = playdate.graphics

-- Define the bullet class
Bullet = {}
Bullet.__index = Bullet

class('Bullet').extends(Object)

-- Create a pool of inactive bullets
local BULLET_POOL_SIZE = 30  -- Adjust this based on your needs
local bulletPool = {}
local activeCount = 0

-- Initialize the bullet
function Bullet:init(playerX, playerY, crankPosition)
    -- Check if there's an inactive bullet in the pool we can reuse
    for _, bullet in ipairs(bulletPool) do
        if not bullet:isVisible() then
            -- Reuse this bullet
            bullet:setVisible(true)
            bullet:moveTo(playerX-1, playerY-1)
            bullet:setVelocity(0 + 16 * math.cos(math.rad(crankPosition)), 
                             0 + 16 * math.sin(math.rad(crankPosition)))
            return bullet
        end
    end

    -- If no inactive bullets found and pool isn't full, create a new one
    if #bulletPool < BULLET_POOL_SIZE then
        -- Create the bullet sprite
        local self = gfx.sprite:new()

        -- Set the type (used for collision detection)
        self.type = "bullet"
        
        -- Set the bullet's size and collision rectangle
        self:setSize(5, 5)
        self:setCollideRect(0, 0, 5, 5)

        -- Move the bullet to the player's position
        self:moveTo(playerX-1, playerY-1)
        self:addSprite()
        
        function self:setVelocity(dx, dy, da)
            self.dx = dx
            self.dy = dy
        end

        -- Set the velocity towards the player
        self:setVelocity(0 + 16 * math.cos(math.rad(crankPosition)), 
                        0 + 16 * math.sin(math.rad(crankPosition)))
        
        function self:update()
            -- Move the bullet
            local x,y,c,n = self:moveWithCollisions(self.x + self.dx, self.y + self.dy)
            
            -- Instead of removing, just hide and reset position if offscreen
            if self.x < 0 or self.x > 400 or self.y < 0 or self.y > 240 then
                self:deactivate()
            end
        end

        function self:deactivate()
            self:setVisible(false)
            self:moveTo(playerX-1, playerY-1)  -- Reset position
            self.dx = 0
            self.dy = 0
        end

        -- Set collision responses
        function self:collisionResponse(other)
            if other.type == "enemy" then
                PlayerScore = PlayerScore + 1
                EnemiesLeft = EnemiesLeft - 1
                other:remove()
                self:deactivate()
        
                -- Check for level completion
                if EnemiesLeft <= 0 then
                    -- Clean up active bullets before scene switch
                    for _, bullet in ipairs(bulletPool) do
                        if bullet:isVisible() then
                            bullet:deactivate()
                        end
                    end
                    SCENE_MANAGER:switchScene(LevelCompleteScene)
                end
                
                return "overlap"
            elseif other.type == "ui" then
                self:deactivate()
                return "freeze"
            else
                return "overlap"    
            end
        end

        function self:draw()
            gfx.setColor(gfx.kColorBlack)
            gfx.fillRect(0, 0, 5, 5)
        end

        -- Add to pool
        table.insert(bulletPool, self)
        return self
    end

    -- If we reach here, the pool is full and all bullets are active
    -- You might want to add some feedback here
    return nil
end