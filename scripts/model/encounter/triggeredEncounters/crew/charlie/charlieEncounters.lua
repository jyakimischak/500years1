--####################################
-- charlieEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for speaking with Charlie in the crew section.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--speakWithCharlie
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.speakWithCharlie()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("charlieDefault")
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.CREW_DETAILS_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--combatTutorialCutScene
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.combatTutorialCutScene()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			--show the intro cut scene
			model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "combatTutorial")
			frontController.dispatch(frontController.DIALOG_SCREEN)
		end
	)
end
