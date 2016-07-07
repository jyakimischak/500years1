--####################################
-- defeatSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the defeat screen.
--####################################

--namespace screens.defeatScreen

screens.defeatScreen.pointerX = 0
screens.defeatScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.defeatScreen.pointerCallback(x, y)
	cursorHover = false

	screens.defeatScreen.pointerX, screens.defeatScreen.pointerY = x, y 
	screens.defeatScreen.screenButtonList:pointer(screens.defeatScreen.layers.screenLayer:wndToWorld(screens.defeatScreen.pointerX, screens.defeatScreen.pointerY))

	if windowsBuild then
		xbox.mouseMoved(screens.defeatScreen.pointerX, x, screens.defeatScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.defeatScreen.clickCallback(down)
	local screenWorldX, screenWorldY = screens.defeatScreen.layers.screenLayer:wndToWorld(screens.defeatScreen.pointerX, screens.defeatScreen.pointerY)
	local buttonName = screens.defeatScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName == "yes" or buttonName == "again" then
		battle.attempts = battle.attempts + 1
		battle.restartBattleDecisionMade = true
	elseif buttonName == "skip" then
		battle.skip = true
		battle.restartBattleDecisionMade = true
		textureUtil.loadTextures(textureUtil.NON_COMBAT)
	elseif buttonName == "no" then
		battle.battleResolved = true
		battle.restartBattleDecisionMade = true
		textureUtil.loadTextures(textureUtil.NON_COMBAT)
		frontController.dispatch(frontController.START_SCREEN)
		return
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.defeatScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if not xbox.leftThumbMoved and thumbLX > 0 then
		screens.defeatScreen.screenButtonList:selectNext()
		xbox.leftThumbMoved = true
	elseif not xbox.leftThumbMoved and thumbLX < 0 then
		screens.defeatScreen.screenButtonList:selectPrev()
		xbox.leftThumbMoved = true
	elseif xbox.leftThumbMoved and thumbLX == 0 then
		xbox.leftThumbMoved = false
	end
	screens.defeatScreen.screenButtonList:selectedVisible(true)
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local buttonName = screens.defeatScreen.screenButtonList:getSelected()
		if buttonName == "yes" or buttonName == "again" then
			battle.attempts = battle.attempts + 1
			battle.restartBattleDecisionMade = true
		elseif buttonName == "skip" then
			battle.skip = true
			battle.restartBattleDecisionMade = true
			textureUtil.loadTextures(textureUtil.NON_COMBAT)
		elseif buttonName == "no" then
			battle.battleResolved = true
			battle.restartBattleDecisionMade = true
			textureUtil.loadTextures(textureUtil.NON_COMBAT)
			frontController.dispatch(frontController.START_SCREEN)
			return
		end
	end
	
end
