--####################################
-- crewListSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the crew list screen.
--####################################

--namespace screens.crewListScreen

screens.crewListScreen.pointerX = 0
screens.crewListScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.crewListScreen.pointerCallback(x, y)
	cursorHover = false

	screens.crewListScreen.pointerX, screens.crewListScreen.pointerY = x, y 
	screens.crewListScreen.bannerButtonList:pointer(screens.crewListScreen.layers.bannerLayer:wndToWorld(screens.crewListScreen.pointerX, screens.crewListScreen.pointerY))
	screens.crewListScreen.clickablePropList:pointer(screens.crewListScreen.layers.screenLayer:wndToWorld(screens.crewListScreen.pointerX, screens.crewListScreen.pointerY))

	if windowsBuild then
		screens.crewListScreen.clickablePropList:selectedVisible(false)
		xbox.mouseMoved(screens.crewListScreen.pointerX, x, screens.crewListScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.crewListScreen.clickCallback(down)
	local bannerWorldX, bannerWorldY = screens.crewListScreen.layers.bannerLayer:wndToWorld(screens.crewListScreen.pointerX, screens.crewListScreen.pointerY)
	local buttonName = screens.crewListScreen.bannerButtonList:click(bannerWorldX, bannerWorldY, down)
	if buttonName == "back" then
		frontController.dispatch(frontController.OPTIONS_SCREEN)
		return
	end

	local screenWorldX, screenWorldY = screens.crewListScreen.layers.screenLayer:wndToWorld(screens.crewListScreen.pointerX, screens.crewListScreen.pointerY)
	local clickablePropName = screens.crewListScreen.clickablePropList:click(screenWorldX, screenWorldY, down)
	if clickablePropName ~= nil then
		gameState.crewDetailsViewing = clickablePropName 
		frontController.dispatch(frontController.CREW_DETAILS_SCREEN)
		return
	end

end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.crewListScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	local clickablePropName = screens.crewListScreen.clickablePropList:getSelected()
	if not xbox.leftThumbMoved and (thumbLX ~= 0 or thumbLY ~= 0) then
		xbox.leftThumbMoved = true
		if clickablePropName == "oleg" and thumbLX > 0 then
			screens.crewListScreen.clickablePropList:setSelected("charlie")
		elseif clickablePropName == "oleg" and thumbLY < 0 and gameState.crew.jarvis then
			screens.crewListScreen.clickablePropList:setSelected("jarvis")
		elseif clickablePropName == "charlie" and thumbLX < 0 then
			screens.crewListScreen.clickablePropList:setSelected("oleg")
		elseif clickablePropName == "charlie" and thumbLX > 0 and gameState.crew.clarence then
			screens.crewListScreen.clickablePropList:setSelected("clarence")
		elseif clickablePropName == "charlie" and thumbLY < 0 and gameState.crew.frank then
			screens.crewListScreen.clickablePropList:setSelected("frank")
		elseif clickablePropName == "clarence" and thumbLX < 0 then
			screens.crewListScreen.clickablePropList:setSelected("charlie")
		elseif clickablePropName == "clarence" and thumbLY < 0 and gameState.crew.yepp then
			screens.crewListScreen.clickablePropList:setSelected("yepp")
		elseif clickablePropName == "jarvis" and thumbLX > 0 and gameState.crew.frank then
			screens.crewListScreen.clickablePropList:setSelected("frank")
		elseif clickablePropName == "jarvis" and thumbLY > 0 then
			screens.crewListScreen.clickablePropList:setSelected("oleg")
		elseif clickablePropName == "frank" and thumbLX < 0 and gameState.crew.jarvis then
			screens.crewListScreen.clickablePropList:setSelected("jarvis")
		elseif clickablePropName == "frank" and thumbLX > 0 and gameState.crew.yepp then
			screens.crewListScreen.clickablePropList:setSelected("yepp")
		elseif clickablePropName == "frank" and thumbLY > 0 then
			screens.crewListScreen.clickablePropList:setSelected("charlie")
		elseif clickablePropName == "yepp" and thumbLX < 0 and gameState.crew.frank then
			screens.crewListScreen.clickablePropList:setSelected("frank")
		elseif clickablePropName == "yepp" and thumbLY > 0 and gameState.crew.clarence then
			screens.crewListScreen.clickablePropList:setSelected("clarence")
		end
	end
	if thumbLX == 0 and thumbLY == 0 then
		xbox.leftThumbMoved = false
	end
	
	screens.crewListScreen.clickablePropList:selectedVisible(true)

	if xbox.controller:isButtonDown(MOAIXboxController.B, buttons) then
		frontController.dispatch(frontController.OPTIONS_SCREEN)
		return
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		if clickablePropName ~= nil then
			gameState.crewDetailsViewing = clickablePropName 
			frontController.dispatch(frontController.CREW_DETAILS_SCREEN)
			return
		end
	end
	
end
