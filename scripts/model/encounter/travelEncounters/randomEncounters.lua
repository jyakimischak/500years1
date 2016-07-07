--####################################
-- randomEncounters.lua
-- author: Jonas Yakimischak
--
-- This is the first time the player will encounter a pirate.
--####################################

--namespace model.encounter.travelEncounters

--------------------------------------------------------------------------
-- randomEncounter
--------------------------------------------------------------------------
function model.encounter.travelEncounters.randomEncounter()
	--we need to have encountered the pirates before random encounters begin and we must not be at the end of the game
	if not gameState.encounteredPirates or gameState.quests.yepp.backToArtemis then
		return false
	end
	
	--50% chance of a random encounter
	if math.random(1, 2) == 1 then
		return false
	end

	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			model.encounter.travelEncounters.shakeStarMap()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("charlieSaysShipsApproach")
			
			--we will always have met the llaxon and the pirates if this is a random encounter, then takataka will follow after meeting them
			--llaxon = 1
			--pirates = 2
			--takataka = 3
			local numEnemiesEncountered = 2
			if gameState.metTakataka then numEnemiesEncountered = numEnemiesEncountered + 1 end 
			
			local enemyEncountered = math.random(1, numEnemiesEncountered)

			if enemyEncountered == 1 then
				--llaxon
				audioUtil.playMusic("llaxon")
				model.dialog.startDialog("llaxonRandomEncounter")
				--based on the energy level of the ship give a different encounter
				if gameState.shipTotalEnergy == 4 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER) then
						return
					end
				elseif gameState.shipTotalEnergy == 5 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER) then
						return
					end
				elseif gameState.shipTotalEnergy == 6 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER) then
						return
					end
				elseif gameState.shipTotalEnergy == 7 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER) then
						return
					end
				else
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER,
						ships.LLAXON_FIGHTER) then
						return
					end
				end
			elseif enemyEncountered == 2 then
				--pirates
				audioUtil.playMusic("pirate")
				model.dialog.startDialog("pirateRandomEncounter")
				--based on the energy level of the ship give a different encounter
				if gameState.shipTotalEnergy == 4 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.PIRATE_FIGHTER) then
						return
					end
				elseif gameState.shipTotalEnergy == 5 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.PIRATE_FIGHTER,
						ships.PIRATE_MISSLE_FIGHTER) then
						return
					end
				elseif gameState.shipTotalEnergy == 6 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.PIRATE_FIGHTER,
						ships.PIRATE_FIGHTER,
						ships.PIRATE_MISSLE_FIGHTER) then
						return
					end
				elseif gameState.shipTotalEnergy == 7 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.PIRATE_FIGHTER,
						ships.PIRATE_FIGHTER,
						ships.PIRATE_MISSLE_FIGHTER,
						ships.PIRATE_MISSLE_FIGHTER) then
						return
					end
				else
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.PIRATE_FIGHTER,
						ships.PIRATE_FIGHTER,
						ships.PIRATE_FIGHTER,
						ships.PIRATE_MISSLE_FIGHTER,
						ships.PIRATE_MISSLE_FIGHTER,
						ships.PIRATE_MISSLE_FIGHTER) then
						return
					end
				end
			else
				--takataka
				audioUtil.playMusic("takataka")
				model.dialog.startDialog("takatakaRandomEncounter")
				--based on the energy level of the ship give a different encounter
				if gameState.shipTotalEnergy == 4 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_FIGHTER) then
						return
					end
				elseif gameState.shipTotalEnergy == 5 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_FIGHTER) then
						return
					end
				elseif gameState.shipTotalEnergy == 6 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_LARGE_FIGHTER) then
						return
					end
				elseif gameState.shipTotalEnergy == 7 then
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_LARGE_FIGHTER) then
						return
					end
				else
					if not battle.startABattle(
						battle.GENERIC_BATTLE_FIELD,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_FIGHTER,
						ships.TAKATAKA_LARGE_FIGHTER,
						ships.TAKATAKA_LARGE_FIGHTER) then
						return
					end
				end
			end
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.STAR_MAP_SCREEN)
			return
		end
	)
	return true
end
