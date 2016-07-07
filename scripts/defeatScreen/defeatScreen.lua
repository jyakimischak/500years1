--####################################
-- defeatScreen.lua
-- author: Jonas Yakimischak
--
-- This is the screen for when a battle is lost.
--####################################

--namespace screens.defeatScreen

screens.defeatScreen.props = {}
screens.defeatScreen.viewports = {}
screens.defeatScreen.layers = {}

--------------------------------------------------------------------------
-- display
--
-- The defeat screen starts with an animations of an explosion...this will be played then
-- displayOptionsScreen will be called to draw the actual screen.
--------------------------------------------------------------------------
function screens.defeatScreen.display()
	--stop any callbacks
	if MOAIInputMgr.device.pointer then
		MOAIInputMgr.device.pointer:setCallback(nil)
		MOAIInputMgr.device.mouseLeft:setCallback(nil)
	else
		MOAIInputMgr.device.touch:setCallback(nil)
	end 

	--setup the viewport and layer
	screens.defeatScreen.viewports.viewport = MOAIViewport.new()
	screens.defeatScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.defeatScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.defeatScreen.layers.layer = MOAILayer2D.new()
	screens.defeatScreen.layers.layer:setViewport(screens.defeatScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.defeatScreen.layers.layer)

	--setup the explode animation
	for i=1, 10 do
		sharedGfxQuads:setRect(sharedNames["defeat"..i..".png"], SCREEN_UNITS_X / 2 * -1, SCREEN_UNITS_Y / 2 * -1, SCREEN_UNITS_X / 2, SCREEN_UNITS_Y / 2)
	end
	screens.defeatScreen.props.explodeProp = MOAIProp2D.new()
	screens.defeatScreen.props.explodeProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.explodeProp:setLoc(0, 0)
	screens.defeatScreen.props.explodeCurve = MOAIAnimCurve.new()
	screens.defeatScreen.props.explodeCurve:reserveKeys(10)
	for i=1,10 do
		screens.defeatScreen.props.explodeCurve:setKey(i, 0.04 * (i-1), sharedNames["defeat"..i..".png"], MOAIEaseType.FLAT)
	end
	screens.defeatScreen.props.explodeAnim = MOAIAnim:new()
	screens.defeatScreen.props.explodeAnim:reserveLinks(1)
	screens.defeatScreen.props.explodeAnim:setLink(1, screens.defeatScreen.props.explodeCurve, screens.defeatScreen.props.explodeProp, MOAIProp2D.ATTR_INDEX)
	screens.defeatScreen.props.explodeAnim:setMode(MOAITimer.LOOP)

	local displayThread = MOAICoroutine.new()
	displayThread:run (
		function()
			local blacknessTime, playExplodeTime = 2, 2
			local timer = MOAITimer.new()
			timer:setMode(MOAITimer.CONTINUE)
			timer:start()
			--stop the music
			audioUtil.stopMusic()
			--play the defeat sound
			audioUtil.playSound("defeat")
			--blackness
			local startTime = timer:getTime()
			while (timer:getTime() - startTime) < blacknessTime do
				coroutine.yield()
			end
			screens.defeatScreen.layers.layer:insertProp(screens.defeatScreen.props.explodeProp)
			screens.defeatScreen.props.explodeAnim:start()
			startTime = timer:getTime()
			while (timer:getTime() - startTime) < playExplodeTime do
				coroutine.yield()
				local color = (playExplodeTime - (timer:getTime() - startTime)) / playExplodeTime
				screens.defeatScreen.props.explodeProp:setColor(color, color, color)  
			end
			timer:stop()
			screens.defeatScreen.props.explodeAnim:stop()
			screens.defeatScreen.props.explodeProp:setVisible(false)
			if battle.attempts < 1 then
				screens.defeatScreen.displayOptionsScreen()
			else
				screens.defeatScreen.displaySkipScreen()
			end
		end
	)
end

--------------------------------------------------------------------------
-- displayOptionsScreen
--------------------------------------------------------------------------
function screens.defeatScreen.displayOptionsScreen()
	--setup the viewports and layers
	--screen
	screens.defeatScreen.viewports.screenViewport = MOAIViewport.new()
	screens.defeatScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.defeatScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.defeatScreen.layers.screenLayer = MOAILayer2D.new()
	screens.defeatScreen.layers.screenLayer:setViewport(screens.defeatScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.defeatScreen.layers.screenLayer)
	--banner
	screens.defeatScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.defeatScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.defeatScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.defeatScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.defeatScreen.layers.bannerLayer:setViewport(screens.defeatScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.defeatScreen.layers.bannerLayer)

	--background
	screens.defeatScreen.props.backgroundProp = MOAIProp2D.new()
	screens.defeatScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.defeatScreen.props.backgroundProp:setLoc(0, 0)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.backgroundProp)

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
		screens.defeatScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.defeatScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.defeatScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.defeatScreen.props.selectedButtonProp:setVisible(false)
		screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.selectedButtonProp)
	end
	--setup button lists
	screens.defeatScreen.screenButtonList = screenUtil.getButtonList(screens.defeatScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.defeatScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end
	
	--draw the banner background
	screens.defeatScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.defeatScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.defeatScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.defeatScreen.layers.bannerLayer:insertProp(screens.defeatScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.defeatScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.defeatScreen.title)
		
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
	screens.defeatScreen.layers.bannerLayer:insertProp(hrProp)

	--draw the message
	screenUtil.addTextBox(
		screens.defeatScreen.layers.screenLayer,
		0, -- centerX
		100, -- centerY
		SCREEN_UNITS_X, -- width
		40, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		40, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.defeatScreen.message)

	--add the yes button
	screens.defeatScreen.props.yesButtonProp = MOAIProp2D.new()
	screens.defeatScreen.props.yesButtonProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.yesButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.defeatScreen.props.yesButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.yesButtonProp)
	--pressed
	screens.defeatScreen.props.yesButtonPressedProp = MOAIProp2D.new()
	screens.defeatScreen.props.yesButtonPressedProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.yesButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.defeatScreen.props.yesButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.defeatScreen.props.yesButtonPressedProp:setVisible(false)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.yesButtonPressedProp)
	screens.defeatScreen.screenButtonList:addButton("yes", screens.defeatScreen.props.yesButtonProp, screens.defeatScreen.props.yesButtonPressedProp)
	screenUtil.addTextBox(
		screens.defeatScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.defeatScreen.yes)

	--add the no button
	screens.defeatScreen.props.noButtonProp = MOAIProp2D.new()
	screens.defeatScreen.props.noButtonProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.noButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.defeatScreen.props.noButtonProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.noButtonProp)
	--pressed
	screens.defeatScreen.props.noButtonPressedProp = MOAIProp2D.new()
	screens.defeatScreen.props.noButtonPressedProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.noButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.defeatScreen.props.noButtonPressedProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.defeatScreen.props.noButtonPressedProp:setVisible(false)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.noButtonPressedProp)
	screens.defeatScreen.screenButtonList:addButton("no", screens.defeatScreen.props.noButtonProp, screens.defeatScreen.props.noButtonPressedProp)
	screenUtil.addTextBox(
		screens.defeatScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.defeatScreen.no)


	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.defeatScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.defeatScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.defeatScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.defeatScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.defeatScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.defeatScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.defeatScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.defeatScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- displaySkipScreen
--------------------------------------------------------------------------
function screens.defeatScreen.displaySkipScreen()
	--setup the viewports and layers
	--screen
	screens.defeatScreen.viewports.screenViewport = MOAIViewport.new()
	screens.defeatScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.defeatScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.defeatScreen.layers.screenLayer = MOAILayer2D.new()
	screens.defeatScreen.layers.screenLayer:setViewport(screens.defeatScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.defeatScreen.layers.screenLayer)
	--banner
	screens.defeatScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.defeatScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.defeatScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.defeatScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.defeatScreen.layers.bannerLayer:setViewport(screens.defeatScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.defeatScreen.layers.bannerLayer)

	--background
	screens.defeatScreen.props.backgroundProp = MOAIProp2D.new()
	screens.defeatScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.defeatScreen.props.backgroundProp:setLoc(0, 0)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.backgroundProp)

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
		screens.defeatScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.defeatScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.defeatScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.defeatScreen.props.selectedButtonProp:setVisible(false)
		screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.selectedButtonProp)
	end
	--setup button lists
	screens.defeatScreen.screenButtonList = screenUtil.getButtonList(screens.defeatScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.defeatScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end
	
	--draw the banner background
	screens.defeatScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.defeatScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.defeatScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.defeatScreen.layers.bannerLayer:insertProp(screens.defeatScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.defeatScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.defeatScreen.title)
		
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
	screens.defeatScreen.layers.bannerLayer:insertProp(hrProp)

	--draw the message
	screenUtil.addTextBox(
		screens.defeatScreen.layers.screenLayer,
		0, -- centerX
		100, -- centerY
		SCREEN_UNITS_X, -- width
		40, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		40, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.defeatScreen.skipMessage)

	--add the yes button
	screens.defeatScreen.props.againButtonProp = MOAIProp2D.new()
	screens.defeatScreen.props.againButtonProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.againButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.defeatScreen.props.againButtonProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.againButtonProp)
	--pressed
	screens.defeatScreen.props.againButtonPressedProp = MOAIProp2D.new()
	screens.defeatScreen.props.againButtonPressedProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.againButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.defeatScreen.props.againButtonPressedProp:setLoc(SCREEN_UNITS_X / 4 * -1, 0)
	screens.defeatScreen.props.againButtonPressedProp:setVisible(false)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.againButtonPressedProp)
	screens.defeatScreen.screenButtonList:addButton("again", screens.defeatScreen.props.againButtonProp, screens.defeatScreen.props.againButtonPressedProp)
	screenUtil.addTextBox(
		screens.defeatScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4 * -1, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.defeatScreen.again)

	--add the no button
	screens.defeatScreen.props.skipButtonProp = MOAIProp2D.new()
	screens.defeatScreen.props.skipButtonProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.skipButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.defeatScreen.props.skipButtonProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.skipButtonProp)
	--pressed
	screens.defeatScreen.props.skipButtonPressedProp = MOAIProp2D.new()
	screens.defeatScreen.props.skipButtonPressedProp:setDeck(sharedGfxQuads)
	screens.defeatScreen.props.skipButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.defeatScreen.props.skipButtonPressedProp:setLoc(SCREEN_UNITS_X / 4, 0)
	screens.defeatScreen.props.skipButtonPressedProp:setVisible(false)
	screens.defeatScreen.layers.screenLayer:insertProp(screens.defeatScreen.props.skipButtonPressedProp)
	screens.defeatScreen.screenButtonList:addButton("skip", screens.defeatScreen.props.skipButtonProp, screens.defeatScreen.props.skipButtonPressedProp)
	screenUtil.addTextBox(
		screens.defeatScreen.layers.screenLayer,
		SCREEN_UNITS_X / 4, -- centerX
		0, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.defeatScreen.skip)


	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.defeatScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.defeatScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.defeatScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.defeatScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.defeatScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.defeatScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.defeatScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.defeatScreen.clickCallback(false)
					end
				end
			)
		end
	end
end

--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.defeatScreen.destroy()
	screens.defeatScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.defeatScreen.props) do
		screens.defeatScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.defeatScreen.layers) do
		if screens.defeatScreen.layers[key] ~= nil then
			screens.defeatScreen.layers[key]:clear()
			screens.defeatScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.defeatScreen.viewports) do
		screens.defeatScreen.viewports[key] = nil
	end
end

