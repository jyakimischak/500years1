--####################################
-- logScreen.lua
-- author: Jonas Yakimischak
--
-- This is the log screen for the game.
--####################################

--namespace screens.logScreen

screens.logScreen.props = {}
screens.logScreen.viewports = {}
screens.logScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.logScreen.display()
	--setup the viewports and layers
	--banner
	screens.logScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.logScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MIN + 72)
	screens.logScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, 72)
	screens.logScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.logScreen.layers.bannerLayer:setViewport(screens.logScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.logScreen.layers.bannerLayer)
	--screen
	screens.logScreen.viewports.screenViewport = MOAIViewport.new()
	screens.logScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, 73, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.logScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y - 72)
	screens.logScreen.layers.screenLayer = MOAILayer2D.new()
	screens.logScreen.layers.screenLayer:setViewport(screens.logScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.logScreen.layers.screenLayer)

	--setup button lists
	screens.logScreen.bannerButtonList = screenUtil.getButtonList()
	screens.logScreen.screenButtonList = screenUtil.getButtonList()

	
	--draw the banner background
	screens.logScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.logScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.logScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.logScreen.props.bannerBackgroundProp:setLoc(0, 0)
	screens.logScreen.layers.bannerLayer:insertProp(screens.logScreen.props.bannerBackgroundProp)

	--draw the title
	screenUtil.addTextBox(
		screens.logScreen.layers.bannerLayer,
		0, -- centerX
		-22, -- centerY
		500, -- width
		50, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.logScreen.title)
		
	--add the back button
	screens.logScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.logScreen.layers.bannerLayer,
		SCREEN_UNITS_X / 2 * -1 + 70, -- centerX
		-30, -- centerY
		150, -- width
		80, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
		textLookup.general.back)
	screens.logScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.logScreen.layers.bannerLayer,
		SCREEN_UNITS_X / 2 * -1 + 70, -- centerX
		-30, -- centerY
		150, -- width
		80, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
		textLookup.general.back)
	screens.logScreen.props.backButtonPressedProp:setVisible(false)
	screens.logScreen.bannerButtonList:addButton("back", screens.logScreen.props.backButtonProp, screens.logScreen.props.backButtonPressedProp)
	
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
	hrProp:setLoc(0, -34)
	screens.logScreen.layers.bannerLayer:insertProp(hrProp)


	--draw the vertical line between the quest list and description
	local function drawVerticalLine(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(bannerHRColorR, bannerHRColorG, bannerHRColorB)
		MOAIDraw.fillRect(1, SCREEN_UNITS_Y / 2, -2, SCREEN_UNITS_Y / 2 * -1)
	end
	local verticalLineDeck = MOAIScriptDeck.new()
	verticalLineDeck:setRect(1, SCREEN_UNITS_Y / 2, -2, SCREEN_UNITS_Y / 2 * -1)
	verticalLineDeck:setDrawCallback(drawVerticalLine)
	local verticalLineProp = MOAIProp2D.new()
	verticalLineProp:setDeck(verticalLineDeck)
	verticalLineProp:setLoc(-80, 0)
	screens.logScreen.layers.screenLayer:insertProp(verticalLineProp)

	--draw the list of quest on the left of the screen
	local questsX = -300
	screens.logScreen.questsStartY = 230
	screens.logScreen.questsMaxY = 800
	local questsSpaceBetween = 50
	local questCount = 0
	screens.logScreen.logListProps = util.getArrayList()
	for i=1, model.quests.allQuests.length do
		local questFunctionName = model.quests.allQuests[i] 
		if gameState.quests[questFunctionName].started then
			local quest = model.quests[questFunctionName]()
			screens.logScreen.props[questFunctionName] = screenUtil.addTextBox(
				screens.logScreen.layers.screenLayer,
				questsX, -- centerX
				screens.logScreen.questsStartY - (questsSpaceBetween * questCount), -- centerY
				400, -- width
				30, -- height
				fonts.grStylusFont,
				MOAITextBox.LEFT_JUSTIFY,
				MOAITextBox.LEFT_JUSTIFY,
				30, -- fontSize
				1, 1, 1, 1, -- color r g b a 
				quest.name)
			screens.logScreen.logListProps:add(screens.logScreen.props[questFunctionName])
			screens.logScreen.props[questFunctionName.."Pressed"] = screenUtil.addTextBox(
				screens.logScreen.layers.screenLayer,
				questsX, -- centerX
				screens.logScreen.questsStartY - (questsSpaceBetween * questCount), -- centerY
				400, -- width
				30, -- height
				fonts.grStylusFont,
				MOAITextBox.LEFT_JUSTIFY,
				MOAITextBox.LEFT_JUSTIFY,
				30, -- fontSize
				.6, .6, .6, 1, -- color r g b a 
				quest.name)
			screens.logScreen.logListProps:add(screens.logScreen.props[questFunctionName.."Pressed"])
			screens.logScreen.props[questFunctionName.."Pressed"]:setVisible(false)
			screens.logScreen.screenButtonList:addButton(questFunctionName, screens.logScreen.props[questFunctionName], screens.logScreen.props[questFunctionName.."Pressed"])
			if questCount == 0 then
				screens.logScreen.firstQuestToView = questFunctionName
			end
			questCount = questCount + 1
		end
	end
	
	--add the log entry on the right hand side
	local quest = model.quests[screens.logScreen.firstQuestToView]()
	screens.logScreen.logEntryMinY = -10000 + 230
	screens.logScreen.logEntryMaxY = 10000
	screens.logScreen.props.logEntry = screenUtil.addTextBox(
		screens.logScreen.layers.screenLayer,
		220, -- centerX
		screens.logScreen.logEntryMinY, -- centerY
		565, -- width
		20000, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		quest:getLogEntry())


	--setup the controller callbacks
	if MOAIInputMgr.device.pointer then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.logScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.logScreen.clickCallback)
	else
		-- touch input
		MOAIInputMgr.device.touch:setCallback ( 
			function(eventType, idx, x, y, tapCount)
				screens.logScreen.pointerCallback(x, y)
				if eventType == MOAITouchSensor.TOUCH_DOWN then
					screens.logScreen.clickCallback(true)
				elseif eventType == MOAITouchSensor.TOUCH_UP then
					screens.logScreen.clickCallback(false)
				end
			end
		)
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.logScreen.destroy()
	screens.logScreen.clickablePropList = nil
	screens.logScreen.bannerButtonList = nil
	screens.logScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.logScreen.props) do
		screens.logScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.logScreen.layers) do
		if screens.logScreen.layers[key] ~= nil then
			screens.logScreen.layers[key]:clear()
			screens.logScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.logScreen.viewports) do
		screens.logScreen.viewports[key] = nil
	end
end

