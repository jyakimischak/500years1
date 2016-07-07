--####################################
-- lepusEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains all of the triggered encounters for the Lepus system.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--scanLepusI
--This encounter takes place when the player has not yet met Lepus and scans it
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.scanLepusI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			gameState.metLepus = true
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("scanLepusI")
			audioUtil.playMusic("lepus")
			model.dialog.startDialog("lepusMeeting")
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
			return
		end
	)
end

--------------------------------------------------------------------------
--hailLepusI
--This encounter takes place after the player has already met Lepus and hails her
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailLepusI()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("lepus")
			if not gameState.quests.malvarPlanet.movedPlanet then
				model.dialog.startDialog("lepusMeeting")
			else
				model.dialog.startDialog("stoleLilpeus")
			end
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
			return
		end
	)
end

--------------------------------------------------------------------------
--scanLepusII
--This encounter takes place when the player has not yet met Lepus and scans Lilepus
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.scanLepusII()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("scanLepusII")
			audioUtil.playMusic("lepus")
			model.dialog.startDialog("talkToMommy")
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
			return
		end
	)
end

--------------------------------------------------------------------------
--hailLepusII
--This encounter takes place when the player has already met lepus and talks to lilepus
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.hailLepusII()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("lepus")
			if not gameState.quests.malvarPlanet.movedPlanet then
				model.dialog.startDialog("lilepusBeforeBeingStolen")
			end
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
			return
		end
	)
end

--------------------------------------------------------------------------
--scanLepusOther
--This encounter takes place when the player has not yet met Lepus and scans one of the other planets in the lepus system
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.scanLepusOther()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			audioUtil.playMusic("charlie")
			model.dialog.startDialog("scanLepusOther")
			audioUtil.playMusic("background")
			frontController.dispatch(frontController.PLANET_SCREEN)
			return
		end
	)
end
