--####################################
-- solarSystemScreen.lua
-- author: Jonas Yakimischak
--
-- This is the solar system screen for the game.
--####################################

--namespace screens.solarSystemScreen

screens.solarSystemScreen.props = {}
screens.solarSystemScreen.viewports = {}
screens.solarSystemScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.solarSystemScreen.display()
	--lock for when a planet is chosen and a transition is taking place
	screens.solarSystemScreen.transition = false
	--setup the viewports and layers
	--screen
	screens.solarSystemScreen.viewports.screenViewport = MOAIViewport.new()
	screens.solarSystemScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.solarSystemScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.solarSystemScreen.layers.screenLayer = MOAILayer2D.new()
	screens.solarSystemScreen.layers.screenLayer:setViewport(screens.solarSystemScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.solarSystemScreen.layers.screenLayer)
	--banner
	screens.solarSystemScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.solarSystemScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.solarSystemScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.solarSystemScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.solarSystemScreen.layers.bannerLayer:setViewport(screens.solarSystemScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.solarSystemScreen.layers.bannerLayer)

	--setup the button selected prop
	if windowsBuild then
		local selectedArrowWidth = 30
		local selectedArrowHeight = selectedArrowWidth * 110 / 100
		sharedGfxQuads:setRect(sharedNames["selectArrow.png"], selectedArrowWidth / 2 * -1, selectedArrowHeight / 2 * -1, selectedArrowWidth / 2, selectedArrowHeight / 2)
		screens.solarSystemScreen.props.selectedArrowProp = MOAIProp2D.new()
		screens.solarSystemScreen.props.selectedArrowProp:setDeck(sharedGfxQuads)
		screens.solarSystemScreen.props.selectedArrowProp:setIndex(sharedNames["selectArrow.png"])
		screens.solarSystemScreen.props.selectedArrowProp:setVisible(false)
		screens.solarSystemScreen.layers.screenLayer:insertProp(screens.solarSystemScreen.props.selectedArrowProp)
	end
	--setup clickable prop list
	screens.solarSystemScreen.clickablePropList = screenUtil.getClickablePropList(screens.solarSystemScreen.props.selectedArrowProp)
	--setup button list
	screens.solarSystemScreen.buttonList = screenUtil.getButtonList()
	

	local location = model.starMapLocations[gameState.currentLocation]()
	
	--draw the banner background
	screens.solarSystemScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.solarSystemScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.solarSystemScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.solarSystemScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.solarSystemScreen.layers.bannerLayer:insertProp(screens.solarSystemScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.solarSystemScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		location.name)
	
	--add the back button
	screens.solarSystemScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.solarSystemScreen.layers.bannerLayer,
		SCREEN_UNITS_X / 2 * -1 + 70, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		150, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
		textLookup.general.back)
	screens.solarSystemScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.solarSystemScreen.layers.bannerLayer,
		SCREEN_UNITS_X / 2 * -1 + 70, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		150, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
		textLookup.general.back)
	screens.solarSystemScreen.props.backButtonPressedProp:setVisible(false)
	screens.solarSystemScreen.buttonList:addButton("back", screens.solarSystemScreen.props.backButtonProp, screens.solarSystemScreen.props.backButtonPressedProp)
	
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
	screens.solarSystemScreen.layers.bannerLayer:insertProp(hrProp)


	--draw the stars
	--star tile size (star tiles are squares)
	local numStarTilesX = SCREEN_UNITS_X / starTileSize
	local numStarTilesY = SCREEN_UNITS_Y / starTileSize
	local starTilesBeginPosX = numStarTilesX / 2 * starTileSize * -1
	local starTilesPosX = starTilesBeginPosX 
	local starTilesBeginPosY = numStarTilesY / 2 * starTileSize * -1
	local starTilesPosY = starTilesBeginPosY 
	for i = 1, numStarTilesY+1 do
		for j = 1, numStarTilesX+1 do
			screens.solarSystemScreen.props["starTile-"..i.."-"..j] = MOAIProp2D.new()
			screens.solarSystemScreen.props["starTile-"..i.."-"..j]:setDeck(starsGfxQuads)
			screens.solarSystemScreen.props["starTile-"..i.."-"..j]:setIndex(starsNames["stars"..math.random(1, 4)..".png"])
			screens.solarSystemScreen.props["starTile-"..i.."-"..j]:setLoc(starTilesPosX, starTilesPosY)
			screens.solarSystemScreen.layers.screenLayer:insertProp(screens.solarSystemScreen.props["starTile-"..i.."-"..j])
			starTilesPosX = starTilesPosX + starTileSize
		end
		starTilesPosX = starTilesBeginPosX
		starTilesPosY = starTilesPosY + starTileSize
	end


	--draw the location (star) sprite at the leftmost center of the screen
	screens.solarSystemScreen.props.star = model.starMapLocations.getLocationProp(location, 5)
	screens.solarSystemScreen.props.star:setLoc(SCREEN_UNITS_X / 2 * -1, 0)
	screens.solarSystemScreen.layers.screenLayer:insertProp(screens.solarSystemScreen.props.star)

	--run through and add the planets
	if location.planets ~= nil then
		for i=1,location.planets.length do
			local value=location.planets[i]
			screens.solarSystemScreen.props[value.functionName] = model.starMapLocations.getPlanetProp(value)
			screens.solarSystemScreen.props[value.functionName]:setLoc(value.locX, value.locY)
			screens.solarSystemScreen.layers.screenLayer:insertProp(screens.solarSystemScreen.props[value.functionName])
			screens.solarSystemScreen.clickablePropList:addClickableProp(value.functionName, screens.solarSystemScreen.props[value.functionName], (value.width / 2 * -1)-15, 0)
			screenUtil.addTextBox(
				screens.solarSystemScreen.layers.screenLayer,
				value.locX, -- centerX
				value.locY - value.height / 2 - 40, -- centerY
				200, -- width
				60, -- height
				fonts.grStylusFont,
				MOAITextBox.CENTER_JUSTIFY,
				MOAITextBox.LEFT_JUSTIFY,
				15, -- fontSize
				1, 1, 1, 1, -- color r g b a 
				value.name)
		end
	end

	
	
	
	-- --run through and add the planets
	-- if location.planets ~= nil then
		-- for key, value in pairs(location.planets) do
			-- screens.solarSystemScreen.props[value.functionName] = model.starMapLocations.getPlanetProp(value)
			-- screens.solarSystemScreen.props[value.functionName]:setLoc(value.locX, value.locY)
			-- screens.solarSystemScreen.layers.screenLayer:insertProp(screens.solarSystemScreen.props[value.functionName])
			-- screens.solarSystemScreen.clickablePropList:addClickableProp(value.functionName, screens.solarSystemScreen.props[value.functionName], value.width * -1, 0)
			-- screenUtil.addTextBox(
				-- screens.solarSystemScreen.layers.screenLayer,
				-- value.locX, -- centerX
				-- value.locY - value.height / 2 - 40, -- centerY
				-- 200, -- width
				-- 60, -- height
				-- fonts.grStylusFont,
				-- MOAITextBox.CENTER_JUSTIFY,
				-- MOAITextBox.LEFT_JUSTIFY,
				-- 15, -- fontSize
				-- 1, 1, 1, 1, -- color r g b a 
				-- value.name)
		-- end
	-- end

	if windowsBuild then
		screens.solarSystemScreen.clickablePropList:selectedVisible(not xbox.cursorVisible)
	end


	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.solarSystemScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.solarSystemScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.solarSystemScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.solarSystemScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.solarSystemScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.solarSystemScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.solarSystemScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.solarSystemScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.solarSystemScreen.destroy()
	screens.solarSystemScreen.clickablePropList = nil
	screens.solarSystemScreen.buttonList = nil
	--destroy the props
	for key, value in pairs(screens.solarSystemScreen.props) do
		screens.solarSystemScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.solarSystemScreen.layers) do
		if screens.solarSystemScreen.layers[key] ~= nil then
			screens.solarSystemScreen.layers[key]:clear()
			screens.solarSystemScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.solarSystemScreen.viewports) do
		screens.solarSystemScreen.viewports[key] = nil
	end
end

