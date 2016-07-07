--####################################
-- yeppEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for speaking with Yepp in the crew section.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--speakWithYepp
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.speakWithYepp()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("yepp")
			model.dialog.startDialog("yeppDefault")
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.CREW_DETAILS_SCREEN)
		end
	)
end