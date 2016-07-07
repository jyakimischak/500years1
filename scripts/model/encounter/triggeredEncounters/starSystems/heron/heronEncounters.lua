--####################################
-- heronEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Heron system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--hailTheGrove
--This encounter takes place when the player hails The Grove colony.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailTheGrove()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("frank")
			model.dialog.startDialog("meetFrank")
			--show the cut scene
			audioUtil.playMusic("background")
			model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "frankArrives")
			--ask Clarence about egg
			audioUtil.playMusic("clarence")
			model.dialog.startDialog("askClarence")
			--talk about Yepp and have Frank give the coordinates to Antares
			audioUtil.playMusic("yepp")
			model.dialog.startDialog("meetYepp")
			gameState.visibleStarMapLocations:add("antares")
			gameState.crew.frank = true
			gameState.crew.yepp = true
			--back to the game
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--hailTheGroveHive
--This encounter takes place when the player hails the Ant Hive that is threatening The Grove.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailTheGroveHive()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("hailTheGroveHive")
			audioUtil.playMusic("ants")
			model.dialog.startDialog("theGroveHive")
			--now battle
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.ANT_HIVE) then
				return
			end
			gameState.quests.yepp.savedTheGrove = true
			--ship is broke
			audioUtil.playMusic("clarence")
			model.dialog.startDialog("damagedShipDuringHiveFight")
			--back to the game
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.SOLAR_SYSTEM_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--landAtTheGrove
--This encounter takes place when the player clicks the Land button at the Grove to make repairs.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.landAtTheGrove()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("background")
			model.cutScenes.playCutScene(screens.planetScreen.layers.screenLayer, "landForRepairs")
			audioUtil.playMusic("clarence")
			model.dialog.startDialog("francisMissing")
			audioUtil.playMusic("background")
			model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "francisDead")
			audioUtil.playMusic("clarence")
			model.dialog.startDialog("francisDead")
			gameState.francisDead = true
			gameState.quests.yepp.shipHasBeenRepaired = true
			--back to the game
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.SOLAR_SYSTEM_SCREEN)
		end
	)
end
