--####################################
-- pirateFighter.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the pirate fighter.
--####################################

--namespace ships


function ships.pirateFighter(baseShip)
	baseShip.width = ships.PIRATE_FIGHTER_WIDTH
	baseShip.height = ships.PIRATE_FIGHTER_HEIGHT
	baseShip.functionName = "pirateFighter"
	baseShip.prop, baseShip.shieldHitProp = ships.getShipProp(baseShip.functionName)
	baseShip.shockwaveProp, baseShip.shockwaveMaxScale = ships.getShockwaveProp(baseShip.functionName)
	baseShip.explodeProp, baseShip.explodeAnim, baseShip.shakeMagnitude, baseShip.shakeDuration = ships.getExplodeProp(baseShip.functionName)
	baseShip.shieldHitProp:setVisible(false)
	baseShip.startingRadiusMin = 2000
	baseShip.startingRadiusMax = 3000

	-- use a random value so that ships don't clump together	
	--move speed
	baseShip.forwardSpeed = 700 + math.random(-50, 50)
	baseShip.strafeSpeed = 400 + math.random(-50, 50)
	--rotate speed
	baseShip.rotateSpeed = 2
	
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
		--the degree of tolerance before we course correct our angle 
		local forwardAngleTolerance = 3

		local catchUpDistance = 1000
		--catchup to the pc ship if we get too far away
		if self.distanceToPcShip > catchUpDistance then
			self.moveAngle = self.angleToPcShip
			if self.rotateAngle == nil or not util.fuzzyCompare(self.rotateAngle, self.angleToPcShip, forwardAngleTolerance) then
				self.rotateAngle = self.angleToPcShip
			end
		else
			self.rotateAngle = self.angleToPcShip
		end
	end


	--------------------------------------------------------------------------
	-- attack
	--------------------------------------------------------------------------
	function baseShip:attack(currentTime)
		local moveSpeed = 1000
		local dpsMin, dpsMax = 30, 80
		local rateOfFire = .4
		local range = 1000
		local arcStart, arcEnd = 300, 60

		--base the damage on the dps numbers
		local damageMin, damageMax = rateOfFire * dpsMin, rateOfFire * dpsMax

		baseShip:standardAttack(
			currentTime, --currentTime,
			rateOfFire, --rateOfFire,
			range, --range,
			arcStart, --arcStart,
			arcEnd, --arcEnd,
			"cannon", --attackSound,
			battle.currentBattle.pcShip, --attackTarget,
			ships.PIRATE_FIGHTER, --weapon,
			damageMin, --damageMin,
			damageMax, --damageMax,
			moveSpeed --moveSpeed
		)
		
	end

	return baseShip
end



