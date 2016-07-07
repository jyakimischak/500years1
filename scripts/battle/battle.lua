--####################################
-- battle.lua
-- author: Jonas Yakimischak
--
-- This contains battle functionality for the game.
--####################################

--namespace battle

--NOTE: the current battle will be stored in battle.currentBattle

--------------------------------------------------------------------------
-- constants
--------------------------------------------------------------------------
battle.GENERIC_BATTLE_FIELD = "generic"
battle.marginOfErrorForForwardAngle = 20
battle.marginOfErrorForAngles = 2

--------------------------------------------------------------------------
-- startABattle
-- the first argument is the battleField to use 
-- the arguments should be the listing of all the enemy ships in the battle 
-- This is a convenience method for running a battle.
-- it will return true for victory, false for defeat. 
--------------------------------------------------------------------------
function battle.startABattle(...)
	-- setup paramaters for a call to startABattleWithArrayList
	local battleField
	local enemies = util.getArrayList()
	for i,v in ipairs({...}) do
		--setup the battle field
		if i == 1 then
			battleField = v
		else
			enemies:add(v)
		end
	end
	return battle.startABattleWithArrayList(battleField, enemies)	
end

--------------------------------------------------------------------------
-- startABattleWithArrayList
-- This just wraps startABattleWithArrayListGuts with a loop to see if we won/lost/retry.
--------------------------------------------------------------------------
function battle.startABattleWithArrayList(battleField, enemies)
	textureUtil.loadTextures(textureUtil.COMBAT)
	--load the enemy textures
	local llaxonLoaded = false
	local llaxonDestroyerLoaded = false
	local pirateLoaded = false
	local pirateDestroyerLoaded = false
	local takatakaLoaded = false
	local antHiveLoaded = false
	local humanDestroyerLoaded = false
	for i=1,enemies.length do
		if enemies[i] == ships.LLAXON_FIGHTER then
			if not llaxonLoaded then
				llaxonLoaded = true
				textureUtil.loadLlaxon()
			end
		elseif enemies[i] == ships.LLAXON_DESTROYER then
			if not llaxonDestroyerLoaded then
				llaxonDestroyerLoaded = true
				textureUtil.loadLlaxonDestroyer()
			end
		elseif enemies[i] == ships.PIRATE_FIGHTER then
			if not pirateLoaded then
				pirateLoaded = true
				textureUtil.loadPirate()
			end
		elseif enemies[i] == ships.PIRATE_MISSLE_FIGHTER then
			if not pirateLoaded then
				pirateLoaded = true
				textureUtil.loadPirate()
			end
		elseif enemies[i] == ships.PIRATE_DESTROYER then
			if not pirateDestroyerLoaded then
				pirateDestroyerLoaded = true
				textureUtil.loadPirateDestroyer()
			end
		elseif enemies[i] == ships.TAKATAKA_FIGHTER then
			if not takatakaLoaded then
				takatakaLoaded = true
				textureUtil.loadTakataka()
			end
		elseif enemies[i] == ships.TAKATAKA_LARGE_FIGHTER then
			if not takatakaLoaded then
				takatakaLoaded = true
				textureUtil.loadTakataka()
			end
		elseif enemies[i] == ships.ANT_HIVE then
			if not antHiveLoaded then
				antHiveLoaded = true
				textureUtil.loadAntHive()
			end
		elseif enemies[i] == ships.HUMAN_DESTROYER then
			if not humanDestroyerLoaded then
				humanDestroyerLoaded = true
				textureUtil.loadHumanDestroyer()
			end
		end
	end 	
	 
	

	battle.battleResolved = false
	battle.skip = false
	battle.attempts = 0
	local battleReturn
	while not battle.battleResolved do
		battle.restartBattleDecisionMade = false
		battleReturn = battle.startABattleWithArrayListGuts(battleField, enemies)
		while not battle.restartBattleDecisionMade do
			coroutine.yield()
		end
		if battle.skip then
			battle.battleResolved = true
			battleReturn = true
		end
	end
	return battleReturn
end

--------------------------------------------------------------------------
-- startABattleWithArrayListGuts
--------------------------------------------------------------------------
function battle.startABattleWithArrayListGuts(battleField, enemies)
	--setup the battle and add the enemy ships
	battle.currentBattle = battle.getBattle()
	battle.currentBattle.battleField = battleField
	if battleField == battle.GENERIC_BATTLE_FIELD then
		screens.battleScreen.battleField = "generic"..(math.random(1, 5))
	end
	battle.currentBattle.initialEnemiesArray = enemies
	for i=1,enemies.length do
		battle.currentBattle:addEnemy(enemies[i])
	end 	
	--change loadout
	battle.currentBattle.doneLoadout = false
	frontController.dispatch(frontController.PREPARE_BATTLE_SCREEN)
	while not battle.currentBattle.doneLoadout do
		coroutine.yield()
	end
	--setup the pcShip
	battle.currentBattle.pcShip = ships.getShip(ships.PC_SHIP)
	--clear the pools
	for i=1,ships.weaponPropPool.length do
		ships.weaponPropPool[i].used = false
	end
--	if battle.hitPoolCreated == nil or not battle.hitPoolCreated then
		battle.hitDamagePool = battle.makeHitDamagePool()
--		battle.hitPoolCreated = true
--	else
--		for i=1,battle.hitDamagePool.length do
--			battle.hitDamagePool[i].used = false
--		end
--	end
	--start the battle
	frontController.dispatch(frontController.BATTLE_SCREEN)
	while not battle.currentBattle.complete do
		coroutine.yield()
	end
	--if the pc ship has no hit points then we lost...show the "you died" cut scene and go to the start screen
	if battle.currentBattle.pcShip.currentHitPoints <= 0 then
		frontController.dispatch(frontController.DEFEAT_SCREEN)
		return false
	else
		frontController.dispatch(frontController.VICTORY_SCREEN)
		while not screens.victoryScreen.complete do
			coroutine.yield()
		end
		battle.battleResolved = true
		battle.restartBattleDecisionMade = true
		return true
	end
end

--------------------------------------------------------------------------
-- restartBattle
-- Restart the current battle
--------------------------------------------------------------------------
function battle.restartBattle()
	--get the current battlefield
	local battleField = battle.currentBattle.battleField
	local enemies = battle.currentBattle.initialEnemiesArray
	battle.startABattleWithArrayList(battleField, enemies)
end

--------------------------------------------------------------------------
-- getBattle
-- This will return a battle object.
--------------------------------------------------------------------------
function battle.getBattle()
	local battle = {}
	battle.enemies = util.getArrayList()
	battle.enemyCounts = {}
	battle.complete = false
	--setup the battle timer
	battle.timer = MOAITimer.new()
	battle.timer:setMode(MOAITimer.CONTINUE)
	battle.timer:start()
	battle.lastLoopTime = 0
	--how long this turn (iteration of the battle loop) has taken
	battle.turnDuration = 0

	--------------------------------------------------------------------------
	-- addEnemy
	-- This will add an emeny ship to the battle.  The enemy should be one of the
	-- ship name constants from the ship namespace.
	--------------------------------------------------------------------------
	function battle:addEnemy(enemy, parent)
		self.enemies:add(ships.getShip(enemy))
		--add the enemy index
		local index = self.enemies.length
		self.enemies[index].enemyIndex = index
		--if this is the first enemy and it is targettable then
		if (self.firstEnemyTargetted == nil or not self.firstEnemyTargetted) and self.enemies[index].isTargettable then
			self.attackTarget = index
			self.firstEnemyTargetted = true
		end
		--update the enemy count
		if self.enemies[index].hasIcon then 
			if self.enemyCounts[enemy] == nil then
				self.enemyCounts[enemy] = 1
			else
				self.enemyCounts[enemy] = self.enemyCounts[enemy] + 1
			end
		end
		--if a parent ship was passed in then set it
		if parent ~= nil then
			self.enemies[index].parent = parent
		end
		if self.enemies[index].hasChildren then
			self.enemies[index]:addChildren()
		end
	end

	return battle
end

--------------------------------------------------------------------------
-- placeEnemies
-- run through the list of enemies and place them on the battlefield
--------------------------------------------------------------------------
function battle.placeEnemies()
	local shipAngle, shipRadius 
	for i=1, battle.currentBattle.enemies.length do
		--set the ships exhaust emitter
		if battle.currentBattle.enemies[i].hasExhaust then
			battle.currentBattle.enemies[i].exhaustEmitter = screens.battleScreen.props.exhaustEmitters[i]
		end
		--if this ship is the child of a larger ship then call the set starting position function, else place in the starting radius
		if battle.currentBattle.enemies[i].isChild then
			battle.currentBattle.enemies[i]:setStartingPosition()
		else
			shipAngle = math.random(0, 359)
			shipRadius = math.random(battle.currentBattle.enemies[i].startingRadiusMin, battle.currentBattle.enemies[i].startingRadiusMax)
			battle.currentBattle.enemies[i]:setLoc(util.polarToCartesian(shipRadius, shipAngle))
			battle.currentBattle.enemies[i]:setRot(math.random(0, 359))
		end
		screens.battleScreen.layers.battleLayer:insertProp(battle.currentBattle.enemies[i].prop)
		--add the health bar prop
		if battle.currentBattle.enemies[i].isTargettable then
			screens.battleScreen.layers.battleLayer:insertProp(battle.currentBattle.enemies[i].healthBarProp)
		end
		--add the shield hit prop
		if battle.currentBattle.enemies[i].isTargettable then
			screens.battleScreen.layers.battleLayer:insertProp(battle.currentBattle.enemies[i].shieldHitProp)
		end
		--add the shockwave prop
		screens.battleScreen.layers.battleLayer:insertProp(battle.currentBattle.enemies[i].shockwaveProp)
		--add the explode animation
		screens.battleScreen.layers.battleLayer:insertProp(battle.currentBattle.enemies[i].explodeProp)
	end
end


--------------------------------------------------------------------------
-- setRotateAngle
--
-- This will handle setting the rotate angle of the ship and rotate wheel
--------------------------------------------------------------------------
function battle.setRotateAngle(x, y)
	local pointX = 0
	local pointY = 0
	
	pointX, pointY = screens.battleScreen.props.rotateWheelProp:getLoc()
	local angle = math.deg(math.atan2(pointY - y, pointX - x)) + 90
	angle = util.normalizeAngle(angle)
	screens.battleScreen.props.rotatePointerProp:setRot(angle)
--	screens.battleScreen.props.pcShipProp:setRot(angle)
	battle.currentBattle.pcShip.rotateAngle = angle
print(angle)
end

--------------------------------------------------------------------------
-- setMoveDirection
--
-- This will handle setting the move direction of the ship and the move wheel
--------------------------------------------------------------------------
function battle.setMoveDirection(x, y)
	local pointX = 0
	local pointY = 0
	
	pointX, pointY = screens.battleScreen.props.moveWheelProp:getLoc()
	local angle = math.deg(math.atan2(pointY - y, pointX - x)) + 90
	angle = util.normalizeAngle(angle)
	screens.battleScreen.props.movePointerProp:setRot(angle)
	battle.currentBattle.pcShip.moveAngle = angle
end


--------------------------------------------------------------------------
-- moveShip
--------------------------------------------------------------------------
function battle.moveShip(ship)
	local shipX, shipY = ship:getLoc()
	
	--if the ship has hit the a boundary of the battle field then we need to bounce it back
	local battleFieldMargin = 300
	if shipX < screens.battleScreen.battleFieldWidth / 2 * -1 + battleFieldMargin then
		ship.moveAngle = util.reflectAngle(ship.moveAngle, "left")
		screens.battleScreen.props.movePointerProp:setRot(ship.moveAngle)
	elseif shipX > screens.battleScreen.battleFieldWidth / 2 - battleFieldMargin then
		ship.moveAngle = util.reflectAngle(ship.moveAngle, "right")
		screens.battleScreen.props.movePointerProp:setRot(ship.moveAngle)
	elseif shipY < screens.battleScreen.battleFieldHeight / 2 * -1 + battleFieldMargin then
		ship.moveAngle = util.reflectAngle(ship.moveAngle, "bottom")
		screens.battleScreen.props.movePointerProp:setRot(ship.moveAngle)
	elseif shipY > screens.battleScreen.battleFieldHeight / 2 - battleFieldMargin then
		ship.moveAngle = util.reflectAngle(ship.moveAngle, "top")
		screens.battleScreen.props.movePointerProp:setRot(ship.moveAngle)
	end
	
	local moveSpeed
	--if the ship is moving forward then use it's forward speed, else use its strafe speed
	if math.abs(ship:getRot() % 360 - ship.moveAngle % 360) <= battle.marginOfErrorForForwardAngle then
		moveSpeed = ship.forwardSpeed
	else
		moveSpeed = ship.strafeSpeed
	end
	local moveDistance = moveSpeed * battle.currentBattle.turnDuration
	--NOTE...NEED TO ADD INERTIA HERE
	ship:setLoc(util.addVector(shipX, shipY, moveDistance, math.rad(ship.moveAngle)))
end

--------------------------------------------------------------------------
-- rotateShip
--------------------------------------------------------------------------
function battle.rotateShip(ship)
	if ship.rotateAngle ~= nil then
		--find the rotate angle based on the rotate speed
		local rotateAngle = math.deg(ship.rotateSpeed) * battle.currentBattle.turnDuration
		ship:setRot(util.addAngle(ship:getRot(), ship.rotateAngle, rotateAngle))
		--if we've reached the end of the turn then stop turning
		if util.angleBetweenTwoNormalVectors(ship:getRot(), ship.rotateAngle) < battle.marginOfErrorForAngles then
			ship.rotateAngle = nil
		end
	end 
end


--------------------------------------------------------------------------
-- applyAttackDamage
-- This will apply the damage for an attack and take care of a ship being destroyed
--------------------------------------------------------------------------
function battle.applyAttackDamage(attackModifier, damageMin, damageMax, attackTarget)
	local enemy = attackTarget
	local startingShieldPoints, startingHitPoints = enemy.currentShieldPoints, enemy.currentHitPoints
	
	if util.rollDice(100, attackModifier) >= enemy.defense then
		--set the time that the attack target was hit at
		attackTarget.lastAttackTime = battle.currentBattle.timer:getTime()
		--hit, now roll damage
		local damage = math.random(damageMin, damageMax)
		--apply the damage
		--calculate how much damage breaks through the shields to the ship as overDr (over damage reduction)
		local overDr = damage - enemy.shieldDamageReduction
		if overDr > 0 then
			--find how much damage remains after damage reduction and apply it first to the shields then to the ship (should the shields be drained)
			damage = damage - overDr
		else
			overDr = 0
		end
		--find how much damage is done to the shields and to the ship
		local shieldDamage
		local shipDamage
		if enemy.currentShieldPoints < damage then
			--the shields cannot absorb all the damage
			shieldDamage = enemy.currentShieldPoints
			shipDamage = damage - shieldDamage + overDr
		else
			shieldDamage = damage
			shipDamage = overDr
		end
		--apply the damage to the enemy
		if enemy.currentShieldPoints < shieldDamage then
			enemy.currentShieldPoints = 0
		else
			enemy.currentShieldPoints = enemy.currentShieldPoints - shieldDamage 
		end
		if enemy.currentHitPoints < shipDamage then
			enemy.currentHitPoints = 0
		else
			enemy.currentHitPoints = enemy.currentHitPoints - shipDamage
		end 
		
		--see if anything blows up
		if enemy.currentHitPoints <= 0 then
			enemy.dead = true
			enemy:die()
--			--check if there are any more enemies
--			local noEnemies = true
--			for i = 1, battle.currentBattle.enemies.length do
--				if not battle.currentBattle.enemies[i].dead then
--					noEnemies = false
--					break
--				end
--			end
--			if noEnemies then
--				battle.currentBattle.complete = true
--			end
		else
			--show damage effects and play sound
			if startingShieldPoints > enemy.currentShieldPoints then
				enemy:displayShieldHit()
				audioUtil.playSound("shieldHit")
			end
			if startingHitPoints > enemy.currentHitPoints then
				battle.showHitDamage(enemy, shipDamage)
				audioUtil.playSound("shieldHit")
			end
		end
	end
end


--------------------------------------------------------------------------
-- makeHitDamagePool
--
-- This will return the hit damage prop pool as an arrayList of prop objects (containing a prop, curve and anim)
--------------------------------------------------------------------------
function battle.makeHitDamagePool()
	battle.hitSize = 30
	for i=1,9 do
		weaponsGfxQuads:setRect(weaponsNames["hit"..i..".png"], battle.hitSize / 2 * -1, battle.hitSize / 2 * -1, battle.hitSize / 2, battle.hitSize / 2)
	end

	local pool = util.getArrayList()
	local numPropsInPool = 30
	for i=1,numPropsInPool do
		local propObj = {}
		propObj.used = false
		propObj.prop = MOAIProp2D.new()
		propObj.curve = MOAIAnimCurve.new()
		propObj.anim = MOAIAnim:new()
	
		--setup the animation curve
		propObj.curve:reserveKeys(9)
		for i=1, 9 do
			propObj.curve:setKey(i, 0.1 * (i-1), weaponsNames["hit"..i..".png"], MOAIEaseType.FLAT)
		end
		propObj.anim:reserveLinks(1)
		propObj.anim:setLink(1, propObj.curve, propObj.prop, MOAIProp2D.ATTR_INDEX)
		propObj.anim:setMode(MOAITimer.CONTINUE)
		propObj.prop:setDeck(weaponsGfxQuads)

		pool:add(propObj)
	end
	return pool
end

--------------------------------------------------------------------------
-- showHitDamage
--------------------------------------------------------------------------
function battle.showHitDamage(attackTarget, damage)
	local hitPropObj = nil
	for i=1,battle.hitDamagePool.length do
		if not battle.hitDamagePool[i].used then
			battle.hitDamagePool[i].used = true
			hitPropObj = battle.hitDamagePool[i]
			break 
		end
	end
	--no prop available, return
	if hitPropObj == nil then
print("****** no hit prop available in pool!")	
		return
	end

	--scale the prop based on the damage
	local minHitSize, maxHitSize, maxDamage = 200, 500, 500
	local scale = 1
	if damage > maxDamage then
		scale = ((maxHitSize - minHitSize) + minHitSize) / battle.hitSize  
	else
		scale = (damage / maxDamage * (maxHitSize - minHitSize) + minHitSize) / battle.hitSize  
	end
	hitPropObj.prop:setScl(scale)

	--the prop should be placed in the center of the ship
	local centerPercent = .5
	local attackTargetWidth, attackTargetHeight = attackTarget.width, attackTarget.height
	local attackTargetX, attackTargetY = attackTarget:getLoc()
	local xRange, yRange = attackTargetWidth * centerPercent / 2, attackTargetHeight * centerPercent / 2
	local xOffset, yOffset = math.random(xRange * -1, xRange), math.random(yRange * -1, yRange) 

	local offsetR, offsetAngle = util.cartesianToPolar(xOffset, yOffset)
	local rotatedXOffset, rotatedYOffset = util.polarToCartesian(offsetR, offsetAngle + attackTarget:getRot())
	hitPropObj.prop:setLoc(attackTargetX + rotatedXOffset, attackTargetY + rotatedYOffset)
	hitPropObj.prop:setVisible(true)
	screens.battleScreen.layers.battleLayer:insertProp(hitPropObj.prop)

	hitPropObj.anim:setSpeed(3)
	hitPropObj.prop:setRot(math.random(0, 359))
	hitPropObj.anim:start()

	local hitThread = MOAICoroutine.new()
	hitThread:run (
		function()
			hitPropObj.anim:start()
			while hitPropObj.anim:getTime() < .8  do
				coroutine.yield()
			end
			hitPropObj.prop:setVisible(false)
			hitPropObj.anim:stop()
			if screens.battleScreen.layers.battleLayer ~= nil then
				screens.battleScreen.layers.battleLayer:removeProp(hitPropObj.prop)
			end
			hitPropObj.used = false
		end
	)
end


--------------------------------------------------------------------------
-- targetNextShip
--
-- This will target the next ship
--------------------------------------------------------------------------
function battle.targetNextShip(forward)
	--if there are no living targettable ships then hide the reticle
	local allDead = true
	for i = 1, battle.currentBattle.enemies.length do
		if not battle.currentBattle.enemies[i].dead and battle.currentBattle.enemies[i].isTargettable then
			allDead = false
		end
	end
	if allDead then
		screens.battleScreen.props.reticleProp:setVisible(false)
	else
		if forward then
			battle.currentBattle.attackTarget = battle.currentBattle.attackTarget + 1
			if battle.currentBattle.attackTarget == battle.currentBattle.enemies.length + 1 then battle.currentBattle.attackTarget = 1 end
			while battle.currentBattle.enemies[battle.currentBattle.attackTarget].dead or not battle.currentBattle.enemies[battle.currentBattle.attackTarget].isTargettable do
				battle.currentBattle.attackTarget = battle.currentBattle.attackTarget + 1
				if battle.currentBattle.attackTarget == battle.currentBattle.enemies.length + 1 then battle.currentBattle.attackTarget = 1 end
			end
		else
			battle.currentBattle.attackTarget = battle.currentBattle.attackTarget - 1
			if battle.currentBattle.attackTarget == 0 then battle.currentBattle.attackTarget = battle.currentBattle.enemies.length end
			while battle.currentBattle.enemies[battle.currentBattle.attackTarget].dead or not battle.currentBattle.enemies[battle.currentBattle.attackTarget].isTargettable do
				battle.currentBattle.attackTarget = battle.currentBattle.attackTarget - 1
				if battle.currentBattle.attackTarget == 0 then battle.currentBattle.attackTarget = battle.currentBattle.enemies.length end
			end  
		end
		--set the last time a new ship was targetted into the battle object 
		battle.currentBattle.targetNextShipTime = battle.currentBattle.timer:getTime()
	end  
end


--------------------------------------------------------------------------
-- targetClosestShip
--
-- This will target the the closest ship
--------------------------------------------------------------------------
function battle.targetClosestShip()
	--if there are no living targettable ships then hide the reticle
	local allDead = true
	for i = 1, battle.currentBattle.enemies.length do
		if not battle.currentBattle.enemies[i].dead and battle.currentBattle.enemies[i].isTargettable then
			allDead = false
		end
	end
	if allDead then
		screens.battleScreen.props.reticleProp:setVisible(false)
	else
		local minDistance = math.huge
		local closestTargetIndex = -1
		local pcShipX, pcShipY = battle.currentBattle.pcShip:getLoc()
		for i=1, battle.currentBattle.enemies.length do
			if not battle.currentBattle.enemies[i].dead and battle.currentBattle.enemies[i].isTargettable then
				local enemyX, enemyY = battle.currentBattle.enemies[i]:getLoc()  
				local distance = util.distanceBetweenPoints(pcShipX, pcShipY, enemyX, enemyY)
				if distance < minDistance then
					minDistance = distance
					closestTargetIndex = i
				end 
			end
		end
		battle.currentBattle.attackTarget = closestTargetIndex
		--set the last time a new ship was targetted into the battle object 
		battle.currentBattle.targetNextShipTime = battle.currentBattle.timer:getTime()
	end  
end

--------------------------------------------------------------------------
-- shakeScreen
--
-- This will shake the screen a few times 
--------------------------------------------------------------------------
function battle.shakeScreen(magnitude, numberShakes)
	local shakeTimer = MOAITimer.new()
	shakeTimer:setMode(MOAITimer.CONTINUE)
	shakeTimer:start()
	local timeBetweenShakes = .02
	local shakeTime
	for i=1, numberShakes do
		shakeTime = shakeTimer:getTime()
		local shakeX = math.random(magnitude * -1, magnitude)
		local shakeY = math.random(magnitude * -1, magnitude)
		local pcShipX, pcShipY = battle.currentBattle.pcShip.getLoc()
		screens.battleScreen.battleFitter:setFitLoc(pcShipX + shakeX, pcShipY + shakeY)
		while shakeTimer:getTime() - shakeTime <= timeBetweenShakes do
			coroutine.yield()
		end
	end
	shakeTimer:stop()
end

--------------------------------------------------------------------------
-- moveReticle
--
-- This will move and scale the reticle on the current attack target 
--------------------------------------------------------------------------
function battle.moveReticle()
	local attackTarget = battle.currentBattle.enemies[battle.currentBattle.attackTarget]
	screens.battleScreen.props.reticleProp:setLoc(attackTarget.prop:getLoc())
	--the reticle should be 1% larger than the ship
	local shipMaxSize = ships.getShipMaxSize(attackTarget.functionName)
	local scale = shipMaxSize * 1.01 / screens.battleScreen.reticleSize
	screens.battleScreen.props.reticleProp:setScl(scale)
end

--------------------------------------------------------------------------
-- pointDirectionIndicator
--
-- This will point the direction indicator at the attack target and hide/show the indicator. 
--------------------------------------------------------------------------
function battle.pointDirectionIndicator()
	--set the angle on the direction indicator
	local pcShipX, pcShipY = battle.currentBattle.pcShip:getLoc()
	local attackTargetX, attackTargetY = battle.currentBattle.enemies[battle.currentBattle.attackTarget]:getLoc()
	local r, angle = util.cartesianToPolar(attackTargetX - pcShipX, attackTargetY - pcShipY)
	screens.battleScreen.props.directionIndicatorProp:setRot(angle)
	
	--if the reticle was moved then we display the direction indicator for a short time
	local currentTime = battle.currentBattle.timer:getTime()
	local displayDuration = .3
	if battle.currentBattle.targetNextShipTime ~= nil and (currentTime - battle.currentBattle.targetNextShipTime) < displayDuration then
		screens.battleScreen.props.directionIndicatorProp:setVisible(true)
	else
		--now show/hide the indicator based on the zoom level
		local displayX, displayY
		if screens.battleScreen.zoomScale == 1 then
			displayX = SCREEN_UNITS_X * 4
			displayY = SCREEN_UNITS_Y * 4
		elseif screens.battleScreen.zoomScale == 2 then
			displayX = SCREEN_UNITS_X * 7
			displayY = SCREEN_UNITS_Y * 7
		else
			displayX = SCREEN_UNITS_X * 10
			displayY = SCREEN_UNITS_Y * 10
		end
		local relativeX, relativeY = attackTargetX - pcShipX,  attackTargetY - pcShipY
		if relativeX > (displayX / 2 * -1) and relativeX < (displayX / 2) and relativeY > (displayY / 2 * -1) and relativeY < (displayY / 2) then
			screens.battleScreen.props.directionIndicatorProp:setVisible(false)
		else
			screens.battleScreen.props.directionIndicatorProp:setVisible(true)
		end
	end 
end

--------------------------------------------------------------------------
-- moveDust
--
-- This will move the dust tiles so that they are always around your ship 
--------------------------------------------------------------------------
function battle.moveDust()
	local shipX, shipY = battle.currentBattle.pcShip.getLoc()
	local maxX = (screens.battleScreen.numDustColumns / 2 * screens.battleScreen.dustTileSize * screens.battleScreen.dustZoom) + shipX + screens.battleScreen.dustTileSize
	local minX = (screens.battleScreen.numDustColumns / 2 * screens.battleScreen.dustTileSize * screens.battleScreen.dustZoom * -1) + shipX - screens.battleScreen.dustTileSize
	local maxY = (screens.battleScreen.numDustRows / 2 * screens.battleScreen.dustTileSize * screens.battleScreen.dustZoom) + shipY + screens.battleScreen.dustTileSize
	local minY = (screens.battleScreen.numDustRows / 2 * screens.battleScreen.dustTileSize * screens.battleScreen.dustZoom * -1) + shipY - screens.battleScreen.dustTileSize
	--cycle the tiles if they go out of bounds
	for i=1,screens.battleScreen.props.dust.length do
		local tileX, tileY = screens.battleScreen.props.dust[i]:getLoc()
		if tileX < minX then
			screens.battleScreen.props.dust[i]:setLoc(tileX + screens.battleScreen.numDustColumns * screens.battleScreen.dustTileSize * screens.battleScreen.dustZoom, tileY)
		end
		if tileX > maxX then
			screens.battleScreen.props.dust[i]:setLoc(tileX - screens.battleScreen.numDustColumns * screens.battleScreen.dustTileSize * screens.battleScreen.dustZoom, tileY)
		end
		if tileY < minY then
			screens.battleScreen.props.dust[i]:setLoc(tileX, tileY + screens.battleScreen.numDustRows * screens.battleScreen.dustTileSize * screens.battleScreen.dustZoom)
		end
		if tileY > maxY then
			screens.battleScreen.props.dust[i]:setLoc(tileX, tileY - screens.battleScreen.numDustRows * screens.battleScreen.dustTileSize * screens.battleScreen.dustZoom)
		end  
	end
end

--------------------------------------------------------------------------
-- doBattle
--
-- This will start up the battle...it has the game loop.
--------------------------------------------------------------------------
function battle.doBattle()
	local battleThread = MOAICoroutine.new()
	battleThread:run (
		function()
			local noEnemies
			audioUtil.playMusic("battle", true, .5)
			local battleCompletePause = 0
			local battleCompletePauseDuration = 3
			local battleIsComplete = false
			while not battleIsComplete or battleCompletePause < battleCompletePauseDuration do
				coroutine.yield()
				
				if battleIsComplete then
					battleCompletePause = battleCompletePause + battle.currentBattle.turnDuration
				end
				
				--get the duration (time delta) for this loop iteration
				local currentTime = battle.currentBattle.timer:getTime()
				battle.currentBattle.turnDuration = currentTime - battle.currentBattle.lastLoopTime 
				
				--handle the pc ship
				battle.moveShip(battle.currentBattle.pcShip)
				battle.rotateShip(battle.currentBattle.pcShip)
				--move the fitters
				local pcShipX, pcShipY = battle.currentBattle.pcShip:getLoc()
				screens.battleScreen.battleFitter:setFitLoc(pcShipX, pcShipY)
				screens.battleScreen.dustFitter:setFitLoc(pcShipX, pcShipY)
				screens.battleScreen.middleFitter:setFitLoc(pcShipX, pcShipY)
				screens.battleScreen.backgroundFitter:setFitLoc(pcShipX, pcShipY)
				--move the dust tiles
				battle.moveDust()
				--attack
				battle.currentBattle.pcShip:attack(currentTime)
				battle.currentBattle.pcShip:resolveAttacks()
				--regenShields
				battle.currentBattle.pcShip:regenShields()
				--fade shields if visible
				battle.currentBattle.pcShip:fadeShieldHit()

				--handle the enemy ships
				local maxDistance = 0
				local enemyDistance = 0
				local enemyX, enemyY
				for i=1, battle.currentBattle.enemies.length do
					if not battle.currentBattle.enemies[i].dead then
						battle.currentBattle.enemies[i]:setAiInformation()
						battle.currentBattle.enemies[i]:ai()
						battle.moveShip(battle.currentBattle.enemies[i])
						battle.rotateShip(battle.currentBattle.enemies[i])
						enemyX, enemyY = battle.currentBattle.enemies[i].prop:getLoc()
						enemyDistance = util.distanceBetweenPoints(pcShipX, pcShipY, enemyX, enemyY)
						if enemyDistance > maxDistance then
							maxDistance = enemyDistance 
						end
						--attack
						battle.currentBattle.enemies[i]:attack(currentTime)
						battle.currentBattle.enemies[i]:resolveAttacks()
						--regen shields
						battle.currentBattle.enemies[i]:regenShields()
						--fade shield hit
						battle.currentBattle.enemies[i]:fadeShieldHit()
					end
				end
				battle.moveReticle()
				battle.pointDirectionIndicator()

				--update the last loop time
				battle.currentBattle.lastLoopTime = battle.currentBattle.timer:getTime()

				--check if there are any more enemies
				local noEnemies = true
				for i = 1, battle.currentBattle.enemies.length do
					if not battle.currentBattle.enemies[i].dead and battle.currentBattle.enemies[i].isTargettable then
						noEnemies = false
						break
					end
				end
				if noEnemies then
					battleIsComplete = true
				end
	
				--check if the pc ship was destroyed
				if battle.currentBattle.pcShip.currentHitPoints <= 0 then
					battleIsComplete = true
					battle.currentBattle.complete = true
					break
				end
			end
			battle.currentBattle.complete = true
		end
	)
end



