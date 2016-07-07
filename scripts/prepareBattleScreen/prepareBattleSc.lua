--####################################
-- prepareBattleSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the battle preparation screen.
--####################################

--namespace screens.prepareBattleScreen

screens.prepareBattleScreen.pointerX = 0
screens.prepareBattleScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.prepareBattleScreen.pointerCallback(x, y)
	cursorHover = false

	screens.prepareBattleScreen.pointerX, screens.prepareBattleScreen.pointerY = x, y 
	screens.prepareBattleScreen.screenButtonList:pointer(screens.prepareBattleScreen.layers.screenLayer:wndToWorld(screens.prepareBattleScreen.pointerX, screens.prepareBattleScreen.pointerY))

	if windowsBuild then
		screens.prepareBattleScreen.screenButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.prepareBattleScreen.pointerX, x, screens.prepareBattleScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.prepareBattleScreen.clickCallback(down)
	local worldX, worldY = screens.prepareBattleScreen.layers.screenLayer:wndToWorld(screens.prepareBattleScreen.pointerX, screens.prepareBattleScreen.pointerY)
	local buttonName = screens.prepareBattleScreen.screenButtonList:click(worldX, worldY, down)
	if buttonName == "fight" then
		battle.currentBattle.doneLoadout = true
		return
	elseif buttonName == "loadout" then
		screens.loadoutScreen.callingScreen = "loadoutScreen"
		frontController.dispatch(frontController.LOADOUT_SCREEN)
		return
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.prepareBattleScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if not xbox.leftThumbMoved and thumbLX > 0 then
		screens.prepareBattleScreen.screenButtonList:selectNext()
		xbox.leftThumbMoved = true
	elseif not xbox.leftThumbMoved and thumbLX < 0 then
		screens.prepareBattleScreen.screenButtonList:selectPrev()
		xbox.leftThumbMoved = true
	elseif xbox.leftThumbMoved and thumbLX == 0 then
		xbox.leftThumbMoved = false
	end
	screens.prepareBattleScreen.screenButtonList:selectedVisible(true)
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local buttonName = screens.prepareBattleScreen.screenButtonList:getSelected()
		if buttonName == "fight" then
			battle.currentBattle.doneLoadout = true
			return
		elseif buttonName == "loadout" then
			screens.loadoutScreen.callingScreen = "loadoutScreen"
			frontController.dispatch(frontController.LOADOUT_SCREEN)
			return
		end
	end
	
end