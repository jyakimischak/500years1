--####################################
-- startScreen.lua
-- author: Jonas Yakimischak
--
-- This is the screen that players first see when entering the game.
--####################################

--namespace screens.startScreen

screens.startScreen.props = {}
screens.startScreen.viewports = {}
screens.startScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.startScreen.display()
	--setup the viewport and layer
	screens.startScreen.viewports.viewport = MOAIViewport.new()
	screens.startScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.startScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.startScreen.layers.layer = MOAILayer2D.new()
	screens.startScreen.layers.layer:setViewport(screens.startScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.startScreen.layers.layer)

	if iosBuild then
		sharedGfxQuads:setRect(sharedNames["startScreenBackground.png"], -655, -384, 655, 384)
	else
		sharedGfxQuads:setRect(sharedNames["startScreenBackground.png"], -512, -300, 512, 300)
	end
	screens.startScreen.props.backgroundProp = MOAIProp2D.new()
	screens.startScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.startScreen.props.backgroundProp:setIndex(sharedNames["startScreenBackground.png"])
	screens.startScreen.props.backgroundProp:setLoc(0, 0)
	screens.startScreen.layers.layer:insertProp(screens.startScreen.props.backgroundProp)

	--setup the button selected prop
	local buttonWidth = 200
	local buttonHeight = buttonWidth * 36 / 100
	if windowsBuild then
		local selectedButtonWidth = buttonWidth + buttonWidth/15
		local selectedButtonHeight = buttonHeight + buttonWidth/15
		sharedGfxQuads:setRect(sharedNames["buttonSelected.png"], selectedButtonWidth / 2 * -1, selectedButtonHeight / 2 * -1, selectedButtonWidth / 2, selectedButtonHeight / 2)
		screens.startScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.startScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.startScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.startScreen.props.selectedButtonProp:setVisible(false)
		screens.startScreen.layers.layer:insertProp(screens.startScreen.props.selectedButtonProp)
	end
		
	--setup button list
	screens.startScreen.buttonList = screenUtil.getButtonList(screens.startScreen.props.selectedButtonProp)
	if windowsBuild then
		screens.startScreen.buttonList:selectedVisible(not xbox.cursorVisible)
	end

	--setup the props for the buttons
	local newX = 0
	local newY = 50
	local continueX = 0
	local continueY = -50
	local quitX = 0
	local quitY = -150
	sharedGfxQuads:setRect(sharedNames["circuitButton.png"], buttonWidth / 2 * -1, buttonHeight / 2 * -1, buttonWidth / 2, buttonHeight / 2)
	sharedGfxQuads:setRect(sharedNames["circuitButtonPressed.png"], buttonWidth / 2 * -1, buttonHeight / 2 * -1, buttonWidth / 2, buttonHeight / 2)
	--new
	screens.startScreen.props.newProp = MOAIProp2D.new()
	screens.startScreen.props.newProp:setDeck(sharedGfxQuads)
	screens.startScreen.props.newProp:setIndex(sharedNames["circuitButton.png"])
	screens.startScreen.props.newProp:setLoc(newX, newY)
	screens.startScreen.layers.layer:insertProp(screens.startScreen.props.newProp)
	--new pressed
	screens.startScreen.props.newPressedProp = MOAIProp2D.new()
	screens.startScreen.props.newPressedProp:setDeck(sharedGfxQuads)
	screens.startScreen.props.newPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.startScreen.props.newPressedProp:setLoc(newX, newY)
	screens.startScreen.props.newPressedProp:setVisible(false)
	screens.startScreen.layers.layer:insertProp(screens.startScreen.props.newPressedProp)
	screens.startScreen.buttonList:addButton("new", screens.startScreen.props.newProp, screens.startScreen.props.newPressedProp)
	screenUtil.addTextBox(
		screens.startScreen.layers.layer,
		newX, -- centerX
		newY, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.startScreen.newButton)
	--continue
	screens.startScreen.props.continueProp = MOAIProp2D.new()
	screens.startScreen.props.continueProp:setDeck(sharedGfxQuads)
	screens.startScreen.props.continueProp:setIndex(sharedNames["circuitButton.png"])
	screens.startScreen.props.continueProp:setLoc(continueX, continueY)
	screens.startScreen.layers.layer:insertProp(screens.startScreen.props.continueProp)
	--continue pressed
	screens.startScreen.props.continuePressedProp = MOAIProp2D.new()
	screens.startScreen.props.continuePressedProp:setDeck(sharedGfxQuads)
	screens.startScreen.props.continuePressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.startScreen.props.continuePressedProp:setLoc(continueX, continueY)
	screens.startScreen.props.continuePressedProp:setVisible(false)
	screens.startScreen.layers.layer:insertProp(screens.startScreen.props.continuePressedProp)
	screens.startScreen.buttonList:addButton("continue", screens.startScreen.props.continueProp, screens.startScreen.props.continuePressedProp)
	screenUtil.addTextBox(
		screens.startScreen.layers.layer,
		continueX, -- centerX
		continueY, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.startScreen.continueButton)

	if windowsBuild then
		--quit
		screens.startScreen.props.quitProp = MOAIProp2D.new()
		screens.startScreen.props.quitProp:setDeck(sharedGfxQuads)
		screens.startScreen.props.quitProp:setIndex(sharedNames["circuitButton.png"])
		screens.startScreen.props.quitProp:setLoc(quitX, quitY)
		screens.startScreen.layers.layer:insertProp(screens.startScreen.props.quitProp)
		--quit pressed
		screens.startScreen.props.quitPressedProp = MOAIProp2D.new()
		screens.startScreen.props.quitPressedProp:setDeck(sharedGfxQuads)
		screens.startScreen.props.quitPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
		screens.startScreen.props.quitPressedProp:setLoc(quitX, quitY)
		screens.startScreen.props.quitPressedProp:setVisible(false)
		screens.startScreen.layers.layer:insertProp(screens.startScreen.props.quitPressedProp)
		screens.startScreen.buttonList:addButton("quit", screens.startScreen.props.quitProp, screens.startScreen.props.quitPressedProp)
		screenUtil.addTextBox(
			screens.startScreen.layers.layer,
			quitX, -- centerX
			quitY, -- centerY
			buttonWidth, -- width
			buttonHeight, -- height
			fonts.grStylusFont,
			MOAITextBox.CENTER_JUSTIFY,
			MOAITextBox.CENTER_JUSTIFY,
			30, -- fontSize
			1, 1, 1, 1, -- color r g b a 
			textLookup.startScreen.quitButton)
	end
		
	
	--draw the title
	screenUtil.addTextBox(
		screens.startScreen.layers.layer,
		0, -- centerX
		300 - 50, -- centerY
		500, -- width
		50, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		50, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.general.gameTitle)
	screenUtil.addTextBox(
		screens.startScreen.layers.layer,
		0, -- centerX
		300 - 50 - 50, -- centerY
		500, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.general.gameSubTitle)


----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
-- Start BETA testing
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
--add a beta build message
-- screens.startScreen.props.llaxonProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- 0, -- centerX
	-- 100, -- centerY
	-- 500, -- width
	-- 30, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- 1, 1, 1, 1, -- color r g b a 
	-- "Beta Build for IGF Submission")


-- --add debug fights message
-- screens.startScreen.props.llaxonProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- 0, -- centerX
	-- -250, -- centerY
	-- 1000, -- width
	-- 20, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 20, -- fontSize
	-- 1, 1, 1, 1, -- color r g b a 
	-- "Try a fight with a fully powered ship.  The B1, B2, B3 and B4 options are for boss battles.")


-- --add a llaxon button
-- screens.startScreen.props.llaxonProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- -450, -- centerX
	-- -300, -- centerY
	-- 150, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
	-- "Llaxon")
-- screens.startScreen.props.llaxonPressedProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- -450, -- centerX
	-- -300, -- centerY
	-- 150, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
	-- "Llaxon")
-- screens.startScreen.props.llaxonPressedProp:setVisible(false)
-- screens.startScreen.buttonList:addButton("llaxon", screens.startScreen.props.llaxonProp, screens.startScreen.props.llaxonPressedProp)

--add a pirate button
screens.startScreen.props.pirateProp = screenUtil.addTextBox(
	screens.startScreen.layers.layer,
	-320, -- centerX
	-300, -- centerY
	150, -- width
	80, -- height
	fonts.grStylusFont,
	MOAITextBox.CENTER_JUSTIFY,
	MOAITextBox.LEFT_JUSTIFY,
	30, -- fontSize
	bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
	"Pirate")
screens.startScreen.props.piratePressedProp = screenUtil.addTextBox(
	screens.startScreen.layers.layer,
	-320, -- centerX
	-300, -- centerY
	150, -- width
	80, -- height
	fonts.grStylusFont,
	MOAITextBox.CENTER_JUSTIFY,
	MOAITextBox.LEFT_JUSTIFY,
	30, -- fontSize
	bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
	"Pirate")
screens.startScreen.props.piratePressedProp:setVisible(false)
screens.startScreen.buttonList:addButton("pirate", screens.startScreen.props.pirateProp, screens.startScreen.props.piratePressedProp)

-- --add a takataka button
-- screens.startScreen.props.takatakaProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- -200, -- centerX
	-- -300, -- centerY
	-- 150, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
	-- "Takataka")
-- screens.startScreen.props.takatakaPressedProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- -200, -- centerX
	-- -300, -- centerY
	-- 150, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
	-- "Takataka")
-- screens.startScreen.props.takatakaPressedProp:setVisible(false)
-- screens.startScreen.buttonList:addButton("takataka", screens.startScreen.props.takatakaProp, screens.startScreen.props.takatakaPressedProp)

-- --add a b1 button
-- screens.startScreen.props.b1Prop = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- -100, -- centerX
	-- -300, -- centerY
	-- 50, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
	-- "B1")
-- screens.startScreen.props.b1PressedProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- -100, -- centerX
	-- -300, -- centerY
	-- 50, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
	-- "B1")
-- screens.startScreen.props.b1PressedProp:setVisible(false)
-- screens.startScreen.buttonList:addButton("b1", screens.startScreen.props.b1Prop, screens.startScreen.props.b1PressedProp)

-- --add a b2 button
-- screens.startScreen.props.b2Prop = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- -50, -- centerX
	-- -300, -- centerY
	-- 50, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
	-- "B2")
-- screens.startScreen.props.b2PressedProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- -50, -- centerX
	-- -300, -- centerY
	-- 50, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
	-- "B2")
-- screens.startScreen.props.b2PressedProp:setVisible(false)
-- screens.startScreen.buttonList:addButton("b2", screens.startScreen.props.b2Prop, screens.startScreen.props.b2PressedProp)

-- --add a b3 button
-- screens.startScreen.props.b3Prop = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- 0, -- centerX
	-- -300, -- centerY
	-- 50, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
	-- "B3")
-- screens.startScreen.props.b3PressedProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- 0, -- centerX
	-- -300, -- centerY
	-- 50, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
	-- "B3")
-- screens.startScreen.props.b3PressedProp:setVisible(false)
-- screens.startScreen.buttonList:addButton("b3", screens.startScreen.props.b3Prop, screens.startScreen.props.b3PressedProp)

-- --add a b4 button
-- screens.startScreen.props.b4Prop = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- 50, -- centerX
	-- -300, -- centerY
	-- 50, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
	-- "B4")
-- screens.startScreen.props.b4PressedProp = screenUtil.addTextBox(
	-- screens.startScreen.layers.layer,
	-- 50, -- centerX
	-- -300, -- centerY
	-- 50, -- width
	-- 80, -- height
	-- fonts.grStylusFont,
	-- MOAITextBox.CENTER_JUSTIFY,
	-- MOAITextBox.LEFT_JUSTIFY,
	-- 30, -- fontSize
	-- bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
	-- "B4")
-- screens.startScreen.props.b4PressedProp:setVisible(false)
-- screens.startScreen.buttonList:addButton("b4", screens.startScreen.props.b4Prop, screens.startScreen.props.b4PressedProp)
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
-- End BETA testing
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

	--since this is the start screen we need a new gamestate object created
	newGameState()

	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.startScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.startScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.startScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.startScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.startScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.startScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.startScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.startScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.startScreen.destroy()
	screens.startScreen.buttonList = nil
	--destroy the props
	for key, value in pairs(screens.startScreen.props) do
		screens.startScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.startScreen.layers) do
		if screens.startScreen.layers[key] ~= nil then
			screens.startScreen.layers[key]:clear()
			screens.startScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.startScreen.viewports) do
		screens.startScreen.viewports[key] = nil
	end
end

