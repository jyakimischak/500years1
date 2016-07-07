--####################################
-- crewListScreen.lua
-- author: Jonas Yakimischak
--
-- This is the crew list screen for the game.
--####################################

--namespace screens.crewListScreen

screens.crewListScreen.props = {}
screens.crewListScreen.viewports = {}
screens.crewListScreen.layers = {}

--y offset due to fixing the banner
screens.crewListScreen.yOffset = 30

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.crewListScreen.display()
	--setup the viewports and layers
	--screen
	screens.crewListScreen.viewports.screenViewport = MOAIViewport.new()
	screens.crewListScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.crewListScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.crewListScreen.layers.screenLayer = MOAILayer2D.new()
	screens.crewListScreen.layers.screenLayer:setViewport(screens.crewListScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.crewListScreen.layers.screenLayer)
	--banner
	screens.crewListScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.crewListScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.crewListScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.crewListScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.crewListScreen.layers.bannerLayer:setViewport(screens.crewListScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.crewListScreen.layers.bannerLayer)

	--setup sprites
	local portraitWidth = 200
	crewGfxQuads:setRect(crewNames["oleg.png"], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
	crewGfxQuads:setRect(crewNames["charlie.png"], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
	crewGfxQuads:setRect(crewNames["clarenceWithGoat.png"], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
	crewGfxQuads:setRect(crewNames["clarenceWithoutGoat.png"], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
	crewGfxQuads:setRect(crewNames["jarvis.png"], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
	crewGfxQuads:setRect(crewNames["frank.png"], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
	crewGfxQuads:setRect(crewNames["yepp.png"], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)

	--setup the button selected prop
	if windowsBuild then
		local selectedWidth = portraitWidth + 40
		local selectedHeight = portraitWidth + 40
		crewGfxQuads:setRect(crewNames["selectedProp.png"], selectedWidth / 2 * -1, selectedHeight / 2 * -1, selectedWidth / 2, selectedHeight / 2)
		screens.crewListScreen.props.selectedProp = MOAIProp2D.new()
		screens.crewListScreen.props.selectedProp:setDeck(crewGfxQuads)
		screens.crewListScreen.props.selectedProp:setIndex(crewNames["selectedProp.png"])
		screens.crewListScreen.props.selectedProp:setVisible(false)
		screens.crewListScreen.layers.screenLayer:insertProp(screens.crewListScreen.props.selectedProp)
	end
	--setup clickable prop list
	screens.crewListScreen.clickablePropList = screenUtil.getClickablePropList(screens.crewListScreen.props.selectedProp)
	--setup button lists
	screens.crewListScreen.bannerButtonList = screenUtil.getButtonList()
	if windowsBuild then
		screens.crewListScreen.clickablePropList:selectedVisible(not xbox.cursorVisible)
	end
	
	--draw the banner background
	screens.crewListScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.crewListScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.crewListScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.crewListScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.crewListScreen.layers.bannerLayer:insertProp(screens.crewListScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.crewListScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.crewListScreen.title)
		
	--add the back button
	screens.crewListScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.crewListScreen.layers.bannerLayer,
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
	screens.crewListScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.crewListScreen.layers.bannerLayer,
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
	screens.crewListScreen.props.backButtonPressedProp:setVisible(false)
	screens.crewListScreen.bannerButtonList:addButton("back", screens.crewListScreen.props.backButtonProp, screens.crewListScreen.props.backButtonPressedProp)
	
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
	screens.crewListScreen.layers.bannerLayer:insertProp(hrProp)


	--draw the portraits of the crew on your ship
	if gameState.crew.oleg then
		screens.crewListScreen.props.olegProp = MOAIProp2D.new()
		screens.crewListScreen.props.olegProp:setDeck(crewGfxQuads)
		screens.crewListScreen.props.olegProp:setIndex(crewNames["oleg.png"])
		screens.crewListScreen.props.olegProp:setLoc(-300, 125 - screens.crewListScreen.yOffset)
		screens.crewListScreen.layers.screenLayer:insertProp(screens.crewListScreen.props.olegProp)
		screens.crewListScreen.clickablePropList:addClickableProp("oleg", screens.crewListScreen.props.olegProp)
	end

	if gameState.crew.charlie then
		screens.crewListScreen.props.charlieProp = MOAIProp2D.new()
		screens.crewListScreen.props.charlieProp:setDeck(crewGfxQuads)
		screens.crewListScreen.props.charlieProp:setIndex(crewNames["charlie.png"])
		screens.crewListScreen.props.charlieProp:setLoc(0, 125 - screens.crewListScreen.yOffset)
		screens.crewListScreen.layers.screenLayer:insertProp(screens.crewListScreen.props.charlieProp)
		screens.crewListScreen.clickablePropList:addClickableProp("charlie", screens.crewListScreen.props.charlieProp)
	end

	if gameState.crew.clarence then
		screens.crewListScreen.props.clarenceProp = MOAIProp2D.new()
		screens.crewListScreen.props.clarenceProp:setDeck(crewGfxQuads)
		if gameState.francisDead then
			screens.crewListScreen.props.clarenceProp:setIndex(crewNames["clarenceWithoutGoat.png"])
		else
			screens.crewListScreen.props.clarenceProp:setIndex(crewNames["clarenceWithGoat.png"])
		end
		screens.crewListScreen.props.clarenceProp:setLoc(300, 125 - screens.crewListScreen.yOffset)
		screens.crewListScreen.layers.screenLayer:insertProp(screens.crewListScreen.props.clarenceProp)
		screens.crewListScreen.clickablePropList:addClickableProp("clarence", screens.crewListScreen.props.clarenceProp)
	end

	if gameState.crew.jarvis then
		screens.crewListScreen.props.jarvisProp = MOAIProp2D.new()
		screens.crewListScreen.props.jarvisProp:setDeck(crewGfxQuads)
		screens.crewListScreen.props.jarvisProp:setIndex(crewNames["jarvis.png"])
		screens.crewListScreen.props.jarvisProp:setLoc(-300, -125 - screens.crewListScreen.yOffset)
		screens.crewListScreen.layers.screenLayer:insertProp(screens.crewListScreen.props.jarvisProp)
		screens.crewListScreen.clickablePropList:addClickableProp("jarvis", screens.crewListScreen.props.jarvisProp)
	end

	if gameState.crew.frank then
		screens.crewListScreen.props.jarvisProp = MOAIProp2D.new()
		screens.crewListScreen.props.jarvisProp:setDeck(crewGfxQuads)
		screens.crewListScreen.props.jarvisProp:setIndex(crewNames["frank.png"])
		screens.crewListScreen.props.jarvisProp:setLoc(0, -125 - screens.crewListScreen.yOffset)
		screens.crewListScreen.layers.screenLayer:insertProp(screens.crewListScreen.props.jarvisProp)
		screens.crewListScreen.clickablePropList:addClickableProp("frank", screens.crewListScreen.props.jarvisProp)
	end

	if gameState.crew.yepp then
		screens.crewListScreen.props.jarvisProp = MOAIProp2D.new()
		screens.crewListScreen.props.jarvisProp:setDeck(crewGfxQuads)
		screens.crewListScreen.props.jarvisProp:setIndex(crewNames["yepp.png"])
		screens.crewListScreen.props.jarvisProp:setLoc(300, -125 - screens.crewListScreen.yOffset)
		screens.crewListScreen.layers.screenLayer:insertProp(screens.crewListScreen.props.jarvisProp)
		screens.crewListScreen.clickablePropList:addClickableProp("yepp", screens.crewListScreen.props.jarvisProp)
	end


	--draw the frames for the craw members
	local function drawFrame(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(bannerHRColorR, bannerHRColorG, bannerHRColorB)
		MOAIGfxDevice.setPenWidth(3)
		MOAIDraw.drawRect(-100, -100, 100, 100)
	end
	local frameDeck = MOAIScriptDeck.new()
	frameDeck:setRect(-100, -100, 100, 100)
	frameDeck:setDrawCallback(drawFrame)
	--crew1 frame
	local crew1FrameProp = MOAIProp2D.new()
	crew1FrameProp:setDeck(frameDeck)
	crew1FrameProp:setLoc(-300, 125 - screens.crewListScreen.yOffset)
	screens.crewListScreen.layers.screenLayer:insertProp(crew1FrameProp)
	--crew2 frame
	local crew2FrameProp = MOAIProp2D.new()
	crew2FrameProp:setDeck(frameDeck)
	crew2FrameProp:setLoc(0, 125 - screens.crewListScreen.yOffset)
	screens.crewListScreen.layers.screenLayer:insertProp(crew2FrameProp)
	--crew3 frame
	local crew3FrameProp = MOAIProp2D.new()
	crew3FrameProp:setDeck(frameDeck)
	crew3FrameProp:setLoc(300, 125 - screens.crewListScreen.yOffset)
	screens.crewListScreen.layers.screenLayer:insertProp(crew3FrameProp)
	--crew4 frame
	local crew4FrameProp = MOAIProp2D.new()
	crew4FrameProp:setDeck(frameDeck)
	crew4FrameProp:setLoc(-300, -125 - screens.crewListScreen.yOffset)
	screens.crewListScreen.layers.screenLayer:insertProp(crew4FrameProp)
	--crew5 frame
	local crew5FrameProp = MOAIProp2D.new()
	crew5FrameProp:setDeck(frameDeck)
	crew5FrameProp:setLoc(0, -125 - screens.crewListScreen.yOffset)
	screens.crewListScreen.layers.screenLayer:insertProp(crew5FrameProp)
	--crew6 frame
	local crew6FrameProp = MOAIProp2D.new()
	crew6FrameProp:setDeck(frameDeck)
	crew6FrameProp:setLoc(300, -125 - screens.crewListScreen.yOffset)
	screens.crewListScreen.layers.screenLayer:insertProp(crew6FrameProp)
	

	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.crewListScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.crewListScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.crewListScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.crewListScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.crewListScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.crewListScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.crewListScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.crewListScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.crewListScreen.destroy()
	screens.crewListScreen.clickablePropList = nil
	screens.crewListScreen.bannerButtonList = nil
	screens.crewListScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.crewListScreen.props) do
		screens.crewListScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.crewListScreen.layers) do
		if screens.crewListScreen.layers[key] ~= nil then
			screens.crewListScreen.layers[key]:clear()
			screens.crewListScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.crewListScreen.viewports) do
		screens.crewListScreen.viewports[key] = nil
	end
end

