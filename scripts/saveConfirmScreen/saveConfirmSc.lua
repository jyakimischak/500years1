--####################################
-- saveConfirmSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the save screen.
--####################################

--namespace screens.saveConfirmScreen

screens.saveConfirmScreen.pointerX = 0
screens.saveConfirmScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.saveConfirmScreen.pointerCallback(x, y)
	cursorHover = false

	screens.saveConfirmScreen.pointerX, screens.saveConfirmScreen.pointerY = x, y 
	screens.saveConfirmScreen.screenButtonList:pointer(screens.saveConfirmScreen.layers.screenLayer:wndToWorld(screens.saveConfirmScreen.pointerX, screens.saveConfirmScreen.pointerY))

	if windowsBuild then
		screens.saveConfirmScreen.screenButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.saveConfirmScreen.pointerX, x, screens.saveConfirmScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.saveConfirmScreen.clickCallback(down)
	local screenWorldX, screenWorldY = screens.saveConfirmScreen.layers.screenLayer:wndToWorld(screens.saveConfirmScreen.pointerX, screens.saveConfirmScreen.pointerY)
	local buttonName = screens.saveConfirmScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName == "yes" then
		saveUtil.saveGame(screens.saveConfirmScreen.saveSlot)
		frontController.dispatch(frontController.STAR_MAP_SCREEN)
		return
	elseif buttonName == "no" then
		frontController.dispatch(frontController.SAVE_SCREEN)
		return
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.saveConfirmScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if not xbox.leftThumbMoved and thumbLX > 0 then
		screens.saveConfirmScreen.screenButtonList:selectNext()
		xbox.leftThumbMoved = true
	elseif not xbox.leftThumbMoved and thumbLX < 0 then
		screens.saveConfirmScreen.screenButtonList:selectPrev()
		xbox.leftThumbMoved = true
	elseif xbox.leftThumbMoved and thumbLX == 0 then
		xbox.leftThumbMoved = false
	end
	screens.saveConfirmScreen.screenButtonList:selectedVisible(true)
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local buttonName = screens.saveConfirmScreen.screenButtonList:getSelected()
		if buttonName == "yes" then
			saveUtil.saveGame(screens.saveConfirmScreen.saveSlot)
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		elseif buttonName == "no" then
			frontController.dispatch(frontController.SAVE_SCREEN)
			return
		end
	end
	
end
