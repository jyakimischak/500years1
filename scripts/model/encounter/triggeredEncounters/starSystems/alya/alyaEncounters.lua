--####################################
-- alyaEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Alya system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--scanAlyaI
--This encounter takes place when the player scans Alya I.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.scanAlyaI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("scanAlyaI")
			audioUtil.playMusic("llaxon")
			model.dialog.startDialog("llaxonAlyaI")
			if gameState.AlyaILlaxonProvoked then
				if not battle.startABattle(
					battle.GENERIC_BATTLE_FIELD,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER,
					ships.LLAXON_FIGHTER) then
					return
				end
				gameState.AlyaILlaxonDefeated = true
			end
			gameState.scannedAlyaI = true
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--probeAlyaI
--This encounter takes place when the player launches a probe on Alya I.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.probeAlyaI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			if not gameState.AlyaILlaxonDefeated then
				audioUtil.playMusic("llaxon")
				model.dialog.startDialog("llaxonAlyaI")
				if gameState.AlyaILlaxonProvoked then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
--						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER) then
						return
					end
					gameState.AlyaILlaxonDefeated = true
				end
			else
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("probeAlyaI")
				gameState.probedAlyaI = true
			end
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
		end
	)

end

--------------------------------------------------------------------------
--hailAlyaI
--This encounter takes place when the player hails Alya I.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailAlyaI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			if not gameState.alyaIMetMary then
				audioUtil.playMusic("syrmaConsultant")
				model.dialog.startDialog("meetMary")
				gameState.alyaIMetMary = true
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "landOnAlyaI")
				gameState.shipTotalEnergy = gameState.shipTotalEnergy + 1
			else
				audioUtil.playMusic("syrmaConsultant")
				model.dialog.startDialog("afterMeetingMary")
			end
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
		end
	)
end
