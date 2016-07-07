--####################################
-- creditsSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the credits screen.
--####################################

--namespace screens.creditsScreen

screens.creditsScreen.pointerX = 0
screens.creditsScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.creditsScreen.pointerCallback(x, y)
	cursorHover = false
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.creditsScreen.clickCallback(down)
	if screens.creditsScreen.creditsTimer:getTime() > screens.creditsScreen.creditsWaitTime then
		audioUtil.stopMusic()
		frontController.dispatch(frontController.START_SCREEN)
		return
	end
end
