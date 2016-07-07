--####################################
-- quitConfirmSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the quit screen.
--####################################

--namespace screens.quitConfirmScreen

screens.quitConfirmScreen.pointerX = 0
screens.quitConfirmScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.quitConfirmScreen.pointerCallback(x, y)
	cursorHover = false

	screens.quitConfirmScreen.pointerX, screens.quitConfirmScreen.pointerY = x, y 
	screens.quitConfirmScreen.screenButtonList:pointer(screens.quitConfirmScreen.layers.screenLayer:wndToWorld(screens.quitConfirmScreen.pointerX, screens.quitConfirmScreen.pointerY))

	if windowsBuild then
		screens.quitConfirmScreen.screenButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.quitConfirmScreen.pointerX, x, screens.quitConfirmScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.quitConfirmScreen.clickCallback(down)
	local screenWorldX, screenWorldY = screens.quitConfirmScreen.layers.screenLayer:wndToWorld(screens.quitConfirmScreen.pointerX, screens.quitConfirmScreen.pointerY)
	local buttonName = screens.quitConfirmScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName == "yes" then
		if screens.quitConfirmScreen.callingScreen == "optionsScreen" then
			frontController.dispatch(frontController.START_SCREEN)
		else
			os.exit()
		end
	elseif buttonName == "no" then
		if screens.quitConfirmScreen.callingScreen == "startScreen" then
			frontController.dispatch(frontController.START_SCREEN)
		else
			frontController.dispatch(frontController.OPTIONS_SCREEN)
		end
		return
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.quitConfirmScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if not xbox.leftThumbMoved and thumbLX > 0 then
		screens.quitConfirmScreen.screenButtonList:selectNext()
		xbox.leftThumbMoved = true
	elseif not xbox.leftThumbMoved and thumbLX < 0 then
		screens.quitConfirmScreen.screenButtonList:selectPrev()
		xbox.leftThumbMoved = true
	elseif xbox.leftThumbMoved and thumbLX == 0 then
		xbox.leftThumbMoved = false
	end
	screens.quitConfirmScreen.screenButtonList:selectedVisible(true)
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local buttonName = screens.quitConfirmScreen.screenButtonList:getSelected()
		if buttonName == "yes" then
			if screens.quitConfirmScreen.callingScreen == "optionsScreen" then
				frontController.dispatch(frontController.START_SCREEN)
			else
				os.exit()
			end
		elseif buttonName == "no" then
			if screens.quitConfirmScreen.callingScreen == "startScreen" then
				frontController.dispatch(frontController.START_SCREEN)
			else
				frontController.dispatch(frontController.OPTIONS_SCREEN)
			end
			return
		end
	end
	
end
