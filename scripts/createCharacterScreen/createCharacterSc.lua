--####################################
-- createCharacterSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the create character screen.
--####################################

--namespace screens.createCharacterScreen

screens.createCharacterScreen.pointerX = 0
screens.createCharacterScreen.pointerY = 0

screens.createCharacterScreen.GENDER_MALE = "male"
screens.createCharacterScreen.GENDER_FEMALE = "female"
screens.createCharacterScreen.selectedGender = nil

screens.createCharacterScreen.PROFESSION_DIPLOMAT = "diplomat"
screens.createCharacterScreen.PROFESSION_DOCTOR = "doctor"
screens.createCharacterScreen.PROFESSION_ENGINEER = "engineer"
screens.createCharacterScreen.PROFESSION_PILOT = "pilot"
screens.createCharacterScreen.PROFESSION_SOLDIER = "soldier"
screens.createCharacterScreen.selectedProfession = nil

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.createCharacterScreen.pointerCallback(x, y)
	screens.createCharacterScreen.pointerX, screens.createCharacterScreen.pointerY = screens.createCharacterScreen.layers.layer:wndToWorld(x, y)
	screens.createCharacterScreen.buttonList:pointer(screens.createCharacterScreen.pointerX, screens.createCharacterScreen.pointerY)
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.createCharacterScreen.clickCallback(down)
	local clickablePropName = screens.createCharacterScreen.clickablePropList:click(screens.createCharacterScreen.pointerX, screens.createCharacterScreen.pointerY, down)
	if clickablePropName == screens.createCharacterScreen.GENDER_MALE then
		screens.createCharacterScreen.selectedGender = screens.createCharacterScreen.GENDER_MALE
		screens.createCharacterScreen.props.unCheckedMaleProp:setVisible(false)
		screens.createCharacterScreen.props.checkedMaleProp:setVisible(true)
		screens.createCharacterScreen.props.unCheckedFemaleProp:setVisible(true)
		screens.createCharacterScreen.props.checkedFemaleProp:setVisible(false)
		screens.createCharacterScreen.genderSelected = true
		gameState.gender = "male"
	elseif clickablePropName == screens.createCharacterScreen.GENDER_FEMALE then
		screens.createCharacterScreen.selectedGender = screens.createCharacterScreen.GENDER_FEMALE
		screens.createCharacterScreen.props.unCheckedMaleProp:setVisible(true)
		screens.createCharacterScreen.props.checkedMaleProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedFemaleProp:setVisible(false)
		screens.createCharacterScreen.props.checkedFemaleProp:setVisible(true)
		screens.createCharacterScreen.genderSelected = true
		gameState.gender = "female"
	elseif clickablePropName == screens.createCharacterScreen.PROFESSION_DIPLOMAT then
		screens.createCharacterScreen.selectedProfession = screens.createCharacterScreen.PROFESSION_DIPLOMAT
		screens.createCharacterScreen.props.unCheckedDiplomatProp:setVisible(false)
		screens.createCharacterScreen.props.checkedDiplomatProp:setVisible(true)
		screens.createCharacterScreen.props.unCheckedDoctorProp:setVisible(true)
		screens.createCharacterScreen.props.checkedDoctorProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedEngineerProp:setVisible(true)
		screens.createCharacterScreen.props.checkedEngineerProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedPilotProp:setVisible(true)
		screens.createCharacterScreen.props.checkedPilotProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedSoldierProp:setVisible(true)
		screens.createCharacterScreen.props.checkedSoldierProp:setVisible(false)
		screens.createCharacterScreen.professionSelected = true
		gameState.profession = "diplomat"
	elseif clickablePropName == screens.createCharacterScreen.PROFESSION_DOCTOR then
		screens.createCharacterScreen.selectedProfession = screens.createCharacterScreen.PROFESSION_DOCTOR
		screens.createCharacterScreen.props.unCheckedDiplomatProp:setVisible(true)
		screens.createCharacterScreen.props.checkedDiplomatProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedDoctorProp:setVisible(false)
		screens.createCharacterScreen.props.checkedDoctorProp:setVisible(true)
		screens.createCharacterScreen.props.unCheckedEngineerProp:setVisible(true)
		screens.createCharacterScreen.props.checkedEngineerProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedPilotProp:setVisible(true)
		screens.createCharacterScreen.props.checkedPilotProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedSoldierProp:setVisible(true)
		screens.createCharacterScreen.props.checkedSoldierProp:setVisible(false)
		screens.createCharacterScreen.professionSelected = true
		gameState.profession = "doctor"
	elseif clickablePropName == screens.createCharacterScreen.PROFESSION_ENGINEER then
		screens.createCharacterScreen.selectedProfession = screens.createCharacterScreen.PROFESSION_ENGINEER
		screens.createCharacterScreen.props.unCheckedDiplomatProp:setVisible(true)
		screens.createCharacterScreen.props.checkedDiplomatProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedDoctorProp:setVisible(true)
		screens.createCharacterScreen.props.checkedDoctorProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedEngineerProp:setVisible(false)
		screens.createCharacterScreen.props.checkedEngineerProp:setVisible(true)
		screens.createCharacterScreen.props.unCheckedPilotProp:setVisible(true)
		screens.createCharacterScreen.props.checkedPilotProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedSoldierProp:setVisible(true)
		screens.createCharacterScreen.props.checkedSoldierProp:setVisible(false)
		screens.createCharacterScreen.professionSelected = true
		gameState.profession = "engineer"
	elseif clickablePropName == screens.createCharacterScreen.PROFESSION_PILOT then
		screens.createCharacterScreen.selectedProfession = screens.createCharacterScreen.PROFESSION_PILOT
		screens.createCharacterScreen.props.unCheckedDiplomatProp:setVisible(true)
		screens.createCharacterScreen.props.checkedDiplomatProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedDoctorProp:setVisible(true)
		screens.createCharacterScreen.props.checkedDoctorProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedEngineerProp:setVisible(true)
		screens.createCharacterScreen.props.checkedEngineerProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedPilotProp:setVisible(false)
		screens.createCharacterScreen.props.checkedPilotProp:setVisible(true)
		screens.createCharacterScreen.props.unCheckedSoldierProp:setVisible(true)
		screens.createCharacterScreen.props.checkedSoldierProp:setVisible(false)
		screens.createCharacterScreen.professionSelected = true
		gameState.profession = "pilot"
	elseif clickablePropName == screens.createCharacterScreen.PROFESSION_SOLDIER then
		screens.createCharacterScreen.selectedProfession = screens.createCharacterScreen.PROFESSION_SOLDIER
		screens.createCharacterScreen.props.unCheckedDiplomatProp:setVisible(true)
		screens.createCharacterScreen.props.checkedDiplomatProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedDoctorProp:setVisible(true)
		screens.createCharacterScreen.props.checkedDoctorProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedEngineerProp:setVisible(true)
		screens.createCharacterScreen.props.checkedEngineerProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedPilotProp:setVisible(true)
		screens.createCharacterScreen.props.checkedPilotProp:setVisible(false)
		screens.createCharacterScreen.props.unCheckedSoldierProp:setVisible(false)
		screens.createCharacterScreen.props.checkedSoldierProp:setVisible(true)
		screens.createCharacterScreen.professionSelected = true
		gameState.profession = "soldier"
	end
	
	local buttonName = screens.createCharacterScreen.buttonList:click(screens.createCharacterScreen.pointerX, screens.createCharacterScreen.pointerY, down)
	if buttonName == "back" then
		frontController.dispatch(frontController.START_SCREEN)
		return
	end
	if screens.createCharacterScreen.professionSelected and screens.createCharacterScreen.professionSelected then
		if not screens.createCharacterScreen.beginVisible then
			screens.createCharacterScreen.props.beginButtonProp:setVisible(true)
			screens.createCharacterScreen.buttonList:addButton("begin", screens.createCharacterScreen.props.beginButtonProp, screens.createCharacterScreen.props.beginButtonPressedProp)
			screens.createCharacterScreen.beginVisible = true
		end 
	
		if buttonName == "begin" then
			--we need to setup the game state for the beginning of the game
			gameState.currentLocation = "artemis"
			gameState.visibleStarMapLocations = util.getArrayList()
			gameState.visibleStarMapLocations:add("artemis")
--			gameState.visibleStarMapLocations:add("cursa")
			gameState.crew.oleg = true
			gameState.crew.charlie = true
			gameState.shipTotalEnergy = 4
	--		gameState.shipTotalEnergy = 10
			gameState.shipTotalArmor = 5
			gameState.pcWeapons.nuclearTorpedoes = true
	--		gameState.pcWeapons.laserBeam = true
	--		gameState.pcWeapons.miniGun = true
	--		gameState.pcWeapons.fissionTorpedoes = true
	--		gameState.pcWeapons.ionBeam = true
	--		gameState.pcWeapons.massDriver = true
	--		gameState.pcWeapons.antiMatterTorpedoes = true
	--		gameState.pcWeapons.plasmaCannon = true
	--		gameState.pcWeapons.coilGun = true
			gameState.pcEngines.level1 = true
	--		gameState.pcEngines.level2 = true
	--		gameState.pcEngines.level3 = true
			gameState.pcComputer.level1 = true
	--		gameState.pcComputer.level2 = true
	--		gameState.pcComputer.level3 = true
			gameState.pcShields.level1 = true
	--		gameState.pcShields.level2 = true
	--		gameState.pcShields.level3 = true
			gameState.pcShipEquippedWeapon = "nuclearTorpedoes"
			gameState.pcShipEquippedEngines = "enginesLevel1"
			gameState.pcShipEquippedComputer = "computerLevel1"
			gameState.pcShipEquippedShields = "shieldsLevel1"
			gameState.quests.theBeginning.started = true
	--		gameState.quests.c1q2.started = true
	--		gameState.quests.c1q3.started = true
	--		gameState.quests.c1q4.started = true
	--		gameState.quests.c1q5.started = true
	--		gameState.quests.c1q6.started = true


			model.encounter.getTriggeredEncounter("introduction")
	
			
	--		--now displatch to the start screen TEMPORARILY
	--		frontController.dispatch(frontController.STAR_MAP_SCREEN)
	--		return
		end
	end
end
