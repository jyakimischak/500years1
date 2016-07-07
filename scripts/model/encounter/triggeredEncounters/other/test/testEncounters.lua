--####################################
-- testEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is for starting test battles.
--####################################

--namespace model.encounter.triggeredEncounters

function model.setupTestShip()
	gameState.shipTotalEnergy = 20
	gameState.pcWeapons.nuclearTorpedoes = true
	gameState.pcWeapons.laserBeam = true
	gameState.pcWeapons.miniGun = true
	gameState.pcWeapons.fissionTorpedoes = true
	gameState.pcWeapons.ionBeam = true
	gameState.pcWeapons.massDriver = true
	gameState.pcWeapons.antiMatterTorpedoes = true
	gameState.pcWeapons.plasmaCannon = true
	gameState.pcWeapons.coilGun = true
	gameState.pcEngines.level1 = true
	gameState.pcEngines.level2 = true
	gameState.pcEngines.level3 = true
	gameState.pcComputer.level1 = true
	gameState.pcComputer.level2 = true
	gameState.pcComputer.level3 = true
	gameState.pcShields.level1 = true
	gameState.pcShields.level2 = true
	gameState.pcShields.level3 = true
	gameState.pcShipEquippedWeapon = "nuclearTorpedoes"
	gameState.pcShipEquippedEngines = "enginesLevel1"
	gameState.pcShipEquippedComputer = "computerLevel1"
	gameState.pcShipEquippedShields = "shieldsLevel1"
end

--------------------------------------------------------------------------
--llaxonTest
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.llaxonTest()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.setupTestShip()

--			if not battle.startABattle(
--				battle.GENERIC_BATTLE_FIELD,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER,
--				ships.PIRATE_FIGHTER) then
--				return
--			end

		
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.LLAXON_FIGHTER,
				ships.LLAXON_FIGHTER,
				ships.LLAXON_FIGHTER,
				ships.LLAXON_FIGHTER,
				ships.LLAXON_FIGHTER) then
				return
			end
			frontController.dispatch(frontController.START_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--llaxonDestroyerTest
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.llaxonDestroyerTest()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.setupTestShip()
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.LLAXON_DESTROYER) then
				return
			end
			frontController.dispatch(frontController.START_SCREEN)
		end
	)
end


--------------------------------------------------------------------------
--pirateTest
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.pirateTest()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.setupTestShip()
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.PIRATE_MISSLE_FIGHTER,
				ships.PIRATE_MISSLE_FIGHTER,
				ships.PIRATE_MISSLE_FIGHTER,
				ships.PIRATE_FIGHTER,
				ships.PIRATE_FIGHTER,
				ships.PIRATE_FIGHTER) then
				return
			end
--			if not battle.startABattle(
--				battle.GENERIC_BATTLE_FIELD,
--				ships.PIRATE_MISSLE_FIGHTER) then
--				return
--			end
			frontController.dispatch(frontController.START_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--pirateDestroyerTest
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.pirateDestroyerTest()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.setupTestShip()
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.PIRATE_DESTROYER) then
				return
			end
			frontController.dispatch(frontController.START_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--takatakaTest
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.takatakaTest()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.setupTestShip()
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.TAKATAKA_FIGHTER,
				ships.TAKATAKA_FIGHTER,
				ships.TAKATAKA_LARGE_FIGHTER) then
				return
			end
			frontController.dispatch(frontController.START_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--antHiveTest
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.antHiveTest()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.setupTestShip()
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.ANT_HIVE) then
				return
			end
			frontController.dispatch(frontController.START_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--humanDestroyerTest
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.humanDestroyerTest()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.setupTestShip()
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.HUMAN_DESTROYER) then
				return
			end
			frontController.dispatch(frontController.START_SCREEN)
		end
	)
end
