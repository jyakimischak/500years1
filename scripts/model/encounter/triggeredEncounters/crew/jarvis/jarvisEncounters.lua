--####################################
-- jarvisEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for speaking with Jarvis in the crew section.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--speakWithJarvis
--This encounter takes place when the player clicks the talk button on the
--crew screen for Jarvis.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.speakWithJarvis()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("jarvis")
			--------------------------------------------------------------------------
			--if we have Jarvis in the crew and he has not yet given us the resort coordinates then he'll lead us to the resort
			--------------------------------------------------------------------------
			if not gameState.quests.jarvisCoordinates.gaveResortCoordinates then
				model.dialog.startDialog("jarvisResortCoordinates")
			else
				model.dialog.startDialog("jarvisDefault")
			end

			audioUtil.playMusic("background")
			frontController.dispatch(frontController.CREW_DETAILS_SCREEN)
		end
	)
end