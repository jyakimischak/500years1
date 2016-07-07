--####################################
-- leavingTheGroveBeforeKillingAnts.lua
-- author: Jonas Yakimischak
--
-- This happens if you try to leave the Heron system during the Ant attack before killing them.
--####################################

--namespace model.encounter.travelEncounters

--------------------------------------------------------------------------
-- antsAttackTheGrove
--------------------------------------------------------------------------
function model.encounter.travelEncounters.leavingTheGroveBeforeKillingAnts()
	if not gameState.quests.yepp.foundOutAntsAttackingTheGrove or gameState.quests.yepp.savedTheGrove then
		return false
	end

	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.encounter.travelEncounters.shakeStarMap()
			audioUtil.playMusic("frank")
			model.dialog.startDialog("leavingTheGroveBeforeKillingAnts")
			--now go back to the Heron system.
			audioUtil.playMusic("background")
			gameState.destination = "heron"
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		end
	)
	return true
end
