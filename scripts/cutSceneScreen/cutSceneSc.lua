--####################################
-- cutSceneSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the cut scene screen.
--####################################

--namespace screens.cutSceneScreen

screens.cutSceneScreen.pointerX = 0
screens.cutSceneScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.cutSceneScreen.pointerCallback(x, y)
	cursorHover = false
	if windowsBuild then
		xbox.mouseMoved(screens.cutSceneScreen.pointerX, x, screens.cutSceneScreen.pointerY, y)
	end
	
	screens.cutSceneScreen.pointerX, screens.cutSceneScreen.pointerY = x, y 
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.cutSceneScreen.clickCallback(down)
	if not down then
		if screens.cutSceneScreen.captionIndex < screens.cutSceneScreen.captions.length then
			screens.cutSceneScreen.captionIndex = screens.cutSceneScreen.captionIndex + 1
			screens.cutSceneScreen.props.captionProp:setString(screens.cutSceneScreen.captions[screens.cutSceneScreen.captionIndex])
		else
			screens.cutSceneScreen.sceneComplete = true
		end
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.cutSceneScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		if screens.cutSceneScreen.captionIndex < screens.cutSceneScreen.captions.length then
			screens.cutSceneScreen.captionIndex = screens.cutSceneScreen.captionIndex + 1
			screens.cutSceneScreen.props.captionProp:setString(screens.cutSceneScreen.captions[screens.cutSceneScreen.captionIndex])
		else
			screens.cutSceneScreen.sceneComplete = true
		end
	end
end