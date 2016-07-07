--####################################
-- castorEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Castor system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--hailCastorI
--This encounter takes place when the player hails castor 1, the Malvar homeworld
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailCastorI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			--------------------------------------------------------------------------
			--If we have not yet helped the Malvar by moving their planet
			--------------------------------------------------------------------------
			if not gameState.quests.malvarPlanet.ungiriAgreedToMovePlanet and not gameState.quests.malvarPlanet.movedPlanet then
				gameState.metMalvar = true
				audioUtil.playMusic("malvarBefore")
				model.dialog.startDialog("hailCastorIBefore")

			--------------------------------------------------------------------------
			--The Ungiri agreed to move the planet but it has not yet been moved
			--------------------------------------------------------------------------
			elseif gameState.quests.malvarPlanet.ungiriAgreedToMovePlanet and not gameState.quests.malvarPlanet.movedPlanet then
				audioUtil.playMusic("malvarBefore")
				gameState.quests.malvarPlanet.movedPlanet = true
				model.dialog.startDialog("ungiriWillMovePlanet")
				--show the cut scene
				audioUtil.playMusic("background")
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "planetIsMoved")
				--add the new star systems
				gameState.visibleStarMapLocations:add("heron")
				--talk to the Malvar after the planet has been moved
				audioUtil.playMusic("malvarAfter")
				model.dialog.startDialog("planetHasBeenMoved")
			else
				audioUtil.playMusic("malvarAfter")
				model.dialog.startDialog("castorAfter")
			end

			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
		end
	)
end
