--####################################
-- antaresEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Antares system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--hailAntaresIII
--This encounter takes place when the player hails Antares III.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailAntaresIII()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			if not gameState.hailedAntaresIII then
				gameState.hailedAntaresIII = true
				audioUtil.playMusic("frank")
				model.dialog.startDialog("frankWarns")
				--back to the game
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				
			else
				audioUtil.playMusic("magistrate")
				model.dialog.startDialog("meetMagistrate")
				audioUtil.playMusic("background")
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "speakWithMagistrate")
				audioUtil.playMusic("magistrate")
				model.dialog.startDialog("magistrateAfterAskingForHelp")
				audioUtil.playMusic("background")
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "antaresShoreLeave")
				audioUtil.playMusic("magistrate")
				model.dialog.startDialog("magistrateLeaving")
				--head to artemis
				gameState.quests.yepp.backToArtemis = true
				audioUtil.playMusic("background")
				gameState.destination = "artemis"
				frontController.dispatch(frontController.STAR_MAP_SCREEN)
				screens.starMapScreen.moveShip()
				while gameState.traveling do
					coroutine.yield()
				end
				gameState.quests.yepp.backAtArtemis = true
			end

		end
	)
end

