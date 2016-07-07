--####################################
-- loadSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the load screen.
--####################################

--namespace screens.loadScreen

screens.loadScreen.pointerX = 0
screens.loadScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.loadScreen.pointerCallback(x, y)
	cursorHover = false

	screens.loadScreen.pointerX, screens.loadScreen.pointerY = x, y 
	screens.loadScreen.bannerButtonList:pointer(screens.loadScreen.layers.bannerLayer:wndToWorld(screens.loadScreen.pointerX, screens.loadScreen.pointerY))
	screens.loadScreen.screenButtonList:pointer(screens.loadScreen.layers.screenLayer:wndToWorld(screens.loadScreen.pointerX, screens.loadScreen.pointerY))

	if windowsBuild then
		screens.loadScreen.screenButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.loadScreen.pointerX, x, screens.loadScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.loadScreen.clickCallback(down)
	local bannerWorldX, bannerWorldY = screens.loadScreen.layers.bannerLayer:wndToWorld(screens.loadScreen.pointerX, screens.loadScreen.pointerY)
	local buttonName = screens.loadScreen.bannerButtonList:click(bannerWorldX, bannerWorldY, down)
	if buttonName == "back" then
		if	screens.loadScreen.callingScreen == "startScreen" then
			frontController.dispatch(frontController.START_SCREEN)
			return
		else
			frontController.dispatch(frontController.OPTIONS_SCREEN)
			return
		end
	end

	local screenWorldX, screenWorldY = screens.loadScreen.layers.screenLayer:wndToWorld(screens.loadScreen.pointerX, screens.loadScreen.pointerY)
	local buttonName = screens.loadScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName == "save1" then
		if not screens.loadScreen.save1Empty then
			screens.loadConfirmScreen.saveSlot = 1
			frontController.dispatch(frontController.LOAD_CONFIRM_SCREEN)
			return
		end
	elseif buttonName == "save2" then
		if not screens.loadScreen.save2Empty then
			screens.loadConfirmScreen.saveSlot = 2
			frontController.dispatch(frontController.LOAD_CONFIRM_SCREEN)
			return
		end
	elseif buttonName == "save3" then
		if not screens.loadScreen.save3Empty then
			screens.loadConfirmScreen.saveSlot = 3
			frontController.dispatch(frontController.LOAD_CONFIRM_SCREEN)
			return
		end
	elseif buttonName == "save4" then
		if not screens.loadScreen.save4Empty then
			screens.loadConfirmScreen.saveSlot = 4
			frontController.dispatch(frontController.LOAD_CONFIRM_SCREEN)
			return
		end
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.loadScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	local buttonName = screens.loadScreen.screenButtonList:getSelected()
	if not xbox.leftThumbMoved and (thumbLX ~= 0 or thumbLY ~= 0) then
		xbox.leftThumbMoved = true
		if buttonName == "save1" and thumbLX > 0 then
			screens.loadScreen.screenButtonList:setSelected("save2")
		elseif buttonName == "save1" and thumbLY < 0 then
			screens.loadScreen.screenButtonList:setSelected("save3")
		elseif buttonName == "save2" and thumbLX < 0 then
			screens.loadScreen.screenButtonList:setSelected("save1")
		elseif buttonName == "save2" and thumbLY < 0 then
			screens.loadScreen.screenButtonList:setSelected("save4")
		elseif buttonName == "save3" and thumbLX > 0 then
			screens.loadScreen.screenButtonList:setSelected("save4")
		elseif buttonName == "save3" and thumbLY > 0 then
			screens.loadScreen.screenButtonList:setSelected("save1")
		elseif buttonName == "save4" and thumbLX < 0 then
			screens.loadScreen.screenButtonList:setSelected("save3")
		elseif buttonName == "save4" and thumbLY > 0 then
			screens.loadScreen.screenButtonList:setSelected("save2")
		end
	end
	if thumbLX == 0 and thumbLY == 0 then
		xbox.leftThumbMoved = false
	end
	
	screens.loadScreen.screenButtonList:selectedVisible(true)

	if xbox.controller:isButtonDown(MOAIXboxController.B, buttons) then
		if	screens.loadScreen.callingScreen == "startScreen" then
			frontController.dispatch(frontController.START_SCREEN)
			return
		else
			frontController.dispatch(frontController.OPTIONS_SCREEN)
			return
		end
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		if buttonName == "save1" then
			if not screens.loadScreen.save1Empty then
				screens.loadConfirmScreen.saveSlot = 1
				frontController.dispatch(frontController.LOAD_CONFIRM_SCREEN)
				return
			end
		elseif buttonName == "save2" then
			if not screens.loadScreen.save2Empty then
				screens.loadConfirmScreen.saveSlot = 2
				frontController.dispatch(frontController.LOAD_CONFIRM_SCREEN)
				return
			end
		elseif buttonName == "save3" then
			if not screens.loadScreen.save3Empty then
				screens.loadConfirmScreen.saveSlot = 3
				frontController.dispatch(frontController.LOAD_CONFIRM_SCREEN)
				return
			end
		elseif buttonName == "save4" then
			if not screens.loadScreen.save4Empty then
				screens.loadConfirmScreen.saveSlot = 4
				frontController.dispatch(frontController.LOAD_CONFIRM_SCREEN)
				return
			end
		end
	end
	
end