--####################################
-- syrmaEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Syrma system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--hailSyrmaIII
--This encounter takes place when the player hails Syrma III
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailSyrmaIII()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("syrmaConsultant")
			model.dialog.startDialog("hailSyrmaIII")
			if gameState.quests.jarvisCoordinates.gaveActualCoordinates and not gameState.quests.jarvisCoordinates.comlete then
				audioUtil.playMusic("background")
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "charlieTalksToJarvis")
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("charlieHasJarvisCoordinates")
--				gameState.visibleStarMapLocations:add("chara")
				gameState.visibleStarMapLocations:add("castor")
				gameState.quests.jarvisCoordinates.comlete = true
			end
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
		end
	)
end
