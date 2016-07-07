--####################################
-- humanDestroyer.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the Human Destroyer.
--####################################

--namespace ships


function ships.humanDestroyer(baseShip)
	baseShip.width = ships.HUMAN_DESTROYER_WIDTH
	baseShip.height = ships.HUMAN_DESTROYER_HEIGHT
	baseShip.functionName = "humanDestroyer"
	baseShip.prop, baseShip.shieldHitProp = ships.getShipProp(baseShip.functionName)
	baseShip.shockwaveProp, baseShip.shockwaveMaxScale = ships.getShockwaveProp(baseShip.functionName)
	baseShip.explodeProp, baseShip.explodeAnim, baseShip.shakeMagnitude, baseShip.shakeDuration = ships.getExplodeProp(baseShip.functionName)
	baseShip.shieldHitProp:setVisible(false)
	baseShip.startingRadiusMin = 2000
	baseShip.startingRadiusMax = 3000
	baseShip.hasExhaust = false
	baseShip.isTargettable = false
	baseShip.hasChildren = true


	-- use a random value so that ships don't clump together	
	--move speed
	baseShip.forwardSpeed = 100 + math.random(-50, 50)
	baseShip.strafeSpeed = 100 + math.random(-50, 50)
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
		battle.currentBattle:addEnemy(ships.HUMAN_DESTROYER_FRONT_TURRET, self)
		battle.currentBattle:addEnemy(ships.HUMAN_DESTROYER_REAR_TURRET_L, self)
		battle.currentBattle:addEnemy(ships.HUMAN_DESTROYER_REAR_TURRET_R, self)
		battle.currentBattle:addEnemy(ships.HUMAN_DESTROYER_GUN_TURRET_TL, self)
		battle.currentBattle:addEnemy(ships.HUMAN_DESTROYER_GUN_TURRET_TR, self)
		battle.currentBattle:addEnemy(ships.HUMAN_DESTROYER_GUN_TURRET_ML, self)
		battle.currentBattle:addEnemy(ships.HUMAN_DESTROYER_GUN_TURRET_MR, self)
		battle.currentBattle:addEnemy(ships.HUMAN_DESTROYER_GUN_TURRET_BL, self)
		battle.currentBattle:addEnemy(ships.HUMAN_DESTROYER_GUN_TURRET_BR, self)
	end

	return baseShip
end



