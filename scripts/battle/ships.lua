--####################################
-- ships.lua
-- author: Jonas Yakimischak
--
-- This contains information for the ships in a battle
--
-- *********************************************
-- NOTE - You must require the ship files at the bottom of this script
-- *********************************************
--####################################

--namespace ships

--------------------------------------------------------------------------
-- ship constants
--------------------------------------------------------------------------
---------- ships
ships.PC_SHIP = "pcShip"
ships.PC_SHIP_HEIGHT = 400
ships.PC_SHIP_WIDTH = ships.PC_SHIP_HEIGHT * 199 / 485

ships.LLAXON_FIGHTER = "llaxonFighter"
ships.LLAXON_FIGHTER_WIDTH = 100
ships.LLAXON_FIGHTER_HEIGHT = ships.LLAXON_FIGHTER_WIDTH * 572 / 304
ships.LLAXON_DESTROYER = "llaxonDestroyer"
ships.LLAXON_DESTROYER_WIDTH = 3000
ships.LLAXON_DESTROYER_HEIGHT = ships.LLAXON_DESTROYER_WIDTH * 500 / 529
ships.LLAXON_DESTROYER_TURRET_R = "llaxonDestroyerTurretR"
ships.LLAXON_DESTROYER_TURRET_L = "llaxonDestroyerTurretL"
ships.LLAXON_DESTROYER_TURRET_WIDTH = 300
ships.LLAXON_DESTROYER_TURRET_HEIGHT = ships.LLAXON_DESTROYER_TURRET_WIDTH * 400 / 179

ships.PIRATE_FIGHTER = "pirateFighter"
ships.PIRATE_FIGHTER_WIDTH = 100
ships.PIRATE_FIGHTER_HEIGHT = ships.PIRATE_FIGHTER_WIDTH * 300 / 141
ships.PIRATE_MISSLE_FIGHTER = "pirateMissleFighter"
ships.PIRATE_MISSLE_FIGHTER_WIDTH = 300
ships.PIRATE_MISSLE_FIGHTER_HEIGHT = ships.PIRATE_MISSLE_FIGHTER_WIDTH * 383 / 295
ships.PIRATE_DESTROYER = "pirateDestroyer"
ships.PIRATE_DESTROYER_WIDTH = 4000
ships.PIRATE_DESTROYER_HEIGHT = ships.PIRATE_DESTROYER_WIDTH * 649 / 400
ships.PIRATE_DESTROYER_TURRET_TR = "pirateDestroyerTurretTr"
ships.PIRATE_DESTROYER_TURRET_TL = "pirateDestroyerTurretTl"
ships.PIRATE_DESTROYER_TURRET_MR = "pirateDestroyerTurretMr"
ships.PIRATE_DESTROYER_TURRET_ML = "pirateDestroyerTurretMl"
ships.PIRATE_DESTROYER_TURRET_BR = "pirateDestroyerTurretBr"
ships.PIRATE_DESTROYER_TURRET_BL = "pirateDestroyerTurretBl"
ships.PIRATE_DESTROYER_TURRET_WIDTH = 500
ships.PIRATE_DESTROYER_TURRET_HEIGHT = ships.PIRATE_DESTROYER_TURRET_WIDTH * 150 / 137

ships.TAKATAKA_FIGHTER = "takatakaFighter"
ships.TAKATAKA_FIGHTER_WIDTH = 400
ships.TAKATAKA_FIGHTER_HEIGHT = ships.TAKATAKA_FIGHTER_WIDTH * 161 / 400
ships.TAKATAKA_LARGE_FIGHTER = "takatakaLargeFighter"
ships.TAKATAKA_LARGE_FIGHTER_WIDTH = 700
ships.TAKATAKA_LARGE_FIGHTER_HEIGHT = ships.TAKATAKA_LARGE_FIGHTER_WIDTH * 230 / 407

ships.ANT_HIVE = "antHive"
ships.ANT_HIVE_WIDTH = 7000
ships.ANT_HIVE_HEIGHT = ships.ANT_HIVE_WIDTH * 500 / 497
ships.ANT_HIVE_TURRET_1 = "antHiveTurret1"
ships.ANT_HIVE_TURRET_2 = "antHiveTurret2"
ships.ANT_HIVE_TURRET_3 = "antHiveTurret3"
ships.ANT_HIVE_TURRET_4 = "antHiveTurret4"
ships.ANT_HIVE_TURRET_5 = "antHiveTurret5"
ships.ANT_HIVE_TURRET_6 = "antHiveTurret6"
ships.ANT_HIVE_TURRET_7 = "antHiveTurret7"
ships.ANT_HIVE_TURRET_8 = "antHiveTurret8"
ships.ANT_HIVE_TURRET_9 = "antHiveTurret9"
ships.ANT_HIVE_TURRET_10 = "antHiveTurret10"
ships.ANT_HIVE_TURRET_WIDTH = 500
ships.ANT_HIVE_TURRET_HEIGHT = ships.ANT_HIVE_TURRET_WIDTH * 200 / 200

ships.HUMAN_DESTROYER = "humanDestroyer"
ships.HUMAN_DESTROYER_WIDTH = 6000
ships.HUMAN_DESTROYER_HEIGHT = ships.HUMAN_DESTROYER_WIDTH * 496 / 650
ships.HUMAN_DESTROYER_FRONT_TURRET = "humanDestroyerFrontTurret"
ships.HUMAN_DESTROYER_FRONT_TURRET_WIDTH = 700
ships.HUMAN_DESTROYER_FRONT_TURRET_HEIGHT = ships.HUMAN_DESTROYER_FRONT_TURRET_WIDTH * 150 / 123
ships.HUMAN_DESTROYER_REAR_TURRET_L = "humanDestroyerRearTurretL"
ships.HUMAN_DESTROYER_REAR_TURRET_R = "humanDestroyerRearTurretR"
ships.HUMAN_DESTROYER_REAR_TURRET_WIDTH = 450
ships.HUMAN_DESTROYER_REAR_TURRET_HEIGHT = ships.HUMAN_DESTROYER_REAR_TURRET_WIDTH * 150 / 123
ships.HUMAN_DESTROYER_GUN_TURRET_TL = "humanDestroyerGunTurretTl"
ships.HUMAN_DESTROYER_GUN_TURRET_TR = "humanDestroyerGunTurretTr"
ships.HUMAN_DESTROYER_GUN_TURRET_ML = "humanDestroyerGunTurretMl"
ships.HUMAN_DESTROYER_GUN_TURRET_MR = "humanDestroyerGunTurretMr"
ships.HUMAN_DESTROYER_GUN_TURRET_BL = "humanDestroyerGunTurretBl"
ships.HUMAN_DESTROYER_GUN_TURRET_BR = "humanDestroyerGunTurretBr"
ships.HUMAN_DESTROYER_GUN_TURRET_WIDTH = 300
ships.HUMAN_DESTROYER_GUN_TURRET_HEIGHT = ships.HUMAN_DESTROYER_GUN_TURRET_WIDTH * 150 / 123



---------- weapons
ships.NUCLEAR_TORPEDOES = "nuclearTorpedoes"
ships.LASER_BEAM = "laserBeam"
ships.MINI_GUN = "miniGun"
ships.FISSION_TORPEDOES = "fissionTorpedoes"
ships.ION_BEAM = "ionBeam"
ships.MASS_DRIVER = "massDriver"
ships.ANTI_MATTER_TORPEDOES = "antiMatterTorpedoes"
ships.PLASMA_CANNON = "plasmaCannon"
ships.COIL_GUN = "coilGun"
ships.LLAXON_FIGHTER = "llaxonFighter"
ships.LLAXON_DESTROYER = "llaxonDestroyer"
ships.TAKATAKA_FIGHTER = "takatakaFighter"
ships.TAKATAKA_LARGE_FIGHTER = "takatakaLargeFighter"
ships.UNGIRI_FIGHTER = "ungiriFighter"
ships.PIRATE_FIGHTER = "pirateFighter"
ships.PIRATE_MISSLE_FIGHTER = "pirateMissleFighter"
ships.PIRATE_DESTROYER = "pirateDestroyer"
ships.ANT_VENOM = "antVenom"
ships.HUMAN_DESTROYER_FRONT = "humanDestroyerFront"
ships.HUMAN_DESTROYER_REAR = "humanDestroyerRear"


--------------------------------------------------------------------------
-- getShipIcon
-- get a ship icon with size (width and height as square)
--------------------------------------------------------------------------
function ships.getShipIcon(ship, size)
	local prop = MOAIProp2D.new()
	
	if ship == ships.LLAXON_FIGHTER then
		llaxonFighterGfxQuads:setRect(llaxonFighterNames["llaxonFighterIcon.png"], size / 2 * -1, size / 2 * -1, size / 2, size / 2)
		prop:setDeck(llaxonFighterGfxQuads)
		prop:setIndex(llaxonFighterNames["llaxonFighterIcon.png"])
	elseif ship == ships.LLAXON_DESTROYER then
		llaxonDestroyerGfxQuads:setRect(llaxonDestroyerNames["llaxonDestroyerIcon.png"], size / 2 * -1, size / 2 * -1, size / 2, size / 2)
		prop:setDeck(llaxonDestroyerGfxQuads)
		prop:setIndex(llaxonDestroyerNames["llaxonDestroyerIcon.png"])

	elseif ship == ships.PIRATE_FIGHTER then
		pirateGfxQuads:setRect(pirateNames["pirateFighterIcon.png"], size / 2 * -1, size / 2 * -1, size / 2, size / 2)
		prop:setDeck(pirateGfxQuads)
		prop:setIndex(pirateNames["pirateFighterIcon.png"])
	elseif ship == ships.PIRATE_MISSLE_FIGHTER then
		pirateGfxQuads:setRect(pirateNames["pirateMissleFighterIcon.png"], size / 2 * -1, size / 2 * -1, size / 2, size / 2)
		prop:setDeck(pirateGfxQuads)
		prop:setIndex(pirateNames["pirateMissleFighterIcon.png"])
	elseif ship == ships.PIRATE_DESTROYER then
		pirateDestroyerGfxQuads:setRect(pirateDestroyerNames["pirateDestroyerIcon.png"], size / 2 * -1, size / 2 * -1, size / 2, size / 2)
		prop:setDeck(pirateDestroyerGfxQuads)
		prop:setIndex(pirateDestroyerNames["pirateDestroyerIcon.png"])

	elseif ship == ships.TAKATAKA_FIGHTER then
		takatakaGfxQuads:setRect(takatakaNames["takatakaFighterIcon.png"], size / 2 * -1, size / 2 * -1, size / 2, size / 2)
		prop:setDeck(takatakaGfxQuads)
		prop:setIndex(takatakaNames["takatakaFighterIcon.png"])
	elseif ship == ships.TAKATAKA_LARGE_FIGHTER then
		takatakaGfxQuads:setRect(takatakaNames["takatakaLargeFighterIcon.png"], size / 2 * -1, size / 2 * -1, size / 2, size / 2)
		prop:setDeck(takatakaGfxQuads)
		prop:setIndex(takatakaNames["takatakaLargeFighterIcon.png"])

	elseif ship == ships.ANT_HIVE then
		antHiveGfxQuads:setRect(antHiveNames["antHiveIcon.png"], size / 2 * -1, size / 2 * -1, size / 2, size / 2)
		prop:setDeck(antHiveGfxQuads)
		prop:setIndex(antHiveNames["antHiveIcon.png"])

	elseif ship == ships.HUMAN_DESTROYER then
		humanDestroyerGfxQuads:setRect(humanDestroyerNames["humanDestroyerIcon.png"], size / 2 * -1, size / 2 * -1, size / 2, size / 2)
		prop:setDeck(humanDestroyerGfxQuads)
		prop:setIndex(humanDestroyerNames["humanDestroyerIcon.png"])
	end 
	
	return prop
end

--------------------------------------------------------------------------
-- getShipProp
-- get a ship prop, animation and shieldHit for the battle
--------------------------------------------------------------------------
function ships.getShipProp(ship)
	local prop = MOAIProp2D.new()
	local curve = MOAIAnimCurve.new()
	local anim = MOAIAnim:new()
	local shieldHitProp = ships.getShieldHitProp(ship)
	
	if ship == ships.LLAXON_FIGHTER then
		ships.setupAnimatedProp(
			llaxonFighterGfxQuads, -- deck
			llaxonFighterNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"llaxonFighter", --textureBaseName
			ships.LLAXON_FIGHTER_WIDTH, -- width
			ships.LLAXON_FIGHTER_HEIGHT, -- height
			"llaxonFighterShipPropSized" -- sizedFlag
		)
	elseif ship == ships.LLAXON_DESTROYER then
		ships.setupAnimatedProp(
			llaxonDestroyerGfxQuads, -- deck
			llaxonDestroyerNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"llaxonDestroyer", --textureBaseName
			ships.LLAXON_DESTROYER_WIDTH, -- width
			ships.LLAXON_DESTROYER_HEIGHT, -- height
			"llaxonDestroyerShipPropSized" -- sizedFlag
		)
	elseif ship == ships.LLAXON_DESTROYER_TURRET_R or ship == ships.LLAXON_DESTROYER_TURRET_L then
		--size the prop
		if ships.llaxonDestroyerTurretShipPropSized == nil or not ships.llaxonDestroyerTurretShipPropSized then
			llaxonDestroyerGfxQuads:setRect(llaxonDestroyerNames["llaxonDestroyerTurret.png"], ships.LLAXON_DESTROYER_TURRET_WIDTH / 2 * -1, ships.LLAXON_DESTROYER_TURRET_HEIGHT / 2 * -1, ships.LLAXON_DESTROYER_TURRET_WIDTH / 2, ships.LLAXON_DESTROYER_TURRET_HEIGHT / 2)
			ships.llaxonDestroyerTurretShipPropSized = true
		end
		prop:setDeck(llaxonDestroyerGfxQuads)
		prop:setIndex(llaxonDestroyerNames["llaxonDestroyerTurret.png"])


	elseif ship == ships.PIRATE_FIGHTER then
		ships.setupAnimatedProp(
			pirateGfxQuads, -- deck
			pirateNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"pirateFighter", --textureBaseName
			ships.PIRATE_FIGHTER_WIDTH, -- width
			ships.PIRATE_FIGHTER_HEIGHT, -- height
			"pirateFighterShipPropSized" -- sizedFlag
		)
	elseif ship == ships.PIRATE_MISSLE_FIGHTER then
		ships.setupAnimatedProp(
			pirateGfxQuads, -- deck
			pirateNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"pirateMissleFighter", --textureBaseName
			ships.PIRATE_MISSLE_FIGHTER_WIDTH, -- width
			ships.PIRATE_MISSLE_FIGHTER_HEIGHT, -- height
			"pirateMissleFighterShipPropSized" -- sizedFlag
		)
	elseif ship == ships.PIRATE_DESTROYER then
		ships.setupAnimatedProp(
			pirateDestroyerGfxQuads, -- deck
			pirateDestroyerNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"pirateDestroyer", --textureBaseName
			ships.PIRATE_DESTROYER_WIDTH, -- width
			ships.PIRATE_DESTROYER_HEIGHT, -- height
			"pirateDestroyerShipPropSized" -- sizedFlag
		)
	elseif ship == ships.PIRATE_DESTROYER_TURRET_TR or ship == ships.PIRATE_DESTROYER_TURRET_TL or ship == ships.PIRATE_DESTROYER_TURRET_MR or
		ship == ships.PIRATE_DESTROYER_TURRET_ML or ship == ships.PIRATE_DESTROYER_TURRET_BR or ship == ships.PIRATE_DESTROYER_TURRET_BL then
		--size the prop
		if ships.pirateDestroyerTurretShipPropSized == nil or not ships.pirateDestroyerTurretShipPropSized then
			pirateDestroyerGfxQuads:setRect(pirateDestroyerNames["pirateDestroyerTurret.png"], ships.PIRATE_DESTROYER_TURRET_WIDTH / 2 * -1, ships.PIRATE_DESTROYER_TURRET_HEIGHT / 2 * -1, ships.PIRATE_DESTROYER_TURRET_WIDTH / 2, ships.PIRATE_DESTROYER_TURRET_HEIGHT / 2)
			ships.pirateDestroyerTurretShipPropSized = true
		end
		prop:setDeck(pirateDestroyerGfxQuads)
		prop:setIndex(pirateDestroyerNames["pirateDestroyerTurret.png"])

	elseif ship == ships.TAKATAKA_FIGHTER then
		ships.setupAnimatedProp(
			takatakaGfxQuads, -- deck
			takatakaNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"takatakaFighter", --textureBaseName
			ships.TAKATAKA_FIGHTER_WIDTH, -- width
			ships.TAKATAKA_FIGHTER_HEIGHT, -- height
			"takatakaFighterShipPropSized" -- sizedFlag
		)
	elseif ship == ships.TAKATAKA_LARGE_FIGHTER then
		ships.setupAnimatedProp(
			takatakaGfxQuads, -- deck
			takatakaNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"takatakaLargeFighter", --textureBaseName
			ships.TAKATAKA_LARGE_FIGHTER_WIDTH, -- width
			ships.TAKATAKA_LARGE_FIGHTER_HEIGHT, -- height
			"takatakaLargeFighterShipPropSized" -- sizedFlag
		)

	elseif ship == ships.ANT_HIVE then
		ships.setupAnimatedProp(
			antHiveGfxQuads, -- deck
			antHiveNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"antHive", --textureBaseName
			ships.ANT_HIVE_WIDTH, -- width
			ships.ANT_HIVE_HEIGHT, -- height
			"antHiveShipPropSized" -- sizedFlag
		)
	elseif ship == ships.ANT_HIVE_TURRET_1 or ship == ships.ANT_HIVE_TURRET_2 or ship == ships.ANT_HIVE_TURRET_3 or ship == ships.ANT_HIVE_TURRET_4 or
		ship == ships.ANT_HIVE_TURRET_5 or ship == ships.ANT_HIVE_TURRET_6 or ship == ships.ANT_HIVE_TURRET_7 or ship == ships.ANT_HIVE_TURRET_8 or
		ship == ships.ANT_HIVE_TURRET_9 or ship == ships.ANT_HIVE_TURRET_10 then
		--size the prop
		if ships.antHiveTurretShipPropSized == nil or not ships.antHiveTurretShipPropSized then
			antHiveGfxQuads:setRect(antHiveNames["antHiveTurret.png"], ships.ANT_HIVE_TURRET_WIDTH / 2 * -1, ships.ANT_HIVE_TURRET_HEIGHT / 2 * -1, ships.ANT_HIVE_TURRET_WIDTH / 2, ships.ANT_HIVE_TURRET_HEIGHT / 2)
			ships.antHiveTurretShipPropSized = true
		end
		prop:setDeck(antHiveGfxQuads)
		prop:setIndex(antHiveNames["antHiveTurret.png"])

	elseif ship == ships.HUMAN_DESTROYER then
		ships.setupAnimatedProp(
			humanDestroyerGfxQuads, -- deck
			humanDestroyerNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"humanDestroyer", --textureBaseName
			ships.HUMAN_DESTROYER_WIDTH, -- width
			ships.HUMAN_DESTROYER_HEIGHT, -- height
			"humanDestroyerShipPropSized" -- sizedFlag
		)
	elseif ship == ships.HUMAN_DESTROYER_FRONT_TURRET then
		--size the prop
		if ships.humanDestroyerFrontTurretShipPropSized == nil or not ships.humanDestroyerFrontTurretShipPropSized then
			humanDestroyerGfxQuads:setRect(humanDestroyerNames["humanDestroyerFrontTurret.png"], ships.HUMAN_DESTROYER_FRONT_TURRET_WIDTH / 2 * -1, ships.HUMAN_DESTROYER_FRONT_TURRET_HEIGHT / 2 * -1, ships.HUMAN_DESTROYER_FRONT_TURRET_WIDTH / 2, ships.HUMAN_DESTROYER_FRONT_TURRET_HEIGHT / 2)
			ships.humanDestroyerFrontTurretShipPropSized = true
		end
		prop:setDeck(humanDestroyerGfxQuads)
		prop:setIndex(humanDestroyerNames["humanDestroyerFrontTurret.png"])
	elseif ship == ships.HUMAN_DESTROYER_REAR_TURRET_L or ship == ships.HUMAN_DESTROYER_REAR_TURRET_R then
		--size the prop
		if ships.humanDestroyerRearTurretShipPropSized == nil or not ships.humanDestroyerRearTurretShipPropSized then
			humanDestroyerGfxQuads:setRect(humanDestroyerNames["humanDestroyerRearTurret.png"], ships.HUMAN_DESTROYER_REAR_TURRET_WIDTH / 2 * -1, ships.HUMAN_DESTROYER_REAR_TURRET_HEIGHT / 2 * -1, ships.HUMAN_DESTROYER_REAR_TURRET_WIDTH / 2, ships.HUMAN_DESTROYER_REAR_TURRET_HEIGHT / 2)
			ships.humanDestroyerRearTurretShipPropSized = true
		end
		prop:setDeck(humanDestroyerGfxQuads)
		prop:setIndex(humanDestroyerNames["humanDestroyerRearTurret.png"])
	elseif ship == ships.HUMAN_DESTROYER_GUN_TURRET_TL or ship == ships.HUMAN_DESTROYER_GUN_TURRET_TR or ship == ships.HUMAN_DESTROYER_GUN_TURRET_ML or
		ship == ships.HUMAN_DESTROYER_GUN_TURRET_MR or ship == ships.HUMAN_DESTROYER_GUN_TURRET_BL or ship == ships.HUMAN_DESTROYER_GUN_TURRET_BR then
		--size the prop
		if ships.humanDestroyerGunTurretShipPropSized == nil or not ships.humanDestroyerGunTurretShipPropSized then
			humanDestroyerGfxQuads:setRect(humanDestroyerNames["humanDestroyerGunTurret.png"], ships.HUMAN_DESTROYER_GUN_TURRET_WIDTH / 2 * -1, ships.HUMAN_DESTROYER_GUN_TURRET_HEIGHT / 2 * -1, ships.HUMAN_DESTROYER_GUN_TURRET_WIDTH / 2, ships.HUMAN_DESTROYER_GUN_TURRET_HEIGHT / 2)
			ships.humanDestroyerGunTurretShipPropSized = true
		end
		prop:setDeck(humanDestroyerGfxQuads)
		prop:setIndex(humanDestroyerNames["humanDestroyerGunTurret.png"])
	end 
	
	return prop, shieldHitProp
end

--------------------------------------------------------------------------
-- makeWeaponPropPool
--
-- This will return the weapon prop pool as an arrayList of prop objects (containing a prop, curve and anim) 
--------------------------------------------------------------------------
function ships.makeWeaponPropPool()
	local pool = util.getArrayList()
	local numPropsInPool = 50
	for i=1,numPropsInPool do
		local weaponPropObj = {}
		weaponPropObj.used = false
		weaponPropObj.prop = MOAIProp2D.new()
		weaponPropObj.curve = MOAIAnimCurve.new()
		weaponPropObj.anim = MOAIAnim:new()
	
		pool:add(weaponPropObj)
	end
	return pool
end
ships.weaponPropPool = ships.makeWeaponPropPool()

--------------------------------------------------------------------------
-- getWeaponProp
-- get a weapon prop (shot) for the battle
--------------------------------------------------------------------------
function ships.getWeaponProp(weapon)
	local weaponPropObj = {}
	weaponPropObj.prop = MOAIProp2D.new()
	weaponPropObj.curve = MOAIAnimCurve.new()
	weaponPropObj.anim = MOAIAnim:new()

	local prop = weaponPropObj.prop
	prop:setVisible(true)
	prop:setIndex(1)
	local curve = weaponPropObj.curve
	local anim = weaponPropObj.anim

	if weapon == ships.NUCLEAR_TORPEDOES then
		local width = 70
		local height = width * 50 / 36
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"nuclearTorpedo", --textureBaseName
			width, -- width
			height, -- height
			"nuclearTorpedoPropSized" -- sizedFlag
		)
	elseif weapon == ships.LASER_BEAM then
		local width = 60
		local height = width * 77 / 41
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"laserBeam", --textureBaseName
			width, -- width
			height, -- height
			"laserBeamPropSized" -- sizedFlag
		)
	elseif weapon == ships.MINI_GUN then
		if ships.cannonPropSized == nil or not ships.cannonPropSized then  
			local width = 30
			local height = width * 100 / 71
			weaponsGfxQuads:setRect(weaponsNames["cannon.png"], width / 2 * -1, height / 2 * -1, width / 2, height / 2)
		end
		prop:setDeck(weaponsGfxQuads)
		prop:setIndex(weaponsNames["cannon.png"])
	elseif weapon == ships.FISSION_TORPEDOES then
		local width = 70
		local height = width * 53 / 41
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"fissionTorpedo", --textureBaseName
			width, -- width
			height, -- height
			"fissionTorpedoPropSized" -- sizedFlag
		)
	elseif weapon == ships.ION_BEAM then
		local width = 60
		local height = width * 83 / 37
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"ionBeam", --textureBaseName
			width, -- width
			height, -- height
			"ionBeamPropSized" -- sizedFlag
		)
	elseif weapon == ships.MASS_DRIVER then
		if ships.cannonPropSized == nil or not ships.cannonPropSized then  
			local width = 30
			local height = width * 100 / 71
			weaponsGfxQuads:setRect(weaponsNames["cannon.png"], width / 2 * -1, height / 2 * -1, width / 2, height / 2)
		end
		prop:setDeck(weaponsGfxQuads)
		prop:setIndex(weaponsNames["cannon.png"])
	elseif weapon == ships.ANTI_MATTER_TORPEDOES then
		local width = 70
		local height = width * 50 / 43
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"antimatterTorpedo", --textureBaseName
			width, -- width
			height, -- height
			"antiMatterTorpedoPropSized" -- sizedFlag
		)
	elseif weapon == ships.PLASMA_CANNON then
		local width = 70
		local height = width * 50 / 45
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"plasmaCannon", --textureBaseName
			width, -- width
			height, -- height
			"plasmaCannonPropSized" -- sizedFlag
		)
	elseif weapon == ships.COIL_GUN then
		if ships.cannonPropSized == nil or not ships.cannonPropSized then  
			local width = 30
			local height = width * 100 / 71
			weaponsGfxQuads:setRect(weaponsNames["cannon.png"], width / 2 * -1, height / 2 * -1, width / 2, height / 2)
		end
		prop:setDeck(weaponsGfxQuads)
		prop:setIndex(weaponsNames["cannon.png"])
	elseif weapon == ships.LLAXON_FIGHTER then
		local width = 30
		local height = width * 50 / 21
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"llaxonFighter", --textureBaseName
			width, -- width
			height, -- height
			"llaxonFighterWeaponPropSized" -- sizedFlag
		)
	elseif weapon == ships.LLAXON_DESTROYER then
	elseif weapon == ships.TAKATAKA_FIGHTER then
		local width = 30
		local height = width * 50 / 18
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"takatakaFighter", --textureBaseName
			width, -- width
			height, -- height
			"takatakaFighterWeaponPropSized" -- sizedFlag
		)
	elseif weapon == ships.TAKATAKA_LARGE_FIGHTER then
		local width = 200
		local height = width * 50 / 49
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, --prop
			anim, -- anim
			curve, -- curve
			"takatakaLargeFighter", --textureBaseName
			width, -- width
			height, -- height
			"takatakaLargeFighterWeaponPropSized" -- sizedFlag
		)
	elseif weapon == ships.PIRATE_FIGHTER then
		if ships.cannonPropSized == nil or not ships.cannonPropSized then  
			local width = 30
			local height = width * 100 / 71
			weaponsGfxQuads:setRect(weaponsNames["cannon.png"], width / 2 * -1, height / 2 * -1, width / 2, height / 2)
		end
		prop:setDeck(weaponsGfxQuads)
		prop:setIndex(weaponsNames["cannon.png"])
	elseif weapon == ships.PIRATE_MISSLE_FIGHTER then
		local width = 70
		local height = width * 50 / 36
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"nuclearTorpedo", --textureBaseName
			width, -- width
			height, -- height
			"nuclearTorpedoPropSized" -- sizedFlag
		)
	elseif weapon == ships.PIRATE_DESTROYER then
		local width = 100
		local height = width * 100 / 42
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"pirateDestroyer", --textureBaseName
			width, -- width
			height, -- height
			"pirateDestroyerWeaponPropSized" -- sizedFlag
		)
	elseif weapon == ships.ANT_VENOM then
		local width = 100
		local height = width * 107 / 98
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"antVenom", --textureBaseName
			width, -- width
			height, -- height
			"antVenomWeaponPropSized" -- sizedFlag
		)
	elseif weapon == ships.HUMAN_DESTROYER_FRONT then
		local width = 300
		local height = width * 216 / 214
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"humanDestroyerFront", --textureBaseName
			width, -- width
			height, -- height
			"humanDestroyerFrontWeaponPropSized" -- sizedFlag
		)
	elseif weapon == ships.HUMAN_DESTROYER_REAR then
		local width = 200
		local height = width * 216 / 214
		ships.setupAnimatedProp(
			weaponsGfxQuads, -- deck
			weaponsNames, -- names
			prop, -- prop
			anim, -- anim
			curve, -- curve
			"humanDestroyerRear", --textureBaseName
			width, -- width
			height, -- height
			"humanDestroyerRearWeaponPropSized" -- sizedFlag
		)
	end
	
	return weaponPropObj
end

--------------------------------------------------------------------------
-- setupAnimatedProp
-- This is used by the getWeaponProp and getShipProp function for all animations
--------------------------------------------------------------------------
function ships.setupAnimatedProp(deck, names, prop, anim, curve, textureBaseName, width, height, sizedFlag)
	--size the prop
	if ships[sizedFlag] == nil or not ships[sizedFlag] then
		for i=1, 10 do
			deck:setRect(names[textureBaseName..i..".png"], width / 2 * -1, height / 2 * -1, width / 2, height / 2)
		end
		ships[sizedFlag] = true
	end
	--setup the animation curve
	curve:reserveKeys(10)
	for i=1, 10 do
		curve:setKey(i, 0.1 * (i-1), names[textureBaseName..i..".png"], MOAIEaseType.FLAT)
	end
	anim:reserveLinks(1)
	anim:setLink(1, curve, prop, MOAIProp2D.ATTR_INDEX)
	anim:setMode(MOAITimer.LOOP)
	anim:start()
	prop:setDeck(deck)
end

--------------------------------------------------------------------------
-- getShieldHitProp
-- get the shield hit prop with a size based on the ship
--------------------------------------------------------------------------
function ships.getShieldHitProp(ship)
	--set the base size for the shieldHit
	local shieldBaseSize = 100
	if ships.shieldHitSized == nil or not ships.shieldHitSized then
		weaponsGfxQuads:setRect(weaponsNames["shieldHit.png"], shieldBaseSize / 2 * -1, shieldBaseSize / 2 * -1, shieldBaseSize / 2, shieldBaseSize / 2)
	end

	local shipMaxSize = ships.getShipMaxSize(ship)

	--get the scale that the shield must be for this ship 
	local shieldSize = shipMaxSize * 1.3
	local shieldScale = shieldSize / shieldBaseSize
	--get the shield prop 
	local shieldHitProp = MOAIProp2D.new()
	shieldHitProp:setDeck(weaponsGfxQuads)
	shieldHitProp:setIndex(weaponsNames["shieldHit.png"])
	shieldHitProp:setScl(shieldScale, shieldScale)
	return shieldHitProp
end

--------------------------------------------------------------------------
-- getShockwaveProp
-- get the shockwave prop and a max scale based on the ship
--------------------------------------------------------------------------
function ships.getShockwaveProp(ship)
	--size the shockwaves
	shockwaveBaseSize = 100
	if ships.shockwavesSized == nil or not ships.shockwavesSized then
		weaponsGfxQuads:setRect(weaponsNames["shockwave1.png"], shockwaveBaseSize / 2 * -1, shockwaveBaseSize / 2 * -1, shockwaveBaseSize / 2, shockwaveBaseSize / 2)
		weaponsGfxQuads:setRect(weaponsNames["shockwave2.png"], shockwaveBaseSize / 2 * -1, shockwaveBaseSize / 2 * -1, shockwaveBaseSize / 2, shockwaveBaseSize / 2)
		ships.shockwavesSized = true
	end 

	local shipMaxSize = ships.getShipMaxSize(ship)
	
	--a shockwave should be 15 times the max ship size
	local shockwaveMaxScale = shipMaxSize * 15 / shockwaveBaseSize

	local prop = MOAIProp2D.new()
	prop:setDeck(weaponsGfxQuads)
	prop:setIndex(weaponsNames["shockwave"..math.random(1, 2)..".png"])
	prop:setVisible(false)
	prop:setRot(math.random(0, 359))
	return prop, shockwaveMaxScale
end

--------------------------------------------------------------------------
-- getExplodeProp
-- get the explode prop, animation, shakeMagnitude and shakeDuration with a size based on the ship
--------------------------------------------------------------------------
function ships.getExplodeProp(ship)
	--set the base size for the explode
	local explodeBaseSize = 100
	if ships.explodePropsSized == nil or not ships.explodePropsSized then 
		for i=0, 19 do
			weaponsGfxQuads:setRect(weaponsNames["explode_"..i..".png"], explodeBaseSize / 2 * -1, explodeBaseSize / 2 * -1, explodeBaseSize / 2, explodeBaseSize / 2)
		end
		ships.explodePropsSized = true
	end

	local shipMaxSize = ships.getShipMaxSize(ship)

	--get the scale that the explode must be for this ship 
	local explodeSize = shipMaxSize * 3
	local explodeScale = explodeSize / explodeBaseSize
	--get the explode prop 
	local explodeProp = MOAIProp2D.new()
	local curve = MOAIAnimCurve.new()
	local anim = MOAIAnim:new()
	--setup the animation curve
	curve:reserveKeys(20)
	for i=1, 20 do
		curve:setKey(i, .009 * (i-1), weaponsNames["explode_"..(i-1)..".png"], MOAIEaseType.FLAT)
	end
	anim:reserveLinks(1)
	anim:setLink(1, curve, explodeProp, MOAIProp2D.ATTR_INDEX)
	anim:setMode(MOAITimer.LOOP)
	explodeProp:setDeck(weaponsGfxQuads)
	explodeProp:setScl(explodeScale, explodeScale)
	--set the prop to invisible
	explodeProp:setVisible(false)
	--set the shake magnitude and duration
	local shakeMagnitude = shipMaxSize / 100 * 30
	local shakeDuration = 20
	return explodeProp, anim, shakeMagnitude, shakeDuration
end


--------------------------------------------------------------------------
-- getShipMaxSize
--
-- This will get the max size (width or height) for the given ship
--------------------------------------------------------------------------
function ships.getShipMaxSize(ship)
	local shipMaxSize = 0
	if ship == ships.PC_SHIP then
		shipMaxSize = math.max(ships.PC_SHIP_WIDTH, ships.PC_SHIP_HEIGHT)
	elseif ship == ships.LLAXON_FIGHTER then
		shipMaxSize = math.max(ships.LLAXON_FIGHTER_WIDTH, ships.LLAXON_FIGHTER_HEIGHT)
	elseif ship == ships.LLAXON_DESTROYER then
		shipMaxSize = math.max(ships.LLAXON_DESTROYER_WIDTH, ships.LLAXON_DESTROYER_HEIGHT)
	elseif ship == ships.LLAXON_DESTROYER_TURRET_R or ship == ships.LLAXON_DESTROYER_TURRET_L then
		shipMaxSize = math.max(ships.LLAXON_DESTROYER_TURRET_WIDTH, ships.LLAXON_DESTROYER_TURRET_HEIGHT)

	elseif ship == ships.PIRATE_FIGHTER then
		shipMaxSize = math.max(ships.PIRATE_FIGHTER_WIDTH, ships.PIRATE_FIGHTER_HEIGHT)
	elseif ship == ships.PIRATE_MISSLE_FIGHTER then
		shipMaxSize = math.max(ships.PIRATE_MISSLE_FIGHTER_WIDTH, ships.PIRATE_MISSLE_FIGHTER_HEIGHT)
	elseif ship == ships.PIRATE_DESTROYER then
		shipMaxSize = math.max(ships.PIRATE_DESTROYER_WIDTH, ships.PIRATE_DESTROYER_HEIGHT)
	elseif ship == ships.PIRATE_DESTROYER_TURRET_TR or ship == ships.PIRATE_DESTROYER_TURRET_TL or ship == ships.PIRATE_DESTROYER_TURRET_MR or
		ship == ships.PIRATE_DESTROYER_TURRET_ML or ship == ships.PIRATE_DESTROYER_TURRET_BR or ship == ships.PIRATE_DESTROYER_TURRET_BL then
		shipMaxSize = math.max(ships.PIRATE_DESTROYER_TURRET_WIDTH, ships.PIRATE_DESTROYER_TURRET_HEIGHT)

	elseif ship == ships.TAKATAKA_FIGHTER then
		shipMaxSize = math.max(ships.TAKATAKA_FIGHTER_WIDTH, ships.TAKATAKA_FIGHTER_HEIGHT)
	elseif ship == ships.TAKATAKA_LARGE_FIGHTER then
		shipMaxSize = math.max(ships.TAKATAKA_LARGE_FIGHTER_WIDTH, ships.TAKATAKA_LARGE_FIGHTER_HEIGHT)

	elseif ship == ships.ANT_HIVE then
		shipMaxSize = math.max(ships.ANT_HIVE_WIDTH, ships.ANT_HIVE_HEIGHT)
	elseif ship == ships.ANT_HIVE_TURRET_1 or ship == ships.ANT_HIVE_TURRET_2 or ship == ships.ANT_HIVE_TURRET_3 or ship == ships.ANT_HIVE_TURRET_4 or
		ship == ships.ANT_HIVE_TURRET_5 or ship == ships.ANT_HIVE_TURRET_6 or ship == ships.ANT_HIVE_TURRET_7 or ship == ships.ANT_HIVE_TURRET_8 or
		ship == ships.ANT_HIVE_TURRET_9 or ship == ships.ANT_HIVE_TURRET_10 then
		shipMaxSize = math.max(ships.ANT_HIVE_TURRET_WIDTH, ships.ANT_HIVE_TURRET_HEIGHT)

	elseif ship == ships.HUMAN_DESTROYER then
		shipMaxSize = math.max(ships.HUMAN_DESTROYER_WIDTH, ships.HUMAN_DESTROYER_HEIGHT)
	elseif ship == ships.HUMAN_DESTROYER_FRONT_TURRET then
		shipMaxSize = math.max(ships.HUMAN_DESTROYER_FRONT_TURRET_WIDTH, ships.HUMAN_DESTROYER_FRONT_TURRET_HEIGHT)
	elseif ship == ships.HUMAN_DESTROYER_REAR_TURRET_L or ship == ships.HUMAN_DESTROYER_REAR_TURRET_R then
		shipMaxSize = math.max(ships.HUMAN_DESTROYER_REAR_TURRET_WIDTH, ships.HUMAN_DESTROYER_REAR_TURRET_HEIGHT)
	elseif ship == ships.HUMAN_DESTROYER_GUN_TURRET_TL or ship == ships.HUMAN_DESTROYER_GUN_TURRET_TR or ship == ships.HUMAN_DESTROYER_GUN_TURRET_ML or
		ship == ships.HUMAN_DESTROYER_GUN_TURRET_MR or ship == ships.HUMAN_DESTROYER_GUN_TURRET_BL or ship == ships.HUMAN_DESTROYER_GUN_TURRET_BR then
		shipMaxSize = math.max(ships.HUMAN_DESTROYER_GUN_TURRET_WIDTH, ships.HUMAN_DESTROYER_GUN_TURRET_HEIGHT)
	end

	return shipMaxSize
end

--------------------------------------------------------------------------
-- getShip
--
-- This will be the factory method for creating ship objects
--
-- extending objects are expected to set the following properties:
--
-- width
-- height
-- functionName
-- forwardSpeed
-- strafeSpeed
-- rotateSpeed
-- totalHitPoints
-- currentHitPoints
-- totalShieldPoints
-- shieldDamageReduction
-- shieldRegen
-- currentShieldPoints
-- attackModifier
-- defense
--------------------------------------------------------------------------
function ships.getShip(shipType)
	local baseShip = {}
	baseShip.prop = nil
	baseShip.dead = false
	--can be targetted
	baseShip.isTargettable = true
	--has an exhaust emitter
	baseShip.hasExhaust = true
	--will have an icon on the prepare battle screen
	baseShip.hasIcon = true
	--has child enemies to place (e.g. turrets)
	baseShip.hasChildren = false
	--this ship is a child of a larger ship
	baseShip.isChild = false
	--move
	baseShip.moveAngle = 0
	--rotate angle
	baseShip.rotateAngle = nil
	
	function baseShip:getLoc()
		return baseShip.prop:getLoc()
	end
	
	
	--------------------------------------------------------------------------
	-- setLoc
	--
	-- Sets the location of all the related ship props
	--------------------------------------------------------------------------
	function baseShip:setLoc(x, y)
		baseShip.prop:setLoc(x, y)
		baseShip:renderHealthBar()
		if baseShip.hasExhaust then
			baseShip.exhaustEmitter:setLoc(x, y)
		end
		if baseShip.shieldHitProp ~= nil then
			baseShip.shieldHitProp:setLoc(x, y)
		end
		if baseShip.explodeProp ~= nil then
			baseShip.explodeProp:setLoc(x, y)
		end
		if baseShip.shockwaveProp ~= nil then
			baseShip.shockwaveProp:setLoc(x, y)
		end
		if baseShip.functionName == "pcShip" then
			screens.battleScreen.props.directionIndicatorProp:setLoc(x, y)
		end
	end
	
	function baseShip:getRot()
		return baseShip.prop:getRot()
	end
	
	function baseShip:setRot(r)
		baseShip.prop:setRot(r)
		baseShip:renderHealthBar()
	end
	
	--------------------------------------------------------------------------
	-- die
	--
	-- This will be called when a ship is killed
	--------------------------------------------------------------------------
	function baseShip:die()
		self.dead = true
		self.prop:setVisible(false)
		if self.isTargettable then
			self.healthBarProp:setVisible(false)
			self.shieldHitProp:setVisible(false)
			--remove the shots
			local node = self.shots.first
			while node ~= nil do
				node.value.prop.prop:setVisible(false)
				node:remove() 
				screens.battleScreen.layers.battleLayer:removeProp(node.value.prop.prop)
				node.value.prop.anim:stop() 
				node.value.prop.used = false
				node = node.next
			end
		end
		--show the shockwave
		self:displayShockwave()
		--explode
		self:explode()
		audioUtil.playSound("explode")
		battle.targetClosestShip()
	end

	--------------------------------------------------------------------------
	-- drawHealthBar
	--
	--This will draw the health bar prop based on the amount of hit points a ship has and it's total hit point.
	--------------------------------------------------------------------------
	function baseShip.drawHealthBar(index, xOff, yOff, xFlip, yFlip)
		local barWidth = 200
		local barHeight = 30
		local sideWidth = 10
		local opacity = 1
		local sideColorR, sideColorG, sideColorB = 111/255, 111/255, 111/255 
		local shieldColorR, shieldColorG, shieldColorB = 0, 0, 1 
		local healthColorR, healthColorG, healthColorB = 1, 0, 0 
		
		local shieldBarAmount = barWidth * baseShip.currentShieldPoints / baseShip.totalShieldPoints
		if shieldBarAmount < 0 then shieldBarAmount = 0 end
		local healthBarAmount = barWidth * baseShip.currentHitPoints / baseShip.totalHitPoints
		if healthBarAmount < 0 then healthBarAmount = 0 end

		--draw the sides
		MOAIGfxDevice.setPenColor(sideColorR, sideColorG, sideColorB, opacity)
		MOAIDraw.fillRect(barWidth / 2 * -1 - sideWidth, barHeight * -1, barWidth / 2 * -1, barHeight)
		MOAIDraw.fillRect(barWidth / 2 + sideWidth, barHeight * -1, barWidth / 2, barHeight)
		--shield bar
		MOAIGfxDevice.setPenColor(shieldColorR, shieldColorG, shieldColorB, opacity)
		MOAIDraw.fillRect(barWidth / 2 * -1, 0, shieldBarAmount - barWidth / 2, barHeight)
		--health bar
		MOAIGfxDevice.setPenColor(healthColorR, healthColorG, healthColorB, opacity)
		MOAIDraw.fillRect(barWidth / 2 * -1, 0, healthBarAmount - barWidth / 2, barHeight * -1)
	end
	
	--setup the script for the health bar
	baseShip.healthBarDeck = MOAIScriptDeck.new()
	baseShip.healthBarDeck:setRect(-100, -50, 100, 50)
	baseShip.healthBarDeck:setDrawCallback(baseShip.drawHealthBar)
	baseShip.healthBarProp = MOAIProp2D.new()
	baseShip.healthBarProp:setDeck(baseShip.healthBarDeck)

	--------------------------------------------------------------------------
	-- renderHealthBar
	--
	--This will render the health bar under the ship
	--------------------------------------------------------------------------
	function baseShip:renderHealthBar()
		if self.functionName == "pcShip" or not self.isTargettable then
			return
		end
		local shipX
		local shipY
		local shipDeg
		local ax
		local ay
		local bx
		local by
		local cx
		local cy
	
		shipX, shipY = self:getLoc()
		shipDeg = self:getRot()
		ax, ay = util.rotatePoint(self.width/2*-1, self.height/2*-1, shipDeg)
		ax = ax + shipX
		ay = ay + shipY
		bx, by = util.rotatePoint(self.width/2, self.height/2*-1, shipDeg)
		bx = bx + shipX
		by = by + shipY
		cx, cy = util.rotatePoint(self.width/2, self.height/2, shipDeg)
		cx = cx + shipX
		cy = cy + shipY
		dx, dy = util.rotatePoint(self.width/2*-1, self.height/2, shipDeg)
		dx = dx + shipX
		dy = dy + shipY

		self.healthBarProp:setLoc(shipX, math.min(ay, by, cy, dy)-50)
	end	

	--------------------------------------------------------------------------
	-- setAiInformation
	--
	--This will set information used by the enemy AI scripts into the ship object
	--------------------------------------------------------------------------
	function baseShip:setAiInformation()
		if self.functionName == "pcShip" then
			return
		end
		local pcShipX, pcShipY = battle.currentBattle.pcShip:getLoc()
		local selfX, selfY = self:getLoc()
		
		--distance to PC Ship
		self.distanceToPcShip = util.distanceBetweenPoints(pcShipX, pcShipY, selfX, selfY)
		--number of enemy ships
		self.numberOfEnemies = 0
		for i = 1, battle.currentBattle.enemies.length do
			if not battle.currentBattle.enemies[i].dead then
				self.numberOfEnemies = self.numberOfEnemies + 1
			end
		end
		self.numberOfEnemies = self.numberOfEnemies - 1
		--distance to nearest enemy ship
		self.distanceToNearestEnemy = -1
		for i = 1, battle.currentBattle.enemies.length do
			if not battle.currentBattle.enemies[i].dead then
				local enemyX, enemyY = battle.currentBattle.enemies[i]:getLoc() 
				local enemyDistance = util.distanceBetweenPoints(enemyX, enemyY, selfX, selfY)
				if self ~= battle.currentBattle.enemies[i] and (self.distanceToNearestEnemy == -1 or self.distanceToNearestEnemy > enemyDistance) then
					self.distanceToNearestEnemy = enemyDistance 
				end
			end
		end
		--distance to right boundary
		self.distanceToRightBoundary = (screens.battleScreen.battleFieldWidth / 2) - selfX
		--distance to left boundary
		self.distanceToLeftBoundary = math.abs((screens.battleScreen.battleFieldWidth / 2 * -1) - selfX)
		--distance to top boundary
		self.distanceToTopBoundary = (screens.battleScreen.battleFieldHeight / 2) - selfY
		--distance to bottom boundary
		self.distanceToBottomBoundary = math.abs((screens.battleScreen.battleFieldHeight / 2 * -1) - selfY)
		--angle to pc ship
		local enemyR, enemyAngle = util.cartesianToPolar(pcShipX - selfX, pcShipY - selfY)
		self.angleToPcShip = enemyAngle
		--angle relative to the pc ship
		local enemyR, enemyAngle = util.cartesianToPolar(selfX - pcShipX, selfY - pcShipY)
		self.angleRelativeToPcShip = util.angleBetweenTwoNormalVectors(battle.currentBattle.pcShip:getRot(), enemyAngle)
	end
	
	--------------------------------------------------------------------------
	-- regenShields
	--
	--Regenerate the shields for the ship
	--------------------------------------------------------------------------
	function baseShip:regenShields()
		--shields can only regen if the ship has not been hit for a short time
		local timeUntilRegen = 5
		if self.lastAttackTime ~= nil and (battle.currentBattle.timer:getTime() - self.lastAttackTime) < timeUntilRegen then
			return
		end  
		self.currentShieldPoints = self.currentShieldPoints + baseShip.shieldRegen * battle.currentBattle.turnDuration
		if self.currentShieldPoints > baseShip.totalShieldPoints then
			self.currentShieldPoints = baseShip.totalShieldPoints
		end
	end

	--------------------------------------------------------------------------
	-- displayShieldHit
	--
	--This will show when an attack hits the ships shields
	--------------------------------------------------------------------------
	function baseShip:displayShieldHit()
		baseShip.shieldHitProp:setVisible(true)
		baseShip.shieldHitProp:setColor(1, 1, 1)
		--the number of milliseconds ago that a shield hit took place
		self.lastShieldHit = 0
	end
	
	--------------------------------------------------------------------------
	-- fadeShieldHit
	--
	--This will fade/hide the shield hit if one is present
	--------------------------------------------------------------------------
	function baseShip:fadeShieldHit()
		--if there has never been a shield hit then just return
		if self.lastShieldHit == nil then
			return
		end
		--increment the shield hit
		self.lastShieldHit = self.lastShieldHit + battle.currentBattle.turnDuration

		--how long will the shield hit be visible in seconds
		local shieldHitDuration = .5
		--the minimum amount that the shield will fade to
		local minFade = .2
		
		if self.lastShieldHit > shieldHitDuration then
			baseShip.shieldHitProp:setVisible(false)
		else
			local fadeAmount = 1 - ((1 - minFade) * self.lastShieldHit / shieldHitDuration) 
			baseShip.shieldHitProp:setColor(fadeAmount, fadeAmount, fadeAmount)
		end 
	end
	
	--------------------------------------------------------------------------
	-- displayShockwave
	--------------------------------------------------------------------------
	function baseShip:displayShockwave()
		local shockwaveThread = MOAICoroutine.new()
		shockwaveThread:run (
			function()
				local startTime = battle.currentBattle.timer:getTime()
				local currentDuration = 0
				--the duration that the shockwave will take to reach max size
				local duration = .1
				--the minimum scale size of the shockwave
				local minScale = .1
				local scale = minScale;
				baseShip.shockwaveProp:setScl(scale)
				baseShip.shockwaveProp:setVisible(true)
				while(scale < baseShip.shockwaveMaxScale) do
					coroutine.yield()
					currentDuration = battle.currentBattle.timer:getTime() - startTime
					scale = ((baseShip.shockwaveMaxScale - minScale) * currentDuration / duration) + minScale
					baseShip.shockwaveProp:setScl(scale)
					--fade the prop as well
					local fadeAmount = 1.3 - currentDuration / duration
					baseShip.shockwaveProp:setColor(fadeAmount, fadeAmount, fadeAmount)
				end
				baseShip.shockwaveProp:setVisible(false)
			end
		)
	end	

	--------------------------------------------------------------------------
	-- explode
	--------------------------------------------------------------------------
	function baseShip:explode()
		local explodeThread = MOAICoroutine.new()
		explodeThread:run (
			function()
				local startTime = battle.currentBattle.timer:getTime()
				local currentDuration = 0
				--the duration that the explosion will be visible
				local duration = .3
				baseShip.explodeProp:setRot(math.random(0, 359))
				baseShip.explodeProp:setVisible(true)
				baseShip.explodeAnim:start()
				--shake the screen based on the size of the ship
				battle.shakeScreen(baseShip.shakeMagnitude, baseShip.shakeDuration)
				while(currentDuration < duration) do
					coroutine.yield()
					currentDuration = battle.currentBattle.timer:getTime() - startTime
					local fadeAmount = 1.3 - currentDuration / duration
					baseShip.explodeProp:setColor(fadeAmount, fadeAmount, fadeAmount)
				end
				baseShip.explodeProp:setVisible(false)
			end
		)
	end

	--shots
	baseShip.shots = util.getLinkedList()
	--ensure that the last shot happened a long time before the battle starts
	baseShip.lastShotTime = -100
	
	--------------------------------------------------------------------------
	-- getShot
	-- This function will return a shot object
	--------------------------------------------------------------------------
	function baseShip:getShot(weapon, range, damageMin, damageMax, moveSpeed, attackTarget)
		local shot = {}
		shot.attackTarget = attackTarget
		shot.range = range
		shot.damageMin = damageMin
		shot.damageMax = damageMax
		shot.moveSpeed = moveSpeed
		shot.prop = ships.getWeaponProp(weapon)
		return shot
	end	

	--------------------------------------------------------------------------
	-- standardAttack
	-- This will carry out a standard attack action.  Ships can use this if they do standard attacks.
	--------------------------------------------------------------------------
	function baseShip:standardAttack(currentTime, rateOfFire, range, arcStart, arcEnd, attackSound, attackTarget, weapon, damageMin, damageMax, moveSpeed)
		--if the pc is dead or all enemies are dead then return
		if battle.currentBattle.pcShip.dead then
			return
		end
		local allDead = true
		for i = 1, battle.currentBattle.enemies.length do
			if not battle.currentBattle.enemies[i].dead and battle.currentBattle.enemies[i].isTargettable then
				allDead = false
			end
		end
		if allDead then
			return
		end

		local attackerX, attackerY = self:getLoc()
		--based on the rate of fire can the weapon shoot again
		if currentTime - self.lastShotTime > rateOfFire then
			local attackTargetX, attackTargetY = attackTarget:getLoc()
			local attackerRot = self:getRot()
			--is the attack target within the arc of fire
			if util.isPointInCone(attackTargetX, attackTargetY, attackerX, attackerY, range, attackerRot, arcStart, arcEnd) then
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
				--update the last shot time
				self.lastShotTime = currentTime
			end
		end
	end
		
	--------------------------------------------------------------------------
	-- resolveAttacks
	-- This will resolve any attacks (i.e. move them, did they hit or miss, etc)
	--------------------------------------------------------------------------
	function baseShip:resolveAttacks()
		--go through the shots, move them and then see if any hit
		local shotX, shotY, r, angle, attackTarget, attackTargetX, attackTargetY, moveSpeed
		node = self.shots.first
		while node ~= nil do
			attackTarget = node.value.attackTarget
			if not attackTarget.dead and node.value.distance <= node.value.range then
				attackTargetX, attackTargetY = attackTarget:getLoc()
				shotX, shotY = node.value.prop.prop:getLoc()
				--move the shot
				r, angle = util.cartesianToPolar(attackTargetX - shotX, attackTargetY - shotY)
				shotX, shotY = util.addVector(shotX, shotY, node.value.moveSpeed * battle.currentBattle.turnDuration, math.rad(angle))
				node.value.prop.prop:setRot(angle)
				node.value.prop.prop:setLoc(shotX, shotY)
				--see if the shot hit
				if attackTarget.prop:inside(shotX, shotY) then
					--the shot hit
					battle.applyAttackDamage(self.attackModifier, node.value.damageMin, node.value.damageMax, node.value.attackTarget)
					node.value.prop.prop:setVisible(false)
					node:remove()
					screens.battleScreen.layers.battleLayer:removeProp(node.value.prop.prop)
					node.value.prop.anim:stop() 
					node.value.prop.used = false
				else
					--update the distance that this shot gone
					node.value.distance = node.value.distance + util.distanceBetweenPoints(shotX, shotY, node.value.lastX, node.value.lastY)
					node.value.lastX, node.value.lastY = shotX, shotY
				end
			else
				node.value.prop.prop:setVisible(false)
				node:remove()
				screens.battleScreen.layers.battleLayer:removeProp(node.value.prop.prop)
				node.value.prop.used = false
			end
			
			node = node.next
		end
	end
	
	return ships[shipType](baseShip)
end


--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- We now must include all of the ship functions
--------------------------------------------------------------------------
--------------------------------------------------------------------------
require("scripts.battle.ships.pcShip")
require("scripts.battle.ships.llaxonFighter")
require("scripts.battle.ships.llaxonDestroyer")
require("scripts.battle.ships.llaxonDestroyerTurret")
require("scripts.battle.ships.pirateFighter")
require("scripts.battle.ships.pirateMissleFighter")
require("scripts.battle.ships.pirateDestroyer")
require("scripts.battle.ships.pirateDestroyerTurret")
require("scripts.battle.ships.takatakaFighter")
require("scripts.battle.ships.takatakaLargeFighter")
require("scripts.battle.ships.antHive")
require("scripts.battle.ships.antHiveTurret")
require("scripts.battle.ships.humanDestroyer")
require("scripts.battle.ships.humanDestroyerFrontTurret")
require("scripts.battle.ships.humanDestroyerRearTurret")
require("scripts.battle.ships.humanDestroyerGunTurret")



