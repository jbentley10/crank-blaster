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
end

	-- Switch to the GameOverScene 
	-- SCENE_MANAGER:switchScene(GameOverScene, "Score: 100")

function GameScene:update(dt)
	-- Spawn a new enemy every second
	local enemySpawnTimer = 0
	local enemySpawnInterval = 3 -- in seconds

	enemySpawnTimer = enemySpawnTimer + dt
	if enemySpawnTimer >= enemySpawnInterval then
		enemySpawnTimer = enemySpawnTimer - enemySpawnInterval
		local enemy = Enemy()
		local dx, dy = 200, 120
		local enemySpeed = 2
		-- Start the enemy position randomly
		enemy:moveTo(400, math.random(0, 240))
		enemy:setVelocity(1 + enemySpeed * math.cos(math.rad(300)), 1 + enemySpeed * math.sin(math.rad(400)))
		enemy:addSprite()
	end

	-- Check for collisions between bullets and enemies
	for i = #Bullet.bullets, 1, -1 do
		local bullet = Bullet.bullets[i]
		for j = #Enemy.enemies, 1, -1 do
			local enemy = Enemy.enemies[j]
			if bullet:collidesWith(enemy) then
				bullet:removeSprite()
				enemy:removeSprite()
				table.remove(Bullet.bullets, i)
				table.remove(Enemy.enemies, j)
				break
			end
		end
	end
end
