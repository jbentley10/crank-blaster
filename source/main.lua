import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "scripts/sceneManager"
-- import "sceneManagerNoTransition"
import "scripts/gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Instantiate game variables
playerScore = nil
playerLives = nil
enemiesLeft = nil

-- Load fonts
local gradius = gfx.font.new("fonts/gradius")
gfx.setFont(gradius)

-- Load scene manager
SCENE_MANAGER = SceneManager()

GameScene()

function pd.update()
	pd.timer.updateTimers()
	gfx.sprite.update()

	-- Add dynamic UI elements
	-- GAME SCENE
	-- Number of enemies remaining
	if SCENE_MANAGER.currentScene == gameScene then
		gfx.drawText("LEFT " .. enemiesLeft, 10, 15)
	end

	-- Number of lives remaining
	if SCENE_MANAGER.currentScene == gameScene then
		gfx.drawText("LIVES " .. playerLives, 10, 30)
	end
end
