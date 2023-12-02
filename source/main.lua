import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "scripts/sceneManager"
-- import "sceneManagerNoTransition"
import "scripts/gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

SCENE_MANAGER = SceneManager()

GameScene()

function pd.update()
	pd.timer.updateTimers()
	gfx.sprite.update()
end
