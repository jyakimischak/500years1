--####################################
-- leavingArtemisAtEnd.lua
-- author: Jonas Yakimischak
--
-- This happens if you try to leave the Artemis system at the end of the game.
--####################################

--namespace model.encounter.travelEncounters

--------------------------------------------------------------------------
-- leavingArtemisAtEnd
--------------------------------------------------------------------------
function model.encounter.travelEncounters.leavingArtemisAtEnd()
	if not gameState.quests.yepp.backAtArtemis then
		return false
	end

	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.encounter.travelEncounters.shakeStarMap()
			audioUtil.playMusic("oleg")
			model.dialog.startDialog("leavingArtemisAtEnd")
			--now go back to the Artemis system.
			audioUtil.playMusic("background")
			gameState.destination = "artemis"
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		end
	)
	return true
end
