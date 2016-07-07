--####################################
-- llaxonFighter.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the llaxon fighter.
--####################################

--namespace ships


function ships.llaxonFighter(baseShip)
	baseShip.width = ships.LLAXON_FIGHTER_WIDTH
	baseShip.height = ships.LLAXON_FIGHTER_HEIGHT
	baseShip.functionName = "llaxonFighter"
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
	baseShip.rotateSpeed = 3
	
	--hit points
	baseShip.totalHitPoints = 300
	baseShip.currentHitPoints = baseShip.totalHitPoints 
	baseShip.totalShieldPoints = 100
	baseShip.shieldDamageReduction = 100
	baseShip.shieldRegen = 5
	baseShip.currentShieldPoints = baseShip.totalShieldPoints
	
	baseShip.defense = 50
	baseShip.attackModifier = 0
	
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

		--catchup to the pc ship if we get too far away
		local catchUpDistance = 3000
		if self.distanceToPcShip > catchUpDistance then
			self.inSweep = false
			self.moveAngle = self.angleToPcShip
			if self.rotateAngle == nil or not util.fuzzyCompare(self.rotateAngle, self.angleToPcShip, forwardAngleTolerance) then
				self.rotateAngle = self.angleToPcShip
			end
		else
			--start a sweep over the pc ship
			if self.inSweep == nil or not self.inSweep then
				self.inSweep = true
				self.rotateAngle = self.angleToPcShip + math.random(-5, 5)
				self.moveAngle = self.rotateAngle
				self.sweepStartX, self.sweepStartY = self.getLoc()
				self.sweetDistance = 2000 + math.random(-200, 200)
			else
				--do the sweep
				local shipX, shipY = self.getLoc()
				if util.distanceBetweenPoints(shipX, shipY, self.sweepStartX, self.sweepStartY) >= self.sweetDistance then
					self.inSweep = false
				end 
			end 
		end
	end


	--------------------------------------------------------------------------
	-- attack
	--------------------------------------------------------------------------
	function baseShip:attack(currentTime)
		local moveSpeed = 2000
		local rateOfFire = .2
		local dpsMin, dpsMax = 100, 130
		local range = 1000
		local arcStart, arcEnd = 340, 20

		--set damage based on damage per second
		local damageMin, damageMax = rateOfFire * dpsMin, rateOfFire * dpsMax

		baseShip:llaxonAttack(
			currentTime, --currentTime,
			rateOfFire, --rateOfFire,
			range, --range,
			arcStart, --arcStart,
			arcEnd, --arcEnd,
			"llaxonFighter", --attackSound,
			battle.currentBattle.pcShip, --attackTarget,
			ships.LLAXON_FIGHTER, --weapon,
			damageMin, --damageMin,
			damageMax, --damageMax,
			moveSpeed --moveSpeed
		)
		
	end

	--------------------------------------------------------------------------
	-- llaxonAttack
	-- Llaxon do not use the standard attack because they must apply damage for their guns backfiring
	--------------------------------------------------------------------------
	function baseShip:llaxonAttack(currentTime, rateOfFire, range, arcStart, arcEnd, attackSound, attackTarget, weapon, damageMin, damageMax, moveSpeed)
		local attackerX, attackerY = self:getLoc()
		--based on the rate of fire can the weapon shoot again
		if currentTime - self.lastShotTime > rateOfFire then
			local attackTargetX, attackTargetY = attackTarget:getLoc()
			local attackerRot = self:getRot()
			--is the attack target within the arc of fire
			if util.isPointInCone(attackTargetX, attackTargetY, attackerX, attackerY, range, attackerRot, arcStart, arcEnd) then
				--check if there was a backfire at a 2 percent chance
				if math.random(1, 100) <= 2 then
					self.backfire = true
					battle.applyAttackDamage(self.attackModifier, 1000, 1000, self)
					self.backfire = false
				else
					local shot = self:getShot(weapon, range, damageMin, damageMax, moveSpeed, attackTarget)
					shot.prop.prop:setRot(attackerRot)
					--set the location at the front of the ship
					local shotX, shotY
					--convert the normalized vector represented by 1/2 the ships height and it's rotation and convert to a cartessian point
					shotX, shotY = util.polarToCartesian(self.height / 2, attackerRot)
					shotX = shotX + attackerX
					shotY = shotY + attackerY
					shot.prop.prop:setLoc(shotX, shotY)
					--add the lastX, lastY and distance so that we can track how far this has moved
					shot.lastX, shot.lastY = shotX, shotY
					shot.distance = 0
					screens.battleScreen.layers.battleLayer:insertProp(shot.prop.prop)
					audioUtil.playSound(attackSound)
					self.shots:add(shot)
				end
				--update the last shot time
				self.lastShotTime = currentTime
			end
		end
	end

	--------------------------------------------------------------------------
	-- die
	-- Llaxon do not use the standard die method because they must take into account their backfires
	--------------------------------------------------------------------------
	function baseShip:die()
		self.dead = true
		self.prop:setVisible(false)
		self.healthBarProp:setVisible(false)
		self.shieldHitProp:setVisible(false)
		--remove the shots
		local node = self.shots.first
		while node ~= nil do
			node.value.prop.prop:setVisible(false)
			node:remove()
			node.value.prop.anim:stop() 
			screens.battleScreen.layers.battleLayer:removeProp(node.value.prop.prop)
			node.value.prop.anim:stop() 
			node.value.prop.used = false 
			node = node.next
		end
		--show the shockwave
		self:displayShockwave()
		--explode
		self:explode()
		audioUtil.playSound("explode")
		--if this ship was killed due to a backfire and it was not the attack target then leave the reticle alone
		if (self.backfire == nil or not self.backfire) or (self.backfire and self.enemyIndex == battle.currentBattle.attackTarget) then
			battle.targetNextShip(true)
		end
	end

	return baseShip
end



