--####################################
-- fakeBattleScreen.lua
-- author: Jonas Yakimischak
--
-- This is the battle screen for the game....right now it just says battle.
--####################################

--namespace screens.fakeBattleScreen

screens.fakeBattleScreen.props = {}
screens.fakeBattleScreen.viewports = {}
screens.fakeBattleScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.fakeBattleScreen.display()
	--set the victory to nil...this will be true if the player wins, false if they lose
	screens.battleScreen.victory = nil

	--setup the viewport and layer
	screens.fakeBattleScreen.viewports.viewport = MOAIViewport.new()
	screens.fakeBattleScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.fakeBattleScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.fakeBattleScreen.layers.layer = MOAILayer2D.new()
	screens.fakeBattleScreen.layers.layer:setViewport(screens.fakeBattleScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.fakeBattleScreen.layers.layer)

	--say battle
	screenUtil.addTextBox(
		screens.fakeBattleScreen.layers.layer,
		0, -- centerX
		0, -- centerY
		SCREEN_UNITS_X, -- width
		40, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		40, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		"Battle!")

	--setup the controller callbacks
	if MOAIInputMgr.device.pointer then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.fakeBattleScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.fakeBattleScreen.clickCallback)
	else
		-- touch input
		MOAIInputMgr.device.touch:setCallback ( 
			function(eventType, idx, x, y, tapCount)
				screens.fakeBattleScreen.pointerCallback(x, y)
				if eventType == MOAITouchSensor.TOUCH_DOWN then
					screens.fakeBattleScreen.clickCallback(true)
				elseif eventType == MOAITouchSensor.TOUCH_UP then
					screens.fakeBattleScreen.clickCallback(false)
				end
			end
		)
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.fakeBattleScreen.destroy()
	screens.fakeBattleScreen.clickablePropList = nil
	screens.fakeBattleScreen.bannerButtonList = nil
	screens.fakeBattleScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.fakeBattleScreen.props) do
		screens.fakeBattleScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.fakeBattleScreen.layers) do
		if screens.fakeBattleScreen.layers[key] ~= nil then
			screens.fakeBattleScreen.layers[key]:clear()
			screens.fakeBattleScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.fakeBattleScreen.viewports) do
		screens.fakeBattleScreen.viewports[key] = nil
	end
end


