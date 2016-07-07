--####################################
-- starMapScreen.lua
-- author: Jonas Yakimischak
--
-- This is the star map of the game.
--####################################

--namespace screens.starMapScreen

screens.starMapScreen.props = {}
screens.starMapScreen.viewports = {}
screens.starMapScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.starMapScreen.display()
	--setup dragging and pinching states
	screens.starMapScreen.dragging = false
	screens.starMapScreen.pinching = false
	--grid dimensions
	screens.starMapScreen.gridCellWidth = 400
	screens.starMapScreen.gridCellHeight = screens.starMapScreen.gridCellWidth * 200 / 160 
	--starmap dimensions
	screens.starMapScreen.cellsWidth = 15
	screens.starMapScreen.cellsHeight = 8
	screens.starMapScreen.width = screens.starMapScreen.gridCellWidth * screens.starMapScreen.cellsWidth
	screens.starMapScreen.height = screens.starMapScreen.gridCellHeight * screens.starMapScreen.cellsHeight
	--scale
	screens.starMapScreen.scale = 2
	--PC Ship size
	screens.starMapScreen.pcShipWidth = 80
	screens.starMapScreen.pcShipHeight = screens.starMapScreen.pcShipWidth * 512 / 256 
	
	--size the textures
	starMapGfxQuads:setRect(starMapNames["starmapBackground.png"], screens.starMapScreen.gridCellWidth * screens.starMapScreen.cellsWidth / 2 * -1, screens.starMapScreen.gridCellHeight * screens.starMapScreen.cellsHeight / 2 * -1, screens.starMapScreen.gridCellWidth * screens.starMapScreen.cellsWidth / 2, screens.starMapScreen.gridCellHeight * screens.starMapScreen.cellsHeight / 2)
	shipsGfxQuads:setRect(shipsNames["pcShipNoOutline.png"], screens.starMapScreen.pcShipWidth / 2 * -1, screens.starMapScreen.pcShipHeight / 2 * -1, screens.starMapScreen.pcShipWidth / 2, screens.starMapScreen.pcShipHeight / 2)
	

	--setup viewports, layers and cameras
	--stars
	screens.starMapScreen.viewports.starsSpeed = 2
	screens.starMapScreen.viewports.starsViewport = MOAIViewport.new()
	screens.starMapScreen.viewports.starsViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.starMapScreen.viewports.starsViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.starMapScreen.layers.starsLayer = MOAILayer2D.new()
	screens.starMapScreen.layers.starsLayer:setViewport(screens.starMapScreen.viewports.starsViewport)
	MOAISim.pushRenderPass(screens.starMapScreen.layers.starsLayer)
	screens.starMapScreen.starsCamera = MOAICamera2D.new()
	screens.starMapScreen.layers.starsLayer:setCamera(screens.starMapScreen.starsCamera)
	screens.starMapScreen.starsFitter = MOAICameraFitter2D.new()
	screens.starMapScreen.starsFitter:setViewport(screens.starMapScreen.viewports.starsViewport)
	screens.starMapScreen.starsFitter:setCamera(screens.starMapScreen.starsCamera)
	screens.starMapScreen.starsFitter:setBounds(screens.starMapScreen.width * -1, screens.starMapScreen.height * -1, screens.starMapScreen.width, screens.starMapScreen.height)
	screens.starMapScreen.starsFitter:start()

	--star map
	screens.starMapScreen.viewports.starMapViewport = MOAIViewport.new()
	screens.starMapScreen.viewports.starMapViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.starMapScreen.viewports.starMapViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.starMapScreen.layers.mapLayer = MOAILayer2D.new()
	screens.starMapScreen.layers.mapLayer:setViewport(screens.starMapScreen.viewports.starMapViewport)
	MOAISim.pushRenderPass(screens.starMapScreen.layers.mapLayer)
	screens.starMapScreen.starMapCamera = MOAICamera2D.new()
	screens.starMapScreen.layers.mapLayer:setCamera(screens.starMapScreen.starMapCamera)
	screens.starMapScreen.starMapFitter = MOAICameraFitter2D.new()
	screens.starMapScreen.starMapFitter:setViewport(screens.starMapScreen.viewports.starMapViewport)
	screens.starMapScreen.starMapFitter:setCamera(screens.starMapScreen.starMapCamera)
	screens.starMapScreen.starMapFitter:setBounds(screens.starMapScreen.width / 2 * -1, screens.starMapScreen.height / 2 * -1, screens.starMapScreen.width / 2, screens.starMapScreen.height / 2)
	screens.starMapScreen.starMapFitter:start()
	screens.starMapScreen.starMapFitter:setFitScale(screens.starMapScreen.scale)

	--banner
	screens.starMapScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.starMapScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.starMapScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.starMapScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.starMapScreen.layers.bannerLayer:setViewport(screens.starMapScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.starMapScreen.layers.bannerLayer)
	
	--setup clickable prop list
	screens.starMapScreen.clickablePropList = screenUtil.getClickablePropList()
	--setup button list
	screens.starMapScreen.buttonList = screenUtil.getButtonList()
	
	--draw the banner background
	screens.starMapScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.starMapScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.starMapScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.starMapScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.starMapScreen.layers.bannerLayer:insertProp(screens.starMapScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.starMapScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.starMapScreen.title)
	
	--add the options button
	screens.starMapScreen.props.optionsButtonProp = screenUtil.addTextBox(
		screens.starMapScreen.layers.bannerLayer,
		SCREEN_UNITS_X / 2 - 70, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		150, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
		textLookup.starMapScreen.options)
	screens.starMapScreen.props.optionsButtonPressedProp = screenUtil.addTextBox(
		screens.starMapScreen.layers.bannerLayer,
		SCREEN_UNITS_X / 2 - 70, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		150, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
		textLookup.starMapScreen.options)
	screens.starMapScreen.props.optionsButtonPressedProp:setVisible(false)
	screens.starMapScreen.buttonList:addButton("options", screens.starMapScreen.props.optionsButtonProp, screens.starMapScreen.props.optionsButtonPressedProp)
	
	--draw the horizontal rule under the title
	local function drawHorizontalRule(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(bannerHRColorR, bannerHRColorG, bannerHRColorB)
		MOAIDraw.fillRect(SCREEN_UNITS_X / 2 * -1, 1, SCREEN_UNITS_X / 2, -2)
	end
	local hrDeck = MOAIScriptDeck.new()
	hrDeck:setRect(SCREEN_UNITS_X / 2 * -1, 1, SCREEN_UNITS_X / 2, -2)
	hrDeck:setDrawCallback(drawHorizontalRule)
	local hrProp = MOAIProp2D.new()
	hrProp:setDeck(hrDeck)
	hrProp:setLoc(0, SCREEN_UNITS_Y / 2 - 67)
	screens.starMapScreen.layers.bannerLayer:insertProp(hrProp)

	--draw the background
	screens.starMapScreen.props.starMapBackground = MOAIProp2D.new()
	screens.starMapScreen.props.starMapBackground:setDeck(starMapGfxQuads)
	screens.starMapScreen.props.starMapBackground:setIndex(starMapNames["starmapBackground.png"])
	screens.starMapScreen.props.starMapBackground:setLoc(0, 0)
	screens.starMapScreen.layers.mapLayer:insertProp(screens.starMapScreen.props.starMapBackground)

	--draw the stars
	--this is starTileSpeed as large as the screen
	--star tile size (star tiles are squares)
	screens.starMapScreen.starTileSpeed = 2
	local numStarTilesX = screens.starMapScreen.width / starTileSize * screens.starMapScreen.starTileSpeed
	local numStarTilesY = screens.starMapScreen.height / starTileSize * screens.starMapScreen.starTileSpeed
	local starTilesBeginPosX = numStarTilesX / 2 * starTileSize * -1
	local starTilesPosX = starTilesBeginPosX 
	local starTilesBeginPosY = numStarTilesY / 2 * starTileSize * -1
	local starTilesPosY = starTilesBeginPosY 
	for i = 1, numStarTilesY do
		for j = 1, numStarTilesX do
			screens.starMapScreen.props["starTile-"..i.."-"..j] = MOAIProp2D.new()
			screens.starMapScreen.props["starTile-"..i.."-"..j]:setDeck(starsGfxQuads)
			screens.starMapScreen.props["starTile-"..i.."-"..j]:setIndex(starsNames["stars"..math.random(1, 5)..".png"])
			screens.starMapScreen.props["starTile-"..i.."-"..j]:setLoc(starTilesPosX, starTilesPosY)
			screens.starMapScreen.layers.starsLayer:insertProp(screens.starMapScreen.props["starTile-"..i.."-"..j])
			starTilesPosX = starTilesPosX + starTileSize
		end
		starTilesPosX = starTilesBeginPosX
		starTilesPosY = starTilesPosY + starTileSize
	end

	--draw the visible locations from the game state
	local location
	for i = 1, gameState.visibleStarMapLocations.length do
		location = model.starMapLocations[gameState.visibleStarMapLocations[i]]()
		--draw the prop
		screens.starMapScreen.props[location.functionName] = model.starMapLocations.getLocationProp(location)
		screens.starMapScreen.props[location.functionName]:setLoc(location.starMapLocX, location.starMapLocY)
		screens.starMapScreen.layers.mapLayer:insertProp(screens.starMapScreen.props[location.functionName])
		screens.starMapScreen.clickablePropList:addClickableProp(location.functionName, screens.starMapScreen.props[location.functionName])

		screenUtil.addTextBox(
			screens.starMapScreen.layers.mapLayer,
			location.starMapLocX, -- centerX
			location.starMapLocY - location.height/2 - 40, -- centerY
			200, -- width
			60, -- height
			fonts.grStylusFont,
			MOAITextBox.CENTER_JUSTIFY,
			MOAITextBox.LEFT_JUSTIFY,
			30, -- fontSize
			1, 1, 1, 1, -- color r g b a
			location.name)
	end

	--get the current location
	location = model.starMapLocations[gameState.currentLocation]()
	
	--setup the cross prop
	if windowsBuild then
		local crossWidth = 20
		local crossHeight = 20
		sharedGfxQuads:setRect(sharedNames["cross.png"], crossWidth / 2 * -1, crossHeight / 2 * -1, crossWidth / 2, crossHeight / 2)
		screens.starMapScreen.props.crossProp = MOAIProp2D.new()
		screens.starMapScreen.props.crossProp:setDeck(sharedGfxQuads)
		screens.starMapScreen.props.crossProp:setIndex(sharedNames["cross.png"])
		screens.starMapScreen.props.crossProp:setVisible(not xbox.cursorVisible)
		screens.starMapScreen.layers.bannerLayer:insertProp(screens.starMapScreen.props.crossProp)
	end

	--if we're not traveling then draw your ship beside the location
	if not gameState.traveling then
		--if we are at a location then center the map on it
		screens.starMapScreen.starMapFitter:setFitLoc(location.starMapLocX, location.starMapLocY)
		screens.starMapScreen.props.pcShip = MOAIProp2D.new()
		screens.starMapScreen.props.pcShip:setDeck(shipsGfxQuads) 
		screens.starMapScreen.props.pcShip:setIndex(shipsNames["pcShipNoOutline.png"])
		screens.starMapScreen.props.pcShip:setLoc(location.starMapLocX + location.width / 2 + 20, location.starMapLocY + location.height / 2 + 10)
		screens.starMapScreen.layers.mapLayer:insertProp(screens.starMapScreen.props.pcShip)
	--else let's draw the ship in the position for traveling
	else
		--if we are traveling then center the map on the travelX, travelY location
		screens.starMapScreen.starMapFitter:setFitLoc(gameState.travelingX, gameState.travelingY)
		screens.starMapScreen.props.pcShip = MOAIProp2D.new()
		screens.starMapScreen.props.pcShip:setDeck(shipsGfxQuads) 
		screens.starMapScreen.props.pcShip:setIndex(shipsNames["pcShipNoOutline.png"])
		screens.starMapScreen.props.pcShip:setLoc(gameState.travelingX, gameState.travelingY)
		screens.starMapScreen.props.pcShip:setRot(gameState.travelingRot)
		screens.starMapScreen.layers.mapLayer:insertProp(screens.starMapScreen.props.pcShip)
		--now move the ship
		screens.starMapScreen.moveShip()
	end

	screens.starMapScreen.startMovementThread()

	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.starMapScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.starMapScreen.clickCallback)
		MOAIInputMgr.device.keyboard:setCallback(screens.starMapScreen.keyboardCallback)
		--xbox controller input
		xbox.setCallback(screens.starMapScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.starMapScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.starMapScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.starMapScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.starMapScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.starMapScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.starMapScreen.destroy()
	--stop the movement thread
	screens.starMapScreen.runMovementThread = false

	screens.starMapScreen.buttonList = nil
	--destroy the props
	for key, value in pairs(screens.starMapScreen.props) do
		screens.starMapScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.starMapScreen.layers) do
		if screens.starMapScreen.layers[key] ~= nil then
			screens.starMapScreen.layers[key]:clear()
			screens.starMapScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.starMapScreen.viewports) do
		screens.starMapScreen.viewports[key] = nil
	end
	--destroy camera and fitter
	screens.starMapScreen.starMapCamera = nil
	screens.starMapScreen.starMapFitter = nil
	--destroy quad and names
	screens.starMapScreen.sharedGfxQuads = nil
	screens.starMapScreen.sharedNames = nil
end


--------------------------------------------------------------------------
-- moveShip
--------------------------------------------------------------------------
function screens.starMapScreen.moveShip()
	if windowsBuild then
		screens.starMapScreen.props.crossProp:setVisible(false)
	end

	local checkEncouter = true
	local startX, startY, destX, destY, shipX, shipY, distance, shipAngle, timeForMove, encounterX, encounterY 
	startX, startY = screens.starMapScreen.props[gameState.currentLocation]:getLoc()
	destX, destY = screens.starMapScreen.props[gameState.destination]:getLoc()
	shipX, shipY = screens.starMapScreen.props.pcShip:getLoc()
	distance, shipAngle = util.cartesianToPolar(destX - shipX, destY - shipY)
	timeForMove = distance / screens.starMapScreen.shipMoveSpeed

	--if we're not already traveling then find the point where the traveling encounter will be called.
	if not gameState.traveling then
		--the encounter will take place between the 1/3 distance and 2/3 distance marks on the journey
		local thirdDistance = distance / 3
		local encounterDistance = math.random(thirdDistance, thirdDistance * 2)
		encounterX, encounterY = util.polarToCartesian(encounterDistance, shipAngle)
		encounterX = encounterX + shipX
		encounterY = encounterY + shipY
	--if we're already traveling then we won't check for a new encounter
	else
		checkEncouter = false
	end
	
	--setup the initial traveling information into the game state
	gameState.traveling = true
	gameState.travelingRot = shipAngle 
	
	local moveShipThread = MOAICoroutine.new ()
	moveShipThread:run (
		function()
			--set screen zoom to the basic
			screens.starMapScreen.starMapFitter:setFitScale(2)

			--move the ship
			screens.starMapScreen.props.pcShip:setRot(shipAngle)
			local moveAction = screens.starMapScreen.props.pcShip:seekLoc(destX, destY, timeForMove)
			shipX, shipY = screens.starMapScreen.props.pcShip:getLoc()
			screens.starMapScreen.starMapFitter:setFitLoc(shipX, shipY)
			screens.starMapScreen.starsFitter:setFitLoc(shipX, shipY)
			while true do
				coroutine.yield()
				shipX, shipY = screens.starMapScreen.props.pcShip:getLoc()
				if util.fuzzyCompare(shipX, destX, 100) and util.fuzzyCompare(shipY, destY, 100) then
					break
				end
				screens.starMapScreen.starMapFitter:setFitLoc(shipX, shipY)
				screens.starMapScreen.starsFitter:setFitLoc(shipX, shipY)
				--check for an encounter
				if checkEncouter then
					if util.fuzzyCompare(shipX, encounterX, 100) and util.fuzzyCompare(shipY, encounterY, 100) then
						gameState.travelingX, gameState.travelingY = shipX, shipY
						if model.encounter.getTravelEncounter() then
							--stop the ship movement
							moveAction:pause()
							return
						end
						checkEncouter = false
					end
				end
			end

			--fade the screen
			screens.starMapScreen.props[gameState.destination]:setPriority(100000)
			local fadeAlpha = 0
			local function drawFade(index, xOff, yOff, xFlip, yFlip)
				MOAIGfxDevice.setPenColor(0, 0, 0, fadeAlpha)
				MOAIDraw.fillRect(screens.starMapScreen.width / 2 * -1, screens.starMapScreen.height / 2 * -1, screens.starMapScreen.width / 2, screens.starMapScreen.height / 2)
			end
			local fadeDeck = MOAIScriptDeck.new()
			fadeDeck:setRect(screens.starMapScreen.width / 2 * -1, screens.starMapScreen.height / 2 * -1, screens.starMapScreen.width / 2, screens.starMapScreen.height / 2)
			fadeDeck:setDrawCallback(drawFade)
			local fadeProp = MOAIProp2D.new()
			fadeProp:setDeck(fadeDeck)
			fadeProp:setLoc(0, 0)
			fadeProp:setPriority(10000)
			screens.starMapScreen.layers.mapLayer:insertProp(fadeProp)
			screens.starMapScreen.layers.starsLayer:clear()
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

			--move the star to the left of the screen and zoom it
			local location = model.starMapLocations[gameState.destination]()
			local transitionZoomLength = 2
			local locationZoomX = location.width / model.starMapLocations.propBaseWidth * 10
			local locationZoomY = location.height / model.starMapLocations.propBaseWidth * 10
			screens.starMapScreen.props[gameState.destination]:seekScl(locationZoomX, locationZoomY, transitionZoomLength)
			local fitterX, fitterY = screens.starMapScreen.starMapFitter:getFitLoc()
			local seekLocX = SCREEN_UNITS_X * -1 + fitterX
			local seekLocY = fitterY
			screens.starMapScreen.props[gameState.destination]:seekLoc(seekLocX, seekLocY, transitionZoomLength - .5)
			local destScaleX, destScaleY 
			while true do
				coroutine.yield()
				destScaleX, destScaleY = screens.starMapScreen.props[gameState.destination]:getScl() 
				if util.fuzzyCompare(destScaleX, locationZoomX, .01) then
					break
				end
			end
			screens.starMapScreen.props[gameState.destination]:setPriority()
			--we've reached the the new location, update the gamestate 
			gameState.currentLocation = gameState.destination
			gameState.destination = nil
			gameState.traveling = false
			gameState.travelingX, gameState.travelingY, gameState.travelingRot = nil, nil, nil
			frontController.dispatch(frontController.SOLAR_SYSTEM_SCREEN)
			return
		end
	)

end



--------------------------------------------------------------------------
-- start the movement thread
--------------------------------------------------------------------------
function screens.starMapScreen.startMovementThread()
	if not windowsBuild then
		return
	end

	local movementThread = MOAICoroutine.new()
	screens.starMapScreen.runMovementThread = true
	screens.starMapScreen.crossMoveX = 0
	screens.starMapScreen.crossMoveY = 0
	screens.starMapScreen.mapMoveX = 0
	screens.starMapScreen.mapMoveY = 0
	screens.starMapScreen.zoomMove = 0
	movementThread:run (
		function()
			while screens.starMapScreen.runMovementThread do
				local crossX, crossY = screens.starMapScreen.props.crossProp:getLoc()
				if crossX + screens.starMapScreen.crossMoveX < (SCREEN_UNITS_X / 2 * -1) + 10 then
					crossX = (SCREEN_UNITS_X / 2 * -1) + 10
				elseif crossX + screens.starMapScreen.crossMoveX > SCREEN_UNITS_X / 2 - 10 then
					crossX = SCREEN_UNITS_X / 2 - 10
				else
					crossX = crossX + screens.starMapScreen.crossMoveX
				end
				if crossY + screens.starMapScreen.crossMoveY < (SCREEN_UNITS_Y / 2 * -1) + 10 then
					crossY = (SCREEN_UNITS_Y / 2 * -1) + 10
				elseif crossY + screens.starMapScreen.crossMoveY > SCREEN_UNITS_Y / 2 - 80 then
					crossY = SCREEN_UNITS_Y / 2 - 80
				else
					crossY = crossY + screens.starMapScreen.crossMoveY
				end
				screens.starMapScreen.props.crossProp:setLoc(crossX, crossY)

				if screens.starMapScreen.mapMoveX ~= 0 or screens.starMapScreen.mapMoveY ~= 0 then
					local cameraX, cameraY, currX, currY
					cameraX, cameraY = screens.starMapScreen.layers.mapLayer:wndToWorld(screens.starMapScreen.starMapCamera:getLoc())
					cameraX = cameraX + ((screens.starMapScreen.mapMoveX) * screens.starMapScreen.scale)
					cameraY = cameraY - ((screens.starMapScreen.mapMoveY) * screens.starMapScreen.scale)
					screens.starMapScreen.starMapFitter:setFitLoc(screens.starMapScreen.layers.mapLayer:worldToWnd(cameraX, cameraY))
					screens.starMapScreen.starsFitter:setFitLoc(screens.starMapScreen.layers.mapLayer:worldToWnd(cameraX, cameraY))
				end
				
				if screens.starMapScreen.zoomMove ~= 0 then
					if screens.starMapScreen.zoomMove < 0 then
						if screens.starMapScreen.scale < 5 then
							screens.starMapScreen.scale = screens.starMapScreen.scale + .05
						else
							screens.starMapScreen.scale = 5
						end
					elseif screens.starMapScreen.zoomMove > 0 then
						if screens.starMapScreen.scale > 1 then
							screens.starMapScreen.scale = screens.starMapScreen.scale - .05
						else
							screens.starMapScreen.scale = 1
						end
					end
					screens.starMapScreen.starMapFitter:setFitScale(screens.starMapScreen.scale)
				end

				coroutine.yield()
			end
		end
	)
end