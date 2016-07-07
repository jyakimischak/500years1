--####################################
-- dialogScreen.lua
-- author: Jonas Yakimischak
--
-- This is the dialog screen for the game.
--####################################

--namespace screens.dialogScreen

screens.dialogScreen.props = {}
screens.dialogScreen.viewports = {}
screens.dialogScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.dialogScreen.display()
	screens.dialogScreen.optionProps = {}

	screens.dialogScreen.portraitWidth = 230

	--setup the viewport and layer
	screens.dialogScreen.viewports.viewport = MOAIViewport.new()
	screens.dialogScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.dialogScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.dialogScreen.layers.layer = MOAILayer2D.new()
	screens.dialogScreen.layers.layer:setViewport(screens.dialogScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.dialogScreen.layers.layer)

	--setup clickable prop list
--	screens.dialogScreen.clickablePropList = screenUtil.getClickablePropList()
--	--setup button lists
--	screens.dialogScreen.optionsButtonList = screenUtil.getButtonList()

	--get the dialog option
	screens.dialogScreen.dialog = model.dialog[gameState.dialog]()

	--setup sprites
	--draw the portrait
	local portraitWidth = screens.dialogScreen.portraitWidth
	local deck, names, index = screens.dialogScreen.dialog:getPortrait()
	deck:setRect(names[index], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
	screens.dialogScreen.props.portrait = MOAIProp2D.new()
	screens.dialogScreen.props.portrait:setDeck(deck)
	screens.dialogScreen.props.portrait:setIndex(names[index])
	screens.dialogScreen.props.portrait:setLoc((SCREEN_UNITS_X / 2 * -1) + screens.dialogScreen.portraitWidth / 2, SCREEN_UNITS_Y / 2 - screens.dialogScreen.portraitWidth / 2)
	screens.dialogScreen.layers.layer:insertProp(screens.dialogScreen.props.portrait)

	--setup the dialog option row sprites
	sharedGfxQuads:setRect(sharedNames["dialogOptionOdd.png"], -550, -20, 550, 20)
	sharedGfxQuads:setRect(sharedNames["dialogOptionEven.png"], -550, -20, 550, 20)
	screens.dialogScreen.props.optionRows = util.getArrayList()
--	local optionStartY = 40
	local optionStartY = SCREEN_UNITS_Y / 2 - 270
	local optionSpaceBetween = 40
	for i = 1, 9 do
		screens.dialogScreen.props.optionRows:add(MOAIProp2D.new())
		screens.dialogScreen.props.optionRows[i]:setDeck(sharedGfxQuads)
		if i % 2 == 1 then
			screens.dialogScreen.props.optionRows[i]:setIndex(sharedNames["dialogOptionOdd.png"])
		else
			screens.dialogScreen.props.optionRows[i]:setIndex(sharedNames["dialogOptionEven.png"])
		end
		screens.dialogScreen.props.optionRows[i]:setLoc(0, optionStartY - (optionSpaceBetween * (i - 1)))
		screens.dialogScreen.props.optionRows[i]:setVisible(false)
		screens.dialogScreen.layers.layer:insertProp(screens.dialogScreen.props.optionRows[i])
	end

	--draw the horizontal rule dividing the screens
	local function drawHorizontalRule(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(bannerHRColorR, bannerHRColorG, bannerHRColorB)
		MOAIDraw.fillRect(SCREEN_UNITS_X / 2 * -1, 1, SCREEN_UNITS_X / 2, -2)
	end
	local hrDeck = MOAIScriptDeck.new()
	hrDeck:setRect(SCREEN_UNITS_X / 2 * -1, 1, SCREEN_UNITS_X / 2, -2)
	hrDeck:setDrawCallback(drawHorizontalRule)
	local hrProp = MOAIProp2D.new()
	hrProp:setDeck(hrDeck)
	hrProp:setLoc(0, SCREEN_UNITS_Y / 2 - screens.dialogScreen.portraitWidth)
	screens.dialogScreen.layers.layer:insertProp(hrProp)

	--vertical line
	local function drawVerticalLine(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(bannerHRColorR, bannerHRColorG, bannerHRColorB)
		MOAIDraw.fillRect(1, screens.dialogScreen.portraitWidth / 2, -2, screens.dialogScreen.portraitWidth / 2 * -1)
	end
	local vlDeck = MOAIScriptDeck.new()
	vlDeck:setRect(1, screens.dialogScreen.portraitWidth / 2, -2, screens.dialogScreen.portraitWidth / 2 * -1)
	vlDeck:setDrawCallback(drawVerticalLine)
	local vlProp = MOAIProp2D.new()
	vlProp:setDeck(vlDeck)
	vlProp:setLoc((SCREEN_UNITS_X / 2 * -1) + screens.dialogScreen.portraitWidth, SCREEN_UNITS_Y / 2 - screens.dialogScreen.portraitWidth / 2)
	screens.dialogScreen.layers.layer:insertProp(vlProp)
	
	--npc dialog text box
	screens.dialogScreen.props.npcDialogText = screenUtil.addTextBox(
		screens.dialogScreen.layers.layer,
		SCREEN_UNITS_X / 2 - (SCREEN_UNITS_X - screens.dialogScreen.portraitWidth) / 2 + 5, -- centerX
		SCREEN_UNITS_Y / 2 - screens.dialogScreen.portraitWidth / 2 - 5, -- centerY
		SCREEN_UNITS_X - screens.dialogScreen.portraitWidth - 10, -- width
		screens.dialogScreen.portraitWidth - 10, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		screens.dialogScreen.dialog:startDialog())
	
	--draw the options props
	screens.dialogScreen.drawOptions()


	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.dialogScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.dialogScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.dialogScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.dialogScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.dialogScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.dialogScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.dialogScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.dialogScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.dialogScreen.destroy()
	screens.dialogScreen.clickablePropList = nil
	screens.dialogScreen.bannerButtonList = nil
	screens.dialogScreen.screenButtonList = nil
	--destroy the options
	for i = 1, screens.dialogScreen.props.optionRows.length do
		screens.dialogScreen.props.optionRows[i] = nil
	end
	--destroy the props
	for key, value in pairs(screens.dialogScreen.props) do
		screens.dialogScreen.props[key] = nil
	end
	for key, value in pairs(screens.dialogScreen.optionProps) do
		screens.dialogScreen.optionProps[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.dialogScreen.layers) do
		if screens.dialogScreen.layers[key] ~= nil then
			screens.dialogScreen.layers[key]:clear()
			screens.dialogScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.dialogScreen.viewports) do
		screens.dialogScreen.viewports[key] = nil
	end
end


--------------------------------------------------------------------------
-- drawOptions
--------------------------------------------------------------------------
function screens.dialogScreen.drawOptions()
	local options = screens.dialogScreen.dialog:getOptions()
	
	--setup the button selected prop
	if windowsBuild then
		if screens.dialogScreen.props.selectedArrowProp then
			screens.dialogScreen.layers.layer:removeProp(screens.dialogScreen.props.selectedArrowProp)
		end
		local selectedArrowWidth = 30
		local selectedArrowHeight = selectedArrowWidth * 110 / 100
		sharedGfxQuads:setRect(sharedNames["selectArrow.png"], selectedArrowWidth / 2 * -1, selectedArrowHeight / 2 * -1, selectedArrowWidth / 2, selectedArrowHeight / 2)
		screens.dialogScreen.props.selectedArrowProp = MOAIProp2D.new()
		screens.dialogScreen.props.selectedArrowProp:setDeck(sharedGfxQuads)
		screens.dialogScreen.props.selectedArrowProp:setIndex(sharedNames["selectArrow.png"])
		screens.dialogScreen.props.selectedArrowProp:setVisible(false)
	end

	--run through the options that are already displayed and remove them
	screens.dialogScreen.optionsButtonList = screenUtil.getButtonList(screens.dialogScreen.props.selectedArrowProp, -500, 0)
	for key, value in pairs(screens.dialogScreen.optionProps) do
		screens.dialogScreen.layers.layer:removeProp(value)
		screens.dialogScreen.optionProps[key] = nil
	end
	for i = 1, screens.dialogScreen.props.optionRows.length do
		screens.dialogScreen.props.optionRows[i]:setVisible(false)
	end

	--now add the new options
--	local optionStartY = 40
	local optionStartY = SCREEN_UNITS_Y / 2 - 270
	local optionSpaceBetween = 40
	local optionFontSize = 30
	for i=1, options.length do
		screens.dialogScreen.optionProps[options[i].name] = screenUtil.addTextBox(
			screens.dialogScreen.layers.layer,
			0, -- centerX
			optionStartY - (optionSpaceBetween * (i - 1)), -- centerY
			SCREEN_UNITS_X - 20, -- width
			optionFontSize, -- height
			fonts.grStylusFont,
			MOAITextBox.LEFT_JUSTIFY,
			MOAITextBox.LEFT_JUSTIFY,
			optionFontSize, -- fontSize
			1, 1, 1, 1, -- color r g b a 
			"- "..options[i].question)
		screens.dialogScreen.optionProps[options[i].name.."Pressed"] = screenUtil.addTextBox(
			screens.dialogScreen.layers.layer,
			0, -- centerX
			optionStartY - (optionSpaceBetween * (i - 1)), -- centerY
			SCREEN_UNITS_X - 20, -- width
			optionFontSize, -- height
			fonts.grStylusFont,
			MOAITextBox.LEFT_JUSTIFY,
			MOAITextBox.LEFT_JUSTIFY,
			optionFontSize, -- fontSize
			.6, .6, .6, .6, -- color r g b a 
			"- "..options[i].question)
		screens.dialogScreen.optionProps[options[i].name.."Pressed"]:setVisible(false)
		screens.dialogScreen.optionsButtonList:addButton(options[i].name, screens.dialogScreen.optionProps[options[i].name], screens.dialogScreen.optionProps[options[i].name.."Pressed"], 0, optionStartY - (optionSpaceBetween * (i - 1)))
		screens.dialogScreen.props.optionRows[i]:setVisible(true)
	end
	
	if windowsBuild then
		screens.dialogScreen.optionsButtonList:selectedVisible(not xbox.cursorVisible)
		screens.dialogScreen.layers.layer:insertProp(screens.dialogScreen.props.selectedArrowProp)
	end


end
