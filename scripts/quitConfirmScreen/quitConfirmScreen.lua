--####################################
-- quitConfirmScreen.lua
-- author: Jonas Yakimischak
--
-- This is the quit confirmation screen for the game.
--####################################

--namespace screens.quitConfirmScreen

screens.quitConfirmScreen.props = {}
screens.quitConfirmScreen.viewports = {}
screens.quitConfirmScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.quitConfirmScreen.display()
	--setup the viewports and layers
	--screen
	screens.quitConfirmScreen.viewports.screenViewport = MOAIViewport.new()
	screens.quitConfirmScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.quitConfirmScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.quitConfirmScreen.layers.screenLayer = MOAILayer2D.new()
	screens.quitConfirmScreen.layers.screenLayer:setViewport(screens.quitConfirmScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.quitConfirmScreen.layers.screenLayer)
	--banner
	screens.quitConfirmScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.quitConfirmScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.quitConfirmScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.quitConfirmScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.quitConfirmScreen.layers.bannerLayer:setViewport(screens.quitConfirmScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.quitConfirmScreen.layers.bannerLayer)


	--background
	screens.quitConfirmScreen.props.backgroundProp = MOAIProp2D.new()
	screens.quitConfirmScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.quitConfirmScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.quitConfirmScreen.props.backgroundProp:setLoc(0, 0)
	screens.quitConfirmScreen.layers.screenLayer:insertProp(screens.quitConfirmScreen.props.backgroundProp)
	
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
		screens.quitConfirmScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.quitConfirmScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.quitConfirmScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.quitConfirmScreen.props.selectedButtonProp:setVisible(false)
		screens.quitConfirmScreen.layers.screenLayer:insertProp(screens.quitConfirmScreen.props.selectedButtonProp)
	end
	--setup button lists
	screens.quitConfirmScreen.screenButtonList = screenUtil.getButtonList(screens.quitConfirmScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.quitConfirmScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end

	--draw the banner background
	screens.quitConfirmScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.quitConfirmScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.quitConfirmScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.quitConfirmScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.quitConfirmScreen.layers.bannerLayer:insertProp(screens.quitConfirmScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.quitConfirmScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.quitConfirmScreen.title)
		
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
	screens.quitConfirmScreen.layers.bannerLayer:insertProp(hrProp)

	--draw the message
	screenUtil.addTextBox(
		screens.quitConfirmScreen.layers.screenLayer,
		0, -- centerX
		100, -- centerY
		SCREEN_UNITS_X, -- width
		40, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		40, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.quitConfirmScreen.message)

	--add the yes button
	screens.quitConfirmScreen.props.yesButtonProp = MOAIProp2D.new()
	screens.quitConfirmScreen.props.yesButtonProp:setDeck(sharedGfxQuads)
	screens.quitConfirmScreen.props.yesButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.quitConfirmScreen.props.yesButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.quitConfirmScreen.layers.screenLayer:insertProp(screens.quitConfirmScreen.props.yesButtonProp)
	--pressed
	screens.quitConfirmScreen.props.yesButtonPressedProp = MOAIProp2D.new()
	screens.quitConfirmScreen.props.yesButtonPressedProp:setDeck(sharedGfxQuads)
	screens.quitConfirmScreen.props.yesButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.quitConfirmScreen.props.yesButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.quitConfirmScreen.props.yesButtonPressedProp:setVisible(false)
	screens.quitConfirmScreen.layers.screenLayer:insertProp(screens.quitConfirmScreen.props.yesButtonPressedProp)
	screens.quitConfirmScreen.screenButtonList:addButton("yes", screens.quitConfirmScreen.props.yesButtonProp, screens.quitConfirmScreen.props.yesButtonPressedProp)
	screenUtil.addTextBox(
		screens.quitConfirmScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.quitConfirmScreen.yes)

	--add the no button
	screens.quitConfirmScreen.props.noButtonProp = MOAIProp2D.new()
	screens.quitConfirmScreen.props.noButtonProp:setDeck(sharedGfxQuads)
	screens.quitConfirmScreen.props.noButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.quitConfirmScreen.props.noButtonProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.quitConfirmScreen.layers.screenLayer:insertProp(screens.quitConfirmScreen.props.noButtonProp)
	--pressed
	screens.quitConfirmScreen.props.noButtonPressedProp = MOAIProp2D.new()
	screens.quitConfirmScreen.props.noButtonPressedProp:setDeck(sharedGfxQuads)
	screens.quitConfirmScreen.props.noButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.quitConfirmScreen.props.noButtonPressedProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.quitConfirmScreen.props.noButtonPressedProp:setVisible(false)
	screens.quitConfirmScreen.layers.screenLayer:insertProp(screens.quitConfirmScreen.props.noButtonPressedProp)
	screens.quitConfirmScreen.screenButtonList:addButton("no", screens.quitConfirmScreen.props.noButtonProp, screens.quitConfirmScreen.props.noButtonPressedProp)
	screenUtil.addTextBox(
		screens.quitConfirmScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.quitConfirmScreen.no)


	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.quitConfirmScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.quitConfirmScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.quitConfirmScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.quitConfirmScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.quitConfirmScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.quitConfirmScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.quitConfirmScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.quitConfirmScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.quitConfirmScreen.destroy()
	screens.quitConfirmScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.quitConfirmScreen.props) do
		screens.quitConfirmScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.quitConfirmScreen.layers) do
		if screens.quitConfirmScreen.layers[key] ~= nil then
			screens.quitConfirmScreen.layers[key]:clear()
			screens.quitConfirmScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.quitConfirmScreen.viewports) do
		screens.quitConfirmScreen.viewports[key] = nil
	end
end

