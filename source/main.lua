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

SCENE_MANAGER = SceneManager()

GameScene()

function pd.update()
	pd.timer.updateTimers()
	gfx.sprite.update()

	-- Add dynamic UI elements
	-- GAME SCENE
	if SCENE_MANAGER.currentScene == gameScene then
		gfx.drawText("Left " .. enemiesLeft, 100, 217)
end
end
