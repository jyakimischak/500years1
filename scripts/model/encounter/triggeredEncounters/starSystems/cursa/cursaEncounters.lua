--####################################
-- cursaEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Cursa system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--scanCursaI
--This encounter takes place when the player scans Cursa I
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.scanCursaI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("scanCursaI")
			gameState.quests.repairs.cursaIScanned = true
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--launchCursaI
--This encounter takes place when the player launches a probe to Cursa I
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.launchCursaI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("launchCursaI")
			gameState.quests.repairs.cursaIProbeLaunched = true
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--hailCursaI
--This encounter takes place when the player hails Cursa I
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailCursaI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("clarence")
			model.dialog.startDialog("hailCursaI")
			gameState.quests.repairs.cursaIHailed = true
			
			--if clarence has joined  your crew, the Llaxon respond with violence
			if screens.dialogScreen.dialog.currentOption == "takeCare" then
				gameState.crew.clarence = true
				audioUtil.playMusic("llaxon")
				model.dialog.startDialog("cursaILlaxonAttack")
				gameState.metLlaxon = true
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("tutorialCursaI")
				if showCursaCombatTutorial then
					model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "combatTutorial")
				end
				
				--now battle
				if not battle.startABattle(
					battle.GENERIC_BATTLE_FIELD,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER) then
					return
				end
			end

			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
		end
	)
end


--------------------------------------------------------------------------
--hailCursaII
--This encounter takes place when the player hails the Cursa II world to speak with the Llaxons.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailCursaII()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			gameState.metLlaxon = true
			audioUtil.playMusic("llaxon")
			model.dialog.startDialog("llaxonLeader")
			--you've spoken with the llaxon
			gameState.quests.repairs.spokeWithLlaxon = true
			--if you already have Clarence then they should be hostile
			if gameState.crew.clarence then
				if not battle.startABattle(
					battle.GENERIC_BATTLE_FIELD,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER) then
					return
				end
			end
			gameState.dialog = nil
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
			return
		end
	)
end
