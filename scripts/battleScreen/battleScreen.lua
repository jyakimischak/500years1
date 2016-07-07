--####################################
-- battleScreen.lua
-- author: Jonas Yakimischak
--
-- This is the battle screen for the game...oh ya!
--####################################

--namespace screens.battleScreen

screens.battleScreen.props = {}
screens.battleScreen.viewports = {}
screens.battleScreen.layers = {}

--------------------------------------------------------------------------
-- battle constants
--------------------------------------------------------------------------


screens.battleScreen.battleFieldWidth = 20480 * 5
screens.battleScreen.battleFieldHeight = 12000 * 5
screens.battleScreen.bgZoomScales = util.getArrayList()

screens.battleScreen.bgZoomScales:add(10 * 5)
screens.battleScreen.bgZoomScales:add(12 * 5)
screens.battleScreen.bgZoomScales:add(14 * 5)
screens.battleScreen.middleZoomScales = util.getArrayList()
screens.battleScreen.middleZoomScales:add(10)
screens.battleScreen.middleZoomScales:add(30)
screens.battleScreen.middleZoomScales:add(50)

screens.battleScreen.dustZoomScales = util.getArrayList()
screens.battleScreen.dustZoomScales:add(2)
screens.battleScreen.dustZoomScales:add(3)
screens.battleScreen.dustZoomScales:add(4)


screens.battleScreen.zoomScales = util.getArrayList()
screens.battleScreen.zoomScales:add(4)
screens.battleScreen.zoomScales:add(7)
screens.battleScreen.zoomScales:add(10)
screens.battleScreen.zoomScale = 1
screens.battleScreen.healthShieldBarLength = 30
screens.battleScreen.battleField = ""
screens.battleScreen.reticleSize = 200
screens.battleScreen.dustTileSize = 500
screens.battleScreen.dustZoom = 4
--the dust rows and columns should be even numbers
screens.battleScreen.numDustColumns = 6
screens.battleScreen.numDustRows = 4



--screens.battleScreen.battleFieldWidth = 204800
--screens.battleScreen.battleFieldHeight = 120000
--screens.battleScreen.bgZoomScales = util.getArrayList()
--
--screens.battleScreen.bgZoomScales:add(100)
--screens.battleScreen.bgZoomScales:add(120)
--screens.battleScreen.bgZoomScales:add(140)
--screens.battleScreen.middleZoomScales = util.getArrayList()
--screens.battleScreen.middleZoomScales:add(10)
--screens.battleScreen.middleZoomScales:add(30)
--screens.battleScreen.middleZoomScales:add(50)
--
--screens.battleScreen.dustZoomScales = util.getArrayList()
--screens.battleScreen.dustZoomScales:add(2)
--screens.battleScreen.dustZoomScales:add(3)
--screens.battleScreen.dustZoomScales:add(4)
--
--
--screens.battleScreen.zoomScales = util.getArrayList()
--screens.battleScreen.zoomScales:add(4)
--screens.battleScreen.zoomScales:add(7)
--screens.battleScreen.zoomScales:add(10)
--screens.battleScreen.zoomScale = 1
--screens.battleScreen.healthShieldBarLength = 30
--screens.battleScreen.battleField = ""
--screens.battleScreen.reticleSize = 200
--screens.battleScreen.dustTileSize = 500
--screens.battleScreen.dustZoom = 4
----the dust rows and columns should be even numbers
--screens.battleScreen.numDustColumns = 6
--screens.battleScreen.numDustRows = 4

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.battleScreen.display()
	glut:setCursor(MOAIGlut.GLUT_CURSOR_CROSSHAIR)

	--setup the viewport
	screens.battleScreen.viewports.viewport = MOAIViewport.new()
	screens.battleScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.battleScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	--setup the background layer
	screens.battleScreen.layers.backgroundLayer = MOAILayer2D.new()
	screens.battleScreen.layers.backgroundLayer:setViewport(screens.battleScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.battleScreen.layers.backgroundLayer)
	screens.battleScreen.backgroundCamera = MOAICamera2D.new()
	screens.battleScreen.layers.backgroundLayer:setCamera(screens.battleScreen.backgroundCamera)
	screens.battleScreen.backgroundFitter = MOAICameraFitter2D.new()
	screens.battleScreen.backgroundFitter:setViewport(screens.battleScreen.viewports.viewport)
	screens.battleScreen.backgroundFitter:setCamera(screens.battleScreen.backgroundCamera)
	screens.battleScreen.backgroundFitter:setBounds(screens.battleScreen.battleFieldWidth / 2 * -1, screens.battleScreen.battleFieldHeight / 2 * -1, screens.battleScreen.battleFieldWidth / 2, screens.battleScreen.battleFieldHeight / 2)
	screens.battleScreen.backgroundFitter:start()
	screens.battleScreen.backgroundFitter:setFitScale(screens.battleScreen.bgZoomScales[screens.battleScreen.zoomScale])

	--setup the middle layer
	screens.battleScreen.layers.middleLayer = MOAILayer2D.new()
	screens.battleScreen.layers.middleLayer:setViewport(screens.battleScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.battleScreen.layers.middleLayer)
	screens.battleScreen.middleCamera = MOAICamera2D.new()
	screens.battleScreen.layers.middleLayer:setCamera(screens.battleScreen.middleCamera)
	screens.battleScreen.middleFitter = MOAICameraFitter2D.new()
	screens.battleScreen.middleFitter:setViewport(screens.battleScreen.viewports.viewport)
	screens.battleScreen.middleFitter:setCamera(screens.battleScreen.middleCamera)
	screens.battleScreen.middleFitter:setBounds(screens.battleScreen.battleFieldWidth / 2 * -1, screens.battleScreen.battleFieldHeight / 2 * -1, screens.battleScreen.battleFieldWidth / 2, screens.battleScreen.battleFieldHeight / 2)
	screens.battleScreen.middleFitter:start()
	screens.battleScreen.middleFitter:setFitScale(screens.battleScreen.middleZoomScales[screens.battleScreen.zoomScale])

	--setup the dust layer
	screens.battleScreen.layers.dustLayer = MOAILayer2D.new()
	screens.battleScreen.layers.dustLayer:setViewport(screens.battleScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.battleScreen.layers.dustLayer)
	screens.battleScreen.dustCamera = MOAICamera2D.new()
	screens.battleScreen.layers.dustLayer:setCamera(screens.battleScreen.dustCamera)
	screens.battleScreen.dustFitter = MOAICameraFitter2D.new()
	screens.battleScreen.dustFitter:setViewport(screens.battleScreen.viewports.viewport)
	screens.battleScreen.dustFitter:setCamera(screens.battleScreen.dustCamera)
	screens.battleScreen.dustFitter:setBounds(screens.battleScreen.battleFieldWidth / 2 * -1, screens.battleScreen.battleFieldHeight / 2 * -1, screens.battleScreen.battleFieldWidth / 2, screens.battleScreen.battleFieldHeight / 2)
	screens.battleScreen.dustFitter:start()
--	screens.battleScreen.dustFitter:setFitScale(screens.battleScreen.dustZoom)
	screens.battleScreen.dustFitter:setFitScale(screens.battleScreen.dustZoomScales[screens.battleScreen.zoomScale])

	--setup the battle layer (where the ships are placed)
	screens.battleScreen.layers.battleLayer = MOAILayer2D.new()
	screens.battleScreen.layers.battleLayer:setViewport(screens.battleScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.battleScreen.layers.battleLayer)
	screens.battleScreen.battleCamera = MOAICamera2D.new()
	screens.battleScreen.layers.battleLayer:setCamera(screens.battleScreen.battleCamera)
	screens.battleScreen.battleFitter = MOAICameraFitter2D.new()
	screens.battleScreen.battleFitter:setViewport(screens.battleScreen.viewports.viewport)
	screens.battleScreen.battleFitter:setCamera(screens.battleScreen.battleCamera)
	screens.battleScreen.battleFitter:setBounds(screens.battleScreen.battleFieldWidth / 2 * -1, screens.battleScreen.battleFieldHeight / 2 * -1, screens.battleScreen.battleFieldWidth / 2, screens.battleScreen.battleFieldHeight / 2)
	screens.battleScreen.battleFitter:start()
	screens.battleScreen.battleFitter:setFitScale(screens.battleScreen.zoomScales[screens.battleScreen.zoomScale])
	--setup the control layer (where the rotate wheel is placed)
	screens.battleScreen.layers.controlLayer = MOAILayer2D.new()
	screens.battleScreen.layers.controlLayer:setViewport(screens.battleScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.battleScreen.layers.controlLayer)
	
	--draw an array of emitters onto the screen.  These need to be placed before any props to that they are painted correctly
	--these will be used for the enemies...the pc ship will have it's own emitter setup lower
	screens.battleScreen.props.exhaustEmitters = util.getArrayList()
	for i=1, 20 do
		screens.battleScreen.props.exhaustEmitters:add(distanceEmitters.exhaust(screens.battleScreen.layers.battleLayer))
	end
	
	--setup button list
	screens.battleScreen.controlButtonList = screenUtil.getButtonList()

	--draw the background
	local battleFieldDeck, battleFieldNames
	if screens.battleScreen.battleField == "generic1" or
		screens.battleScreen.battleField == "generic2" or
		screens.battleScreen.battleField == "generic3" or
		screens.battleScreen.battleField == "generic4" then
		battleFieldDeck, battleFieldNames = battleFields1GfxQuads, battleFields1Names
	else
		battleFieldDeck, battleFieldNames = battleFields2GfxQuads, battleFields2Names
	end
	battleFieldDeck:setRect(battleFieldNames[screens.battleScreen.battleField..".png"], screens.battleScreen.battleFieldWidth / 2 * -1, screens.battleScreen.battleFieldHeight / 2 * -1, screens.battleScreen.battleFieldWidth / 2, screens.battleScreen.battleFieldHeight / 2)
	screens.battleScreen.props.backgroundProp = MOAIProp2D.new()
	screens.battleScreen.props.backgroundProp:setDeck(battleFieldDeck)
	screens.battleScreen.props.backgroundProp:setIndex(battleFieldNames[screens.battleScreen.battleField..".png"])
	screens.battleScreen.props.backgroundProp:setLoc(0, 0)
	screens.battleScreen.layers.backgroundLayer:insertProp(screens.battleScreen.props.backgroundProp)
	
	--add the dust layer
	screens.battleScreen.setupDustLayer()
	
	--setup the middle layer
	screens.battleScreen.setupMiddleLayer()		

	--draw the wheels onto the control layer
	local wheelSize = 200
	local wheelPointerWidth = 4
	sharedGfxQuads:setRect(sharedNames["wheel.png"], wheelSize / 2 * -1, wheelSize / 2 * -1, wheelSize / 2, wheelSize / 2)
	sharedGfxQuads:setRect(sharedNames["wheelPointer.png"], wheelPointerWidth / 2 * -1, wheelSize / 2 * -1, wheelPointerWidth / 2, wheelSize / 2)
	--rotate control	
	local rotateWheelX = 410
	local rotateWheelY = -100
	screens.battleScreen.props.rotateWheelProp = MOAIProp2D.new()
	screens.battleScreen.props.rotateWheelProp:setDeck(sharedGfxQuads)
	screens.battleScreen.props.rotateWheelProp:setIndex(sharedNames["wheel.png"])
	screens.battleScreen.props.rotateWheelProp:setLoc(rotateWheelX, rotateWheelY)
	screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.rotateWheelProp)
	screens.battleScreen.props.rotatePointerProp = MOAIProp2D.new()
	screens.battleScreen.props.rotatePointerProp:setDeck(sharedGfxQuads)
	screens.battleScreen.props.rotatePointerProp:setIndex(sharedNames["wheelPointer.png"])
	screens.battleScreen.props.rotatePointerProp:setLoc(rotateWheelX, rotateWheelY)
	screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.rotatePointerProp)
	--move control
	local moveWheelX = -410
	local moveWheelY = -100
	screens.battleScreen.props.moveWheelProp = MOAIProp2D.new()
	screens.battleScreen.props.moveWheelProp:setDeck(sharedGfxQuads)
	screens.battleScreen.props.moveWheelProp:setIndex(sharedNames["wheel.png"])
	screens.battleScreen.props.moveWheelProp:setLoc(moveWheelX, moveWheelY)
	screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.moveWheelProp)
	screens.battleScreen.props.movePointerProp = MOAIProp2D.new()
	screens.battleScreen.props.movePointerProp:setDeck(sharedGfxQuads)
	screens.battleScreen.props.movePointerProp:setIndex(sharedNames["wheelPointer.png"])
	screens.battleScreen.props.movePointerProp:setLoc(moveWheelX, moveWheelY)
	screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.movePointerProp)
	--hide the move controls for a windows build
	if windowsBuild then
		screens.battleScreen.props.rotateWheelProp:setVisible(false)
		screens.battleScreen.props.rotatePointerProp:setVisible(false)
		screens.battleScreen.props.moveWheelProp:setVisible(false)
		screens.battleScreen.props.movePointerProp:setVisible(false)
	end
	
	--don't draw the buttons for a windows build
	if not windowsBuild then
		--Arrows (change attack target)
		local arrowWidth = 140
		local arrowHeight = arrowWidth * 235 / 300
		local arrowX, arrowY = 430, 80
		sharedGfxQuads:setRect(sharedNames["arrowRight.png"], arrowWidth / 2 * -1, arrowHeight / 2 * -1, arrowWidth / 2, arrowHeight / 2)
		sharedGfxQuads:setRect(sharedNames["arrowRightPressed.png"], arrowWidth / 2 * -1, arrowHeight / 2 * -1, arrowWidth / 2, arrowHeight / 2)
		sharedGfxQuads:setRect(sharedNames["arrowLeft.png"], arrowWidth / 2 * -1, arrowHeight / 2 * -1, arrowWidth / 2, arrowHeight / 2)
		sharedGfxQuads:setRect(sharedNames["arrowLeftPressed.png"], arrowWidth / 2 * -1, arrowHeight / 2 * -1, arrowWidth / 2, arrowHeight / 2)
		--arrow right
		screens.battleScreen.props.rightArrowProp = MOAIProp2D.new()
		screens.battleScreen.props.rightArrowProp:setDeck(sharedGfxQuads)
		screens.battleScreen.props.rightArrowProp:setIndex(sharedNames["arrowRight.png"])
		screens.battleScreen.props.rightArrowProp:setLoc(arrowX, arrowY)
		screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.rightArrowProp)
		--arrow right pressed
		screens.battleScreen.props.rightArrowPressedProp = MOAIProp2D.new()
		screens.battleScreen.props.rightArrowPressedProp:setDeck(sharedGfxQuads)
		screens.battleScreen.props.rightArrowPressedProp:setIndex(sharedNames["arrowRightPressed.png"])
		screens.battleScreen.props.rightArrowPressedProp:setLoc(arrowX, arrowY)
		screens.battleScreen.props.rightArrowPressedProp:setVisible(false)
		screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.rightArrowPressedProp)
		screens.battleScreen.controlButtonList:addButton("right", screens.battleScreen.props.rightArrowProp, screens.battleScreen.props.rightArrowPressedProp)
		--arrow left
		screens.battleScreen.props.rightArrowProp = MOAIProp2D.new()
		screens.battleScreen.props.rightArrowProp:setDeck(sharedGfxQuads)
		screens.battleScreen.props.rightArrowProp:setIndex(sharedNames["arrowLeft.png"])
		screens.battleScreen.props.rightArrowProp:setLoc(arrowX * -1, arrowY)
		screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.rightArrowProp)
		--arrow left pressed
		screens.battleScreen.props.rightArrowPressedProp = MOAIProp2D.new()
		screens.battleScreen.props.rightArrowPressedProp:setDeck(sharedGfxQuads)
		screens.battleScreen.props.rightArrowPressedProp:setIndex(sharedNames["arrowLeftPressed.png"])
		screens.battleScreen.props.rightArrowPressedProp:setLoc(arrowX * -1, arrowY)
		screens.battleScreen.props.rightArrowPressedProp:setVisible(false)
		screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.rightArrowPressedProp)
		screens.battleScreen.controlButtonList:addButton("left", screens.battleScreen.props.rightArrowProp, screens.battleScreen.props.rightArrowPressedProp)

		--closest target arrow
		local closestWidth = arrowHeight * 235 / 300
		local closestHeight = 140
		local closestX, closestY = 450, 220
		sharedGfxQuads:setRect(sharedNames["closest.png"], closestWidth / 2 * -1, closestHeight / 2 * -1, closestWidth / 2, closestHeight / 2)
		sharedGfxQuads:setRect(sharedNames["closestPressed.png"], closestWidth / 2 * -1, closestHeight / 2 * -1, closestWidth / 2, closestHeight / 2)
		--arrow right
		screens.battleScreen.props.closestProp = MOAIProp2D.new()
		screens.battleScreen.props.closestProp:setDeck(sharedGfxQuads)
		screens.battleScreen.props.closestProp:setIndex(sharedNames["closest.png"])
		screens.battleScreen.props.closestProp:setLoc(closestX, closestY)
		screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.closestProp)
		--arrow right pressed
		screens.battleScreen.props.closestPressedProp = MOAIProp2D.new()
		screens.battleScreen.props.closestPressedProp:setDeck(sharedGfxQuads)
		screens.battleScreen.props.closestPressedProp:setIndex(sharedNames["closestPressed.png"])
		screens.battleScreen.props.closestPressedProp:setLoc(closestX, closestY)
		screens.battleScreen.props.closestPressedProp:setVisible(false)
		screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.closestPressedProp)
		screens.battleScreen.controlButtonList:addButton("closest", screens.battleScreen.props.closestProp, screens.battleScreen.props.closestPressedProp)

		--zoom control
		local zoomSize = 80
		local zoomX, zoomY = -460, 250
		sharedGfxQuads:setRect(sharedNames["zoom.png"], zoomSize / 2 * -1, zoomSize / 2 * -1, zoomSize / 2, zoomSize / 2)
		sharedGfxQuads:setRect(sharedNames["zoomPressed.png"], zoomSize / 2 * -1, zoomSize / 2 * -1, zoomSize / 2, zoomSize / 2)
		--arrow right
		screens.battleScreen.props.zoomProp = MOAIProp2D.new()
		screens.battleScreen.props.zoomProp:setDeck(sharedGfxQuads)
		screens.battleScreen.props.zoomProp:setIndex(sharedNames["zoom.png"])
		screens.battleScreen.props.zoomProp:setLoc(zoomX, zoomY)
		screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.zoomProp)
		--arrow right pressed
		screens.battleScreen.props.zoomPressedProp = MOAIProp2D.new()
		screens.battleScreen.props.zoomPressedProp:setDeck(sharedGfxQuads)
		screens.battleScreen.props.zoomPressedProp:setIndex(sharedNames["zoomPressed.png"])
		screens.battleScreen.props.zoomPressedProp:setLoc(zoomX, zoomY)
		screens.battleScreen.props.zoomPressedProp:setVisible(false)
		screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.zoomPressedProp)
		screens.battleScreen.controlButtonList:addButton("zoom", screens.battleScreen.props.zoomProp, screens.battleScreen.props.zoomPressedProp)
	end
	
	--draw the sheilds/health bar
	local healthBarDeck = MOAIScriptDeck.new()
	healthBarDeck:setRect(-100, -50, 100, 50)
	healthBarDeck:setDrawCallback(screens.battleScreen.drawHealthBar)
	screens.battleScreen.props.healthBarProp = MOAIProp2D.new()
	screens.battleScreen.props.healthBarProp:setDeck(healthBarDeck)
--	screens.battleScreen.props.healthBarProp:setLoc(0, 280)
	screens.battleScreen.props.healthBarProp:setLoc(0, SCREEN_UNITS_Y / 2 - 20)
	screens.battleScreen.layers.controlLayer:insertProp(screens.battleScreen.props.healthBarProp)

	battle.placeEnemies()

	--setup the exhaust emitter for the ship
	local pcShipExhaust = distanceEmitters.exhaust(screens.battleScreen.layers.battleLayer)
	--place your ship on the origin of the battle layer and start up it's animation
	for i=1, 20 do
		shipsGfxQuads:setRect(shipsNames["pcShipForBattle"..i..".png"], ships.PC_SHIP_WIDTH / 2 * -1, ships.PC_SHIP_HEIGHT / 2 * -1, ships.PC_SHIP_WIDTH / 2, ships.PC_SHIP_HEIGHT / 2)
	end
	--add the pc ship
	screens.battleScreen.props.pcShipProp = MOAIProp2D.new()
	screens.battleScreen.props.pcShipProp:setDeck(shipsGfxQuads)
	screens.battleScreen.props.pcShipProp:setLoc(0, 0)
	screens.battleScreen.layers.battleLayer:insertProp(screens.battleScreen.props.pcShipProp)
	screens.battleScreen.props.pcShipCurve = MOAIAnimCurve.new()
	screens.battleScreen.props.pcShipCurve:reserveKeys(20)
	for i=1,20 do
		screens.battleScreen.props.pcShipCurve:setKey(i, 0.07 * (i-1), shipsNames["pcShipForBattle"..i..".png"], MOAIEaseType.FLAT)
	end
	screens.battleScreen.props.pcShipAnim = MOAIAnim:new()
	screens.battleScreen.props.pcShipAnim:reserveLinks(1)
	screens.battleScreen.props.pcShipAnim:setLink(1, screens.battleScreen.props.pcShipCurve, screens.battleScreen.props.pcShipProp, MOAIProp2D.ATTR_INDEX)
	screens.battleScreen.props.pcShipAnim:setMode(MOAITimer.LOOP)
	screens.battleScreen.props.pcShipAnim:start()
	--set the prop into the ship object
	battle.currentBattle.pcShip.prop = screens.battleScreen.props.pcShipProp
	--set the exhaust emitter into the ship object and start it
	battle.currentBattle.pcShip.exhaustEmitter = pcShipExhaust
	battle.currentBattle.pcShip.exhaustEmitter:start()
	--setup the shieldHit for the pc ship
	battle.currentBattle.pcShip.shieldHitProp = ships.getShieldHitProp(ships.PC_SHIP)
	battle.currentBattle.pcShip.shieldHitProp:setLoc(0, 0)
	battle.currentBattle.pcShip.shieldHitProp:setVisible(false)
	screens.battleScreen.layers.battleLayer:insertProp(battle.currentBattle.pcShip.shieldHitProp)
	
	--add the reticle
	sharedGfxQuads:setRect(sharedNames["reticle.png"], screens.battleScreen.reticleSize / 2 * -1, screens.battleScreen.reticleSize / 2 * -1, screens.battleScreen.reticleSize / 2, screens.battleScreen.reticleSize / 2)
	screens.battleScreen.props.reticleProp = MOAIProp2D.new()
	screens.battleScreen.props.reticleProp:setDeck(sharedGfxQuads)
	screens.battleScreen.props.reticleProp:setIndex(sharedNames["reticle.png"])
	screens.battleScreen.layers.battleLayer:insertProp(screens.battleScreen.props.reticleProp)
	
	--add the direction indicator
	local directionIndicatorHeight = 1200
	local directionIndicatorWidth = directionIndicatorHeight * 22 / 1000 
	sharedGfxQuads:setRect(sharedNames["directionIndicator.png"], directionIndicatorWidth / 2 * -1, directionIndicatorHeight / 2 * -1, directionIndicatorWidth / 2, directionIndicatorHeight / 2)
	screens.battleScreen.props.directionIndicatorProp = MOAIProp2D.new()
	screens.battleScreen.props.directionIndicatorProp:setDeck(sharedGfxQuads)
	screens.battleScreen.props.directionIndicatorProp:setIndex(sharedNames["directionIndicator.png"])
	screens.battleScreen.props.directionIndicatorProp:setColor(.5, .5, .5)
	screens.battleScreen.layers.battleLayer:insertProp(screens.battleScreen.props.directionIndicatorProp)

	--start the battle up
	battle.doBattle()
	
	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.battleScreen.windowsPointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.battleScreen.windowsLeftClickCallback)
		MOAIInputMgr.device.mouseRight:setCallback(screens.battleScreen.windowsRightClickCallback)
		MOAIInputMgr.device.keyboard:setCallback(screens.battleScreen.keyboardCallback)
		--xbox controller input
		xbox.setCallback(screens.battleScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.battleScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.battleScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.battleScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.battleScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.battleScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.battleScreen.destroy()
	screens.battleScreen.clickablePropList = nil
	screens.battleScreen.bannerButtonList = nil
	screens.battleScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.battleScreen.props) do
		screens.battleScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.battleScreen.layers) do
		if screens.battleScreen.layers[key] ~= nil then
			screens.battleScreen.layers[key]:clear()
			screens.battleScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.battleScreen.viewports) do
		screens.battleScreen.viewports[key] = nil
	end
end


--------------------------------------------------------------------------
-- drawHealthBar
--------------------------------------------------------------------------
function screens.battleScreen.drawHealthBar(index, xOff, yOff, xFlip, yFlip)
	local barWidth = 200
	local barHeight = 30
	local opacity = .5
	local sideColorR, sideColorG, sideColorB = 111/255, 111/255, 111/255 
	local shieldColorR, shieldColorG, shieldColorB = 0, 0, 1 
	local shieldEmptyColorR, shieldEmptyColorG, shieldEmptyColorB = .1, .1, .3 
	local healthEmptyColorR, healthEmptyColorG, healthEmptyColorB = .3, .1, .1 
	local healthColorR, healthColorG, healthColorB = 1, 0, 0 

	local shieldBarAmount = barWidth * battle.currentBattle.pcShip.currentShieldPoints / battle.currentBattle.pcShip.totalShieldPoints
	if shieldBarAmount < 0 then shieldBarAmount = 0 end
	local healthBarAmount = barWidth * battle.currentBattle.pcShip.currentHitPoints / battle.currentBattle.pcShip.totalHitPoints
	if healthBarAmount < 0 then healthBarAmount = 0 end

	--empty health bar
	MOAIGfxDevice.setPenColor(healthEmptyColorR, healthEmptyColorG, healthEmptyColorB, opacity)
	MOAIDraw.fillRect(barWidth * -1, barHeight / 2 * -1, 0, barHeight / 2)
	--health bar
	MOAIGfxDevice.setPenColor(healthColorR, healthColorG, healthColorB, opacity)
	MOAIDraw.fillRect(barWidth * -1, barHeight / 2 * -1, healthBarAmount - barWidth, barHeight / 2)
	--empty shield bar
	MOAIGfxDevice.setPenColor(shieldEmptyColorR, shieldEmptyColorG, shieldEmptyColorB, opacity)
	MOAIDraw.fillRect(0, barHeight / 2 * -1, barWidth, barHeight / 2)
	--shield bar
	MOAIGfxDevice.setPenColor(shieldColorR, shieldColorG, shieldColorB, opacity)
	MOAIDraw.fillRect(0, barHeight / 2 * -1, shieldBarAmount, barHeight / 2)
end


--------------------------------------------------------------------------
-- setupDustLayer
--------------------------------------------------------------------------
function screens.battleScreen.setupDustLayer()
	local tileSize = screens.battleScreen.dustTileSize * screens.battleScreen.dustZoom
	screens.battleScreen.props.dust = util.getArrayList()
	local startX = tileSize * screens.battleScreen.numDustColumns / 2 * -1 + (tileSize / 2)
	local startY =  tileSize * screens.battleScreen.numDustRows / 2 * -1 + (tileSize / 2)
	for i=1,screens.battleScreen.numDustColumns do
		for j=1,screens.battleScreen.numDustRows do
			local dustProp = MOAIProp2D.new()
			dustProp:setDeck(starsGfxQuads)
			dustProp:setIndex(starsNames["dust"..math.random(1, 2)..".png"])
			dustProp:setLoc(startX + ((i - 1) * tileSize), startY + ((j - 1) * tileSize))
			dustProp:setScl(screens.battleScreen.dustZoom)
			dustProp:setColor(.6, .6, .6)
			screens.battleScreen.layers.dustLayer:insertProp(dustProp)
			screens.battleScreen.props.dust:add(dustProp)
		end
	end
end

--------------------------------------------------------------------------
-- setupMiddleLayer
--------------------------------------------------------------------------
function screens.battleScreen.setupMiddleLayer()
	local numAsteroids = math.random(30, 60)
--	local numAsteroids = math.random(50, 100)
	local minX = screens.battleScreen.battleFieldWidth / 2 * -1 + 500
	local maxX = screens.battleScreen.battleFieldWidth / 2 - 500
	local minY = screens.battleScreen.battleFieldHeight / 2 * -1 + 500
	local maxY = screens.battleScreen.battleFieldHeight / 2 - 500
	for i=1,numAsteroids do
		screens.battleScreen.props["asteroid"..1] = screens.battleScreen.getAsteroidProp(math.random(1000, 3000))
		screens.battleScreen.props["asteroid"..1]:setLoc(math.random(minX, maxX), math.random(minY, maxY))
		screens.battleScreen.props["asteroid"..1]:setRot(math.random(0, 359))
		local color = math.random(40, 60)
		screens.battleScreen.props["asteroid"..1]:setColor(color/100, color/100, color/100)
		screens.battleScreen.layers.middleLayer:insertProp(screens.battleScreen.props["asteroid"..1])
	end
end

--------------------------------------------------------------------------
-- getAsteroidProp
--------------------------------------------------------------------------
function screens.battleScreen.getAsteroidProp(size)
	local asteroidSize = 100
	--size the asteroids
	if screens.battleScreen.asteroidsSized == nil or not screens.battleScreen.asteroidsSized then
		for i=1,5 do 
			sharedGfxQuads:setRect(sharedNames["asteroid"..i..".png"], asteroidSize / 2 * -1, asteroidSize / 2 * -1, asteroidSize / 2, asteroidSize / 2)
		end
	end
	local asteroidProp = MOAIProp2D.new()
	asteroidProp:setDeck(sharedGfxQuads)
	asteroidProp:setIndex(sharedNames["asteroid"..math.random(1, 5)..".png"])
	asteroidProp:setScl(size / asteroidSize)
	return asteroidProp 
end


