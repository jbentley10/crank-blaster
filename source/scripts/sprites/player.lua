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
		gfx.setColor(gfx.kColorBlack)
		if pd.buttonIsPressed(pd.kButtonUp) then
			-- Draw a rectangle around the shield power up
			gfx.drawRect(30, 190, 15, 15)
			print('Power up active: Shield')
			-- Store new power up value
			-- Add shield value
		end
		if pd.buttonIsPressed(pd.kButtonLeft) then
			-- Draw a rectangle around the shield power up
			gfx.drawRect(8, 208, 15, 15)
			print('Power up active: Infinite')
			-- Store new power up value
			-- Add shield value
		end
		if pd.buttonIsPressed(pd.kButtonRight) then
			-- Draw a rectangle around the shield power up
			gfx.drawRect(47, 204, 15, 15)
			print('Power up active: Crosshair')
			-- Store new power up value
			-- Add shield value
		end
		if pd.buttonIsPressed(pd.kButtonDown) then
			-- Draw a rectangle around the shield power up
			gfx.drawRect(30, 190, 15, 15)
			print('Power up active: ?')
			-- Store new power up value
			-- Add shield value
		end

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
