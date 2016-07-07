--####################################
-- pirateDestroyerEncounter.lua
-- author: Jonas Yakimischak
--
-- This is the pirate destroyer boss battle.
--####################################

--namespace model.encounter.travelEncounters

function model.encounter.travelEncounters.pirateDestroyerEncounter()
	if not gameState.metMalvar or gameState.pirateDestroyerKilled then
		return false
	end

	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.encounter.travelEncounters.shakeStarMap()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("charlieSaysBigShipApproaching")
			audioUtil.playMusic("pirate")
			model.dialog.startDialog("pirateDestroyerEncounter")
			--now battle the pirates
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.PIRATE_DESTROYER) then
				return
			end
			--fight over
			gameState.pirateDestroyerKilled = true			
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		end
	)
	return true
end
