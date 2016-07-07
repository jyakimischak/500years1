--####################################
-- startGameEncounter.lua
-- author: Jonas Yakimischak
--
-- This file is the triggered encounter for starting the game!
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--startGame
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.startGame()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
--------------------------------------------------------------
--IF YOU NEED TO TEST A CONVERSATION		
--newGameState()
--model.dialog.startDialog("hailCastorIBefore")

--------------------------------------------------------------
-- Used to test texture loading
--newGameState()
--gameState.currentLocation = "artemis"
--gameState.visibleStarMapLocations = util.getArrayList()
--gameState.visibleStarMapLocations:add("artemis")
--gameState.crew.oleg = true
--gameState.crew.charlie = true
--gameState.shipTotalEnergy = 4
--gameState.pcShipEquippedWeapon = "nuclearTorpedoes"
--gameState.pcShipEquippedEngines = "enginesLevel1"
--gameState.pcShipEquippedComputer = "computerLevel1"
--gameState.pcShipEquippedShields = "shieldsLevel1"
--gameState.quests.theBeginning.started = true
--textureUtil.loadTextures(textureUtil.NON_COMBAT)
--while(true) do
--	frontController.dispatch(frontController.CREW_LIST_SCREEN)
----	for i=1,10 do
--		coroutine.yield()
----	end
--	frontController.dispatch(frontController.STAR_MAP_SCREEN)
----	for i=1,10 do
--		coroutine.yield()
----	end
--	textureUtil.loadTextures(textureUtil.COMBAT)
--	textureUtil.loadTextures(textureUtil.INTRO)
--	textureUtil.loadTextures(textureUtil.TUTORIAL)
--	textureUtil.loadTextures(textureUtil.OUTRO)
--	textureUtil.loadLlaxon()
--	textureUtil.loadLlaxonDestroyer()
--	textureUtil.loadPirate()
--	textureUtil.loadPirateDestroyer()
--	textureUtil.loadTakataka()
--	textureUtil.loadAntHive()
--	textureUtil.loadHumanDestroyer()
--	textureUtil.loadTextures(textureUtil.NON_COMBAT)
--end


			while not splashScreenIntroComplete do
				coroutine.yield()
			end
			textureUtil.loadTextures(textureUtil.NON_COMBAT)
			frontController.dispatch(frontController.START_SCREEN)
		end
	)
end

