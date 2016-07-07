--####################################
-- llaxonAttackArtemis.lua
-- author: Jonas Yakimischak
--
-- This happens right after getting Jarvis.
--####################################

--namespace model.encounter.travelEncounters

--------------------------------------------------------------------------
-- antsAttackTheGrove
--------------------------------------------------------------------------
function model.encounter.travelEncounters.llaxonAttackArtemis()
	if not gameState.crew.jarvis or gameState.llaxonDestroyerAttacked then
		return false
	end

	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.encounter.travelEncounters.shakeStarMap()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("llaxonDestroyerDistress")
			gameState.llaxonDestroyerAttacked = true
			--now go to the artemis system
			audioUtil.playMusic("background")
			gameState.destination = "artemis"
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		end
	)
	return true
end
