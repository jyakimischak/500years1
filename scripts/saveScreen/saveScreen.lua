--####################################
-- saveScreen.lua
-- author: Jonas Yakimischak
--
-- This is the save screen for the game.
--####################################

--namespace screens.saveScreen

screens.saveScreen.props = {}
screens.saveScreen.viewports = {}
screens.saveScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.saveScreen.display()
	--setup the viewports and layers
	--screen
	screens.saveScreen.viewports.screenViewport = MOAIViewport.new()
	screens.saveScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.saveScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.saveScreen.layers.screenLayer = MOAILayer2D.new()
	screens.saveScreen.layers.screenLayer:setViewport(screens.saveScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.saveScreen.layers.screenLayer)
	--banner
	screens.saveScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.saveScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.saveScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.saveScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.saveScreen.layers.bannerLayer:setViewport(screens.saveScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.saveScreen.layers.bannerLayer)

	--background
	screens.saveScreen.props.backgroundProp = MOAIProp2D.new()
	screens.saveScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.saveScreen.props.backgroundProp:setLoc(0, 0)
	screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.backgroundProp)

	--size the buttons
	screens.saveScreen.buttonWidth = 400
	screens.saveScreen.buttonHeight = screens.saveScreen.buttonWidth * 36 / 100
	sharedGfxQuads:setRect(sharedNames["circuitButton.png"], screens.saveScreen.buttonWidth / 2 * -1, screens.saveScreen.buttonHeight / 2 * -1, screens.saveScreen.buttonWidth / 2, screens.saveScreen.buttonHeight / 2)
	sharedGfxQuads:setRect(sharedNames["circuitButtonPressed.png"], screens.saveScreen.buttonWidth / 2 * -1, screens.saveScreen.buttonHeight / 2 * -1, screens.saveScreen.buttonWidth / 2, screens.saveScreen.buttonHeight / 2)
	--setup the button selected prop
	if windowsBuild then
		local selectedButtonWidth = screens.saveScreen.buttonWidth + screens.saveScreen.buttonWidth/15
		local selectedButtonHeight = screens.saveScreen.buttonHeight + screens.saveScreen.buttonWidth/15
		sharedGfxQuads:setRect(sharedNames["buttonSelected.png"], selectedButtonWidth / 2 * -1, selectedButtonHeight / 2 * -1, selectedButtonWidth / 2, selectedButtonHeight / 2)
		screens.saveScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.saveScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.saveScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.saveScreen.props.selectedButtonProp:setVisible(false)
		screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.selectedButtonProp)
	end
	--setup button lists
	screens.saveScreen.bannerButtonList = screenUtil.getButtonList()
	screens.saveScreen.screenButtonList = screenUtil.getButtonList(screens.saveScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.saveScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end
	
	--draw the banner background
	screens.saveScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.saveScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.saveScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.saveScreen.layers.bannerLayer:insertProp(screens.saveScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.saveScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.saveScreen.title)
		
	--add the back button
	screens.saveScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.saveScreen.layers.bannerLayer,
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
	screens.saveScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.saveScreen.layers.bannerLayer,
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
	screens.saveScreen.props.backButtonPressedProp:setVisible(false)
	screens.saveScreen.bannerButtonList:addButton("back", screens.saveScreen.props.backButtonProp, screens.saveScreen.props.backButtonPressedProp)
	
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
	screens.saveScreen.layers.bannerLayer:insertProp(hrProp)

	screens.saveScreen.buttonYOffset = 30

	--add the first save button
	screens.saveScreen.props.save3ButtonProp = MOAIProp2D.new()
	screens.saveScreen.props.save3ButtonProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.save3ButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.saveScreen.props.save3ButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1, SCREEN_UNITS_Y / 4 - screens.saveScreen.buttonYOffset)
	screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.save3ButtonProp)
	--pressed
	screens.saveScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.saveScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.saveScreen.props.loadoutButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1, SCREEN_UNITS_Y / 4 - screens.saveScreen.buttonYOffset)
	screens.saveScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.loadoutButtonPressedProp)
	screens.saveScreen.screenButtonList:addButton("save1", screens.saveScreen.props.save3ButtonProp, screens.saveScreen.props.loadoutButtonPressedProp)

	--add the second save button
	screens.saveScreen.props.save2ButtonProp = MOAIProp2D.new()
	screens.saveScreen.props.save2ButtonProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.save2ButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.saveScreen.props.save2ButtonProp:setLoc(SCREEN_UNITS_X / 4, SCREEN_UNITS_Y / 4 - screens.saveScreen.buttonYOffset)
	screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.save2ButtonProp)
	--pressed
	screens.saveScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.saveScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.saveScreen.props.loadoutButtonPressedProp:setLoc(SCREEN_UNITS_X / 4, SCREEN_UNITS_Y / 4 - screens.saveScreen.buttonYOffset)
	screens.saveScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.loadoutButtonPressedProp)
	screens.saveScreen.screenButtonList:addButton("save2", screens.saveScreen.props.save2ButtonProp, screens.saveScreen.props.loadoutButtonPressedProp)

	--add the third save button
	screens.saveScreen.props.save3ButtonProp = MOAIProp2D.new()
	screens.saveScreen.props.save3ButtonProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.save3ButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.saveScreen.props.save3ButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1, SCREEN_UNITS_Y / 4 * -1 - screens.saveScreen.buttonYOffset)
	screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.save3ButtonProp)
	--pressed
	screens.saveScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.saveScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.saveScreen.props.loadoutButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1, SCREEN_UNITS_Y / 4 * -1 - screens.saveScreen.buttonYOffset)
	screens.saveScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.loadoutButtonPressedProp)
	screens.saveScreen.screenButtonList:addButton("save3", screens.saveScreen.props.save3ButtonProp, screens.saveScreen.props.loadoutButtonPressedProp)

	--add the fourth save button
	screens.saveScreen.props.save4ButtonProp = MOAIProp2D.new()
	screens.saveScreen.props.save4ButtonProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.save4ButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.saveScreen.props.save4ButtonProp:setLoc(SCREEN_UNITS_X / 4, SCREEN_UNITS_Y / 4 * -1 - screens.saveScreen.buttonYOffset)
	screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.save4ButtonProp)
	--pressed
	screens.saveScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.saveScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.saveScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.saveScreen.props.loadoutButtonPressedProp:setLoc(SCREEN_UNITS_X / 4, SCREEN_UNITS_Y / 4 * -1 - screens.saveScreen.buttonYOffset)
	screens.saveScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.saveScreen.layers.screenLayer:insertProp(screens.saveScreen.props.loadoutButtonPressedProp)
	screens.saveScreen.screenButtonList:addButton("save4", screens.saveScreen.props.save4ButtonProp, screens.saveScreen.props.loadoutButtonPressedProp)
		
	--draw the labels on the buttons
	screens.saveScreen.drawSaveLabels()


		--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.saveScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.saveScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.saveScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.saveScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.saveScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.saveScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.saveScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.saveScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.saveScreen.destroy()
	screens.saveScreen.bannerButtonList = nil
	screens.saveScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.saveScreen.props) do
		screens.saveScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.saveScreen.layers) do
		if screens.saveScreen.layers[key] ~= nil then
			screens.saveScreen.layers[key]:clear()
			screens.saveScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.saveScreen.viewports) do
		screens.saveScreen.viewports[key] = nil
	end
end


--------------------------------------------------------------------------
-- drawSaveLabels
-- Draw the labels for the save buttons 
--------------------------------------------------------------------------
function screens.saveScreen.drawSaveLabels()
	local saveGameState
	--save 1
	local save1Label
	if util.doesFileExist(documentsDirectory.."/save1") then
		saveGameState = dofile(documentsDirectory.."/save1")
		save1Label = saveGameState.saveDate
		screens.saveScreen.save1Empty = false
	else
		save1Label = textLookup.saveScreen.empty
		screens.saveScreen.save1Empty = true
	end
	screenUtil.addTextBox(
		screens.saveScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1, -- centerX
		SCREEN_UNITS_Y / 4 - screens.saveScreen.buttonYOffset, -- centerY
		screens.saveScreen.buttonWidth, -- width
		screens.saveScreen.buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		save1Label)

	--save 2
	local save2Label
	if util.doesFileExist(documentsDirectory.."/save2") then
		saveGameState = dofile(documentsDirectory.."/save2")
		save2Label = saveGameState.saveDate
		screens.saveScreen.save2Empty = false
	else
		save2Label = textLookup.saveScreen.empty
		screens.saveScreen.save2Empty = true
	end
	screenUtil.addTextBox(
		screens.saveScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4, -- centerX
		SCREEN_UNITS_Y / 4 - screens.saveScreen.buttonYOffset, -- centerY
		screens.saveScreen.buttonWidth, -- width
		screens.saveScreen.buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		save2Label)

	--save 3
	local save3Label
	if util.doesFileExist(documentsDirectory.."/save3") then
		saveGameState = dofile(documentsDirectory.."/save3")
		save3Label = saveGameState.saveDate
		screens.saveScreen.save3Empty = false
	else
		save3Label = textLookup.saveScreen.empty
		screens.saveScreen.save3Empty = true
	end
	screenUtil.addTextBox(
		screens.saveScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1, -- centerX
		SCREEN_UNITS_Y / 4 * -1 - screens.saveScreen.buttonYOffset, -- centerY
		screens.saveScreen.buttonWidth, -- width
		screens.saveScreen.buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		save3Label)

	--save 4
	local save4Label
	if util.doesFileExist(documentsDirectory.."/save4") then
		saveGameState = dofile(documentsDirectory.."/save4")
		save4Label = saveGameState.saveDate
		screens.saveScreen.save4Empty = false
	else
		save4Label = textLookup.saveScreen.empty
		screens.saveScreen.save4Empty = true
	end
	screenUtil.addTextBox(
		screens.saveScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4, -- centerX
		SCREEN_UNITS_Y / 4 * -1 - screens.saveScreen.buttonYOffset, -- centerY
		screens.saveScreen.buttonWidth, -- width
		screens.saveScreen.buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		save4Label)
end

