--####################################
-- antsAttackTheGrove.lua
-- author: Jonas Yakimischak
--
-- This happens right after getting Yepp and leaving the Heron system.
--####################################

--namespace model.encounter.travelEncounters

--------------------------------------------------------------------------
-- antsAttackTheGrove
--------------------------------------------------------------------------
function model.encounter.travelEncounters.antsAttackTheGrove()
	if not gameState.crew.yepp or gameState.quests.yepp.foundOutAntsAttackingTheGrove then
		return false
	end

	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.encounter.travelEncounters.shakeStarMap()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("antsAreAttackingTheGrove")
			gameState.quests.yepp.foundOutAntsAttackingTheGrove = true
			--now go back to the Heron system.
			audioUtil.playMusic("background")
			gameState.destination = "heron"
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		end
	)
	return true
end
