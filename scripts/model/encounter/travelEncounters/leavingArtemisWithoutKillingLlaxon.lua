--####################################
-- leavingArtemisWithoutKillingLlaxon.lua
-- author: Jonas Yakimischak
--
-- This happens if you try to leave the Artemis system before killing the llaxon destroyer.
--####################################

--namespace model.encounter.travelEncounters

--------------------------------------------------------------------------
-- antsAttackTheGrove
--------------------------------------------------------------------------
function model.encounter.travelEncounters.leavingArtemisWithoutKillingLlaxon()
	if not gameState.llaxonDestroyerAttacked or gameState.llaxonDestroyerKilled then
		return false
	end

	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.encounter.travelEncounters.shakeStarMap()
			audioUtil.playMusic("oleg")
			model.dialog.startDialog("leavingArtemisBeforeKillingLlaxon")
			--now go back to the artemis system.
			audioUtil.playMusic("background")
			gameState.destination = "artemis"
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		end
	)
	return true
end
