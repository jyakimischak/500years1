--####################################
-- planetScreen.lua
-- author: Jonas Yakimischak
--
-- This is the planet screen for the game.
--####################################

--namespace screens.planetScreen

screens.planetScreen.props = {}
screens.planetScreen.viewports = {}
screens.planetScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.planetScreen.display()
	--setup the viewports and layers
	--screen
	screens.planetScreen.viewports.screenViewport = MOAIViewport.new()
	screens.planetScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.planetScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.planetScreen.layers.screenLayer = MOAILayer2D.new()
	screens.planetScreen.layers.screenLayer:setViewport(screens.planetScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.planetScreen.layers.screenLayer)
	--banner
	screens.planetScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.planetScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.planetScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.planetScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.planetScreen.layers.bannerLayer:setViewport(screens.planetScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.planetScreen.layers.bannerLayer)

	--size the buttons
	local buttonWidth = 150
	local buttonHeight = buttonWidth * 36 / 100
	sharedGfxQuads:setRect(sharedNames["circuitButton.png"], buttonWidth / 2 * -1, buttonHeight / 2 * -1, buttonWidth / 2, buttonHeight / 2)
	sharedGfxQuads:setRect(sharedNames["circuitButtonPressed.png"], buttonWidth / 2 * -1, buttonHeight / 2 * -1, buttonWidth / 2, buttonHeight / 2)
	--setup the button selected prop
	if windowsBuild then
		local selectedButtonWidth = buttonWidth + buttonWidth/15
		local selectedButtonHeight = buttonHeight + buttonWidth/15
		sharedGfxQuads:setRect(sharedNames["buttonSelected.png"], selectedButtonWidth / 2 * -1, selectedButtonHeight / 2 * -1, selectedButtonWidth / 2, selectedButtonHeight / 2)
		screens.planetScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.planetScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.planetScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.planetScreen.props.selectedButtonProp:setVisible(false)
		screens.planetScreen.layers.screenLayer:insertProp(screens.planetScreen.props.selectedButtonProp)
	end
	--setup button lists
	screens.planetScreen.bannerButtonList = screenUtil.getButtonList()
	screens.planetScreen.screenButtonList = screenUtil.getButtonList(screens.planetScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.planetScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end

	local location = model.starMapLocations[gameState.currentLocation]()
	local planet
	for i=1,location.planets.length do
		if location.planets[i].functionName == gameState.currentPlanet then
			planet = location.planets[i]
			break
		end
	end
	
	--draw the banner background
	screens.planetScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.planetScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.planetScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.planetScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.planetScreen.layers.bannerLayer:insertProp(screens.planetScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.planetScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		planet.name)
	
	--add the back button
	screens.planetScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.planetScreen.layers.bannerLayer,
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
	screens.planetScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.planetScreen.layers.bannerLayer,
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
	screens.planetScreen.props.backButtonPressedProp:setVisible(false)
	screens.planetScreen.bannerButtonList:addButton("back", screens.planetScreen.props.backButtonProp, screens.planetScreen.props.backButtonPressedProp)
	
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
	screens.planetScreen.layers.bannerLayer:insertProp(hrProp)


	--draw the planet
	screens.planetScreen.props.planet = model.starMapLocations.getPlanetProp(planet, 4)
	screens.planetScreen.props.planet:setLoc(SCREEN_UNITS_X / 2 * -1 + 200, SCREEN_UNITS_Y / 2 - 250)
	screens.planetScreen.layers.screenLayer:insertProp(screens.planetScreen.props.planet)
	
	--draw the planet information text box
	screens.planetScreen.planetInfoMinY = -10000 + 230
	screens.planetScreen.planetInfoMaxY = 10000
--	screens.planetScreen.planetInfoMaxY = planet.information:len() / 50 * 25
	screens.planetScreen.props.planetInformation = screenUtil.addTextBox(
		screens.planetScreen.layers.screenLayer,
		190, -- centerX
		screens.planetScreen.planetInfoMinY - 30, -- centerY
		600, -- width
		20000, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		planet.information)


	local actionId, actionName = planet:action1()
	if actionId ~= nil then
		screens.planetScreen.props.button1Prop = MOAIProp2D.new()
		screens.planetScreen.props.button1Prop:setDeck(sharedGfxQuads)
		screens.planetScreen.props.button1Prop:setIndex(sharedNames["circuitButton.png"])
		screens.planetScreen.props.button1Prop:setLoc(-400, -200)
		screens.planetScreen.layers.screenLayer:insertProp(screens.planetScreen.props.button1Prop)
		screens.planetScreen.props.button1PressedProp = MOAIProp2D.new()
		screens.planetScreen.props.button1PressedProp:setDeck(sharedGfxQuads)
		screens.planetScreen.props.button1PressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
		screens.planetScreen.props.button1PressedProp:setLoc(-400, -200)
		screens.planetScreen.layers.screenLayer:insertProp(screens.planetScreen.props.button1PressedProp)
		screens.planetScreen.props.button1PressedProp:setVisible(false)
		screenUtil.addTextBox(
			screens.planetScreen.layers.screenLayer,
			-400, -- centerX
			-200, -- centerY
			150, -- width
			25, -- height
			fonts.grStylusFont,
			MOAITextBox.CENTER_JUSTIFY,
			MOAITextBox.CENTER_JUSTIFY,
			25, -- fontSize
			1, 1, 1, 1, -- color r g b a 
			actionName)
		screens.planetScreen.screenButtonList:addButton(actionId, screens.planetScreen.props.button1Prop, screens.planetScreen.props.button1PressedProp)
	end

	actionId, actionName = planet:action2()
	if actionId ~= nil then
		screens.planetScreen.props.button2Prop = MOAIProp2D.new()
		screens.planetScreen.props.button2Prop:setDeck(sharedGfxQuads)
		screens.planetScreen.props.button2Prop:setIndex(sharedNames["circuitButton.png"])
		screens.planetScreen.props.button2Prop:setLoc(-400 + buttonWidth + 20, -200)
		screens.planetScreen.layers.screenLayer:insertProp(screens.planetScreen.props.button2Prop)
		screens.planetScreen.props.button2PressedProp = MOAIProp2D.new()
		screens.planetScreen.props.button2PressedProp:setDeck(sharedGfxQuads)
		screens.planetScreen.props.button2PressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
		screens.planetScreen.props.button2PressedProp:setLoc(-400, -200)
		screens.planetScreen.layers.screenLayer:insertProp(screens.planetScreen.props.button2PressedProp)
		screens.planetScreen.props.button2PressedProp:setVisible(false)
		screenUtil.addTextBox(
			screens.planetScreen.layers.screenLayer,
			-400 + buttonWidth + 20, -- centerX
			-200, -- centerY
			150, -- width
			25, -- height
			fonts.grStylusFont,
			MOAITextBox.CENTER_JUSTIFY,
			MOAITextBox.CENTER_JUSTIFY,
			25, -- fontSize
			1, 1, 1, 1, -- color r g b a 
			actionName)
		screens.planetScreen.screenButtonList:addButton(actionId, screens.planetScreen.props.button2Prop, screens.planetScreen.props.button2PressedProp)
	end
	
	screens.planetScreen.startInfoMoveThread()

	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.planetScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.planetScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.planetScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.planetScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.planetScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.planetScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.planetScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.planetScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.planetScreen.destroy()
	--stop the info move thread
	screens.planetScreen.runInfoMoveThread = false

	screens.planetScreen.clickablePropList = nil
	screens.planetScreen.bannerButtonList = nil
	--destroy the props
	for key, value in pairs(screens.planetScreen.props) do
		screens.planetScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.planetScreen.layers) do
		if screens.planetScreen.layers[key] ~= nil then
			screens.planetScreen.layers[key]:clear()
			screens.planetScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.planetScreen.viewports) do
		screens.planetScreen.viewports[key] = nil
	end
end

--------------------------------------------------------------------------
-- start the background info thread
--------------------------------------------------------------------------
function screens.planetScreen.startInfoMoveThread()
	if not windowsBuild then
		return
	end

	local infoMoveThread = MOAICoroutine.new()
	screens.planetScreen.runInfoMoveThread = true
	screens.planetScreen.infoMoveAmount = 0
	infoMoveThread:run (
		function()
			while screens.planetScreen.runInfoMoveThread do
				local infoX, infoY = screens.planetScreen.props.planetInformation:getLoc()
				infoY = infoY + screens.planetScreen.infoMoveAmount
				if infoY < 0 then
					infoY = 0
				end
				screens.planetScreen.props.planetInformation:setLoc(infoX, infoY)
				coroutine.yield()
			end
		end
	)
end

	