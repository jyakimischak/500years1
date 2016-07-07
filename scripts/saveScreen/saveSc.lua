--####################################
-- saveSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the save screen.
--####################################

--namespace screens.saveScreen

screens.saveScreen.pointerX = 0
screens.saveScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.saveScreen.pointerCallback(x, y)
	cursorHover = false

	screens.saveScreen.pointerX, screens.saveScreen.pointerY = x, y 
	screens.saveScreen.bannerButtonList:pointer(screens.saveScreen.layers.bannerLayer:wndToWorld(screens.saveScreen.pointerX, screens.saveScreen.pointerY))
	screens.saveScreen.screenButtonList:pointer(screens.saveScreen.layers.screenLayer:wndToWorld(screens.saveScreen.pointerX, screens.saveScreen.pointerY))

	if windowsBuild then
		xbox.mouseMoved(screens.saveScreen.pointerX, x, screens.saveScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.saveScreen.clickCallback(down)
	local bannerWorldX, bannerWorldY = screens.saveScreen.layers.bannerLayer:wndToWorld(screens.saveScreen.pointerX, screens.saveScreen.pointerY)
	local buttonName = screens.saveScreen.bannerButtonList:click(bannerWorldX, bannerWorldY, down)
	if buttonName == "back" then
		frontController.dispatch(frontController.OPTIONS_SCREEN)
		return
	end

	local screenWorldX, screenWorldY = screens.saveScreen.layers.screenLayer:wndToWorld(screens.saveScreen.pointerX, screens.saveScreen.pointerY)
	local buttonName = screens.saveScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName == "save1" then
		if screens.saveScreen.save1Empty then
			saveUtil.saveGame(1)
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		else
			screens.saveConfirmScreen.saveSlot = 1
			frontController.dispatch(frontController.SAVE_CONFIRM_SCREEN)
			return
		end
	elseif buttonName == "save2" then
		if screens.saveScreen.save2Empty then
			saveUtil.saveGame(2)
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		else
			screens.saveConfirmScreen.saveSlot = 2
			frontController.dispatch(frontController.SAVE_CONFIRM_SCREEN)
			return
		end
	elseif buttonName == "save3" then
		if screens.saveScreen.save3Empty then
			saveUtil.saveGame(3)
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		else
			screens.saveConfirmScreen.saveSlot = 3
			frontController.dispatch(frontController.SAVE_CONFIRM_SCREEN)
			return
		end
	elseif buttonName == "save4" then
		if screens.saveScreen.save4Empty then
			saveUtil.saveGame(4)
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		else
			screens.saveConfirmScreen.saveSlot = 4
			frontController.dispatch(frontController.SAVE_CONFIRM_SCREEN)
			return
		end
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.saveScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	local buttonName = screens.saveScreen.screenButtonList:getSelected()
	if not xbox.leftThumbMoved and (thumbLX ~= 0 or thumbLY ~= 0) then
		xbox.leftThumbMoved = true
		if buttonName == "save1" and thumbLX > 0 then
			screens.saveScreen.screenButtonList:setSelected("save2")
		elseif buttonName == "save1" and thumbLY < 0 then
			screens.saveScreen.screenButtonList:setSelected("save3")
		elseif buttonName == "save2" and thumbLX < 0 then
			screens.saveScreen.screenButtonList:setSelected("save1")
		elseif buttonName == "save2" and thumbLY < 0 then
			screens.saveScreen.screenButtonList:setSelected("save4")
		elseif buttonName == "save3" and thumbLX > 0 then
			screens.saveScreen.screenButtonList:setSelected("save4")
		elseif buttonName == "save3" and thumbLY > 0 then
			screens.saveScreen.screenButtonList:setSelected("save1")
		elseif buttonName == "save4" and thumbLX < 0 then
			screens.saveScreen.screenButtonList:setSelected("save3")
		elseif buttonName == "save4" and thumbLY > 0 then
			screens.saveScreen.screenButtonList:setSelected("save2")
		end
	end
	if thumbLX == 0 and thumbLY == 0 then
		xbox.leftThumbMoved = false
	end
	
	screens.saveScreen.screenButtonList:selectedVisible(true)

	if xbox.controller:isButtonDown(MOAIXboxController.B, buttons) then
		frontController.dispatch(frontController.OPTIONS_SCREEN)
		return
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		if buttonName == "save1" then
			if screens.saveScreen.save1Empty then
				saveUtil.saveGame(1)
				frontController.dispatch(frontController.STAR_MAP_SCREEN)
				return
			else
				screens.saveConfirmScreen.saveSlot = 1
				frontController.dispatch(frontController.SAVE_CONFIRM_SCREEN)
				return
			end
		elseif buttonName == "save2" then
			if screens.saveScreen.save2Empty then
				saveUtil.saveGame(2)
				frontController.dispatch(frontController.STAR_MAP_SCREEN)
				return
			else
				screens.saveConfirmScreen.saveSlot = 2
				frontController.dispatch(frontController.SAVE_CONFIRM_SCREEN)
				return
			end
		elseif buttonName == "save3" then
			if screens.saveScreen.save3Empty then
				saveUtil.saveGame(3)
				frontController.dispatch(frontController.STAR_MAP_SCREEN)
				return
			else
				screens.saveConfirmScreen.saveSlot = 3
				frontController.dispatch(frontController.SAVE_CONFIRM_SCREEN)
				return
			end
		elseif buttonName == "save4" then
			if screens.saveScreen.save4Empty then
				saveUtil.saveGame(4)
				frontController.dispatch(frontController.STAR_MAP_SCREEN)
				return
			else
				screens.saveConfirmScreen.saveSlot = 4
				frontController.dispatch(frontController.SAVE_CONFIRM_SCREEN)
				return
			end
		end
	end
	
end