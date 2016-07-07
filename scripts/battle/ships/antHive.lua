--####################################
-- antHive.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the ant hive.
--####################################

--namespace ships


function ships.antHive(baseShip)
	baseShip.width = ships.ANT_HIVE_WIDTH
	baseShip.height = ships.ANT_HIVE_HEIGHT
	baseShip.functionName = "antHive"
	baseShip.prop, baseShip.shieldHitProp = ships.getShipProp(baseShip.functionName)
	baseShip.shockwaveProp, baseShip.shockwaveMaxScale = ships.getShockwaveProp(baseShip.functionName)
	baseShip.explodeProp, baseShip.explodeAnim, baseShip.shakeMagnitude, baseShip.shakeDuration = ships.getExplodeProp(baseShip.functionName)
	baseShip.shieldHitProp:setVisible(false)
	baseShip.startingRadiusMin = 2000
	baseShip.startingRadiusMax = 3000
	baseShip.isTargettable = false
	baseShip.hasChildren = true
	baseShip.hasExhaust = false

	-- use a random value so that ships don't clump together	
	--move speed
	baseShip.forwardSpeed = 100 + math.random(-50, 50)
	baseShip.strafeSpeed = 100 + math.random(-50, 50)
	--rotate speed
	baseShip.rotateSpeed = .03
	
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
		local catchUpDistance = 10000
		local stopCatchingUpDistance = 6000
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
			self.forwardSpeed = 300
			self.strafeSpeed = 300
			self.moveAngle = self.angleToPcShip
		elseif self.distanceToPcShip < stopCatchingUpDistance then
			self.forwardSpeed = 0
			self.strafeSpeed = 0
		end
		
		local rotateAmount = 5 
		self.rotateAngle = self:getRot() + rotateAmount 
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
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_1, self)
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_2, self)
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_3, self)
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_4, self)
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_5, self)
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_6, self)
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_7, self)
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_8, self)
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_9, self)
		battle.currentBattle:addEnemy(ships.ANT_HIVE_TURRET_10, self)
	end

	return baseShip
end



