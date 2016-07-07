--####################################
-- antHiveTurret.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the ant hive's turret.
--####################################

--namespace ships

function ships.antHiveTurret1(baseShip)
	baseShip.functionName = "antHiveTurret1"
	
	--build the possible positions on the ship (5x5 matrix)
	ships.antTurretMatrix = util.getArrayList()
	local startPos = -1600
	for i=1,5 do
		ships.antTurretMatrix:add(util.getArrayList())
		for j=1,5 do
			ships.antTurretMatrix[i]:add({})
			ships.antTurretMatrix[i][j].used = false
			ships.antTurretMatrix[i][j].x = startPos + 800 * (i - 1) 
			ships.antTurretMatrix[i][j].y = startPos + 800 * (j - 1) 
		end
	end
	
	return ships.antHiveTurret(baseShip)
end

function ships.antHiveTurret2(baseShip)
	baseShip.functionName = "antHiveTurret2"
	return ships.antHiveTurret(baseShip)
end

function ships.antHiveTurret3(baseShip)
	baseShip.functionName = "antHiveTurret3"
	return ships.antHiveTurret(baseShip)
end

function ships.antHiveTurret4(baseShip)
	baseShip.functionName = "antHiveTurret4"
	return ships.antHiveTurret(baseShip)
end

function ships.antHiveTurret5(baseShip)
	baseShip.functionName = "antHiveTurret5"
	return ships.antHiveTurret(baseShip)
end

function ships.antHiveTurret6(baseShip)
	baseShip.functionName = "antHiveTurret6"
	return ships.antHiveTurret(baseShip)
end

function ships.antHiveTurret7(baseShip)
	baseShip.functionName = "antHiveTurret7"
	return ships.antHiveTurret(baseShip)
end

function ships.antHiveTurret8(baseShip)
	baseShip.functionName = "antHiveTurret8"
	return ships.antHiveTurret(baseShip)
end

function ships.antHiveTurret9(baseShip)
	baseShip.functionName = "antHiveTurret9"
	return ships.antHiveTurret(baseShip)
end

function ships.antHiveTurret10(baseShip)
	baseShip.functionName = "antHiveTurret10"
	return ships.antHiveTurret(baseShip)
end


function ships.antHiveTurret(baseShip)
	baseShip.width = ships.ANT_HIVE_TURRET_WIDTH
	baseShip.height = ships.ANT_HIVE_TURRET_HEIGHT
	baseShip.prop, baseShip.shieldHitProp = ships.getShipProp(baseShip.functionName)
	baseShip.shockwaveProp, baseShip.shockwaveMaxScale = ships.getShockwaveProp(baseShip.functionName)
	baseShip.explodeProp, baseShip.explodeAnim, baseShip.shakeMagnitude, baseShip.shakeDuration = ships.getExplodeProp(baseShip.functionName)
	baseShip.shieldHitProp:setVisible(false)
	baseShip.startingRadiusMin = 2000
	baseShip.startingRadiusMax = 3000
	baseShip.hasIcon = false
	baseShip.hasExhaust = false
	baseShip.isChild = true

	--find the turret position
	while true do
		local posX, posY = math.random(1, 5), math.random(1, 5)
		local isUsed = ships.antTurretMatrix[posX][posY].used
		if not isUsed then
			baseShip.xOffset, baseShip.yOffset = ships.antTurretMatrix[posX][posY].x, ships.antTurretMatrix[posX][posY].y
			ships.antTurretMatrix[posX][posY].used = true
			break
		end
	end

	-- use a random value so that ships don't clump together	
	--move speed
	baseShip.forwardSpeed = 0
	baseShip.strafeSpeed = 0
	--rotate speed
	baseShip.rotateSpeed = .4
	
	--hit points
	baseShip.totalHitPoints = 100
	baseShip.currentHitPoints = baseShip.totalHitPoints 
	baseShip.totalShieldPoints = 10
	baseShip.shieldDamageReduction = 0
	baseShip.shieldRegen = 0
	baseShip.currentShieldPoints = 0
	
	baseShip.defense = 20
	baseShip.attackModifier = 60
	
	--------------------------------------------------------------------------
	-- ai script for the ship
	--
	-- available information
	-- self.distanceToPcShip
	-- self.numberOfEnemies
	-- self.distanceToNearestEnemy
	-- self.distanceToRightBoundary
	-- self.distanceToLeftBoundary
	-- self.distanceToTopBoundary
	-- self.distanceToBottomBoundary
	-- self.angleToPcShip
	-- self.angleRelativeToPcShip
	--------------------------------------------------------------------------
	function baseShip:ai()
		self:setPositionWithOffset()
		self:setRot(self.parent:getRot())
	end


	--------------------------------------------------------------------------
	-- attack
	--------------------------------------------------------------------------
	function baseShip:attack(currentTime)
		local moveSpeed = 2000
		local dpsMin, dpsMax = 5, 10
		local rateOfFire = 1.5
		local range = 4000
		local arcStart, arcEnd = 0, 359

		--base the damage on the dps numbers
		local damageMin, damageMax = rateOfFire * dpsMin, rateOfFire * dpsMax

		baseShip:standardAttack(
			currentTime, --currentTime,
			rateOfFire, --rateOfFire,
			range, --range,
			arcStart, --arcStart,
			arcEnd, --arcEnd,
			"llaxonFighter", --attackSound,
			battle.currentBattle.pcShip, --attackTarget,
			ships.ANT_VENOM, --weapon,
			damageMin, --damageMin,
			damageMax, --damageMax,
			moveSpeed --moveSpeed
		)
	end

	--------------------------------------------------------------------------
	-- setPositionWithOffset
	--------------------------------------------------------------------------
	function baseShip:setPositionWithOffset()
		local offsetR, offsetAngle = util.cartesianToPolar(self.xOffset, self.yOffset)
		local rotatedXOffset, rotatedYOffset = util.polarToCartesian(offsetR, offsetAngle + self.parent:getRot())
		local parentX, parentY = self.parent:getLoc()
		self:setLoc(parentX + rotatedXOffset, parentY + rotatedYOffset)
	end
	
	--------------------------------------------------------------------------
	-- setStartingPosition
	--------------------------------------------------------------------------
	function baseShip:setStartingPosition()
		self:setPositionWithOffset()
		self:setRot(self.parent:getRot())
	end

	return baseShip
end



