--####################################
-- planetSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the planet screen.
--####################################

--namespace screens.planetScreen

screens.planetScreen.pointerX = 0
screens.planetScreen.pointerY = 0

screens.planetScreen.scrollingPlanetInfo = false

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.planetScreen.pointerCallback(x, y)
	cursorHover = false

	--if we are scrolling then scroll the planet information text
	if screens.planetScreen.scrollingPlanetInfo then
		local infoX, infoY = screens.planetScreen.props.planetInformation:getLoc()
		infoY = infoY - (y - screens.planetScreen.pointerY)
		if infoY < 0 then
			infoY = 0
		end
		if infoY > screens.planetScreen.planetInfoMaxY then
			infoY = screens.planetScreen.planetInfoMaxY
		end
		screens.planetScreen.props.planetInformation:setLoc(infoX, infoY)
	end

	screens.planetScreen.pointerX, screens.planetScreen.pointerY = x, y 
	screens.planetScreen.bannerButtonList:pointer(screens.planetScreen.layers.bannerLayer:wndToWorld(screens.planetScreen.pointerX, screens.planetScreen.pointerY))
	screens.planetScreen.screenButtonList:pointer(screens.planetScreen.layers.screenLayer:wndToWorld(screens.planetScreen.pointerX, screens.planetScreen.pointerY))

	if windowsBuild then
		screens.planetScreen.screenButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.planetScreen.pointerX, x, screens.planetScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.planetScreen.clickCallback(down)
	--if it's a touch up then stop scrolling
	if not down then
		screens.planetScreen.scrollingPlanetInfo = false
	end
	
	local bannerWorldX, bannerWorldY = screens.planetScreen.layers.bannerLayer:wndToWorld(screens.planetScreen.pointerX, screens.planetScreen.pointerY)
	local buttonName = screens.planetScreen.bannerButtonList:click(bannerWorldX, bannerWorldY, down)
	if buttonName == "back" then
		local transitonThread = MOAICoroutine.new ()
		transitonThread:run (
			function()
				--fade the screen
				screens.planetScreen.props.planet:setPriority(100000)
				local fadeAlpha = 0
				local function drawFade(index, xOff, yOff, xFlip, yFlip)
					MOAIGfxDevice.setPenColor(0, 0, 0, fadeAlpha)
					MOAIDraw.fillRect(SCREEN_UNITS_X / 2 * -1, SCREEN_UNITS_Y / 2 * -1, SCREEN_UNITS_X / 2, SCREEN_UNITS_Y / 2)
				end
				local fadeDeck = MOAIScriptDeck.new()
				fadeDeck:setRect(SCREEN_UNITS_X / 2 * -1, SCREEN_UNITS_Y / 2 * -1, SCREEN_UNITS_X / 2, SCREEN_UNITS_Y / 2)
				fadeDeck:setDrawCallback(drawFade)
				local fadeProp = MOAIProp2D.new()
				fadeProp:setDeck(fadeDeck)
				fadeProp:setLoc(0, 0)
				fadeProp:setPriority(10000)
				screens.planetScreen.layers.screenLayer:insertProp(fadeProp)
				local fadeTimer = MOAITimer.new()
				fadeTimer:setMode(MOAITimer.CONTINUE)
				fadeTimer:start()
				local prevTime = fadeTimer:getTime()
				local currTime = nil
				while fadeAlpha < 1 do
					coroutine.yield()
					currTime = fadeTimer:getTime()
					local delta = (currTime - prevTime) * 1
					if fadeAlpha + delta > 1 then
						fadeAlpha = 1
					else
						fadeAlpha = fadeAlpha + delta
					end
				end
				fadeTimer:stop()		

				--scale and translate the planet to where it will be on the planet screen
				local location = model.starMapLocations[gameState.currentLocation]()
				local planet
				for i=1,location.planets.length do
					if location.planets[i].functionName == gameState.currentPlanet then
						planet = location.planets[i]
						break
					end
				end
				local transitionLength = 1.5
				local seekLocX = planet.locX
				local seekLocY = planet.locY
				local locationZoomX = planet.width / model.starMapLocations.propBaseWidth
				local locationZoomY = planet.height / model.starMapLocations.propBaseWidth
				screens.planetScreen.props.planet:seekLoc(seekLocX, seekLocY, transitionLength+.5)
				screens.planetScreen.props.planet:seekScl(locationZoomX, locationZoomY, transitionLength)
				local destScaleX, destScaleY
				while true do
					coroutine.yield()
					destScaleX, destScaleY = screens.planetScreen.props.planet:getScl() 
					if util.fuzzyCompare(destScaleX, locationZoomX, .01) then
						break
					end
				end
				--update the current planet
				gameState.currentPlanet = nil
				frontController.dispatch(frontController.SOLAR_SYSTEM_SCREEN)
				return
			end
		)
	end

	local screenWorldX, screenWorldY = screens.planetScreen.layers.screenLayer:wndToWorld(screens.planetScreen.pointerX, screens.planetScreen.pointerY)
	local buttonName = screens.planetScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName ~= nil then
		model.encounter.getTriggeredEncounter(buttonName)
	end
	
	if down and screens.planetScreen.props.planetInformation:inside(screenWorldX, screenWorldY) then
		screens.planetScreen.scrollingPlanetInfo = true
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.planetScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	screens.planetScreen.screenButtonList:selectedVisible(true)
	local buttonName = screens.planetScreen.screenButtonList:getSelected()
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		if buttonName ~= nil then
			model.encounter.getTriggeredEncounter(buttonName)
		end
		return
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.B, buttons) then
		local transitonThread = MOAICoroutine.new ()
		transitonThread:run (
			function()
				--fade the screen
				screens.planetScreen.props.planet:setPriority(100000)
				local fadeAlpha = 0
				local function drawFade(index, xOff, yOff, xFlip, yFlip)
					MOAIGfxDevice.setPenColor(0, 0, 0, fadeAlpha)
					MOAIDraw.fillRect(SCREEN_UNITS_X / 2 * -1, SCREEN_UNITS_Y / 2 * -1, SCREEN_UNITS_X / 2, SCREEN_UNITS_Y / 2)
				end
				local fadeDeck = MOAIScriptDeck.new()
				fadeDeck:setRect(SCREEN_UNITS_X / 2 * -1, SCREEN_UNITS_Y / 2 * -1, SCREEN_UNITS_X / 2, SCREEN_UNITS_Y / 2)
				fadeDeck:setDrawCallback(drawFade)
				local fadeProp = MOAIProp2D.new()
				fadeProp:setDeck(fadeDeck)
				fadeProp:setLoc(0, 0)
				fadeProp:setPriority(10000)
				screens.planetScreen.layers.screenLayer:insertProp(fadeProp)
				local fadeTimer = MOAITimer.new()
				fadeTimer:setMode(MOAITimer.CONTINUE)
				fadeTimer:start()
				local prevTime = fadeTimer:getTime()
				local currTime = nil
				while fadeAlpha < 1 do
					coroutine.yield()
					currTime = fadeTimer:getTime()
					local delta = (currTime - prevTime) * 1
					if fadeAlpha + delta > 1 then
						fadeAlpha = 1
					else
						fadeAlpha = fadeAlpha + delta
					end
				end
				fadeTimer:stop()		

				--scale and translate the planet to where it will be on the planet screen
				local location = model.starMapLocations[gameState.currentLocation]()
				local planet
				for i=1,location.planets.length do
					if location.planets[i].functionName == gameState.currentPlanet then
						planet = location.planets[i]
						break
					end
				end
				local transitionLength = 1.5
				local seekLocX = planet.locX
				local seekLocY = planet.locY
				local locationZoomX = planet.width / model.starMapLocations.propBaseWidth
				local locationZoomY = planet.height / model.starMapLocations.propBaseWidth
				screens.planetScreen.props.planet:seekLoc(seekLocX, seekLocY, transitionLength+.5)
				screens.planetScreen.props.planet:seekScl(locationZoomX, locationZoomY, transitionLength)
				local destScaleX, destScaleY
				while true do
					coroutine.yield()
					destScaleX, destScaleY = screens.planetScreen.props.planet:getScl() 
					if util.fuzzyCompare(destScaleX, locationZoomX, .01) then
						break
					end
				end
				--update the current planet
				gameState.currentPlanet = nil
				frontController.dispatch(frontController.SOLAR_SYSTEM_SCREEN)
				return
			end
		)
	end

	if thumbRY == 0 then
		screens.planetScreen.infoMoveAmount = 0
	else
		if thumbRY > 20000 then
			screens.planetScreen.infoMoveAmount = -10
		elseif thumbRY > 0 then
			screens.planetScreen.infoMoveAmount = -3
		elseif thumbRY < 20000 then
			screens.planetScreen.infoMoveAmount = 10
		elseif thumbRY < 0 then
			screens.planetScreen.infoMoveAmount = 3
		end
	end
end
