--####################################
-- optionsScreen.lua
-- author: Jonas Yakimischak
--
-- This is the options screen for the game.
--####################################

--namespace screens.optionsScreen

screens.optionsScreen.props = {}
screens.optionsScreen.viewports = {}
screens.optionsScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.optionsScreen.display()
	--setup the viewports and layers
	--screen
	screens.optionsScreen.viewports.screenViewport = MOAIViewport.new()
	screens.optionsScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.optionsScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.optionsScreen.layers.screenLayer = MOAILayer2D.new()
	screens.optionsScreen.layers.screenLayer:setViewport(screens.optionsScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.optionsScreen.layers.screenLayer)
	--banner
	screens.optionsScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.optionsScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.optionsScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.optionsScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.optionsScreen.layers.bannerLayer:setViewport(screens.optionsScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.optionsScreen.layers.bannerLayer)

	--background
	screens.optionsScreen.props.backgroundProp = MOAIProp2D.new()
	screens.optionsScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.optionsScreen.props.backgroundProp:setLoc(0, 0)
	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.backgroundProp)

	--setup clickable prop list
	screens.optionsScreen.clickablePropList = screenUtil.getClickablePropList()

	--size the buttons
	local buttonWidth = 200
	local buttonHeight = buttonWidth * 36 / 100
	sharedGfxQuads:setRect(sharedNames["circuitButton.png"], buttonWidth / 2 * -1, buttonHeight / 2 * -1, buttonWidth / 2, buttonHeight / 2)
	sharedGfxQuads:setRect(sharedNames["circuitButtonPressed.png"], buttonWidth / 2 * -1, buttonHeight / 2 * -1, buttonWidth / 2, buttonHeight / 2)

	--setup the button selected prop
	if windowsBuild then
		local selectedButtonWidth = buttonWidth + buttonWidth/15
		local selectedButtonHeight = buttonHeight + buttonWidth/15
		sharedGfxQuads:setRect(sharedNames["buttonSelected.png"], selectedButtonWidth / 2 * -1, selectedButtonHeight / 2 * -1, selectedButtonWidth / 2, selectedButtonHeight / 2)
		screens.optionsScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.optionsScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.optionsScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.optionsScreen.props.selectedButtonProp:setVisible(false)
		screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.selectedButtonProp)
	end
	--setup button lists
	screens.optionsScreen.bannerButtonList = screenUtil.getButtonList()
	screens.optionsScreen.screenButtonList = screenUtil.getButtonList(screens.optionsScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.optionsScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end

	--load the textures
	--draw the banner background
	screens.optionsScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.optionsScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.optionsScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.optionsScreen.layers.bannerLayer:insertProp(screens.optionsScreen.props.bannerBackgroundProp)
	
	--draw the title
	screenUtil.addTextBox(
		screens.optionsScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.optionsScreen.title)
		
	--add the back button
	screens.optionsScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.optionsScreen.layers.bannerLayer,
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
	screens.optionsScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.optionsScreen.layers.bannerLayer,
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
	screens.optionsScreen.props.backButtonPressedProp:setVisible(false)
	screens.optionsScreen.bannerButtonList:addButton("back", screens.optionsScreen.props.backButtonProp, screens.optionsScreen.props.backButtonPressedProp)
	
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
	screens.optionsScreen.layers.bannerLayer:insertProp(hrProp)

	--add the loadout button
	screens.optionsScreen.props.loadoutButtonProp = MOAIProp2D.new()
	screens.optionsScreen.props.loadoutButtonProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.loadoutButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.optionsScreen.props.loadoutButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1 - 50, SCREEN_UNITS_Y / 4)
	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.loadoutButtonProp)
	--pressed
	screens.optionsScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.optionsScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.optionsScreen.props.loadoutButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1 - 50, SCREEN_UNITS_Y / 4)
	screens.optionsScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.loadoutButtonPressedProp)
	screens.optionsScreen.screenButtonList:addButton("loadout", screens.optionsScreen.props.loadoutButtonProp, screens.optionsScreen.props.loadoutButtonPressedProp)
	screenUtil.addTextBox(
		screens.optionsScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1 - 50, -- centerX
		SCREEN_UNITS_Y / 4, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.optionsScreen.loadout)

	--add the crew button
	screens.optionsScreen.props.crewButtonProp = MOAIProp2D.new()
	screens.optionsScreen.props.crewButtonProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.crewButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.optionsScreen.props.crewButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1 - 50, 0)
	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.crewButtonProp)
	--pressed
	screens.optionsScreen.props.crewButtonPressedProp = MOAIProp2D.new()
	screens.optionsScreen.props.crewButtonPressedProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.crewButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.optionsScreen.props.crewButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1 - 50, 0)
	screens.optionsScreen.props.crewButtonPressedProp:setVisible(false)
	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.crewButtonPressedProp)
	screens.optionsScreen.screenButtonList:addButton("crew", screens.optionsScreen.props.crewButtonProp, screens.optionsScreen.props.crewButtonPressedProp)
	screenUtil.addTextBox(
		screens.optionsScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1 - 50, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.optionsScreen.crew)

--might not have a log
--	--add the log button
--	screens.optionsScreen.props.logButtonProp = MOAIProp2D.new()
--	screens.optionsScreen.props.logButtonProp:setDeck(sharedGfxQuads)
--	screens.optionsScreen.props.logButtonProp:setIndex(sharedNames["circuitButton.png"])
--	screens.optionsScreen.props.logButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1 - 50, SCREEN_UNITS_Y / 4 * -1)
--	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.logButtonProp)
--	--pressed
--	screens.optionsScreen.props.logButtonPressedProp = MOAIProp2D.new()
--	screens.optionsScreen.props.logButtonPressedProp:setDeck(sharedGfxQuads)
--	screens.optionsScreen.props.logButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
--	screens.optionsScreen.props.logButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1 - 50, SCREEN_UNITS_Y / 4 * -1)
--	screens.optionsScreen.props.logButtonPressedProp:setVisible(false)
--	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.logButtonPressedProp)
--	screens.optionsScreen.screenButtonList:addButton("log", screens.optionsScreen.props.logButtonProp, screens.optionsScreen.props.logButtonPressedProp)
--	screenUtil.addTextBox(
--		screens.optionsScreen.layers.screenLayer,
--		SCREEN_UNITS_X / 4 * -1 - 50, -- centerX
--		SCREEN_UNITS_Y / 4 * -1, -- centerY
--		buttonWidth, -- width
--		buttonHeight, -- height
--		fonts.grStylusFont,
--		MOAITextBox.CENTER_JUSTIFY,
--		MOAITextBox.CENTER_JUSTIFY,
--		30, -- fontSize,
--		1, 1, 1, 1, -- color r g b a 
--		textLookup.optionsScreen.log)

	--NOTE: decided against having additional options.
--	--add the options button
--	screens.optionsScreen.props.optionsButtonProp = MOAIProp2D.new()
--	screens.optionsScreen.props.optionsButtonProp:setDeck(sharedGfxQuads)
--	screens.optionsScreen.props.optionsButtonProp:setIndex(sharedNames["circuitButton.png"])
--	screens.optionsScreen.props.optionsButtonProp:setLoc(0, SCREEN_UNITS_Y / 4)
--	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.optionsButtonProp)
--	--pressed
--	screens.optionsScreen.props.optionsButtonPressedProp = MOAIProp2D.new()
--	screens.optionsScreen.props.optionsButtonPressedProp:setDeck(sharedGfxQuads)
--	screens.optionsScreen.props.optionsButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
--	screens.optionsScreen.props.optionsButtonPressedProp:setLoc(0, SCREEN_UNITS_Y / 4)
--	screens.optionsScreen.props.optionsButtonPressedProp:setVisible(false)
--	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.optionsButtonPressedProp)
--	screens.optionsScreen.screenButtonList:addButton("options", screens.optionsScreen.props.optionsButtonProp, screens.optionsScreen.props.optionsButtonPressedProp)
--	screenUtil.addTextBox(
--		screens.optionsScreen.layers.screenLayer,
--		0, -- centerX
--		SCREEN_UNITS_Y / 4, -- centerY
--		buttonWidth, -- width
--		buttonHeight, -- height
--		fonts.grStylusFont,
--		MOAITextBox.CENTER_JUSTIFY,
--		MOAITextBox.CENTER_JUSTIFY,
--		30, -- fontSize,
--		1, 1, 1, 1, -- color r g b a 
--		textLookup.optionsScreen.options)

	--add the save button
	screens.optionsScreen.props.saveButtonProp = MOAIProp2D.new()
	screens.optionsScreen.props.saveButtonProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.saveButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.optionsScreen.props.saveButtonProp:setLoc(SCREEN_UNITS_X / 4 + 50, SCREEN_UNITS_Y / 4)
	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.saveButtonProp)
	--pressed
	screens.optionsScreen.props.saveButtonPressedProp = MOAIProp2D.new()
	screens.optionsScreen.props.saveButtonPressedProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.saveButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.optionsScreen.props.saveButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 + 50, SCREEN_UNITS_Y / 4)
	screens.optionsScreen.props.saveButtonPressedProp:setVisible(false)
	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.saveButtonPressedProp)
	screens.optionsScreen.screenButtonList:addButton("save", screens.optionsScreen.props.saveButtonProp, screens.optionsScreen.props.saveButtonPressedProp)
	screenUtil.addTextBox(
		screens.optionsScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 + 50, -- centerX
		SCREEN_UNITS_Y / 4, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.optionsScreen.save)

	--add the load button
	screens.optionsScreen.props.loadButtonProp = MOAIProp2D.new()
	screens.optionsScreen.props.loadButtonProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.loadButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.optionsScreen.props.loadButtonProp:setLoc(SCREEN_UNITS_X / 4 + 50, 0)
	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.loadButtonProp)
	--pressed
	screens.optionsScreen.props.loadButtonPressedProp = MOAIProp2D.new()
	screens.optionsScreen.props.loadButtonPressedProp:setDeck(sharedGfxQuads)
	screens.optionsScreen.props.loadButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.optionsScreen.props.loadButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 + 50, 0)
	screens.optionsScreen.props.loadButtonPressedProp:setVisible(false)
	screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.loadButtonPressedProp)
	screens.optionsScreen.screenButtonList:addButton("load", screens.optionsScreen.props.loadButtonProp, screens.optionsScreen.props.loadButtonPressedProp)
	screenUtil.addTextBox(
		screens.optionsScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 + 50, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.optionsScreen.load)

	--NOTE: android and iOS apps don't have a quit button
	if windowsBuild then
		--add the quit button
		screens.optionsScreen.props.quitButtonProp = MOAIProp2D.new()
		screens.optionsScreen.props.quitButtonProp:setDeck(sharedGfxQuads)
		screens.optionsScreen.props.quitButtonProp:setIndex(sharedNames["circuitButton.png"])
		screens.optionsScreen.props.quitButtonProp:setLoc(SCREEN_UNITS_X / 4 + 50, SCREEN_UNITS_Y / 4 * -1)
		screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.quitButtonProp)
		--pressed
		screens.optionsScreen.props.quitButtonPressedProp = MOAIProp2D.new()
		screens.optionsScreen.props.quitButtonPressedProp:setDeck(sharedGfxQuads)
		screens.optionsScreen.props.quitButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
		screens.optionsScreen.props.quitButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 + 50, SCREEN_UNITS_Y / 4 * -1)
		screens.optionsScreen.props.quitButtonPressedProp:setVisible(false)
		screens.optionsScreen.layers.screenLayer:insertProp(screens.optionsScreen.props.quitButtonPressedProp)
		screens.optionsScreen.screenButtonList:addButton("quit", screens.optionsScreen.props.quitButtonProp, screens.optionsScreen.props.quitButtonPressedProp)
		screenUtil.addTextBox(
			screens.optionsScreen.layers.screenLayer,
			SCREEN_UNITS_X / 4 + 50, -- centerX
			SCREEN_UNITS_Y / 4 * -1, -- centerY
			buttonWidth, -- width
			buttonHeight, -- height
			fonts.grStylusFont,
			MOAITextBox.CENTER_JUSTIFY,
			MOAITextBox.CENTER_JUSTIFY,
			30, -- fontSize,
			1, 1, 1, 1, -- color r g b a 
			textLookup.optionsScreen.quit)
	end



	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.optionsScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.optionsScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.optionsScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.optionsScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.optionsScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.optionsScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.optionsScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.optionsScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.optionsScreen.destroy()
	screens.optionsScreen.clickablePropList = nil
	screens.optionsScreen.bannerButtonList = nil
	screens.optionsScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.optionsScreen.props) do
		screens.optionsScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.optionsScreen.layers) do
		if screens.optionsScreen.layers[key] ~= nil then
			screens.optionsScreen.layers[key]:clear()
			screens.optionsScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.optionsScreen.viewports) do
		screens.optionsScreen.viewports[key] = nil
	end
end

