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

	-- Spawn enemies at regular intervals
	-- First param is inital, second is regular intervals
	-- Default: 3000, 2000
	pd.timer.keyRepeatTimerWithDelay(3000, 2000, function()
		-- Add another enemy
		local newEnemy = Enemy()
	end)
end
