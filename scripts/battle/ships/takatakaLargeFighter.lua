--####################################
-- takatakaLargeFighter.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the takataka large fighter.
--####################################

--namespace ships


function ships.takatakaLargeFighter(baseShip)
	baseShip.width = ships.TAKATAKA_LARGE_FIGHTER_WIDTH
	baseShip.height = ships.TAKATAKA_LARGE_FIGHTER_HEIGHT
	baseShip.functionName = "takatakaLargeFighter"
	baseShip.prop, baseShip.shieldHitProp = ships.getShipProp(baseShip.functionName)
	baseShip.shockwaveProp, baseShip.shockwaveMaxScale = ships.getShockwaveProp(baseShip.functionName)
	baseShip.explodeProp, baseShip.explodeAnim, baseShip.shakeMagnitude, baseShip.shakeDuration = ships.getExplodeProp(baseShip.functionName)
	baseShip.shieldHitProp:setVisible(false)
	baseShip.startingRadiusMin = 2000
	baseShip.startingRadiusMax = 3000

	-- use a random value so that ships don't clump together	
	--move speed
	baseShip.forwardSpeed = 500 + math.random(-50, 50)
	baseShip.strafeSpeed = 200 + math.random(-50, 50)
	--rotate speed
	baseShip.rotateSpeed = .4
	
	--hit points
	baseShip.totalHitPoints = 1000
	baseShip.currentHitPoints = baseShip.totalHitPoints 
	baseShip.totalShieldPoints = 500
	baseShip.shieldDamageReduction = 300
	baseShip.shieldRegen = 500
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
		--the degree of tolerance before we course correct our angle 
		local forwardAngleTolerance = 3

		local catchUpDistance = 5000
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
		local moveSpeed = 500
		local dpsMin, dpsMax = 800/10, 1000/10
		local rateOfFire = 10
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
			ships.TAKATAKA_LARGE_FIGHTER, --weapon,
			damageMin, --damageMin,
			damageMax, --damageMax,
			moveSpeed --moveSpeed
		)
	end

	return baseShip
end



