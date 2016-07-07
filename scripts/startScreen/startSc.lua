--####################################
-- startSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the start screen.
--####################################

--namespace screens.startScreen

screens.startScreen.pointerX = 0
screens.startScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.startScreen.pointerCallback(x, y)
	cursorHover = false

	screens.startScreen.pointerX, screens.startScreen.pointerY = screens.startScreen.layers.layer:wndToWorld(x, y)
	screens.startScreen.buttonList:pointer(screens.startScreen.pointerX, screens.startScreen.pointerY)

	if windowsBuild then
		screens.startScreen.buttonList:selectedVisible(false)
		xbox.mouseMoved(screens.startScreen.pointerX, x, screens.startScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.startScreen.clickCallback(down)
	local buttonName = screens.startScreen.buttonList:click(screens.startScreen.pointerX, screens.startScreen.pointerY, down)
	if buttonName == "new" then
--		frontController.dispatch(frontController.CREATE_CHARACTER_SCREEN)
--		return
		--we need to setup the game state for the beginning of the game
		gameState.currentLocation = "artemis"
		gameState.visibleStarMapLocations = util.getArrayList()
		gameState.visibleStarMapLocations:add("artemis")
		gameState.crew.oleg = true
		gameState.crew.charlie = true
		gameState.shipTotalEnergy = 4
--		gameState.shipTotalArmor = 5
--		gameState.pcWeapons.nuclearTorpedoes = true
--		gameState.pcEngines.level1 = true
--		gameState.pcComputer.level1 = true
--		gameState.pcShields.level1 = true
		gameState.pcShipEquippedWeapon = "nuclearTorpedoes"
		gameState.pcShipEquippedEngines = "enginesLevel1"
		gameState.pcShipEquippedComputer = "computerLevel1"
		gameState.pcShipEquippedShields = "shieldsLevel1"
		gameState.quests.theBeginning.started = true
		model.encounter.getTriggeredEncounter("introduction")
		return
	elseif buttonName == "continue" then
		screens.loadScreen.callingScreen = "startScreen"
		frontController.dispatch(frontController.LOAD_SCREEN)
		return
	elseif buttonName == "quit" then
		screens.quitConfirmScreen.callingScreen = "startScreen"
		frontController.dispatch(frontController.QUIT_CONFIRM_SCREEN)
		return
	--***************************************************************************************
	--***************************************************************************************
	-- TODO: remove these test functions
	--***************************************************************************************
	--***************************************************************************************
	elseif buttonName == "llaxon" then
		model.encounter.getTriggeredEncounter("llaxonTest")
	elseif buttonName == "pirate" then
		model.encounter.getTriggeredEncounter("pirateTest")
	elseif buttonName == "takataka" then
		model.encounter.getTriggeredEncounter("takatakaTest")
	elseif buttonName == "b1" then
		model.encounter.getTriggeredEncounter("llaxonDestroyerTest")
	elseif buttonName == "b2" then
		model.encounter.getTriggeredEncounter("pirateDestroyerTest")
	elseif buttonName == "b3" then
		model.encounter.getTriggeredEncounter("antHiveTest")
	elseif buttonName == "b4" then
		model.encounter.getTriggeredEncounter("humanDestroyerTest")
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.startScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if not xbox.leftThumbMoved and thumbLY < 0 then
		screens.startScreen.buttonList:selectNext()
		xbox.leftThumbMoved = true
	elseif not xbox.leftThumbMoved and thumbLY > 0 then
		screens.startScreen.buttonList:selectPrev()
		xbox.leftThumbMoved = true
	elseif xbox.leftThumbMoved and thumbLY == 0 then
		xbox.leftThumbMoved = false
	end
	screens.startScreen.buttonList:selectedVisible(true)
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local buttonName = screens.startScreen.buttonList:getSelected()
		if buttonName == "new" then
			--we need to setup the game state for the beginning of the game
			gameState.currentLocation = "artemis"
			gameState.visibleStarMapLocations = util.getArrayList()
			gameState.visibleStarMapLocations:add("artemis")
			gameState.crew.oleg = true
			gameState.crew.charlie = true
			gameState.shipTotalEnergy = 4
			gameState.pcShipEquippedWeapon = "nuclearTorpedoes"
			gameState.pcShipEquippedEngines = "enginesLevel1"
			gameState.pcShipEquippedComputer = "computerLevel1"
			gameState.pcShipEquippedShields = "shieldsLevel1"
			gameState.quests.theBeginning.started = true
			model.encounter.getTriggeredEncounter("introduction")
			return
		elseif buttonName == "continue" then
			screens.loadScreen.callingScreen = "startScreen"
			frontController.dispatch(frontController.LOAD_SCREEN)
			return
		elseif buttonName == "quit" then
			screens.quitConfirmScreen.callingScreen = "startScreen"
			frontController.dispatch(frontController.QUIT_CONFIRM_SCREEN)
			return
		end
	end
	
end