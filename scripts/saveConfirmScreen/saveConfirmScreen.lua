--####################################
-- saveConfirmScreen.lua
-- author: Jonas Yakimischak
--
-- This is the save confirmation screen for the game.
--####################################

--namespace screens.saveConfirmScreen

screens.saveConfirmScreen.props = {}
screens.saveConfirmScreen.viewports = {}
screens.saveConfirmScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.saveConfirmScreen.display()
	--setup the viewports and layers
	--screen
	screens.saveConfirmScreen.viewports.screenViewport = MOAIViewport.new()
	screens.saveConfirmScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.saveConfirmScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.saveConfirmScreen.layers.screenLayer = MOAILayer2D.new()
	screens.saveConfirmScreen.layers.screenLayer:setViewport(screens.saveConfirmScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.saveConfirmScreen.layers.screenLayer)
	--banner
	screens.saveConfirmScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.saveConfirmScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.saveConfirmScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.saveConfirmScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.saveConfirmScreen.layers.bannerLayer:setViewport(screens.saveConfirmScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.saveConfirmScreen.layers.bannerLayer)

	--background
	screens.saveConfirmScreen.props.backgroundProp = MOAIProp2D.new()
	screens.saveConfirmScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.saveConfirmScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.saveConfirmScreen.props.backgroundProp:setLoc(0, 0)
	screens.saveConfirmScreen.layers.screenLayer:insertProp(screens.saveConfirmScreen.props.backgroundProp)

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
		screens.saveConfirmScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.saveConfirmScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.saveConfirmScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.saveConfirmScreen.props.selectedButtonProp:setVisible(false)
		screens.saveConfirmScreen.layers.screenLayer:insertProp(screens.saveConfirmScreen.props.selectedButtonProp)
	end

	--setup button lists
	screens.saveConfirmScreen.screenButtonList = screenUtil.getButtonList(screens.saveConfirmScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.saveConfirmScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end
	
	--draw the banner background
	screens.saveConfirmScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.saveConfirmScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.saveConfirmScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.saveConfirmScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.saveConfirmScreen.layers.bannerLayer:insertProp(screens.saveConfirmScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.saveConfirmScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.saveConfirmScreen.title)
		
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
	screens.saveConfirmScreen.layers.bannerLayer:insertProp(hrProp)

	--draw the message
	screenUtil.addTextBox(
		screens.saveConfirmScreen.layers.screenLayer,
		0, -- centerX
		100, -- centerY
		SCREEN_UNITS_X, -- width
		40, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		40, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.saveConfirmScreen.message)

	--add the yes button
	screens.saveConfirmScreen.props.yesButtonProp = MOAIProp2D.new()
	screens.saveConfirmScreen.props.yesButtonProp:setDeck(sharedGfxQuads)
	screens.saveConfirmScreen.props.yesButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.saveConfirmScreen.props.yesButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.saveConfirmScreen.layers.screenLayer:insertProp(screens.saveConfirmScreen.props.yesButtonProp)
	--pressed
	screens.saveConfirmScreen.props.yesButtonPressedProp = MOAIProp2D.new()
	screens.saveConfirmScreen.props.yesButtonPressedProp:setDeck(sharedGfxQuads)
	screens.saveConfirmScreen.props.yesButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.saveConfirmScreen.props.yesButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.saveConfirmScreen.props.yesButtonPressedProp:setVisible(false)
	screens.saveConfirmScreen.layers.screenLayer:insertProp(screens.saveConfirmScreen.props.yesButtonPressedProp)
	screens.saveConfirmScreen.screenButtonList:addButton("yes", screens.saveConfirmScreen.props.yesButtonProp, screens.saveConfirmScreen.props.yesButtonPressedProp)
	screenUtil.addTextBox(
		screens.saveConfirmScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.saveConfirmScreen.yes)

	--add the no button
	screens.saveConfirmScreen.props.noButtonProp = MOAIProp2D.new()
	screens.saveConfirmScreen.props.noButtonProp:setDeck(sharedGfxQuads)
	screens.saveConfirmScreen.props.noButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.saveConfirmScreen.props.noButtonProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.saveConfirmScreen.layers.screenLayer:insertProp(screens.saveConfirmScreen.props.noButtonProp)
	--pressed
	screens.saveConfirmScreen.props.noButtonPressedProp = MOAIProp2D.new()
	screens.saveConfirmScreen.props.noButtonPressedProp:setDeck(sharedGfxQuads)
	screens.saveConfirmScreen.props.noButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.saveConfirmScreen.props.noButtonPressedProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.saveConfirmScreen.props.noButtonPressedProp:setVisible(false)
	screens.saveConfirmScreen.layers.screenLayer:insertProp(screens.saveConfirmScreen.props.noButtonPressedProp)
	screens.saveConfirmScreen.screenButtonList:addButton("no", screens.saveConfirmScreen.props.noButtonProp, screens.saveConfirmScreen.props.noButtonPressedProp)
	screenUtil.addTextBox(
		screens.saveConfirmScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.saveConfirmScreen.no)


	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.saveConfirmScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.saveConfirmScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.saveConfirmScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.saveConfirmScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.saveConfirmScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.saveConfirmScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.saveConfirmScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.saveConfirmScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.saveConfirmScreen.destroy()
	screens.saveConfirmScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.saveConfirmScreen.props) do
		screens.saveConfirmScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.saveConfirmScreen.layers) do
		if screens.saveConfirmScreen.layers[key] ~= nil then
			screens.saveConfirmScreen.layers[key]:clear()
			screens.saveConfirmScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.saveConfirmScreen.viewports) do
		screens.saveConfirmScreen.viewports[key] = nil
	end
end

