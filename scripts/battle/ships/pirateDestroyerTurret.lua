--####################################
-- pirateDestroyerTurret.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the pirate Destroyer's turret.
--####################################

--namespace ships

function ships.pirateDestroyerTurretTr(baseShip)
	baseShip.functionName = "pirateDestroyerTurretTr"
	baseShip.xOffset = 1400
	baseShip.yOffset = 1300
	
	return ships.pirateDestroyerTurret(baseShip)
end

function ships.pirateDestroyerTurretTl(baseShip)
	baseShip.functionName = "pirateDestroyerTurretTl"
	baseShip.xOffset = -1400
	baseShip.yOffset = 1300
	
	return ships.pirateDestroyerTurret(baseShip)
end

function ships.pirateDestroyerTurretMr(baseShip)
	baseShip.functionName = "pirateDestroyerTurretMr"
	baseShip.xOffset = 1100
	baseShip.yOffset = -600
	
	return ships.pirateDestroyerTurret(baseShip)
end

function ships.pirateDestroyerTurretMl(baseShip)
	baseShip.functionName = "pirateDestroyerTurretMl"
	baseShip.xOffset = -1100
	baseShip.yOffset = -600
	
	return ships.pirateDestroyerTurret(baseShip)
end

function ships.pirateDestroyerTurretBr(baseShip)
	baseShip.functionName = "pirateDestroyerTurretBr"
	baseShip.xOffset = 800
	baseShip.yOffset = -1500
	
	return ships.pirateDestroyerTurret(baseShip)
end

function ships.pirateDestroyerTurretBl(baseShip)
	baseShip.functionName = "pirateDestroyerTurretBl"
	baseShip.xOffset = -800
	baseShip.yOffset = -1500
	
	return ships.pirateDestroyerTurret(baseShip)
end

function ships.pirateDestroyerTurret(baseShip)
	baseShip.width = ships.PIRATE_DESTROYER_TURRET_WIDTH
	baseShip.height = ships.PIRATE_DESTROYER_TURRET_HEIGHT
	baseShip.prop, baseShip.shieldHitProp = ships.getShipProp(baseShip.functionName)
	baseShip.shockwaveProp, baseShip.shockwaveMaxScale = ships.getShockwaveProp(baseShip.functionName)
	baseShip.explodeProp, baseShip.explodeAnim, baseShip.shakeMagnitude, baseShip.shakeDuration = ships.getExplodeProp(baseShip.functionName)
	baseShip.shieldHitProp:setVisible(false)
	baseShip.startingRadiusMin = 2000
	baseShip.startingRadiusMax = 3000
	baseShip.hasIcon = false
	baseShip.hasExhaust = false
	baseShip.isChild = true

	-- use a random value so that ships don't clump together	
	--move speed
	baseShip.forwardSpeed = 0
	baseShip.strafeSpeed = 0
	--rotate speed
	baseShip.rotateSpeed = .4
	
	--hit points
	baseShip.totalHitPoints = 100
	baseShip.currentHitPoints = baseShip.totalHitPoints 
	baseShip.totalShieldPoints = 100
	baseShip.shieldDamageReduction = 100
	baseShip.shieldRegen = 100
	baseShip.currentShieldPoints = baseShip.totalShieldPoints
	
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
		self.rotateAngle = self.angleToPcShip
	end


	--------------------------------------------------------------------------
	-- attack
	--------------------------------------------------------------------------
	function baseShip:attack(currentTime)
		local moveSpeed = 2000
		local dpsMin, dpsMax = 10, 20
		local rateOfFire = .5
		local range = 4000
		local arcStart, arcEnd = 340, 20

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
			ships.PIRATE_DESTROYER, --weapon,
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



