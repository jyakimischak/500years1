--####################################
-- olegEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for speaking with Oleg in the crew section.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--speakWithOleg
--This encounter takes place when the player clicks the talk button on the
--crew screen for Oleg.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.speakWithOleg()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("oleg")
			model.dialog.startDialog("olegDefault")
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.CREW_DETAILS_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--showHowToNavigateCutScene
--Show the how to navigate intro cut scene and go back to Oleg's dialog
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.showHowToNavigateCutScene()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			--show the intro cut scene
			model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "howToNavigate")
			frontController.dispatch(frontController.DIALOG_SCREEN)
		end
	)
end

