local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Define the enemy class
Enemy = {}
Enemy.__index = Enemy

class('Enemy').extends(Object)

-- Initialize the enemy	
function Enemy:init()
	-- Initialization
	-- Load the enemy image
	local enemyImage = gfx.image.new("images/enemy-1")
	assert(enemyImage)

	-- Create the enemy sprite
	local self = gfx.sprite.new(enemyImage)

	-- Set the type (used for collision detection)
	self.type = "enemy"

	-- Set the enemy's size and collision rectangle
	self:setCollideRect(5, 5, 22, 25)

	-- Set the enemy's velocity
	local dx, dy = 200, 120
	
	-- Start the enemy position randomly
	-- Choose ranodmly either left (0) or right (1)
	local leftOrRight = math.random(0, 1)
	-- Pick either 0 or 400 based on choice
	local position = leftOrRight == 0 and 0 or 400
	-- Position the enemy
	self:moveTo(position, math.random(0, 240))
	self:addSprite()

	-- Set the velocity towards the player
	function self:setVelocity(playerX, playerY, position)
		-- Calculate the direction vector
		local dx = nil;
		local dy = nil;
		-- Take in the enemy's position to determine if it moves
		-- towards the player or away from the player
		if (position == 0) then
			dx = playerX + self.x
			dy = playerY + self.y
		else
			dx = playerX - self.x
			dy = playerY - self.y
		end

		-- Normalize the direction vector to get a unit vector
		local length = math.sqrt(dx * dx + dy * dy)
		local unitX = dx / length
		local unitY = dy / length

		-- Multiply the unit vector by the desired speed to get the velocity
		-- Default enemy speed: 1
		local speed = 1 -- Adjust this value to change the speed
		self.dx = unitX * speed
		self.dy = unitY * speed

		print("Enemy: dx = " .. self.dx .. ", dy = " .. self.dy)
	end

	self:setVelocity(1 * math.cos(math.rad(300)), 1 * math.sin(math.rad(400)))

	-- Update the enemy
	function self:update()
		-- Move the enemy
		local x, y, c, n = self:moveWithCollisions(self.x + self.dx, self.y + self.dy)

		-- Update the enemy's position
		self.x = x
		self.y = y
	end

	-- Set collision responses
	function self:collisionResponse(other)
		if other.type == "player" then
			print('Enemy: hit player')
			-- Remove 1 life from the player
			playerLives = playerLives - 1
			print("Lives remaining: " .. playerLives)
			self:remove()

			-- Check if the player has run out of lives
			if playerLives == 0 then
				-- Switch to the GameOverScene
				SCENE_MANAGER:switchScene(GameOverScene, "Enemies hit: " .. playerScore)
			end
			return "overlap"
		elseif other.type == "ui" then
			return "slide"
		else
			return "overlap"	
		end
	end

	self:add()

	-- Return the enemy class
	return self
end
