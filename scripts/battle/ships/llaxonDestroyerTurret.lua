--####################################
-- llaxonDestroyerTurret.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the llaxon Destroyer's turret.
--####################################

--namespace ships

function ships.llaxonDestroyerTurretR(baseShip)
	baseShip.functionName = "llaxonDestroyerTurretR"
	baseShip.xOffset = 1000
	baseShip.yOffset = 0
	
	return ships.llaxonDestroyerTurret(baseShip)
end

function ships.llaxonDestroyerTurretL(baseShip)
	baseShip.functionName = "llaxonDestroyerTurretL"
	baseShip.xOffset = -1000
	baseShip.yOffset = 0
	
	return ships.llaxonDestroyerTurret(baseShip)
end

function ships.llaxonDestroyerTurret(baseShip)
	baseShip.width = ships.LLAXON_DESTROYER_TURRET_WIDTH
	baseShip.height = ships.LLAXON_DESTROYER_TURRET_HEIGHT
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
	baseShip.totalHitPoints = 300
	baseShip.currentHitPoints = baseShip.totalHitPoints 
	baseShip.totalShieldPoints = 200
	baseShip.shieldDamageReduction = 200
	baseShip.shieldRegen = 200
	baseShip.currentShieldPoints = baseShip.totalShieldPoints
	
	baseShip.defense = 40
	baseShip.attackModifier = 40
	
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
		local moveSpeed = 1000
		local dpsMin, dpsMax = 70, 90
		local rateOfFire = 1
		local range = 4000
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



