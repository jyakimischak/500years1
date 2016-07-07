--####################################
-- pirateDestroyer.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the pirate Destroyer.
--####################################

--namespace ships


function ships.pirateDestroyer(baseShip)
	baseShip.width = ships.PIRATE_DESTROYER_WIDTH
	baseShip.height = ships.PIRATE_DESTROYER_HEIGHT
	baseShip.functionName = "pirateDestroyer"
	baseShip.prop, baseShip.shieldHitProp = ships.getShipProp(baseShip.functionName)
	baseShip.shockwaveProp, baseShip.shockwaveMaxScale = ships.getShockwaveProp(baseShip.functionName)
	baseShip.explodeProp, baseShip.explodeAnim, baseShip.shakeMagnitude, baseShip.shakeDuration = ships.getExplodeProp(baseShip.functionName)
	baseShip.shieldHitProp:setVisible(false)
	baseShip.startingRadiusMin = 10000
	baseShip.startingRadiusMax = 11000
	baseShip.isTargettable = false
	baseShip.hasChildren = true
	baseShip.hasExhaust = false

	-- use a random value so that ships don't clump together	
	--move speed
	baseShip.forwardSpeed = 400
	baseShip.strafeSpeed = 400
	--rotate speed
	baseShip.rotateSpeed = .3
	
	--hit points (cap ships don't have hit points)
	baseShip.totalHitPoints = 1
	baseShip.currentHitPoints = baseShip.totalHitPoints 
	baseShip.totalShieldPoints = 1
	baseShip.shieldDamageReduction = 1
	baseShip.shieldRegen = 1
	baseShip.currentShieldPoints = baseShip.totalShieldPoints
	
	baseShip.defense = 0
	baseShip.attackModifier = 0
	
	--this ship cannot be targeted and has no exhaust emitter
	baseShip.isTargettable = false
	baseShip.hasExhaust = false
	
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

		local catchUpDistance = 8000
		local stopCatchingUpDistance = 2000
		local noTurrets = true
		for i = 1, battle.currentBattle.enemies.length do
			if not battle.currentBattle.enemies[i].dead and battle.currentBattle.enemies[i].isTargettable then
				noTurrets = false
				break
			end
		end
		if noTurrets then
			self.forwardSpeed = 3000
			self.moveAngle = self:getRot()
		elseif self.distanceToPcShip > catchUpDistance then
			self.forwardSpeed = 3000
			self.moveAngle = self.angleToPcShip
			if self.rotateAngle == nil or not util.fuzzyCompare(self.rotateAngle, self.angleToPcShip, forwardAngleTolerance) then
				self.rotateAngle = self.angleToPcShip
			end
		elseif self.distanceToPcShip < stopCatchingUpDistance then
			self.forwardSpeed = 200
		end
	end


	--------------------------------------------------------------------------
	-- attack
	--------------------------------------------------------------------------
	function baseShip:attack(currentTime)
		--cap ships don't attack directly
	end
	
	--------------------------------------------------------------------------
	-- addChildren
	--------------------------------------------------------------------------
	function baseShip:addChildren()
		battle.currentBattle:addEnemy(ships.PIRATE_DESTROYER_TURRET_TR, self)
		battle.currentBattle:addEnemy(ships.PIRATE_DESTROYER_TURRET_TL, self)
		battle.currentBattle:addEnemy(ships.PIRATE_DESTROYER_TURRET_MR, self)
		battle.currentBattle:addEnemy(ships.PIRATE_DESTROYER_TURRET_ML, self)
		battle.currentBattle:addEnemy(ships.PIRATE_DESTROYER_TURRET_BR, self)
		battle.currentBattle:addEnemy(ships.PIRATE_DESTROYER_TURRET_BL, self)
	end
	

	return baseShip
end



