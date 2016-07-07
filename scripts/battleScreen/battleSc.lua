--####################################
-- battkeSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for a battle.
--####################################

--namespace screens.battleScreen

screens.battleScreen.pointerX = 0
screens.battleScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.battleScreen.pointerCallback(x, y)
	if windowsBuild then
		xbox.mouseMoved(screens.battleScreen.pointerX, x, screens.battleScreen.pointerY, y)
	end

	screens.battleScreen.pointerX, screens.battleScreen.pointerY = x, y
	
	if windowsBuild then
		print("windows")
	else
		--handle the rotate wheel...if there is no touch device then this is the pointer and the user must click for the control to work
		if MOAIInputMgr.device.touch ~= nil or MOAIInputMgr.device.mouseLeft:isDown() then
			local controlX, controlY = screens.battleScreen.layers.controlLayer:wndToWorld(screens.battleScreen.pointerX, screens.battleScreen.pointerY) 
			if screens.battleScreen.props.rotateWheelProp:inside(controlX, controlY) then
				battle.setRotateAngle(controlX, controlY)
			elseif screens.battleScreen.props.moveWheelProp:inside(controlX, controlY) then
				battle.setMoveDirection(controlX, controlY)
			end
		end
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.battleScreen.clickCallback(down)
	local controlWorldX, controlWorldY = screens.battleScreen.layers.controlLayer:wndToWorld(screens.battleScreen.pointerX, screens.battleScreen.pointerY)
	local buttonName = screens.battleScreen.controlButtonList:click(controlWorldX, controlWorldY, down)
	if buttonName == "right" then
		battle.targetNextShip(true)
	elseif buttonName == "left" then
		battle.targetNextShip(false)
	elseif buttonName == "closest" then
		battle.targetClosestShip()
	elseif buttonName == "zoom" then
		screens.battleScreen.zoomScale = screens.battleScreen.zoomScale + 1
		if screens.battleScreen.zoomScale > screens.battleScreen.zoomScales.length then screens.battleScreen.zoomScale = 1 end
		screens.battleScreen.battleFitter:setFitScale(screens.battleScreen.zoomScales[screens.battleScreen.zoomScale])
		screens.battleScreen.dustFitter:setFitScale(screens.battleScreen.dustZoomScales[screens.battleScreen.zoomScale])
		screens.battleScreen.middleFitter:setFitScale(screens.battleScreen.middleZoomScales[screens.battleScreen.zoomScale])
		screens.battleScreen.backgroundFitter:setFitScale(screens.battleScreen.bgZoomScales[screens.battleScreen.zoomScale])
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.battleScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	--move ship with thumbsticks
	if thumbLX ~= 0 and thumbLY ~= 0 then
		battle.setMoveDirection(thumbLX, thumbLY)
	end
	if thumbRX ~= 0 and thumbRY ~= 0 then
		battle.setRotateAngle(thumbRX, thumbRY)
	end
	--check if the buttons we are interested in are down
	local rShoulderDown = xbox.controller:isButtonDown(MOAIXboxController.RIGHT_SHOULDER, buttons)
	local lShoulderDown = xbox.controller:isButtonDown(MOAIXboxController.LEFT_SHOULDER, buttons)
	local rTriggerDown = rightTrigger > 0
	local lTriggerDown = leftTrigger > 0
	
	--check if a button was pressed and take action
	if not xbox.rShoulderDown and rShoulderDown then
		battle.targetClosestShip()
	end
	if not xbox.lShoulderDown and lShoulderDown then
		screens.battleScreen.zoomScale = screens.battleScreen.zoomScale + 1
		if screens.battleScreen.zoomScale > screens.battleScreen.zoomScales.length then screens.battleScreen.zoomScale = 1 end
		screens.battleScreen.battleFitter:setFitScale(screens.battleScreen.zoomScales[screens.battleScreen.zoomScale])
		screens.battleScreen.dustFitter:setFitScale(screens.battleScreen.dustZoomScales[screens.battleScreen.zoomScale])
		screens.battleScreen.middleFitter:setFitScale(screens.battleScreen.middleZoomScales[screens.battleScreen.zoomScale])
		screens.battleScreen.backgroundFitter:setFitScale(screens.battleScreen.bgZoomScales[screens.battleScreen.zoomScale])
	end
	if not xbox.rTriggerDown and rTriggerDown then
		battle.targetNextShip(true)
	end
	if not xbox.lTriggerDown and lTriggerDown then
		battle.targetNextShip(false)
	end
	
	--set the button values
	xbox.rShoulderDown = rShoulderDown
	xbox.lShoulderDown = lShoulderDown
	xbox.rTriggerDown = rTriggerDown
	xbox.lTriggerDown = lTriggerDown
end



function screens.battleScreen.windowsPointerCallback(x, y)
	battle.setRotateAngle(screens.battleScreen.layers.controlLayer:wndToWorld(x, y))
end

function screens.battleScreen.windowsLeftClickCallback(down)
end

function screens.battleScreen.windowsRightClickCallback(down)
end

function screens.battleScreen.keyboardCallback(key, down)
end

