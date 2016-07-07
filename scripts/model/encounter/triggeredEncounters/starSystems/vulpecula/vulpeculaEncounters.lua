--####################################
-- vulpeculaEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Vulpecula system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--hailVulpeculaI
--This encounter takes place when the player hails vulpecula 1 (the takataka ambassador world)
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailVulpeculaI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("hailVulpeculaI")
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
			return
		end
	)
end

--------------------------------------------------------------------------
--hailVulpeculaIII
--This encounter takes place when the player hails vulpeculaIII, the takataka home world.
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailVulpeculaIII()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			--------------------------------------------------------------------------
			--if Jarvis is not in your crew
			--------------------------------------------------------------------------
			if not gameState.crew.jarvis then
				gameState.metTakataka = true
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("charlieSaysShipsApproach")

				audioUtil.playMusic("takataka")
				model.dialog.startDialog("takatakaHomeWorldFirstMeeting")

				audioUtil.playMusic("background")
				model.cutScenes.playCutScene(screens.dialogScreen.layers.layer, "jarvisArrives")
				audioUtil.playMusic("jarvis")
				model.dialog.startDialog("meetJarvis")

				--now battle
				if not battle.startABattle(
					battle.GENERIC_BATTLE_FIELD,
					ships.TAKATAKA_FIGHTER,
					ships.TAKATAKA_FIGHTER) then
					return
				end
				
				--talk to Charlie about Jarvis
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("charlieAfterWeGetJarvis")
				
				gameState.crew.jarvis = true
				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return
			end

			--------------------------------------------------------------------------
			--Jarvis is in your crew
			--------------------------------------------------------------------------
			if gameState.crew.jarvis then
				audioUtil.playMusic("charlie")
				model.dialog.startDialog("charlieSaysShipsApproach")

				audioUtil.playMusic("takataka")
				model.dialog.startDialog("takatakaHomeWorldWithJarvis")
				
				--now battle
--TODO: fix this after encounters are done
				if not battle.startABattle(
					battle.GENERIC_BATTLE_FIELD,
					ships.TAKATAKA_FIGHTER,
					ships.TAKATAKA_FIGHTER,
					ships.TAKATAKA_FIGHTER,
					ships.TAKATAKA_FIGHTER,
					ships.TAKATAKA_FIGHTER,
					ships.TAKATAKA_FIGHTER,
					ships.TAKATAKA_FIGHTER) then
					return
				end

				audioUtil.playMusic("background")
				frontController.dispatch(frontController.PLANET_SCREEN)
				return
			end
		end
	)
end
