--####################################
-- pirateMissleFighter.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the pirate Missle fighter.
--####################################

--namespace ships


function ships.pirateMissleFighter(baseShip)
	baseShip.width = ships.PIRATE_MISSLE_FIGHTER_WIDTH
	baseShip.height = ships.PIRATE_MISSLE_FIGHTER_HEIGHT
	baseShip.functionName = "pirateMissleFighter"
	baseShip.prop, baseShip.shieldHitProp = ships.getShipProp(baseShip.functionName)
	baseShip.shockwaveProp, baseShip.shockwaveMaxScale = ships.getShockwaveProp(baseShip.functionName)
	baseShip.explodeProp, baseShip.explodeAnim, baseShip.shakeMagnitude, baseShip.shakeDuration = ships.getExplodeProp(baseShip.functionName)
	baseShip.shieldHitProp:setVisible(false)
	baseShip.startingRadiusMin = 3000
	baseShip.startingRadiusMax = 4000

	-- use a random value so that ships don't clump together	
	--move speed
	baseShip.forwardSpeed = 500 + math.random(-50, 50)
	baseShip.strafeSpeed = 300 + math.random(-50, 50)
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

		local catchUpDistance = 3000
		local backOffDistance = 2000
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
		local moveSpeed = 500
		local rateOfFire = 3
		local dpsMin, dpsMax = 50, 100
		local range = 3000
		local arcStart, arcEnd = 350, 10

		--base the damage on the dps numbers
		local damageMin, damageMax = rateOfFire * dpsMin, rateOfFire * dpsMax

		baseShip:standardAttack(
			currentTime, --currentTime,
			rateOfFire, --rateOfFire,
			range, --range,
			arcStart, --arcStart,
			arcEnd, --arcEnd,
			"missle", --attackSound,
			battle.currentBattle.pcShip, --attackTarget,
			ships.PIRATE_MISSLE_FIGHTER, --weapon,
			damageMin, --damageMin,
			damageMax, --damageMax,
			moveSpeed --moveSpeed
		)
		
	end

	return baseShip
end



