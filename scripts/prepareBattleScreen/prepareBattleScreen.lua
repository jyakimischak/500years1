--####################################
-- prepareBattleScreen.lua
-- author: Jonas Yakimischak
--
-- This is the battle preparation screen for the game.
--####################################

--namespace screens.prepareBattleScreen

screens.prepareBattleScreen.props = {}
screens.prepareBattleScreen.viewports = {}
screens.prepareBattleScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.prepareBattleScreen.display()
	--setup the viewport and layer
	screens.prepareBattleScreen.viewports.viewport = MOAIViewport.new()
	screens.prepareBattleScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.prepareBattleScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.prepareBattleScreen.layers.screenLayer = MOAILayer2D.new()
	screens.prepareBattleScreen.layers.screenLayer:setViewport(screens.prepareBattleScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.prepareBattleScreen.layers.screenLayer)

	--background
	screens.prepareBattleScreen.props.backgroundProp = MOAIProp2D.new()
	screens.prepareBattleScreen.props.backgroundProp:setDeck(sharedGfxQuads)
	screens.prepareBattleScreen.props.backgroundProp:setIndex(sharedNames["starBackground.png"])
	screens.prepareBattleScreen.props.backgroundProp:setLoc(0, 0)
	screens.prepareBattleScreen.layers.screenLayer:insertProp(screens.prepareBattleScreen.props.backgroundProp)

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
		screens.prepareBattleScreen.props.selectedButtonProp = MOAIProp2D.new()
		screens.prepareBattleScreen.props.selectedButtonProp:setDeck(sharedGfxQuads)
		screens.prepareBattleScreen.props.selectedButtonProp:setIndex(sharedNames["buttonSelected.png"])
		screens.prepareBattleScreen.props.selectedButtonProp:setVisible(false)
		screens.prepareBattleScreen.layers.screenLayer:insertProp(screens.prepareBattleScreen.props.selectedButtonProp)
	end
	--setup button lists
	screens.prepareBattleScreen.screenButtonList = screenUtil.getButtonList(screens.prepareBattleScreen.props.selectedButtonProp)

	--add the loadout button
	local loadoutX = -300
	local loadoutY = -200
	screens.prepareBattleScreen.props.loadoutButtonProp = MOAIProp2D.new()
	screens.prepareBattleScreen.props.loadoutButtonProp:setDeck(sharedGfxQuads)
	screens.prepareBattleScreen.props.loadoutButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.prepareBattleScreen.props.loadoutButtonProp:setLoc(loadoutX, loadoutY)
	screens.prepareBattleScreen.layers.screenLayer:insertProp(screens.prepareBattleScreen.props.loadoutButtonProp)
	--pressed
	screens.prepareBattleScreen.props.loadoutButtonPressedProp = MOAIProp2D.new()
	screens.prepareBattleScreen.props.loadoutButtonPressedProp:setDeck(sharedGfxQuads)
	screens.prepareBattleScreen.props.loadoutButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.prepareBattleScreen.props.loadoutButtonPressedProp:setLoc(loadoutX, loadoutY)
	screens.prepareBattleScreen.props.loadoutButtonPressedProp:setVisible(false)
	screens.prepareBattleScreen.layers.screenLayer:insertProp(screens.prepareBattleScreen.props.loadoutButtonPressedProp)
	screens.prepareBattleScreen.screenButtonList:addButton("loadout", screens.prepareBattleScreen.props.loadoutButtonProp, screens.prepareBattleScreen.props.loadoutButtonPressedProp)
	screenUtil.addTextBox(
		screens.prepareBattleScreen.layers.screenLayer,
		loadoutX, -- centerX
		loadoutY, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.prepareBattleScreen.loadout)

	--add the battle button
	local battleX = 300
	local battleY = -200
	screens.prepareBattleScreen.props.battleButtonProp = MOAIProp2D.new()
	screens.prepareBattleScreen.props.battleButtonProp:setDeck(sharedGfxQuads)
	screens.prepareBattleScreen.props.battleButtonProp:setIndex(sharedNames["circuitButton.png"])
	screens.prepareBattleScreen.props.battleButtonProp:setLoc(battleX, battleY)
	screens.prepareBattleScreen.layers.screenLayer:insertProp(screens.prepareBattleScreen.props.battleButtonProp)
	--pressed
	screens.prepareBattleScreen.props.battleButtonPressedProp = MOAIProp2D.new()
	screens.prepareBattleScreen.props.battleButtonPressedProp:setDeck(sharedGfxQuads)
	screens.prepareBattleScreen.props.battleButtonPressedProp:setIndex(sharedNames["circuitButtonPressed.png"])
	screens.prepareBattleScreen.props.battleButtonPressedProp:setLoc(battleX, battleY)
	screens.prepareBattleScreen.props.battleButtonPressedProp:setVisible(false)
	screens.prepareBattleScreen.layers.screenLayer:insertProp(screens.prepareBattleScreen.props.battleButtonPressedProp)
	screens.prepareBattleScreen.screenButtonList:addButton("fight", screens.prepareBattleScreen.props.battleButtonProp, screens.prepareBattleScreen.props.battleButtonPressedProp)
	screenUtil.addTextBox(
		screens.prepareBattleScreen.layers.screenLayer,
		battleX, -- centerX
		battleY, -- centerY
		buttonWidth, -- width
		buttonHeight, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.prepareBattleScreen.fight)

	--battle
	screenUtil.addTextBox(
		screens.prepareBattleScreen.layers.screenLayer,
		0, -- centerX
		250, -- centerY
		500, -- width
		50, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		50, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.prepareBattleScreen.battle)

	--enemies
	screenUtil.addTextBox(
		screens.prepareBattleScreen.layers.screenLayer,
		-400, -- centerX
		200, -- centerY
		200, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.prepareBattleScreen.enemies)


	--draw the enemies with counts
	local enemySize = 100
	local enemyType = 1
	local enemyStartX = -450
	local enemyY = 100
	for enemyName, enemyCount in pairs(battle.currentBattle.enemyCounts) do
		--draw the prop
		local enemyProp = ships.getShipIcon(enemyName, enemySize)
		enemyProp:setLoc(enemyStartX, enemyY)
		screens.prepareBattleScreen.layers.screenLayer:insertProp(enemyProp)
		screenUtil.addTextBox(
			screens.prepareBattleScreen.layers.screenLayer,
			enemyStartX + enemySize / 2 + 10, -- centerX
			enemyY - enemySize / 2, -- centerY
			50, -- width
			20, -- height
			fonts.grStylusFont,
			MOAITextBox.LEFT_JUSTIFY,
			MOAITextBox.LEFT_JUSTIFY,
			20, -- fontSize,
			1, 1, 1, 1, -- color r g b a 
			"X"..enemyCount)
		enemyStartX = enemyStartX + enemySize + 30
	end

	if windowsBuild then
		screens.prepareBattleScreen.screenButtonList:selectedVisible(not xbox.cursorVisible)
	end

	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.prepareBattleScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.prepareBattleScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.prepareBattleScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.prepareBattleScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.prepareBattleScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.prepareBattleScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.prepareBattleScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.prepareBattleScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.prepareBattleScreen.destroy()
	screens.prepareBattleScreen.clickablePropList = nil
	screens.prepareBattleScreen.bannerButtonList = nil
	screens.prepareBattleScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.prepareBattleScreen.props) do
		screens.prepareBattleScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.prepareBattleScreen.layers) do
		if screens.prepareBattleScreen.layers[key] ~= nil then
			screens.prepareBattleScreen.layers[key]:clear()
			screens.prepareBattleScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.prepareBattleScreen.viewports) do
		screens.prepareBattleScreen.viewports[key] = nil
	end
end
