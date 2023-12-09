local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Define the player class
Player = {}

class('Player').extends(Object)

-- Initialize the player
function Player:init()
	-- Load the player image
	local playerImage = gfx.image.new("images/player--1")
	assert(playerImage)

	-- Create the player sprite
	local self = gfx.sprite.new(playerImage)

	-- Set the type (used for collision detection)
	self.type = "player"

	self:setCollideRect(5, 9, 22, 15)
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
			-- Fire a projectile
			local b = Bullet(self.x, self.y, crankPosition)
		end
	end

	-- Return the player class
	return self
end
