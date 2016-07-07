--####################################
-- frankEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for speaking with Frank in the crew section.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--speakWithFrank
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.speakWithFrank()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("frank")
			model.dialog.startDialog("frankDefault")
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.CREW_DETAILS_SCREEN)
		end
	)
end