--####################################
-- pcShip.lua
-- author: Jonas Yakimischak
--
-- This contains the ship function for the pc ship
--####################################

--namespace ships

function ships.pcShip(baseShip)
	baseShip.functionName = "pcShip"
	baseShip.width = ships.PC_SHIP_HEIGHT
	baseShip.height = ships.PC_SHIP_WIDTH
	--hit points
	baseShip.totalHitPoints = gameState.shipTotalArmor
	baseShip.currentHitPoints = gameState.shipTotalArmor

	--shield points and regen are based on the shields level
	if gameState.pcShipEquippedShields == model.pcEquipment.shieldsLevel1().functionName then
		baseShip.totalShieldPoints = 400
		baseShip.shieldDamageReduction = 200
		baseShip.shieldRegen = 400
	elseif gameState.pcShipEquippedShields == model.pcEquipment.shieldsLevel2().functionName then
		baseShip.totalShieldPoints = 800
		baseShip.shieldDamageReduction = 400
		baseShip.shieldRegen = 800
	else
		baseShip.totalShieldPoints = 1600
		baseShip.shieldDamageReduction = 800
		baseShip.shieldRegen = 1600
	end
	baseShip.currentShieldPoints = baseShip.totalShieldPoints
		
	--attackModifier and defense is based on computers
	if gameState.pcShipEquippedComputer == model.pcEquipment.computerLevel1().functionName then
		baseShip.attackModifier = 0
		baseShip.defense = 50
	elseif gameState.pcShipEquippedComputer == model.pcEquipment.computerLevel2().functionName then
		baseShip.attackModifier = 30
		baseShip.defense = 70
	else
		baseShip.attackModifier = 60
		baseShip.defense = 90
	end
	
	--speeds are based on engines
	if gameState.pcShipEquippedEngines == model.pcEquipment.enginesLevel1().functionName then
		baseShip.forwardSpeed = 400
		baseShip.strafeSpeed = 200
		baseShip.rotateSpeed = 1
	elseif gameState.pcShipEquippedEngines == model.pcEquipment.enginesLevel2().functionName then
		baseShip.forwardSpeed = 600
		baseShip.strafeSpeed = 400
		baseShip.rotateSpeed = 1.5
	else
		baseShip.forwardSpeed = 800
		baseShip.strafeSpeed = 600
		baseShip.rotateSpeed = 2
	end

	--------------------------------------------------------------------------
	-- attack
	-- based on the weapon the pc ship will have a different attack
	-- based on the computer the pc ship will have a different attack roll modifier
	--------------------------------------------------------------------------
	function baseShip:attack(currentTime)
		local moveSpeed
		local rateOfFire, damageMin, damageMax, range, arcStart, arcEnd
		local attackSound
		--damageMin and damageMax will be based on the damage per second of a weapon
		local dpsMin, dpsMax
		
		if gameState.pcShipEquippedWeapon == "nuclearTorpedoes" then
			moveSpeed = 500
			dpsMin, dpsMax = 100, 200
			dpsMin, dpsMax = dpsMin / 3, dpsMax / 3
			rateOfFire = 5
			range = 3000
			arcStart, arcEnd = 350, 10
			attackSound = "missle"
		elseif gameState.pcShipEquippedWeapon == "laserBeam" then
			moveSpeed = 1000
			dpsMin, dpsMax = 100, 200
			dpsMin, dpsMax = dpsMin / 2, dpsMax / 2
			rateOfFire = 2
			range = 2000
			arcStart, arcEnd = 330, 30
			attackSound = "beam"
		elseif gameState.pcShipEquippedWeapon == "miniGun" then
			moveSpeed = 1000
			dpsMin, dpsMax = 100, 200
			rateOfFire = .2
			range = 1000
			arcStart, arcEnd = 260, 100
			attackSound = "cannon"
		elseif gameState.pcShipEquippedWeapon == "fissionTorpedoes" then
			moveSpeed = 700
			dpsMin, dpsMax = 200, 300
			dpsMin, dpsMax = dpsMin / 3, dpsMax / 3
			rateOfFire = 5
			range = 3000
			arcStart, arcEnd = 350, 10
			attackSound = "missle"
		elseif gameState.pcShipEquippedWeapon == "ionBeam" then
			moveSpeed = 1000
			dpsMin, dpsMax = 200, 300
			dpsMin, dpsMax = dpsMin / 2, dpsMax / 2
			rateOfFire = 2
			range = 2000
			arcStart, arcEnd = 330, 30
			attackSound = "beam"
		elseif gameState.pcShipEquippedWeapon == "massDriver" then
			moveSpeed = 1000
			dpsMin, dpsMax = 200, 300
			rateOfFire = .2
			range = 1000
			arcStart, arcEnd = 300, 60
			attackSound = "cannon"
		elseif gameState.pcShipEquippedWeapon == "antiMatterTorpedoes" then
			moveSpeed = 900
			dpsMin, dpsMax = 300, 400
			dpsMin, dpsMax = dpsMin / 3, dpsMax / 3
			rateOfFire = 5
			range = 3000
			arcStart, arcEnd = 350, 10
			attackSound = "missle"
		elseif gameState.pcShipEquippedWeapon == "plasmaCannon" then
			moveSpeed = 1000
			dpsMin, dpsMax = 300, 400
			dpsMin, dpsMax = dpsMin / 2, dpsMax / 2
			rateOfFire = 2
			range = 2000
			arcStart, arcEnd = 330, 30
			attackSound = "plasma"
		elseif gameState.pcShipEquippedWeapon == "coilGun" then
			moveSpeed = 1000
			dpsMin, dpsMax = 300, 400
			rateOfFire = .2
			range = 1000
			arcStart, arcEnd = 300, 60
			attackSound = "cannon"
		end
		
		--set damage based on damage per second
		damageMin, damageMax = rateOfFire * dpsMin, rateOfFire * dpsMax
		
		baseShip:standardAttack(
			currentTime, --currentTime,
			rateOfFire, --rateOfFire,
			range, --range,
			arcStart, --arcStart,
			arcEnd, --arcEnd,
			attackSound, --attackSound,
			battle.currentBattle.enemies[battle.currentBattle.attackTarget], --attackTarget,
			gameState.pcShipEquippedWeapon, --weapon,
			damageMin, --damageMin,
			damageMax, --damageMax,
			moveSpeed --moveSpeed
		)

	end

	--------------------------------------------------------------------------
	-- die
	-- When the pc ship dies nothing happens
	--------------------------------------------------------------------------
	function baseShip:die()
	end

	return baseShip
end

