--####################################
-- creditsScreen.lua
-- author: Jonas Yakimischak
--
-- This is the credits screen at the end of the game.
--####################################

--namespace screens.creditsScreen

screens.creditsScreen.props = {}
screens.creditsScreen.viewports = {}
screens.creditsScreen.layers = {}

screens.creditsScreen.creditsWaitTime = 5

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.creditsScreen.display()
	screens.creditsScreen.creditsTimer = MOAITimer.new()
	screens.creditsScreen.creditsTimer:setMode(MOAITimer.CONTINUE)
	screens.creditsScreen.creditsTimer:start()

	--setup the viewports and layers
	--screen
	screens.creditsScreen.viewports.screenViewport = MOAIViewport.new()
	screens.creditsScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.creditsScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.creditsScreen.layers.screenLayer = MOAILayer2D.new()
	screens.creditsScreen.layers.screenLayer:setViewport(screens.creditsScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.creditsScreen.layers.screenLayer)

	--background
	screens.creditsScreen.props.backgroundProp = MOAIProp2D.new()
	screens.creditsScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.creditsScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.creditsScreen.props.backgroundProp:setLoc(0, 0)
	screens.creditsScreen.layers.screenLayer:insertProp(screens.creditsScreen.props.backgroundProp)

	--draw the end credits
	screenUtil.addTextBox(
		screens.creditsScreen.layers.screenLayer,
		0, -- centerX
		250, -- centerY
		SCREEN_UNITS_X, -- width
		40, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		40, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.creditsScreen.thankYou)

	screenUtil.addTextBox(
		screens.creditsScreen.layers.screenLayer,
		0, -- centerX
		200, -- centerY
		SCREEN_UNITS_X, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.creditsScreen.madeBy)

	screenUtil.addTextBox(
		screens.creditsScreen.layers.screenLayer,
		0, -- centerX
		170, -- centerY
		SCREEN_UNITS_X, -- width
		20, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		20, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.creditsScreen.site)

	screenUtil.addTextBox(
		screens.creditsScreen.layers.screenLayer,
		0, -- centerX
		50, -- centerY
		SCREEN_UNITS_X-100, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.creditsScreen.jonas)

	screenUtil.addTextBox(
		screens.creditsScreen.layers.screenLayer,
		0, -- centerX
		-50, -- centerY
		SCREEN_UNITS_X-100, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.creditsScreen.sasha)

	screenUtil.addTextBox(
		screens.creditsScreen.layers.screenLayer,
		0, -- centerX
		-250, -- centerY
		SCREEN_UNITS_X, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.creditsScreen.act2)

	screens.creditsScreen.props.touchProp = screenUtil.addTextBox(
		screens.creditsScreen.layers.screenLayer,
		0, -- centerX
		-280, -- centerY
		SCREEN_UNITS_X-50, -- width
		20, -- height
		fonts.grStylusFont,
		MOAITextBox.RIGHT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		20, -- fontSize,
		.5, .5, 1, 1, -- color r g b a 
		textLookup.creditsScreen.touch)
	screens.creditsScreen.props.touchProp:setVisible(false)
	
	--start up a coroutine to check for the timer to make the touch message visible
	local creditsThread = MOAICoroutine.new()
	creditsThread:run (
		function()
			while screens.creditsScreen.creditsTimer:getTime() < screens.creditsScreen.creditsWaitTime do
				coroutine.yield()
			end
			screens.creditsScreen.props.touchProp:setVisible(true)
		end
	)
	


		--setup the controller callbacks
	if MOAIInputMgr.device.pointer then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.creditsScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.creditsScreen.clickCallback)
	else
		-- touch input
		MOAIInputMgr.device.touch:setCallback ( 
			function(eventType, idx, x, y, tapCount)
				screens.creditsScreen.pointerCallback(x, y)
				if eventType == MOAITouchSensor.TOUCH_DOWN then
					screens.creditsScreen.clickCallback(true)
				elseif eventType == MOAITouchSensor.TOUCH_UP then
					screens.creditsScreen.clickCallback(false)
				end
			end
		)
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.creditsScreen.destroy()
	screens.creditsScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.creditsScreen.props) do
		screens.creditsScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.creditsScreen.layers) do
		if screens.creditsScreen.layers[key] ~= nil then
			screens.creditsScreen.layers[key]:clear()
			screens.creditsScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.creditsScreen.viewports) do
		screens.creditsScreen.viewports[key] = nil
	end
end

