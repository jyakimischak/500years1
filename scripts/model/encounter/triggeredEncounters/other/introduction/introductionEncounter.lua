--####################################
-- introductionEncounter.lua
-- author: Jonas Yakimischak
--
-- This file is the triggered encounter for the games introduction.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--introduction
--This encounter takes place at the beginning of the game.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.introduction()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			--show the intro cut scene
			audioUtil.playMusic("intro")
			model.cutScenes.playCutScene(screens.startScreen.layers.layer, "introCutScene")
			--speak with oleg
			audioUtil.playMusic("oleg")
			model.dialog.startDialog("olegIntro")
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
		end
	)
end

--------------------------------------------------------------------------
--showHowToNavigateCutSceneForIntro
--Show the how to navigate intro cut scene and go to the olegIntro2 dialog
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.showHowToNavigateCutSceneForIntro()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			--show the intro cut scene
			model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "howToNavigate")
			model.dialog.startDialog("olegIntro2")
		end
	)
end

--------------------------------------------------------------------------
--skipToOlegIntro2
--skip to the olegIntro2 dialog without showing how to navigate
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.skipToOlegIntro2()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.dialog.startDialog("olegIntro2")
		end
	)
end
