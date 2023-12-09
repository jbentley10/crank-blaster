-- Import libs
local gfx = playdate.graphics

-- Define the bullet class
Bullet = {}
Bullet.__index = Bullet

class('Bullet').extends(Object)

-- Initialize the bullet
function Bullet:init(playerX, playerY, crankPosition)
	-- Create the bullet sprite
	local self = playdate.graphics.sprite:new()

	-- Set the type (used for collision detection)
	self.type = "bullet"
	
	-- Set the bullet's size and collision rectangle
	self:setSize(5, 5)
	self:setCollideRect(0, 0, 5, 5)

	-- Set the bullet's velocity
	local dx, dy = 0, 0
	local bulletspeed = 16

	-- Move the bullet to the player's position
	self:moveTo(playerX-1, playerY-1)
	self:addSprite()
	
	function self:setVelocity(dx, dy, da)
		self.dx = dx
		self.dy = dy
	end

	-- Set the velocity towards the player
	self:setVelocity(dx + bulletspeed * math.cos(math.rad(crankPosition)), dy + bulletspeed * math.sin(math.rad(crankPosition)))
	
	function self:update()
		-- Move the bullet
		print('Bullet: moving')
		local x,y,c,n = self:moveWithCollisions(self.x + self.dx, self.y + self.dy)
		
		-- Remove the bullet if it goes offscreen
		if self.x < 0 or self.x > 400 or self.y < 0 or self.y > 240 or self.removeme then
			print('Bullet: offscreen')
			self:remove()
		end
	end

	-- Set collision responses
	function self:collisionResponse(other)
		if other.type == "enemy" then
			print('Bullet: hit enemy')
			other:remove()
			self:remove()
			return "overlap"
		else
			print('Bullet: hit else')
			return "overlap"	
		end
	end

	function self:draw()
		gfx.setColor(gfx.kColorBlack)
		gfx.fillRect(0, 0, 5, 5)
	end

	return self
end
