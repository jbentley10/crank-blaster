local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Define the player class
Player = {}

-- Initialize the player
function Player:new()
	-- Load the player image
	local playerImage = gfx.image.new("images/player--1")
	assert(playerImage)

	-- Create the player sprite
	local self = gfx.sprite.new(playerImage)
	self:setCollideRect(0, 0, 32, 32)
	self:moveTo(200, 120)
	self:add()

	function self:update()
		-- Store the crank position to inform player direction
		local crankPosition = pd.getCrankPosition()

		-- Set the power-ups
		-- if pd.buttonIsPressed(pd.kButtonUp) then
		-- ...
		-- end
		-- ...

		-- Rotate the player sprite using the crank
		self:setRotation(crankPosition)

		if pd.buttonJustPressed(pd.kButtonA) then
			local playerX, playerY = self:getPosition()
			-- Fire a projectile
			local b = Bullet:new()
			local dx, dy = 0, 0
			local bulletspeed = 16
			b:moveTo(playerX-1, playerY-1)
			b:setVelocity(dx + bulletspeed * math.cos(math.rad(crankPosition)), dy + bulletspeed * math.sin(math.rad(crankPosition)))
			b:addSprite()
		end
	end

	-- Return the player class
	return self
end
