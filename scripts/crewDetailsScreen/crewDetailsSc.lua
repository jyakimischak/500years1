--####################################
-- crewDetailsSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the crew details screen.
--####################################

--namespace screens.crewDetailsScreen

screens.crewDetailsScreen.pointerX = 0
screens.crewDetailsScreen.pointerY = 0

screens.crewDetailsScreen.scrollingCrewBackground = false

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.crewDetailsScreen.pointerCallback(x, y)
	cursorHover = false

	--if we are scrolling then scroll the background information text
	if screens.crewDetailsScreen.scrollingCrewBackground then
		local backgroundX, backgroundY = screens.crewDetailsScreen.props.crewBackground:getLoc()
		backgroundY = backgroundY - (y - screens.crewDetailsScreen.pointerY)
		if backgroundY < 0 then
			backgroundY = 0
		end
		if backgroundY > screens.crewDetailsScreen.crewBackgroundMaxY then
			backgroundY = screens.crewDetailsScreen.crewBackgroundMaxY
		end
		screens.crewDetailsScreen.props.crewBackground:setLoc(backgroundX, backgroundY)
	end

	screens.crewDetailsScreen.pointerX, screens.crewDetailsScreen.pointerY = x, y 
	screens.crewDetailsScreen.bannerButtonList:pointer(screens.crewDetailsScreen.layers.bannerLayer:wndToWorld(screens.crewDetailsScreen.pointerX, screens.crewDetailsScreen.pointerY))
	screens.crewDetailsScreen.screenButtonList:pointer(screens.crewDetailsScreen.layers.screenLayer:wndToWorld(screens.crewDetailsScreen.pointerX, screens.crewDetailsScreen.pointerY))

	if windowsBuild then
		screens.crewDetailsScreen.screenButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.crewDetailsScreen.pointerX, x, screens.crewDetailsScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.crewDetailsScreen.clickCallback(down)
	--if it's a touch up then stop scrolling
	if not down then
		screens.crewDetailsScreen.scrollingCrewBackground = false
	end

	local bannerWorldX, bannerWorldY = screens.crewDetailsScreen.layers.bannerLayer:wndToWorld(screens.crewDetailsScreen.pointerX, screens.crewDetailsScreen.pointerY)
	local buttonName = screens.crewDetailsScreen.bannerButtonList:click(bannerWorldX, bannerWorldY, down)
	if buttonName == "back" then
		gameState.crewDetailsViewing = nil
		frontController.dispatch(frontController.CREW_LIST_SCREEN)
		return
	end

	local screenWorldX, screenWorldY = screens.crewDetailsScreen.layers.screenLayer:wndToWorld(screens.crewDetailsScreen.pointerX, screens.crewDetailsScreen.pointerY)
	local buttonName = screens.crewDetailsScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName == "talk" then
		if gameState.crewDetailsViewing == "oleg" then
			model.encounter.getTriggeredEncounter("speakWithOleg")
		elseif gameState.crewDetailsViewing == "charlie" then
			model.encounter.getTriggeredEncounter("speakWithCharlie")
		elseif gameState.crewDetailsViewing == "clarence" then
			model.encounter.getTriggeredEncounter("speakWithClarence")
		elseif gameState.crewDetailsViewing == "jarvis" then
			model.encounter.getTriggeredEncounter("speakWithJarvis")
		elseif gameState.crewDetailsViewing == "frank" then
			model.encounter.getTriggeredEncounter("speakWithFrank")
		elseif gameState.crewDetailsViewing == "yepp" then
			model.encounter.getTriggeredEncounter("speakWithYepp")
		end
		return
	end

	if down and screens.crewDetailsScreen.props.crewBackground:inside(screenWorldX, screenWorldY) then
		screens.crewDetailsScreen.scrollingCrewBackground = true
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.crewDetailsScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	screens.crewDetailsScreen.screenButtonList:selectedVisible(true)
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		if gameState.crewDetailsViewing == "oleg" then
			model.encounter.getTriggeredEncounter("speakWithOleg")
		elseif gameState.crewDetailsViewing == "charlie" then
			model.encounter.getTriggeredEncounter("speakWithCharlie")
		elseif gameState.crewDetailsViewing == "clarence" then
			model.encounter.getTriggeredEncounter("speakWithClarence")
		elseif gameState.crewDetailsViewing == "jarvis" then
			model.encounter.getTriggeredEncounter("speakWithJarvis")
		elseif gameState.crewDetailsViewing == "frank" then
			model.encounter.getTriggeredEncounter("speakWithFrank")
		elseif gameState.crewDetailsViewing == "yepp" then
			model.encounter.getTriggeredEncounter("speakWithYepp")
		end
		return
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.B, buttons) then
		gameState.crewDetailsViewing = nil
		frontController.dispatch(frontController.CREW_LIST_SCREEN)
		return
	end

	if thumbRY == 0 then
		screens.crewDetailsScreen.bgMoveAmount = 0
	else
		if thumbRY > 20000 then
			screens.crewDetailsScreen.bgMoveAmount = -10
		elseif thumbRY > 0 then
			screens.crewDetailsScreen.bgMoveAmount = -3
		elseif thumbRY < 20000 then
			screens.crewDetailsScreen.bgMoveAmount = 10
		elseif thumbRY < 0 then
			screens.crewDetailsScreen.bgMoveAmount = 3
		end
	end
end
