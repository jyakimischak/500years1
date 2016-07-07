--####################################
-- starMapSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the star map screen.
--####################################

--namespace screens.starMapScreen

screens.starMapScreen.pointer0X = 0
screens.starMapScreen.pointer0Y = 0
screens.starMapScreen.pointer1X = 0
screens.starMapScreen.pointer1Y = 0

--in pixels per second
screens.starMapScreen.shipMoveSpeed = 200

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.starMapScreen.pointerCallback(x, y)
	cursorHover = false

	if gameState.traveling then
		return
	end
	
	local idx0, idx1

	if MOAIInputMgr.device.touch == nil then
		x0, y0 = x, y
	else
		idx0, idx1 = MOAIInputMgr.device.touch:getActiveTouches()
		if idx0 ~= nil and MOAIInputMgr.device.touch:isDown(idx0) then
			x0, y0 = MOAIInputMgr.device.touch:getTouch(idx0)
		end
		if idx1 ~= nil and MOAIInputMgr.device.touch:isDown(idx1) then
			x1, y1 = MOAIInputMgr.device.touch:getTouch(idx1)
		end
	end
		
	--drag the screen
	if screens.starMapScreen.dragging then
		local cameraX, cameraY, wndPointerX, wndPointerY, currX, currY
		cameraX, cameraY = screens.starMapScreen.layers.mapLayer:wndToWorld(screens.starMapScreen.starMapCamera:getLoc())
		wndPointerX, wndPointerY = screens.starMapScreen.layers.mapLayer:wndToWorld(screens.starMapScreen.pointer0X, screens.starMapScreen.pointer0Y)
		currX, currY = screens.starMapScreen.layers.mapLayer:wndToWorld(x0, y0)
		cameraX = cameraX + ((wndPointerX - currX) * screens.starMapScreen.scale)
		cameraY = cameraY - ((wndPointerY - currY) * screens.starMapScreen.scale)
		screens.starMapScreen.starMapFitter:setFitLoc(screens.starMapScreen.layers.mapLayer:worldToWnd(cameraX, cameraY))
		screens.starMapScreen.starsFitter:setFitLoc(screens.starMapScreen.layers.mapLayer:worldToWnd(cameraX, cameraY))
	end

	--scale the screen
	if screens.starMapScreen.pinching then
		local oldDistance, newDistance
		oldDistance = util.distanceBetweenPoints(screens.starMapScreen.pointer0X, screens.starMapScreen.pointer0Y, screens.starMapScreen.pointer1X, screens.starMapScreen.pointer1Y)
		newDistance = util.distanceBetweenPoints(x0, y0, x1, y1)
		
		if newDistance - oldDistance < 0 then
			if screens.starMapScreen.scale < 5 then
				screens.starMapScreen.scale = screens.starMapScreen.scale + .05
			else
				screens.starMapScreen.scale = 5
			end
		else
			if screens.starMapScreen.scale > 1 then
				screens.starMapScreen.scale = screens.starMapScreen.scale - .05
			else
				screens.starMapScreen.scale = 1
			end
		end
		screens.starMapScreen.starMapFitter:setFitScale(screens.starMapScreen.scale)
	end

	--update pointer values
	if MOAIInputMgr.device.touch == nil then
		screens.starMapScreen.pointer0X, screens.starMapScreen.pointer0Y = x, y
	else
		if idx0 ~= nil and MOAIInputMgr.device.touch:isDown(idx0) then
			screens.starMapScreen.pointer0X, screens.starMapScreen.pointer0Y = x0, y0
		end
		if idx1 ~= nil and MOAIInputMgr.device.touch:isDown(idx1) then
			screens.starMapScreen.pointer1X, screens.starMapScreen.pointer1Y = x1, y1
		end
	end
	screens.starMapScreen.buttonList:pointer(screens.starMapScreen.layers.bannerLayer:wndToWorld(screens.starMapScreen.pointer0X, screens.starMapScreen.pointer0Y))
	screens.starMapScreen.clickablePropList:pointer(screens.starMapScreen.layers.mapLayer:wndToWorld(screens.starMapScreen.pointer0X, screens.starMapScreen.pointer0Y))

	if windowsBuild then
		screens.starMapScreen.props.crossProp:setVisible(false)
		xbox.mouseMoved(screens.starMapScreen.pointerX, x, screens.starMapScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.starMapScreen.clickCallback(down)
	if gameState.traveling then
		return
	end

	local worldX
	local worldY
	worldX, worldY = screens.starMapScreen.layers.bannerLayer:wndToWorld(screens.starMapScreen.pointer0X, screens.starMapScreen.pointer0Y)
	local buttonName = screens.starMapScreen.buttonList:click(worldX, worldY, down)
	if buttonName == "options" then
		frontController.dispatch(frontController.OPTIONS_SCREEN)
		return
	end

	--dragging/pinching
	if MOAIInputMgr.device.touch == nil then
		screens.starMapScreen.dragging = down
	else
		local idx0, idx1
		idx0, idx1 = MOAIInputMgr.device.touch:getActiveTouches()
		if idx0 ~= nil and MOAIInputMgr.device.touch:down(idx0) then
			screens.starMapScreen.pointer0X, screens.starMapScreen.pointer0Y = MOAIInputMgr.device.touch:getTouch(idx0)
			screens.starMapScreen.dragging = true
			screens.starMapScreen.pinching = false
		end
		if idx0 == nil or MOAIInputMgr.device.touch:up(idx0) then
			screens.starMapScreen.dragging = false
			screens.starMapScreen.pinching = false
		end
		if idx1 == nil or MOAIInputMgr.device.touch:up(idx1) then
			screens.starMapScreen.pinching = false
		end
		if idx1 ~= nil and MOAIInputMgr.device.touch:down(idx1) then
			screens.starMapScreen.pinching = true
			screens.starMapScreen.dragging = false
		end
	end
	
	worldX, worldY = screens.starMapScreen.layers.mapLayer:wndToWorld(screens.starMapScreen.pointer0X, screens.starMapScreen.pointer0Y)
	local clickablePropName = screens.starMapScreen.clickablePropList:click(worldX, worldY, down)
	if clickablePropName ~= nil then
		gameState.destination = clickablePropName
		screens.starMapScreen.moveShip()
	end

end


--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.starMapScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if gameState.traveling then
		return
	end

	screens.starMapScreen.props.crossProp:setVisible(true)
	if thumbLX ~= 0 or thumbLY ~= 0 then
		local r, angle = util.cartesianToPolar(thumbLX, thumbLY)
		if r < 30000 then
			screens.starMapScreen.crossMoveX, screens.starMapScreen.crossMoveY = util.polarToCartesian(2, angle)
		else
			screens.starMapScreen.crossMoveX, screens.starMapScreen.crossMoveY = util.polarToCartesian(10, angle)
		end
	else
		screens.starMapScreen.crossMoveX, screens.starMapScreen.crossMoveY = 0, 0
	end

	if thumbRX ~= 0 or thumbRY ~= 0 then
		local r, angle = util.cartesianToPolar(thumbRX, thumbRY)
		screens.starMapScreen.mapMoveX, screens.starMapScreen.mapMoveY = util.polarToCartesian(20, angle)
	else
		screens.starMapScreen.mapMoveX, screens.starMapScreen.mapMoveY = 0, 0
	end
	
	if leftTrigger > 0 and rightTrigger == 0 then
		screens.starMapScreen.zoomMove = -0.2
	elseif rightTrigger > 0 and leftTrigger == 0 then
		screens.starMapScreen.zoomMove = 0.2
	else
		screens.starMapScreen.zoomMove = 0
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local crossX, crossY = screens.starMapScreen.layers.mapLayer:wndToWorld(screens.starMapScreen.layers.bannerLayer:worldToWnd(screens.starMapScreen.props.crossProp:getLoc()))
		for i=1,screens.starMapScreen.clickablePropList.length do
			local system = screens.starMapScreen.clickablePropList[i]
			if system.prop:inside(crossX, crossY) then
				gameState.destination = system.name
				screens.starMapScreen.moveShip()
			end
		end
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.START, buttons) then
		frontController.dispatch(frontController.OPTIONS_SCREEN)
		return
	end
	
end

function screens.starMapScreen.keyboardCallback(key, down)
	if gameState.traveling then
		return
	end

	if down then
		local zoomOut = string.byte("-")
		local zoomIn = string.byte("=")
		if key == zoomOut or key == zoomIn then
			if key == zoomOut then
				if screens.starMapScreen.scale < 5 then
					screens.starMapScreen.scale = screens.starMapScreen.scale + .5
				else
					screens.starMapScreen.scale = 5
				end
			else
				if screens.starMapScreen.scale > 1 then
					screens.starMapScreen.scale = screens.starMapScreen.scale - .5
				else
					screens.starMapScreen.scale = 1
				end
			end
			screens.starMapScreen.starMapFitter:setFitScale(screens.starMapScreen.scale)
		end
	end
end