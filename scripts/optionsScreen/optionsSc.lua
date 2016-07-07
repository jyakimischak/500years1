--####################################
-- optionsSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the options screen.
--####################################

--namespace screens.optionsScreen

screens.optionsScreen.pointerX = 0
screens.optionsScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.optionsScreen.pointerCallback(x, y)
	cursorHover = false

	screens.optionsScreen.pointerX, screens.optionsScreen.pointerY = x, y 
	screens.optionsScreen.bannerButtonList:pointer(screens.optionsScreen.layers.bannerLayer:wndToWorld(screens.optionsScreen.pointerX, screens.optionsScreen.pointerY))
	screens.optionsScreen.screenButtonList:pointer(screens.optionsScreen.layers.screenLayer:wndToWorld(screens.optionsScreen.pointerX, screens.optionsScreen.pointerY))

	if windowsBuild then
		screens.optionsScreen.screenButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.optionsScreen.pointerX, x, screens.optionsScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.optionsScreen.clickCallback(down)
	local bannerWorldX, bannerWorldY = screens.optionsScreen.layers.bannerLayer:wndToWorld(screens.optionsScreen.pointerX, screens.optionsScreen.pointerY)
	local buttonName = screens.optionsScreen.bannerButtonList:click(bannerWorldX, bannerWorldY, down)
	if buttonName == "back" then
		frontController.dispatch(frontController.STAR_MAP_SCREEN)
		return
	end

	local screenWorldX, screenWorldY = screens.optionsScreen.layers.screenLayer:wndToWorld(screens.optionsScreen.pointerX, screens.optionsScreen.pointerY)
	local buttonName = screens.optionsScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName == "crew" then
		frontController.dispatch(frontController.CREW_LIST_SCREEN)
		return
	elseif buttonName == "loadout" then
		--set a flag so that the loadout screens back button will return to the options page
		screens.loadoutScreen.callingScreen = "optionsScreen"
		frontController.dispatch(frontController.LOADOUT_SCREEN)
		return
	elseif buttonName == "log" then
		frontController.dispatch(frontController.LOG_SCREEN)
		return
	elseif buttonName == "save" then
		frontController.dispatch(frontController.SAVE_SCREEN)
		return
	elseif buttonName == "load" then
		screens.loadScreen.callingScreen = "optionsScreen"
		frontController.dispatch(frontController.LOAD_SCREEN)
		return
	elseif buttonName == "quit" then
		screens.quitConfirmScreen.callingScreen = "optionsScreen"
		frontController.dispatch(frontController.QUIT_CONFIRM_SCREEN)
		return
	end
end



--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.optionsScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	local buttonName = screens.optionsScreen.screenButtonList:getSelected()
	if not xbox.leftThumbMoved and (thumbLX ~= 0 or thumbLY ~= 0) then
		xbox.leftThumbMoved = true
		if buttonName == "loadout" and thumbLX > 0 then
			screens.optionsScreen.screenButtonList:setSelected("save")
		elseif buttonName == "loadout" and thumbLY < 0 then
			screens.optionsScreen.screenButtonList:setSelected("crew")
		elseif buttonName == "crew" and thumbLX > 0 then
			screens.optionsScreen.screenButtonList:setSelected("load")
		elseif buttonName == "crew" and thumbLY > 0 then
			screens.optionsScreen.screenButtonList:setSelected("loadout")
		elseif buttonName == "save" and thumbLX < 0 then
			screens.optionsScreen.screenButtonList:setSelected("loadout")
		elseif buttonName == "save" and thumbLY < 0 then
			screens.optionsScreen.screenButtonList:setSelected("load")
		elseif buttonName == "load" and thumbLX < 0 then
			screens.optionsScreen.screenButtonList:setSelected("crew")
		elseif buttonName == "load" and thumbLY > 0 then
			screens.optionsScreen.screenButtonList:setSelected("save")
		elseif buttonName == "load" and thumbLY < 0 then
			screens.optionsScreen.screenButtonList:setSelected("quit")
		elseif buttonName == "quit" and thumbLY > 0 then
			screens.optionsScreen.screenButtonList:setSelected("load")
		end
	end
	if thumbLX == 0 and thumbLY == 0 then
		xbox.leftThumbMoved = false
	end
	
	screens.optionsScreen.screenButtonList:selectedVisible(true)

	if xbox.controller:isButtonDown(MOAIXboxController.B, buttons) then
		frontController.dispatch(frontController.STAR_MAP_SCREEN)
		return
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		if buttonName == "crew" then
			frontController.dispatch(frontController.CREW_LIST_SCREEN)
			return
		elseif buttonName == "loadout" then
			--set a flag so that the loadout screens back button will return to the options page
			screens.loadoutScreen.callingScreen = "optionsScreen"
			frontController.dispatch(frontController.LOADOUT_SCREEN)
			return
		elseif buttonName == "log" then
			frontController.dispatch(frontController.LOG_SCREEN)
			return
		elseif buttonName == "save" then
			frontController.dispatch(frontController.SAVE_SCREEN)
			return
		elseif buttonName == "load" then
			screens.loadScreen.callingScreen = "optionsScreen"
			frontController.dispatch(frontController.LOAD_SCREEN)
			return
		elseif buttonName == "quit" then
			screens.quitConfirmScreen.callingScreen = "optionsScreen"
			frontController.dispatch(frontController.QUIT_CONFIRM_SCREEN)
			return
		end
	end
	
end
