import "gameOverScene"
import "sprites/bullet"

local pd <const> = playdate
local gfx <const> = playdate.graphics

local bulletspeed = 16

class('GameScene').extends(gfx.sprite)

function GameScene:init()
	local backgroundImage = gfx.image.new("images/main-ui-background")
	gfx.sprite.setBackgroundDrawingCallback(function()
		backgroundImage:draw(0, 0)
	end)

	local playerSprite = gfx.image.new("images/player--1")
	self.player = gfx.sprite.new(playerSprite)
	self.player:moveTo(200, 120)
	self.player:add()

	self.playerSpeed = 2

	self:add()
end

-- SCENE_MANAGER:switchScene(GameOverScene, "Score: 100")

function GameScene:update()
	local crankPosition = pd.getCrankPosition()

	-- Switch to the GameOverScene when the A button is pressed
	if pd.buttonJustPressed(pd.kButtonA) then
		local playerX, playerY = self.player:getPosition()
		-- Fire a projectile
		local b = Bullet:new()
		local dx, dy = 0, 0
		b:moveTo(playerX-1, playerY-1)
		b:setVelocity(dx + bulletspeed * math.cos(math.rad(crankPosition)), dy + bulletspeed * math.sin(math.rad(crankPosition)))
		b:addSprite()
	end

	-- Set the power-up
	-- if pd.buttonIsPressed(pd.kButtonUp) then
		
	-- end
	-- if pd.buttonIsPressed(pd.kButtonRight) then
		
	-- end
	-- if pd.buttonIsPressed(pd.kButtonDown) then
		
	-- end
	-- if pd.buttonIsPressed(pd.kButtonLeft) then
		
	-- end
	-- Rotate the player sprite using the crank
	print(crankPosition)
	self.player:setRotation(crankPosition)
end
