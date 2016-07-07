--####################################
-- loadScreen.lua
-- author: Jonas Yakimischak
--
-- This is the load screen for the game.
--####################################

--namespace screens.loadScreen

screens.loadScreen.props = {}
screens.loadScreen.viewports = {}
screens.loadScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.loadScreen.display()
	--setup the viewports and layers
	--screen
	screens.loadScreen.viewports.screenViewport = MOAIViewport.new()
	screens.loadScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.loadScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.loadScreen.layers.screenLayer = MOAILayer2D.new()
	screens.loadScreen.layers.screenLayer:setViewport(screens.loadScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.loadScreen.layers.screenLayer)
	--banner
	screens.loadScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.loadScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.loadScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.loadScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.loadScreen.layers.bannerLayer:setViewport(screens.loadScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.loadScreen.layers.bannerLayer)

	--background
	screens.loadScreen.props.backgroundProp = MOAIProp2D.new()
	screens.loadScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.loadScreen.props.backgroundProp:setLoc(0, 0)
	screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.backgroundProp)

	--size the buttons
	screens.loadScreen.buttonWidth = 400
	screens.loadScreen.buttonHeight = screens.loadScreen.buttonWidth * 36 / 100
	sharedGfxQuads:setRect(sharedNames["circuitButton.png"], screens.loadScreen.buttonWidth / 2 * -1, screens.loadScreen.buttonHeight / 2 * -1, screens.loadScreen.buttonWidth / 2, screens.loadScreen.buttonHeight / 2)
	sharedGfxQuads:setRect(sharedNames["circuitButtonPressed.png"], screens.loadScreen.buttonWidth / 2 * -1, screens.loadScreen.buttonHeight / 2 * -1, screens.loadScreen.buttonWidth / 2, screens.loadScreen.buttonHeight / 2)
	--setup the button selected prop
	if windowsBuild then
		local selectedButtonWidth = screens.loadScreen.buttonWidth + screens.loadScreen.buttonWidth/15
		local selectedButtonHeight = screens.loadScreen.buttonHeight + screens.loadScreen.buttonWidth/15
		sharedGfxQuads:setRect(sharedNames["buttonSelected.png"], selectedButtonWidth / 2 * -1, selectedButtonHeight / 2 * -1, selectedButtonWidth / 2, selectedButtonHeight / 2)
		screens.loadScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.loadScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.loadScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.loadScreen.props.selectedButtonProp:setVisible(false)
		screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.selectedButtonProp)
	end

	--setup button lists
	screens.loadScreen.bannerButtonList = screenUtil.getButtonList()
	screens.loadScreen.screenButtonList = screenUtil.getButtonList(screens.loadScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.loadScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end

	--draw the banner background
	screens.loadScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.loadScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.loadScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.loadScreen.layers.bannerLayer:insertProp(screens.loadScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.loadScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.loadScreen.title)
		
	--add the back button
	screens.loadScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.loadScreen.layers.bannerLayer,
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
	screens.loadScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.loadScreen.layers.bannerLayer,
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
	screens.loadScreen.props.backButtonPressedProp:setVisible(false)
	screens.loadScreen.bannerButtonList:addButton("back", screens.loadScreen.props.backButtonProp, screens.loadScreen.props.backButtonPressedProp)
	
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
	screens.loadScreen.layers.bannerLayer:insertProp(hrProp)

	screens.loadScreen.buttonYOffset = 30

	--add the first save button
	screens.loadScreen.props.save3ButtonProp = MOAIProp2D.new()
	screens.loadScreen.props.save3ButtonProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.save3ButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.loadScreen.props.save3ButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1, SCREEN_UNITS_Y / 4 - screens.loadScreen.buttonYOffset)
	screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.save3ButtonProp)
	--pressed
	screens.loadScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.loadScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.loadScreen.props.loadoutButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1, SCREEN_UNITS_Y / 4 - screens.loadScreen.buttonYOffset)
	screens.loadScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.loadoutButtonPressedProp)
	screens.loadScreen.screenButtonList:addButton("save1", screens.loadScreen.props.save3ButtonProp, screens.loadScreen.props.loadoutButtonPressedProp)

	--add the second save button
	screens.loadScreen.props.save2ButtonProp = MOAIProp2D.new()
	screens.loadScreen.props.save2ButtonProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.save2ButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.loadScreen.props.save2ButtonProp:setLoc(SCREEN_UNITS_X / 4, SCREEN_UNITS_Y / 4 - screens.loadScreen.buttonYOffset)
	screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.save2ButtonProp)
	--pressed
	screens.loadScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.loadScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.loadScreen.props.loadoutButtonPressedProp:setLoc(SCREEN_UNITS_X / 4, SCREEN_UNITS_Y / 4 - screens.loadScreen.buttonYOffset)
	screens.loadScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.loadoutButtonPressedProp)
	screens.loadScreen.screenButtonList:addButton("save2", screens.loadScreen.props.save2ButtonProp, screens.loadScreen.props.loadoutButtonPressedProp)

	--add the third save button
	screens.loadScreen.props.save3ButtonProp = MOAIProp2D.new()
	screens.loadScreen.props.save3ButtonProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.save3ButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.loadScreen.props.save3ButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1, SCREEN_UNITS_Y / 4 * -1 - screens.loadScreen.buttonYOffset)
	screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.save3ButtonProp)
	--pressed
	screens.loadScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.loadScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.loadScreen.props.loadoutButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1, SCREEN_UNITS_Y / 4 * -1 - screens.loadScreen.buttonYOffset)
	screens.loadScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.loadoutButtonPressedProp)
	screens.loadScreen.screenButtonList:addButton("save3", screens.loadScreen.props.save3ButtonProp, screens.loadScreen.props.loadoutButtonPressedProp)

	--add the fourth save button
	screens.loadScreen.props.save4ButtonProp = MOAIProp2D.new()
	screens.loadScreen.props.save4ButtonProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.save4ButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.loadScreen.props.save4ButtonProp:setLoc(SCREEN_UNITS_X / 4, SCREEN_UNITS_Y / 4 * -1 - screens.loadScreen.buttonYOffset)
	screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.save4ButtonProp)
	--pressed
	screens.loadScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.loadScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.loadScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.loadScreen.props.loadoutButtonPressedProp:setLoc(SCREEN_UNITS_X / 4, SCREEN_UNITS_Y / 4 * -1 - screens.loadScreen.buttonYOffset)
	screens.loadScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.loadScreen.layers.screenLayer:insertProp(screens.loadScreen.props.loadoutButtonPressedProp)
	screens.loadScreen.screenButtonList:addButton("save4", screens.loadScreen.props.save4ButtonProp, screens.loadScreen.props.loadoutButtonPressedProp)
		
	--draw the labels on the buttons
	screens.loadScreen.drawSaveLabels()


	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.loadScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.loadScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.loadScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.loadScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.loadScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.loadScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.loadScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.loadScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.loadScreen.destroy()
	screens.loadScreen.bannerButtonList = nil
	screens.loadScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.loadScreen.props) do
		screens.loadScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.loadScreen.layers) do
		if screens.loadScreen.layers[key] ~= nil then
			screens.loadScreen.layers[key]:clear()
			screens.loadScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.loadScreen.viewports) do
		screens.loadScreen.viewports[key] = nil
	end
end


--------------------------------------------------------------------------
-- drawSaveLabels
-- Draw the labels for the save buttons 
--------------------------------------------------------------------------
function screens.loadScreen.drawSaveLabels()
	local saveGameState
	--save 1
	local save1Label
	if util.doesFileExist(documentsDirectory.."/save1") then
		saveGameState = dofile(documentsDirectory.."/save1")
		save1Label = saveGameState.saveDate
		screens.loadScreen.save1Empty = false
	else
		save1Label = textLookup.loadScreen.empty
		screens.loadScreen.save1Empty = true
	end
	screenUtil.addTextBox(
		screens.loadScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1, -- centerX
		SCREEN_UNITS_Y / 4 - screens.loadScreen.buttonYOffset, -- centerY
		screens.loadScreen.buttonWidth, -- width
		screens.loadScreen.buttonHeight, -- height
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
		screens.loadScreen.save2Empty = false
	else
		save2Label = textLookup.loadScreen.empty
		screens.loadScreen.save2Empty = true
	end
	screenUtil.addTextBox(
		screens.loadScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4, -- centerX
		SCREEN_UNITS_Y / 4 - screens.loadScreen.buttonYOffset, -- centerY
		screens.loadScreen.buttonWidth, -- width
		screens.loadScreen.buttonHeight, -- height
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
		screens.loadScreen.save3Empty = false
	else
		save3Label = textLookup.loadScreen.empty
		screens.loadScreen.save3Empty = true
	end
	screenUtil.addTextBox(
		screens.loadScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1, -- centerX
		SCREEN_UNITS_Y / 4 * -1 - screens.loadScreen.buttonYOffset, -- centerY
		screens.loadScreen.buttonWidth, -- width
		screens.loadScreen.buttonHeight, -- height
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
		screens.loadScreen.save4Empty = false
	else
		save4Label = textLookup.loadScreen.empty
		screens.loadScreen.save4Empty = true
	end
	screenUtil.addTextBox(
		screens.loadScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4, -- centerX
		SCREEN_UNITS_Y / 4 * -1 - screens.loadScreen.buttonYOffset, -- centerY
		screens.loadScreen.buttonWidth, -- width
		screens.loadScreen.buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		save4Label)
end

