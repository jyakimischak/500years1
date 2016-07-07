--####################################
-- clarenceEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for speaking with Clarence in the crew section.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--speakWithClarence
--This encounter takes place when the player clicks the talk button on the
--crew screen for Clarence.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.speakWithClarence()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			--------------------------------------------------------------------------
			--if we have Clarence in our crew but we have not yet asked him for assistance with repairs to the ship
			--------------------------------------------------------------------------
			audioUtil.playMusic("clarence")
			if not gameState.quests.repairs.gotLocations then
				model.dialog.startDialog("clarenceBeforeRepairs")
			else
				model.dialog.startDialog("clarenceDefault")
			end

			audioUtil.playMusic("background")
			frontController.dispatch(frontController.CREW_DETAILS_SCREEN)
		end
	)
end
