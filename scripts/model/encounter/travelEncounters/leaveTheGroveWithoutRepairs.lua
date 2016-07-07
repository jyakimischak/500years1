--####################################
-- leaveTheGroveWithoutRepairs.lua
-- author: Jonas Yakimischak
--
-- This happens if you try to leave the Heron system after the Hive fight without landing for repairs.
--####################################

--namespace model.encounter.travelEncounters

--------------------------------------------------------------------------
-- antsAttackTheGrove
--------------------------------------------------------------------------
function model.encounter.travelEncounters.leaveTheGroveWithoutRepairs()
	if not gameState.quests.yepp.savedTheGrove or gameState.quests.yepp.shipHasBeenRepaired then
		return false
	end

	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.encounter.travelEncounters.shakeStarMap()
			audioUtil.playMusic("clarence")
			model.dialog.startDialog("leaveTheGroveWithoutRepairs")
			--now go back to the Heron system.
			audioUtil.playMusic("background")
			gameState.destination = "heron"
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		end
	)
	return true
end
