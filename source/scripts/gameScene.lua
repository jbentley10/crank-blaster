import "gameOverScene"
import "sprites/bullet"
import "sprites/player"
import "sprites/enemy"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
	print("Scene update: Game scene")
	playerScore = 0
	playerLives = 3
	enemiesLeft = 5
	-- LOAD THE GAME
	-- Add the background image
	local backgroundImage = gfx.image.new("images/main-ui-background")
	local backgroundSprite = gfx.sprite.new(backgroundImage)
	backgroundSprite:moveTo(200, 120)
	backgroundSprite:add()

	-- Add the player and enemy instances
	local player = Player()
	local enemy = Enemy()

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

	-- Spawn enemies at regular intervals
	-- First param is inital, second is regular intervals
	-- Default: 3000, 2000
	pd.timer.keyRepeatTimerWithDelay(3000, 2000, function()
		-- Add another enemy
		local newEnemy = Enemy()
	end)
end
