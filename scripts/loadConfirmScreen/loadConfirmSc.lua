--####################################
-- loadConfirmSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the load screen.
--####################################

--namespace screens.loadConfirmScreen

screens.loadConfirmScreen.pointerX = 0
screens.loadConfirmScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.loadConfirmScreen.pointerCallback(x, y)
	cursorHover = false

	screens.loadConfirmScreen.pointerX, screens.loadConfirmScreen.pointerY = x, y 
	screens.loadConfirmScreen.screenButtonList:pointer(screens.loadConfirmScreen.layers.screenLayer:wndToWorld(screens.loadConfirmScreen.pointerX, screens.loadConfirmScreen.pointerY))

	if windowsBuild then
		screens.loadConfirmScreen.screenButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.loadConfirmScreen.pointerX, x, screens.loadConfirmScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.loadConfirmScreen.clickCallback(down)
	local screenWorldX, screenWorldY = screens.loadConfirmScreen.layers.screenLayer:wndToWorld(screens.loadConfirmScreen.pointerX, screens.loadConfirmScreen.pointerY)
	local buttonName = screens.loadConfirmScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName == "yes" then
		saveUtil.loadGame(screens.loadConfirmScreen.saveSlot)
		--we need to start the background music here as there is no encounter at this point
		audioUtil.playMusic("background")
		frontController.dispatch(frontController.STAR_MAP_SCREEN)
		return
	elseif buttonName == "no" then
		frontController.dispatch(frontController.LOAD_SCREEN)
		return
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.loadConfirmScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if not xbox.leftThumbMoved and thumbLX > 0 then
		screens.loadConfirmScreen.screenButtonList:selectNext()
		xbox.leftThumbMoved = true
	elseif not xbox.leftThumbMoved and thumbLX < 0 then
		screens.loadConfirmScreen.screenButtonList:selectPrev()
		xbox.leftThumbMoved = true
	elseif xbox.leftThumbMoved and thumbLX == 0 then
		xbox.leftThumbMoved = false
	end
	screens.loadConfirmScreen.screenButtonList:selectedVisible(true)
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local buttonName = screens.loadConfirmScreen.screenButtonList:getSelected()
		if buttonName == "yes" then
			saveUtil.loadGame(screens.loadConfirmScreen.saveSlot)
			--we need to start the background music here as there is no encounter at this point
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		elseif buttonName == "no" then
			frontController.dispatch(frontController.LOAD_SCREEN)
			return
		end
	end
	
end

