--####################################
-- artemisEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Artmeis system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--hailArtemis1_1
--This encounter takes place when the player hails the home colony.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailArtemis1_1()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			--------------------------------------------------------------------------
			--if clarence is not in your crew then this is the first meeting with the Proctor, talk to him and see if you get your first quest
			--------------------------------------------------------------------------
			if not gameState.crew.clarence then
				audioUtil.playMusic("proctor")
				model.dialog.startDialog("proctorTheBeginning")
				--if the repair quest has not been started we need to set that up
				if not gameState.quests.repairs.started then
					gameState.quests.theBeginning.complete = true
					gameState.quests.repairs.started = true
					gameState.visibleStarMapLocations:add("cursa")
				end
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return

			--------------------------------------------------------------------------
			--if clarence is in your crew and you have not received the star map locations from him then proctor will ask you to speak with him
			--------------------------------------------------------------------------
			elseif not gameState.quests.repairs.gotLocations then
				audioUtil.playMusic("proctor")
				model.dialog.startDialog("proctorSpeakWithClarence")
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return

			--------------------------------------------------------------------------
			--if clarence is in your crew and you have gotten the locations from him then you can speak with the proctor about landing and
			--making the repairs on your ship, etc
			--------------------------------------------------------------------------
			elseif not gameState.quests.repairs.complete then
				audioUtil.playMusic("proctor")
				model.dialog.startDialog("proctorMakeRepairs")
				--fix up the ship, setup star map locations, speak with Clarence
--				gameState.pcWeapons.laserBeam = true
--				gameState.pcWeapons.miniGun = true
--				gameState.pcEngines.level2 = true
--				gameState.pcComputer.level2 = true
--				gameState.pcShields.level2 = true
				gameState.shipTotalEnergy = 5
--				gameState.shipTotalArmor = 8
				gameState.visibleStarMapLocations:add("vulpecula")
				gameState.visibleStarMapLocations:add("pollux")
				gameState.visibleStarMapLocations:add("alya")
				gameState.visibleStarMapLocations:add("hydra")
				--finish the quest
				gameState.quests.repairs.complete = true
				--show the cut scene
				audioUtil.playMusic("background")
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "clarenceRepairsShip")
				--finally speak with Clarence
				audioUtil.playMusic("clarence")
				model.dialog.startDialog("clarenceRepairsMade")
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return

			--------------------------------------------------------------------------
			--if we have Jarvis and he has not yet given us the coordinates then Proctor will suggest that we ask him
			--------------------------------------------------------------------------
			elseif gameState.llaxonDestroyerAttacked and not gameState.llaxonDestroyerKilled then
				audioUtil.playMusic("llaxon")
				model.dialog.startDialog("llaxonDestroyer")
				if not battle.startABattle(
					battle.GENERIC_BATTLE_FIELD,
					ships.LLAXON_DESTROYER) then
					return
				end
				gameState.llaxonDestroyerKilled = true
				audioUtil.playMusic("proctor")
				model.dialog.startDialog("proctorAfterLlaxonAttack")
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return

			--------------------------------------------------------------------------
			--if we have Jarvis and he has not yet given us the coordinates then Proctor will suggest that we ask him
			--------------------------------------------------------------------------
			elseif gameState.crew.jarvis and not gameState.quests.jarvisCoordinates.gaveResortCoordinates then
				audioUtil.playMusic("proctor")
				model.dialog.startDialog("proctorSpeakWithJarvis")
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return
				
			--------------------------------------------------------------------------
			--if we are back at artemis for the end of the game then we'll fight the human destroyer
			--------------------------------------------------------------------------
			elseif gameState.quests.yepp.backAtArtemis and not gameState.quests.yepp.humanDestroyerKilled then
				audioUtil.playMusic("pirate")
				model.dialog.startDialog("speakWithHumanDestroyer")
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("noMatchForHumanDestroyer")
				gameState.shipTotalEnergy = 12
				audioUtil.playMusic("background")
				if not battle.startABattle(
					battle.GENERIC_BATTLE_FIELD,
					ships.HUMAN_DESTROYER) then
					return
				end
				gameState.quests.yepp.humanDestroyerKilled = true
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return
				
			--------------------------------------------------------------------------
			--the destroyer is killed and we're hailing artemis colony for the end outro
			--------------------------------------------------------------------------
			elseif gameState.quests.yepp.humanDestroyerKilled then
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("noOneLeftAtArtemis")
				audioUtil.playMusic("background")
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "scanArtemis")
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("noOneLeftAtArtemis2")
				audioUtil.playMusic("background")
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "artemisDeserted")
				audioUtil.playMusic("oleg")
				model.dialog.startDialog("noOneLeftAtArtemis3")
				audioUtil.playMusic("background")
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "shipTrail")
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("noOneLeftAtArtemis4")
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.CREDITS_SCREEN)
				
				
			--------------------------------------------------------------------------
			--else the proctor will not say much
			--------------------------------------------------------------------------
			else
				audioUtil.playMusic("proctor")
				model.dialog.startDialog("proctorDefault")
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return
			end
		end
	)
end
