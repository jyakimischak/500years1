--####################################
-- firstPirateEncounter.lua
-- author: Jonas Yakimischak
--
-- This is the first time the player will encounter a pirate.
--####################################

--namespace model.encounter.travelEncounters

--------------------------------------------------------------------------
-- firstPirateEncounter
--------------------------------------------------------------------------
function model.encounter.travelEncounters.firstPirateEncounter()
	--we will encounter the first pirate after aquiring Clarence.
	--this will also be the first pirate attack only
	if gameState.encounteredPirates or not gameState.crew.clarence then
		return false
	end

	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.encounter.travelEncounters.shakeStarMap()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("charlieSaysShipsApproach")
			audioUtil.playMusic("pirate")
			model.dialog.startDialog("firstPirateEncounter")
			--now battle the pirates
			if not battle.startABattle(
				battle.GENERIC_BATTLE_FIELD,
				ships.PIRATE_FIGHTER) then
				return
			end
			--fight over
			gameState.encounteredPirates = true			
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		end
	)
	return true
end
