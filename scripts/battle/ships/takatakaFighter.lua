--####################################
-- takatakaFighter.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the takataka fighter.
--####################################

--namespace ships


function ships.takatakaFighter(baseShip)
	baseShip.width = ships.TAKATAKA_FIGHTER_WIDTH
	baseShip.height = ships.TAKATAKA_FIGHTER_HEIGHT
	baseShip.functionName = "takatakaFighter"
	baseShip.prop, baseShip.shieldHitProp = ships.getShipProp(baseShip.functionName)
	baseShip.shockwaveProp, baseShip.shockwaveMaxScale = ships.getShockwaveProp(baseShip.functionName)
	baseShip.explodeProp, baseShip.explodeAnim, baseShip.shakeMagnitude, baseShip.shakeDuration = ships.getExplodeProp(baseShip.functionName)
	baseShip.shieldHitProp:setVisible(false)
	baseShip.startingRadiusMin = 2000
	baseShip.startingRadiusMax = 3000

	-- use a random value so that ships don't clump together	
	--move speed
	baseShip.forwardSpeed = 600 + math.random(-100, 100)
	baseShip.strafeSpeed = 600 + math.random(-100, 100)
	--rotate speed
	baseShip.rotateSpeed = 2
	
	--hit points
	baseShip.totalHitPoints = 100
	baseShip.currentHitPoints = baseShip.totalHitPoints 
	baseShip.totalShieldPoints = 200
	baseShip.shieldDamageReduction = 200
	baseShip.shieldRegen = 200
	baseShip.currentShieldPoints = baseShip.totalShieldPoints
	
	baseShip.defense = 50
	baseShip.attackModifier = 30
	
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
		local backOffDistance = 200
		--catchup to the pc ship if we get too far away
		if self.distanceToPcShip > catchUpDistance then
			self.strafe = false
			self.moveAngle = self.angleToPcShip
			if self.rotateAngle == nil or not util.fuzzyCompare(self.rotateAngle, self.angleToPcShip, forwardAngleTolerance) then
				self.rotateAngle = self.angleToPcShip
			end
		elseif self.distanceToPcShip < backOffDistance then
			self.strafe = false
			self.moveAngle = util.normalizeAngle(self.angleToPcShip - 180)
			self.rotateAngle = self.angleToPcShip
		else
			if not self.strafe then
				--pick strafe direction randomly
				if math.random(1, 2) == 1 then
					self.moveAngle = util.normalizeAngle(self.angleToPcShip - 90)
				else
					self.moveAngle = util.normalizeAngle(self.angleToPcShip + 90)
				end
				self.strafe = true
			end
			self.rotateAngle = self.angleToPcShip
		end
	end


	--------------------------------------------------------------------------
	-- attack
	--------------------------------------------------------------------------
	function baseShip:attack(currentTime)
		local moveSpeed = 1000
		local dpsMin, dpsMax = 50, 100
		local rateOfFire = .5
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
			"llaxonFighter", --attackSound,
			battle.currentBattle.pcShip, --attackTarget,
			ships.TAKATAKA_FIGHTER, --weapon,
			damageMin, --damageMin,
			damageMax, --damageMax,
			moveSpeed --moveSpeed
		)
	end

	return baseShip
end



