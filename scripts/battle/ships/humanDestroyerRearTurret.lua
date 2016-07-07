--####################################
-- humanDestroyerRearTurret.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the human Destroyer's rear turrets.
--####################################

--namespace ships

function ships.humanDestroyerRearTurretL(baseShip)
	baseShip.functionName = "humanDestroyerRearTurretL"
	baseShip.xOffset = -600
	baseShip.yOffset = -900
	
	return ships.humanDestroyerRearTurret(baseShip)
end

function ships.humanDestroyerRearTurretR(baseShip)
	baseShip.functionName = "humanDestroyerRearTurretR"
	baseShip.xOffset = 600
	baseShip.yOffset = -900
	
	return ships.humanDestroyerRearTurret(baseShip)
end


function ships.humanDestroyerRearTurret(baseShip)
	baseShip.width = ships.HUMAN_DESTROYER_FRONT_TURRET_WIDTH
	baseShip.height = ships.HUMAN_DESTROYER_FRONT_TURRET_HEIGHT
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
	baseShip.rotateSpeed = .3
	
	--hit points
	baseShip.totalHitPoints = 600
	baseShip.currentHitPoints = baseShip.totalHitPoints 
	baseShip.totalShieldPoints = 300
	baseShip.shieldDamageReduction = 200
	baseShip.shieldRegen = 300
	baseShip.currentShieldPoints = baseShip.totalShieldPoints
	
	baseShip.defense = 40
	baseShip.attackModifier = 100
	
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
		local moveSpeed = 600
		local dpsMin, dpsMax = 100, 200
		local rateOfFire = 3
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
			"plasma", --attackSound,
			battle.currentBattle.pcShip, --attackTarget,
			ships.HUMAN_DESTROYER_REAR, --weapon,
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



