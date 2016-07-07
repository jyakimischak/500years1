--####################################
-- victoryScreen.lua
-- author: Jonas Yakimischak
--
-- This is the screen for when a battle is won.
--####################################

--namespace screens.victoryScreen

screens.victoryScreen.props = {}
screens.victoryScreen.viewports = {}
screens.victoryScreen.layers = {}
screens.victoryScreen.complete = false

--------------------------------------------------------------------------
-- display
--
-- The defeat screen starts with an animations of an explosion...this will be played then
-- displayOptionsScreen will be called to draw the actual screen.
--------------------------------------------------------------------------
function screens.victoryScreen.display()
	cursorHover = false

	--set the victory to not complete
	screens.victoryScreen.complete = false

	--stop any callbacks
	if MOAIInputMgr.device.pointer then
		MOAIInputMgr.device.pointer:setCallback(nil)
		MOAIInputMgr.device.mouseLeft:setCallback(nil)
	else
		MOAIInputMgr.device.touch:setCallback(nil)
	end 

	--setup the viewport and layer
	screens.victoryScreen.viewports.viewport = MOAIViewport.new()
	screens.victoryScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.victoryScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.victoryScreen.layers.layer = MOAILayer2D.new()
	screens.victoryScreen.layers.layer:setViewport(screens.victoryScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.victoryScreen.layers.layer)

	--victory
	screenUtil.addTextBox(
		screens.victoryScreen.layers.layer,
		0, -- centerX
		0, -- centerY
		SCREEN_UNITS_X, -- width
		100, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		100, -- fontSize,
		1, 1, 1, 1, -- color r g b a 
		textLookup.victoryScreen.victory)

	local displayThread = MOAICoroutine.new()
	displayThread:run (
		function()
			local victoryTime = 3
			local timer = MOAITimer.new()
			timer:setMode(MOAITimer.CONTINUE)
			timer:start()
			--stop the music
			audioUtil.stopMusic()
			--play the victory sound
			audioUtil.playSound("victory")
			local startTime = timer:getTime()
			while (timer:getTime() - startTime) < victoryTime do
				coroutine.yield()
			end
			timer:stop()
			screens.victoryScreen.complete = true

			textureUtil.loadTextures(textureUtil.NON_COMBAT)
		end
	)
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.victoryScreen.destroy()
	screens.victoryScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.victoryScreen.props) do
		screens.victoryScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.victoryScreen.layers) do
		if screens.victoryScreen.layers[key] ~= nil then
			screens.victoryScreen.layers[key]:clear()
			screens.victoryScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.victoryScreen.viewports) do
		screens.victoryScreen.viewports[key] = nil
	end
end

