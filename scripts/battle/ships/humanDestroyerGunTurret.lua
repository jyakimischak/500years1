--####################################
-- humanDestroyerGunTurret.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the human Destroyer's gun turrets.
--####################################

--namespace ships

function ships.humanDestroyerGunTurretTl(baseShip)
	baseShip.functionName = "humanDestroyerGunTurretTl"
	baseShip.xOffset = -2500
	baseShip.yOffset = 1300
	
	return ships.humanDestroyerGunTurret(baseShip)
end

function ships.humanDestroyerGunTurretTr(baseShip)
	baseShip.functionName = "humanDestroyerGunTurretTr"
	baseShip.xOffset = 2500
	baseShip.yOffset = 1300
	
	return ships.humanDestroyerGunTurret(baseShip)
end

function ships.humanDestroyerGunTurretMl(baseShip)
	baseShip.functionName = "humanDestroyerGunTurretMl"
	baseShip.xOffset = -1000
	baseShip.yOffset = 600
	
	return ships.humanDestroyerGunTurret(baseShip)
end

function ships.humanDestroyerGunTurretMr(baseShip)
	baseShip.functionName = "humanDestroyerGunTurretMr"
	baseShip.xOffset = 1000
	baseShip.yOffset = 600
	
	return ships.humanDestroyerGunTurret(baseShip)
end

function ships.humanDestroyerGunTurretBl(baseShip)
	baseShip.functionName = "humanDestroyerGunTurretBl"
	baseShip.xOffset = -2200
	baseShip.yOffset = -100
	
	return ships.humanDestroyerGunTurret(baseShip)
end

function ships.humanDestroyerGunTurretBr(baseShip)
	baseShip.functionName = "humanDestroyerGunTurretBr"
	baseShip.xOffset = 2200
	baseShip.yOffset = -100
	
	return ships.humanDestroyerGunTurret(baseShip)
end


function ships.humanDestroyerGunTurret(baseShip)
	baseShip.width = ships.HUMAN_DESTROYER_GUN_TURRET_WIDTH
	baseShip.height = ships.HUMAN_DESTROYER_GUN_TURRET_HEIGHT
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
	baseShip.rotateSpeed = 1
	
	--hit points
	baseShip.totalHitPoints = 400
	baseShip.currentHitPoints = baseShip.totalHitPoints 
	baseShip.totalShieldPoints = 200
	baseShip.shieldDamageReduction = 100
	baseShip.shieldRegen = 200
	baseShip.currentShieldPoints = baseShip.totalShieldPoints
	
	baseShip.defense = 40
	baseShip.attackModifier = 80
	
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
		local rateOfFire = 2
		local range = 10000
		local arcStart, arcEnd = 350, 10

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



