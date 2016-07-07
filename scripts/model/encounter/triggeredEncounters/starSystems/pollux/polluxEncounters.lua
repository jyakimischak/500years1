--####################################
-- polluxEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Pollux system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--hailPolluxIV
--This encounter takes place when the player hails Pollux 4, the Ungiri home world.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailPolluxIV()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			--------------------------------------------------------------------------
			--If the Ungiri have not yet stolen Lepus' daughter
			--------------------------------------------------------------------------
--			if not gameState.metMalvar then
				gameState.metUngiri = true
				audioUtil.playMusic("ungiri")
				model.dialog.startDialog("ungiriFirstMeeting")
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return
--			end
		end
	)

end
