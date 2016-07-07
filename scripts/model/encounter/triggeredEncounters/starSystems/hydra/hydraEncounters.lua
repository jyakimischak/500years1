--####################################
-- hydraEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Hydra system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--scanHydraI
--This encounter takes place when the player scans the planet in the Hydra system.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.scanHydraI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("scanHydraI")
			gameState.scannedHydraI = true
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
			return
		end
	)
end

--------------------------------------------------------------------------
--landHydraI
--This encounter takes place if the player chooses to land on Hydra I.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.landHydraI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.cutScenes.playCutScene(screens.planetScreen.layers.screenLayer, "landOnHydraI")
			audioUtil.playMusic("clarence")
			model.dialog.startDialog("minedHydraI")
			gameState.landedHydraI = true
			--the armor is lowered by landed on the planet by 10%
			gameState.shipTotalArmor = gameState.shipTotalArmor * .9
			--the minerals allow the ship to have an additional point of energy
			gameState.shipTotalEnergy = gameState.shipTotalEnergy + 1
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
			return
		end
	)
end
