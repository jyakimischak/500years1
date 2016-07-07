--####################################
-- cutSceneScreen.lua
-- author: Jonas Yakimischak
--
-- This is the cut scene for the game.
--####################################

--namespace screens.cutSceneScreen

screens.cutSceneScreen.props = {}
screens.cutSceneScreen.viewports = {}
screens.cutSceneScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.cutSceneScreen.display()
	screens.cutSceneScreen.sceneComplete = false
	screens.cutSceneScreen.sceneWidth = 700
	screens.cutSceneScreen.sceneHeight = 400
	screens.cutSceneScreen.captionIndex = 1
	
	--setup the viewport and layer
	screens.cutSceneScreen.viewports.viewport = MOAIViewport.new()
	screens.cutSceneScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.cutSceneScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.cutSceneScreen.layers.layer = MOAILayer2D.new()
	screens.cutSceneScreen.layers.layer:setViewport(screens.cutSceneScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.cutSceneScreen.layers.layer)

	--set up the scene prop
	if screens.cutSceneScreen.gfxQuads ~= nil then
		screens.cutSceneScreen.gfxQuads:setRect(screens.cutSceneScreen.names[screens.cutSceneScreen.sceneIndex], screens.cutSceneScreen.sceneWidth / 2 * -1, screens.cutSceneScreen.sceneHeight / 2 * -1, screens.cutSceneScreen.sceneWidth / 2, screens.cutSceneScreen.sceneHeight / 2)
		screens.cutSceneScreen.props.sceneProp = MOAIProp2D.new()
		screens.cutSceneScreen.props.sceneProp:setLoc(0, 50)
		screens.cutSceneScreen.props.sceneProp:setDeck(screens.cutSceneScreen.gfxQuads)
		screens.cutSceneScreen.props.sceneProp:setIndex(screens.cutSceneScreen.names[screens.cutSceneScreen.sceneIndex])
		screens.cutSceneScreen.layers.layer:insertProp(screens.cutSceneScreen.props.sceneProp)
	end

	screens.cutSceneScreen.props.captionProp = screenUtil.addTextBox(
		screens.cutSceneScreen.layers.layer,
		0, -- centerX
		-200, -- centerY
		SCREEN_UNITS_X, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		screens.cutSceneScreen.captions[screens.cutSceneScreen.captionIndex])

	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.cutSceneScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.cutSceneScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.cutSceneScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.cutSceneScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.cutSceneScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.cutSceneScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.cutSceneScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.cutSceneScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.cutSceneScreen.destroy()
	screens.cutSceneScreen.clickablePropList = nil
	screens.cutSceneScreen.bannerButtonList = nil
	screens.cutSceneScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.cutSceneScreen.props) do
		screens.cutSceneScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.cutSceneScreen.layers) do
		if screens.cutSceneScreen.layers[key] ~= nil then
			screens.cutSceneScreen.layers[key]:clear()
			screens.cutSceneScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.cutSceneScreen.viewports) do
		screens.cutSceneScreen.viewports[key] = nil
	end
end


