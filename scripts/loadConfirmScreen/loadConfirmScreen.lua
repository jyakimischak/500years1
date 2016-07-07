--####################################
-- loadConfirmScreen.lua
-- author: Jonas Yakimischak
--
-- This is the load confirmation screen for the game.
--####################################

--namespace screens.loadConfirmScreen

screens.loadConfirmScreen.props = {}
screens.loadConfirmScreen.viewports = {}
screens.loadConfirmScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.loadConfirmScreen.display()
	--setup the viewports and layers
	--screen
	screens.loadConfirmScreen.viewports.screenViewport = MOAIViewport.new()
	screens.loadConfirmScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.loadConfirmScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.loadConfirmScreen.layers.screenLayer = MOAILayer2D.new()
	screens.loadConfirmScreen.layers.screenLayer:setViewport(screens.loadConfirmScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.loadConfirmScreen.layers.screenLayer)
	--banner
	screens.loadConfirmScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.loadConfirmScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.loadConfirmScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.loadConfirmScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.loadConfirmScreen.layers.bannerLayer:setViewport(screens.loadConfirmScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.loadConfirmScreen.layers.bannerLayer)

	--background
	screens.loadConfirmScreen.props.backgroundProp = MOAIProp2D.new()
	screens.loadConfirmScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.loadConfirmScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.loadConfirmScreen.props.backgroundProp:setLoc(0, 0)
	screens.loadConfirmScreen.layers.screenLayer:insertProp(screens.loadConfirmScreen.props.backgroundProp)

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
		screens.loadConfirmScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.loadConfirmScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.loadConfirmScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.loadConfirmScreen.props.selectedButtonProp:setVisible(false)
		screens.loadConfirmScreen.layers.screenLayer:insertProp(screens.loadConfirmScreen.props.selectedButtonProp)
	end

	--setup button lists
	screens.loadConfirmScreen.screenButtonList = screenUtil.getButtonList(screens.loadConfirmScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.loadConfirmScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end

	--draw the banner background
	screens.loadConfirmScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.loadConfirmScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.loadConfirmScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.loadConfirmScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.loadConfirmScreen.layers.bannerLayer:insertProp(screens.loadConfirmScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.loadConfirmScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.loadConfirmScreen.title)
		
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
	screens.loadConfirmScreen.layers.bannerLayer:insertProp(hrProp)

	--draw the message
	screenUtil.addTextBox(
		screens.loadConfirmScreen.layers.screenLayer,
		0, -- centerX
		100, -- centerY
		SCREEN_UNITS_X, -- width
		40, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		40, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.loadConfirmScreen.message)

	--add the yes button
	screens.loadConfirmScreen.props.yesButtonProp = MOAIProp2D.new()
	screens.loadConfirmScreen.props.yesButtonProp:setDeck(sharedGfxQuads)
	screens.loadConfirmScreen.props.yesButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.loadConfirmScreen.props.yesButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.loadConfirmScreen.layers.screenLayer:insertProp(screens.loadConfirmScreen.props.yesButtonProp)
	--pressed
	screens.loadConfirmScreen.props.yesButtonPressedProp = MOAIProp2D.new()
	screens.loadConfirmScreen.props.yesButtonPressedProp:setDeck(sharedGfxQuads)
	screens.loadConfirmScreen.props.yesButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.loadConfirmScreen.props.yesButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.loadConfirmScreen.props.yesButtonPressedProp:setVisible(false)
	screens.loadConfirmScreen.layers.screenLayer:insertProp(screens.loadConfirmScreen.props.yesButtonPressedProp)
	screens.loadConfirmScreen.screenButtonList:addButton("yes", screens.loadConfirmScreen.props.yesButtonProp, screens.loadConfirmScreen.props.yesButtonPressedProp)
	screenUtil.addTextBox(
		screens.loadConfirmScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.loadConfirmScreen.yes)

	--add the no button
	screens.loadConfirmScreen.props.noButtonProp = MOAIProp2D.new()
	screens.loadConfirmScreen.props.noButtonProp:setDeck(sharedGfxQuads)
	screens.loadConfirmScreen.props.noButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.loadConfirmScreen.props.noButtonProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.loadConfirmScreen.layers.screenLayer:insertProp(screens.loadConfirmScreen.props.noButtonProp)
	--pressed
	screens.loadConfirmScreen.props.noButtonPressedProp = MOAIProp2D.new()
	screens.loadConfirmScreen.props.noButtonPressedProp:setDeck(sharedGfxQuads)
	screens.loadConfirmScreen.props.noButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.loadConfirmScreen.props.noButtonPressedProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.loadConfirmScreen.props.noButtonPressedProp:setVisible(false)
	screens.loadConfirmScreen.layers.screenLayer:insertProp(screens.loadConfirmScreen.props.noButtonPressedProp)
	screens.loadConfirmScreen.screenButtonList:addButton("no", screens.loadConfirmScreen.props.noButtonProp, screens.loadConfirmScreen.props.noButtonPressedProp)
	screenUtil.addTextBox(
		screens.loadConfirmScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.loadConfirmScreen.no)


	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.loadConfirmScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.loadConfirmScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.loadConfirmScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.loadConfirmScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.loadConfirmScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.loadConfirmScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.loadConfirmScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.loadConfirmScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.loadConfirmScreen.destroy()
	screens.loadConfirmScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.loadConfirmScreen.props) do
		screens.loadConfirmScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.loadConfirmScreen.layers) do
		if screens.loadConfirmScreen.layers[key] ~= nil then
			screens.loadConfirmScreen.layers[key]:clear()
			screens.loadConfirmScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.loadConfirmScreen.viewports) do
		screens.loadConfirmScreen.viewports[key] = nil
	end
end

