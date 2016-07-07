--####################################
-- xboxController.lua
-- author: Jonas Yakimischak
--
-- This helps with handling xbox controller input to the game.
--####################################

--namespace xbox

xbox.controller = nil
xbox.cursorVisible = true

--------------------------------------------------------------------------
-- Setup a new xbox controller object and start it.
--------------------------------------------------------------------------
function xbox.startController()
	xbox.controller = MOAIXboxController.new()
	xbox.controller:start()
end

--------------------------------------------------------------------------
-- Sets a callback function for the xbox controller.
--------------------------------------------------------------------------
function xbox.setCallback(callback)
	if callback then
		xbox.aDown = false
		xbox.rTriggerDown = false
		xbox.lTriggerDown = false
		xbox.rShoulderDown = false
		xbox.lShoulderDown = false
		xbox.leftThumbMoved = false
		xbox.controller:setCallback(function(changed1, connected1, buttons1, leftTrigger1, rightTrigger1, thumbLX1, thumbLY1, thumbRX1, thumbRY1,
											changed2, connected2, buttons2, leftTrigger2, rightTrigger2, thumbLX2, thumbLY2, thumbRX2, thumbRY2,
											changed3, connected3, buttons3, leftTrigger3, rightTrigger3, thumbLX3, thumbLY3, thumbRX3, thumbRY3,
											changed4, connected4, buttons4, leftTrigger4, rightTrigger4, thumbLX4, thumbLY4, thumbRX4, thumbRY4)
				if connected1 and changed1 then
					if xbox.cursorVisible then
						glut:setCursor(MOAIGlut.GLUT_CURSOR_NONE)
						xbox.cursorVisible = false
					end
					callback(buttons1, leftTrigger1, rightTrigger1, thumbLX1, thumbLY1, thumbRX1, thumbRY1)
				end
			end)
	else
		xbox.controller:setCallback(function() end)
	end
end

--------------------------------------------------------------------------
-- The mouse moved, show the cursor if need be
--------------------------------------------------------------------------
function xbox.mouseMoved(prevX, curX, prevY, curY)
	-- local localPrevX
	-- if prevX == nil then localPrevX = 0 else localPrevX = prevX end
	-- local localCurX
	-- if curX == nil then localCurX = 0 else localCurX = curX end
	-- local localPrevY
	-- if prevY == nil then localPrevY = 0 else localPrevY = prevY end
	-- local localCurY
	-- if curY == nil then localCurY = 0 else localCurY = curY end
	-- if not xbox.cursorVisible and (not util.fuzzyCompare(localPrevX, localCurX, 1) or not util.fuzzyCompare(localPrevY, localCurY, 1)) then
	if cursorHover then
		glut:setCursor(MOAIGlut.GLUT_CURSOR_CROSSHAIR)
	else
		glut:setCursor(MOAIGlut.GLUT_CURSOR_LEFT_ARROW)
	end
	xbox.cursorVisible = true
	-- end
end
