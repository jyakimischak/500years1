--####################################
-- solarSystemSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the solar system.
--####################################

--namespace screens.solarSystemScreen

screens.solarSystemScreen.pointerX = 0
screens.solarSystemScreen.pointerY = 0


--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.solarSystemScreen.pointerCallback(x, y)
	cursorHover = false

	if screens.solarSystemScreen.transition then
		return
	end
	
	screens.solarSystemScreen.pointerX, screens.solarSystemScreen.pointerY = x, y 
	screens.solarSystemScreen.buttonList:pointer(screens.solarSystemScreen.layers.bannerLayer:wndToWorld(screens.solarSystemScreen.pointerX, screens.solarSystemScreen.pointerY))
	screens.solarSystemScreen.clickablePropList:pointer(screens.solarSystemScreen.layers.screenLayer:wndToWorld(screens.solarSystemScreen.pointerX, screens.solarSystemScreen.pointerY))

	if windowsBuild then
		screens.solarSystemScreen.clickablePropList:selectedVisible(false)
		xbox.mouseMoved(screens.solarSystemScreen.pointerX, x, screens.solarSystemScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.solarSystemScreen.clickCallback(down)
	if screens.solarSystemScreen.transition then
		return
	end

	local bannerWorldX, bannerWorldY = screens.solarSystemScreen.layers.bannerLayer:wndToWorld(screens.solarSystemScreen.pointerX, screens.solarSystemScreen.pointerY)
	local buttonName = screens.solarSystemScreen.buttonList:click(bannerWorldX, bannerWorldY, down)
	if buttonName == "back" then
		screens.solarSystemScreen.transition = true
		local transitionThread = MOAICoroutine.new ()
		transitionThread:run (
			function()
				--fade the screen
				screens.solarSystemScreen.props.star:setPriority(100000)
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
				screens.solarSystemScreen.layers.screenLayer:insertProp(fadeProp)
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

				--move the star to it's position on the star map
				local location = model.starMapLocations[gameState.currentLocation]()
				local transitionZoomLength = 1.5
				local locationZoomX = location.width / model.starMapLocations.propBaseWidth / 2
				local locationZoomY = location.height / model.starMapLocations.propBaseWidth / 2
				screens.solarSystemScreen.props.star:seekScl(locationZoomX, locationZoomY, transitionZoomLength)
				local seekLocX = 0
				local seekLocY = 0
				screens.solarSystemScreen.props.star:seekLoc(seekLocX, seekLocY, transitionZoomLength + .5)
				local destScaleX, destScaleY 
				while true do
					coroutine.yield()
					destScaleX, destScaleY = screens.solarSystemScreen.props.star:getScl() 
					if util.fuzzyCompare(destScaleX, locationZoomX, .01) then
						break
					end
				end
				frontController.dispatch(frontController.STAR_MAP_SCREEN)
				return
			end
		)
	end

	local screenWorldX, screenWorldY = screens.solarSystemScreen.layers.screenLayer:wndToWorld(screens.solarSystemScreen.pointerX, screens.solarSystemScreen.pointerY)
	local clickablePropName = screens.solarSystemScreen.clickablePropList:click(screenWorldX, screenWorldY, down)
	if clickablePropName ~= nil then
		screens.solarSystemScreen.transition = true
		local transitonThread = MOAICoroutine.new ()
		transitonThread:run (
			function()
				--update the current planet
				gameState.currentPlanet = clickablePropName
				
				--fade the screen
				screens.solarSystemScreen.props[clickablePropName]:setPriority(100000)
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
				screens.solarSystemScreen.layers.screenLayer:insertProp(fadeProp)
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
					if location.planets[i].functionName == clickablePropName then
						planet = location.planets[i]
						break
					end
				end
				local transitionLength = 2
				local seekLocX = SCREEN_UNITS_X / 2 * -1 + 200
				local seekLocY = SCREEN_UNITS_Y / 2 - 250
				local locationZoomX = planet.width / model.starMapLocations.propBaseWidth * 4
				local locationZoomY = planet.height / model.starMapLocations.propBaseWidth * 4
				screens.solarSystemScreen.props[clickablePropName]:seekLoc(seekLocX, seekLocY, transitionLength-.5)
				screens.solarSystemScreen.props[clickablePropName]:seekScl(locationZoomX, locationZoomY, transitionLength)
				local destScaleX, destScaleY
				while true do
					coroutine.yield()
					destScaleX, destScaleY = screens.solarSystemScreen.props[clickablePropName]:getScl() 
					if util.fuzzyCompare(destScaleX, locationZoomX, .01) then
						break
					end
				end
				frontController.dispatch(frontController.PLANET_SCREEN)
				return
			end
		)
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.solarSystemScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if screens.solarSystemScreen.transition then
		return
	end

	if not xbox.leftThumbMoved and thumbLX > 0 then
		screens.solarSystemScreen.clickablePropList:selectNext()
		xbox.leftThumbMoved = true
	elseif not xbox.leftThumbMoved and thumbLX < 0 then
		screens.solarSystemScreen.clickablePropList:selectPrev()
		xbox.leftThumbMoved = true
	elseif xbox.leftThumbMoved and thumbLX == 0 then
		xbox.leftThumbMoved = false
	end

	screens.solarSystemScreen.clickablePropList:selectedVisible(true)

	if xbox.controller:isButtonDown(MOAIXboxController.B, buttons) then
		screens.solarSystemScreen.transition = true
		local transitionThread = MOAICoroutine.new ()
		transitionThread:run (
			function()
				--fade the screen
				screens.solarSystemScreen.props.star:setPriority(100000)
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
				screens.solarSystemScreen.layers.screenLayer:insertProp(fadeProp)
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

				--move the star to it's position on the star map
				local location = model.starMapLocations[gameState.currentLocation]()
				local transitionZoomLength = 1.5
				local locationZoomX = location.width / model.starMapLocations.propBaseWidth / 2
				local locationZoomY = location.height / model.starMapLocations.propBaseWidth / 2
				screens.solarSystemScreen.props.star:seekScl(locationZoomX, locationZoomY, transitionZoomLength)
				local seekLocX = 0
				local seekLocY = 0
				screens.solarSystemScreen.props.star:seekLoc(seekLocX, seekLocY, transitionZoomLength + .5)
				local destScaleX, destScaleY 
				while true do
					coroutine.yield()
					destScaleX, destScaleY = screens.solarSystemScreen.props.star:getScl() 
					if util.fuzzyCompare(destScaleX, locationZoomX, .01) then
						break
					end
				end
				frontController.dispatch(frontController.STAR_MAP_SCREEN)
				return
			end
		)
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local clickablePropName = screens.solarSystemScreen.clickablePropList:getSelected()
		if clickablePropName ~= nil then
			screens.solarSystemScreen.transition = true
			local transitonThread = MOAICoroutine.new ()
			transitonThread:run (
				function()
					--update the current planet
					gameState.currentPlanet = clickablePropName
					
					--fade the screen
					screens.solarSystemScreen.props[clickablePropName]:setPriority(100000)
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
					screens.solarSystemScreen.layers.screenLayer:insertProp(fadeProp)
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
						if location.planets[i].functionName == clickablePropName then
							planet = location.planets[i]
							break
						end
					end
					local transitionLength = 2
					local seekLocX = SCREEN_UNITS_X / 2 * -1 + 200
					local seekLocY = SCREEN_UNITS_Y / 2 - 250
					local locationZoomX = planet.width / model.starMapLocations.propBaseWidth * 4
					local locationZoomY = planet.height / model.starMapLocations.propBaseWidth * 4
					screens.solarSystemScreen.props[clickablePropName]:seekLoc(seekLocX, seekLocY, transitionLength-.5)
					screens.solarSystemScreen.props[clickablePropName]:seekScl(locationZoomX, locationZoomY, transitionLength)
					local destScaleX, destScaleY
					while true do
						coroutine.yield()
						destScaleX, destScaleY = screens.solarSystemScreen.props[clickablePropName]:getScl() 
						if util.fuzzyCompare(destScaleX, locationZoomX, .01) then
							break
						end
					end
					frontController.dispatch(frontController.PLANET_SCREEN)
					return
				end
			)
		end
	end
	

	-- if not xbox.leftThumbMoved and thumbLX > 0 then
		-- screens.quitConfirmScreen.screenButtonList:selectNext()
		-- xbox.leftThumbMoved = true
	-- elseif not xbox.leftThumbMoved and thumbLX < 0 then
		-- screens.quitConfirmScreen.screenButtonList:selectPrev()
		-- xbox.leftThumbMoved = true
	-- elseif xbox.leftThumbMoved and thumbLX == 0 then
		-- xbox.leftThumbMoved = false
	-- end
	-- screens.quitConfirmScreen.screenButtonList:selectedVisible(true)
	
	-- if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		-- local buttonName = screens.quitConfirmScreen.screenButtonList:getSelected()
		-- if buttonName == "yes" then
			-- if screens.quitConfirmScreen.callingScreen == "optionsScreen" then
				-- frontController.dispatch(frontController.START_SCREEN)
			-- else
				-- os.exit()
			-- end
		-- elseif buttonName == "no" then
			-- if screens.quitConfirmScreen.callingScreen == "startScreen" then
				-- frontController.dispatch(frontController.START_SCREEN)
			-- else
				-- frontController.dispatch(frontController.OPTIONS_SCREEN)
			-- end
			-- return
		-- end
	-- end
	
end