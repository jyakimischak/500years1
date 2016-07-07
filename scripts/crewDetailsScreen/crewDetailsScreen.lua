--####################################
-- crewDetailsScreen.lua
-- author: Jonas Yakimischak
--
-- This is the crew details screen for the game.
--####################################

--namespace screens.crewDetailsScreen

screens.crewDetailsScreen.props = {}
screens.crewDetailsScreen.viewports = {}
screens.crewDetailsScreen.layers = {}

--y offset due to banner redo
screens.crewDetailsScreen.yOffset = 30

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.crewDetailsScreen.display()
	--setup the viewports and layers
	--screen
	screens.crewDetailsScreen.viewports.screenViewport = MOAIViewport.new()
	screens.crewDetailsScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.crewDetailsScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.crewDetailsScreen.layers.screenLayer = MOAILayer2D.new()
	screens.crewDetailsScreen.layers.screenLayer:setViewport(screens.crewDetailsScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.crewDetailsScreen.layers.screenLayer)
	--banner
	screens.crewDetailsScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.crewDetailsScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.crewDetailsScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.crewDetailsScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.crewDetailsScreen.layers.bannerLayer:setViewport(screens.crewDetailsScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.crewDetailsScreen.layers.bannerLayer)

	--crew object
	local crew = model.crew[gameState.crewDetailsViewing]()

	--setup sprites
	local portraitWidth = 200
	if gameState.crewDetailsViewing == "clarence" then
		crewGfxQuads:setRect(crewNames["clarenceWithGoat.png"], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
	else
		crewGfxQuads:setRect(crewNames[gameState.crewDetailsViewing..".png"], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
	end

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
		screens.crewDetailsScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.crewDetailsScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.crewDetailsScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.crewDetailsScreen.props.selectedButtonProp:setVisible(false)
		screens.crewDetailsScreen.layers.screenLayer:insertProp(screens.crewDetailsScreen.props.selectedButtonProp)
	end
	--setup button lists
	screens.crewDetailsScreen.bannerButtonList = screenUtil.getButtonList()
	screens.crewDetailsScreen.screenButtonList = screenUtil.getButtonList(screens.crewDetailsScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.crewDetailsScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end
	
	--draw the banner background
	screens.crewDetailsScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.crewDetailsScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.crewDetailsScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.crewDetailsScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.crewDetailsScreen.layers.bannerLayer:insertProp(screens.crewDetailsScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.crewDetailsScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		crew.lastName..", "..crew.firstName)
		
	--add the back button
	screens.crewDetailsScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.crewDetailsScreen.layers.bannerLayer,
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
	screens.crewDetailsScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.crewDetailsScreen.layers.bannerLayer,
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
	screens.crewDetailsScreen.props.backButtonPressedProp:setVisible(false)
	screens.crewDetailsScreen.bannerButtonList:addButton("back", screens.crewDetailsScreen.props.backButtonProp, screens.crewDetailsScreen.props.backButtonPressedProp)
	
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
	screens.crewDetailsScreen.layers.bannerLayer:insertProp(hrProp)


	--draw the character portrait
	screens.crewDetailsScreen.props.crewProp = MOAIProp2D.new()
	screens.crewDetailsScreen.props.crewProp:setDeck(crewGfxQuads)
	if gameState.crewDetailsViewing == "clarence" then
		if gameState.francisDead then
			screens.crewDetailsScreen.props.crewProp:setIndex(crewNames["clarenceWithoutGoat.png"])
		else
			screens.crewDetailsScreen.props.crewProp:setIndex(crewNames["clarenceWithGoat.png"])
		end
	else
		screens.crewDetailsScreen.props.crewProp:setIndex(crewNames[gameState.crewDetailsViewing..".png"])
	end
	screens.crewDetailsScreen.props.crewProp:setLoc(-300, 125 - screens.crewDetailsScreen.yOffset)
	screens.crewDetailsScreen.layers.screenLayer:insertProp(screens.crewDetailsScreen.props.crewProp)
	--draw the frames for the crew member
	local function drawFrame(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(bannerHRColorR, bannerHRColorG, bannerHRColorB)
		MOAIGfxDevice.setPenWidth(3)
		MOAIDraw.drawRect(-100, -100, 100, 100)
	end
	local frameDeck = MOAIScriptDeck.new()
	frameDeck:setRect(-100, -100, 100, 100)
	frameDeck:setDrawCallback(drawFrame)
	local frameProp = MOAIProp2D.new()
	frameProp:setDeck(frameDeck)
	frameProp:setLoc(-300, 125 - screens.crewDetailsScreen.yOffset)
	screens.crewDetailsScreen.layers.screenLayer:insertProp(frameProp)
	
	--draw the crew information text box
	screenUtil.addTextBox(
		screens.crewDetailsScreen.layers.screenLayer,
		-250, -- centerX
		-150 - screens.crewDetailsScreen.yOffset, -- centerY
		300, -- width
		300, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		crew.information)

	--draw the crew background text box
	screens.crewDetailsScreen.crewBackgroundMinY = -10000 + 230
	screens.crewDetailsScreen.crewBackgroundMaxY = 10000
	screens.crewDetailsScreen.props.crewBackground = screenUtil.addTextBox(
		screens.crewDetailsScreen.layers.screenLayer,
		190, -- centerX
		screens.crewDetailsScreen.crewBackgroundMinY - screens.crewDetailsScreen.yOffset, -- centerY
		600, -- width
		20000, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		crew.background)

	--add the talk button
	local talkButtonX = -320
	local talkButtonY = -180 - screens.crewDetailsScreen.yOffset
	screens.crewDetailsScreen.props.talkButtonProp = MOAIProp2D.new()
	screens.crewDetailsScreen.props.talkButtonProp:setDeck(sharedGfxQuads)
	screens.crewDetailsScreen.props.talkButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.crewDetailsScreen.props.talkButtonProp:setLoc(talkButtonX, talkButtonY)
	screens.crewDetailsScreen.layers.screenLayer:insertProp(screens.crewDetailsScreen.props.talkButtonProp)
	--pressed
	screens.crewDetailsScreen.props.talkButtonPressedProp = MOAIProp2D.new()
	screens.crewDetailsScreen.props.talkButtonPressedProp:setDeck(sharedGfxQuads)
	screens.crewDetailsScreen.props.talkButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.crewDetailsScreen.props.talkButtonPressedProp:setLoc(talkButtonX, talkButtonY)
	screens.crewDetailsScreen.props.talkButtonPressedProp:setVisible(false)
	screens.crewDetailsScreen.layers.screenLayer:insertProp(screens.crewDetailsScreen.props.talkButtonPressedProp)
	screens.crewDetailsScreen.screenButtonList:addButton("talk", screens.crewDetailsScreen.props.talkButtonProp, screens.crewDetailsScreen.props.talkButtonPressedProp)
	screenUtil.addTextBox(
		screens.crewDetailsScreen.layers.screenLayer,
		talkButtonX, -- centerX
		talkButtonY, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.crewDetailsScreen.talk)

	screens.crewDetailsScreen.startBgMoveThread()
	
	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.crewDetailsScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.crewDetailsScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.crewDetailsScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.crewDetailsScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.crewDetailsScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.crewDetailsScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.crewDetailsScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.crewDetailsScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.crewDetailsScreen.destroy()
	--stop the bg move thread
	screens.crewDetailsScreen.runBgMoveThread = false
	
	screens.crewDetailsScreen.clickablePropList = nil
	screens.crewDetailsScreen.bannerButtonList = nil
	screens.crewDetailsScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.crewDetailsScreen.props) do
		screens.crewDetailsScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.crewDetailsScreen.layers) do
		if screens.crewDetailsScreen.layers[key] ~= nil then
			screens.crewDetailsScreen.layers[key]:clear()
			screens.crewDetailsScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.crewDetailsScreen.viewports) do
		screens.crewDetailsScreen.viewports[key] = nil
	end
end


--------------------------------------------------------------------------
-- start the background info movement thread
--------------------------------------------------------------------------
function screens.crewDetailsScreen.startBgMoveThread()
	if not windowsBuild then
		return
	end

	local bgMoveThread = MOAICoroutine.new()
	screens.crewDetailsScreen.runBgMoveThread = true
	screens.crewDetailsScreen.bgMoveAmount = 0
	bgMoveThread:run (
		function()
			while screens.crewDetailsScreen.runBgMoveThread do
				local backgroundX, backgroundY = screens.crewDetailsScreen.props.crewBackground:getLoc()
				backgroundY = backgroundY + screens.crewDetailsScreen.bgMoveAmount
				if backgroundY < 0 then
					backgroundY = 0
				end
				screens.crewDetailsScreen.props.crewBackground:setLoc(backgroundX, backgroundY)
				coroutine.yield()
			end
		end
	)
end

