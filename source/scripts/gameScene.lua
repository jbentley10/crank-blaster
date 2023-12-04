import "gameOverScene"
import "sprites/bullet"
import "sprites/player"
import "sprites/enemy"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
	-- Add the background image
	local backgroundImage = gfx.image.new("images/main-ui-background")
	local backgroundSprite = gfx.sprite.new(backgroundImage)
	backgroundSprite:moveTo(200, 120)
	backgroundSprite:add()

	-- Add the player
	local player = Player()
	-- Add the enemy
	local enemy = Enemy()

	pd.timer.keyRepeatTimerWithDelay(3000, 2000, function()
		-- Code to execute every 3 seconds
		-- Add another enemy
		print('going!')
		local newEnemy = Enemy()
	end)
end

	-- Switch to the GameOverScene 
	-- SCENE_MANAGER:switchScene(GameOverScene, "Score: 100")

function GameScene:update(dt)
	-- Update the sprites
	gfx.sprite.update()
end
