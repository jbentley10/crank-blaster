local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Define the enemy class
Enemy = {}
Enemy.__index = Enemy

class('Enemy').extends(Object)

-- Create a pool of inactive enemies
local ENEMY_POOL_SIZE = 20
local enemyPool = {}

function Enemy:init(playerX, playerY)
    -- Set default values if player position not provided
    playerX = playerX or 200  -- Default to center of screen
    playerY = playerY or 120
    
    -- Check for reusable enemy in pool
    for _, enemy in ipairs(enemyPool) do
        if not enemy:isVisible() then
            enemy:setVisible(true)
            local leftOrRight = math.random(0, 1)
            local position = leftOrRight == 0 and 0 or 400
            enemy:moveTo(position, math.random(0, 240))
            enemy.dx = 0
            enemy.dy = 0
            enemy:setVelocity(playerX, playerY)
            return enemy
        end
    end

    if #enemyPool < ENEMY_POOL_SIZE then
        local enemyImage = gfx.image.new("images/enemy-1")
        assert(enemyImage)

        local self = gfx.sprite.new(enemyImage)
        self.type = "enemy"
        self:setCollideRect(5, 5, 22, 25)

        -- Initialize velocity variables
        self.dx = 0
        self.dy = 0

        local leftOrRight = math.random(0, 1)
        local position = leftOrRight == 0 and 0 or 400
        self:moveTo(position, math.random(0, 240))
        self:addSprite()

        function self:setVelocity(targetX, targetY)
            -- Add safety checks
            targetX = targetX or 200
            targetY = targetY or 120
            
            -- Calculate direction vector from enemy to player
            local dx = targetX - self.x
            local dy = targetY - self.y
            -- Normalize the direction vector
            local length = math.sqrt(dx * dx + dy * dy)
            if length > 0 then
                local unitX = dx / length
                local unitY = dy / length

                local speed = 2
                self.dx = unitX * speed
                self.dy = unitY * speed
            else
                self.dx = 0
                self.dy = 0
            end
        end

        function self:deactivate()
            self:setVisible(false)
            self.dx = 0
            self.dy = 0
        end

        function self:update()
            if self.dx and self.dy then
				-- Find the player sprite
				local allSprites = gfx.sprite.getAllSprites()
				local player = nil
				for _, sprite in ipairs(allSprites) do
					if sprite.type == "player" then
						player = sprite
						break
					end
				end
				
				-- Update velocity to move towards current player position
				if player then
					self:setVelocity(player.x, player.y)
				end
				
				-- Move the enemy
				local x, y, c, n = self:moveWithCollisions(self.x + self.dx, self.y + self.dy)
				self.x = x
				self.y = y
			end
        end

        function self:collisionResponse(other)
            if other.type == "player" then
                PlayerLives -= 1
                print("Lives remaining: " .. PlayerLives)
                self:remove()
        
                if PlayerLives <= 0 then
                    -- Use switchScene consistently
                    SCENE_MANAGER:switchScene(GameOverScene, "Score: " .. PlayerScore)
                end
                return "overlap"
            end
        end

        self:add()
        
        -- Set initial velocity
        self:setVelocity(playerX, playerY)

        table.insert(enemyPool, self)
        return self
    end
end

function Enemy:getPoolSize()
    return #enemyPool
end

function Enemy:getActiveCount()
    local count = 0
    for _, enemy in ipairs(enemyPool) do
        if enemy:isVisible() then
            count = count + 1
        end
    end
    return count
end