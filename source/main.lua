import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "scripts/sceneManager"
import "scripts/titleScene"
import "scripts/gameScene"
import "scripts/gameOverScene"
import "scripts/levelComplete"  -- Add this line

local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Instantiate game variables
PlayerScore = 0
PlayerLives = 0
EnemiesLeft = 0

-- Load fonts
local gradius = gfx.font.new("fonts/gradius")
gfx.setFont(gradius)

-- Load scene manager
SCENE_MANAGER = SceneManager()

TitleScene()

function pd.update()
	pd.timer.updateTimers()
	gfx.sprite.update()

	-- Add dynamic UI elements
	-- GAME SCENE
	-- Number of enemies remaining
	gfx.drawText("LEFT " .. EnemiesLeft, 10, 15)

	-- Number of lives remaining
	gfx.drawText("LIVES " .. PlayerLives, 10, 30)
end
