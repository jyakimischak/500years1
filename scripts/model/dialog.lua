--####################################
-- dialog.lua
-- author: Jonas Yakimischak
--
-- This holds sets up the requires for the dialogs in the game.
--####################################

--namespace model.dialog

---------------------
--shared dialogs
---------------------
require("scripts.model.encounter.dialog.charlieSaysShipsApproach")

---------------------
--triggered encounters for other
---------------------
--introduction
require("scripts.model.encounter.triggeredEncounters.other.introduction.dialog.olegIntro")
require("scripts.model.encounter.triggeredEncounters.other.introduction.dialog.olegIntro2")

---------------------
--triggered encounters for star systems
---------------------
--Alya star system
require("scripts.model.encounter.triggeredEncounters.starSystems.alya.dialog.scanAlyaI")
require("scripts.model.encounter.triggeredEncounters.starSystems.alya.dialog.llaxonAlyaI")
require("scripts.model.encounter.triggeredEncounters.starSystems.alya.dialog.probeAlyaI")
require("scripts.model.encounter.triggeredEncounters.starSystems.alya.dialog.meetMary")
require("scripts.model.encounter.triggeredEncounters.starSystems.alya.dialog.afterMeetingMary")
--Artemis star system
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.proctorTheBeginning")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.proctorSpeakWithClarence")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.proctorMakeRepairs")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.clarenceRepairsMade")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.speakWithJarvis")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.proctorDefault")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.llaxonDestroyer")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.proctorAfterLlaxonAttack")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.speakWithHumanDestroyer")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.noMatchForHumanDestroyer")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.noOneLeftAtArtemis")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.noOneLeftAtArtemis2")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.noOneLeftAtArtemis3")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.dialog.noOneLeftAtArtemis4")
--Cursa star system
require("scripts.model.encounter.triggeredEncounters.starSystems.cursa.dialog.llaxonLeader")
require("scripts.model.encounter.triggeredEncounters.starSystems.cursa.dialog.scanCursaI")
require("scripts.model.encounter.triggeredEncounters.starSystems.cursa.dialog.launchCursaI")
require("scripts.model.encounter.triggeredEncounters.starSystems.cursa.dialog.hailCursaI")
require("scripts.model.encounter.triggeredEncounters.starSystems.cursa.dialog.cursaILlaxonAttack")
require("scripts.model.encounter.triggeredEncounters.starSystems.cursa.dialog.tutorialCursaI")
--Pollux star system
require("scripts.model.encounter.triggeredEncounters.starSystems.pollux.dialog.ungiriFirstMeeting")
--Vulpecula star system
require("scripts.model.encounter.triggeredEncounters.starSystems.vulpecula.dialog.takatakaHomeWorldFirstMeeting")
require("scripts.model.encounter.triggeredEncounters.starSystems.vulpecula.dialog.meetJarvis")
require("scripts.model.encounter.triggeredEncounters.starSystems.vulpecula.dialog.charlieAfterWeGetJarvis")
require("scripts.model.encounter.triggeredEncounters.starSystems.vulpecula.dialog.hailVulpeculaI")
require("scripts.model.encounter.triggeredEncounters.starSystems.vulpecula.dialog.takatakaHomeWorldWithJarvis")
--Syrma star system
require("scripts.model.encounter.triggeredEncounters.starSystems.syrma.dialog.hailSyrmaIII")
require("scripts.model.encounter.triggeredEncounters.starSystems.syrma.dialog.charlieHasJarvisCoordinates")
--Castor star system
require("scripts.model.encounter.triggeredEncounters.starSystems.castor.dialog.hailCastorIBefore")
require("scripts.model.encounter.triggeredEncounters.starSystems.castor.dialog.ungiriWillMovePlanet")
require("scripts.model.encounter.triggeredEncounters.starSystems.castor.dialog.planetHasBeenMoved")
require("scripts.model.encounter.triggeredEncounters.starSystems.castor.dialog.castorAfter")
--Lepus star system
require("scripts.model.encounter.triggeredEncounters.starSystems.lepus.dialog.scanLepusI")
require("scripts.model.encounter.triggeredEncounters.starSystems.lepus.dialog.lepusMeeting")
require("scripts.model.encounter.triggeredEncounters.starSystems.lepus.dialog.scanLepusII")
require("scripts.model.encounter.triggeredEncounters.starSystems.lepus.dialog.talkToMommy")
require("scripts.model.encounter.triggeredEncounters.starSystems.lepus.dialog.scanLepusOther")
require("scripts.model.encounter.triggeredEncounters.starSystems.lepus.dialog.lilepusBeforeBeingStolen")
--Heron star system
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.dialog.meetFrank")
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.dialog.askClarence")
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.dialog.meetYepp")
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.dialog.hailTheGroveHive")
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.dialog.theGroveHive")
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.dialog.damagedShipDuringHiveFight")
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.dialog.francisMissing")
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.dialog.francisDead")
--Antares star system
require("scripts.model.encounter.triggeredEncounters.starSystems.antares.dialog.frankWarns")
require("scripts.model.encounter.triggeredEncounters.starSystems.antares.dialog.meetMagistrate")
require("scripts.model.encounter.triggeredEncounters.starSystems.antares.dialog.magistrateAfterAskingForHelp")
require("scripts.model.encounter.triggeredEncounters.starSystems.antares.dialog.magistrateLeaving")
--Hydra star system
require("scripts.model.encounter.triggeredEncounters.starSystems.hydra.dialog.scanHydraI")
require("scripts.model.encounter.triggeredEncounters.starSystems.hydra.dialog.minedHydraI")

---------------------
--triggered encounters for crew
---------------------
--Oleg
require("scripts.model.encounter.triggeredEncounters.crew.oleg.dialog.olegDefault")
--Charlie
require("scripts.model.encounter.triggeredEncounters.crew.charlie.dialog.charlieDefault")
--Clarence
require("scripts.model.encounter.triggeredEncounters.crew.clarence.dialog.clarenceBeforeRepairs")
require("scripts.model.encounter.triggeredEncounters.crew.clarence.dialog.clarenceDefault")
--Jarvis
require("scripts.model.encounter.triggeredEncounters.crew.jarvis.dialog.jarvisResortCoordinates")
require("scripts.model.encounter.triggeredEncounters.crew.jarvis.dialog.jarvisDefault")
--Frank
require("scripts.model.encounter.triggeredEncounters.crew.frank.dialog.frankDefault")
--Yepp
require("scripts.model.encounter.triggeredEncounters.crew.yepp.dialog.yeppDefault")

---------------------
--travel encounters
---------------------
require("scripts.model.encounter.travelEncounters.dialog.firstPirateEncounter")
require("scripts.model.encounter.travelEncounters.dialog.antsAreAttackingTheGrove")
require("scripts.model.encounter.travelEncounters.dialog.leavingTheGroveBeforeKillingAnts")
require("scripts.model.encounter.travelEncounters.dialog.leaveTheGroveWithoutRepairs")
require("scripts.model.encounter.travelEncounters.dialog.llaxonRandomEncounter")
require("scripts.model.encounter.travelEncounters.dialog.pirateRandomEncounter")
require("scripts.model.encounter.travelEncounters.dialog.takatakaRandomEncounter")
require("scripts.model.encounter.travelEncounters.dialog.llaxonDestroyerDistress")
require("scripts.model.encounter.travelEncounters.dialog.leavingArtemisBeforeKillingLlaxon")
require("scripts.model.encounter.travelEncounters.dialog.pirateDestroyerEncounter")
require("scripts.model.encounter.travelEncounters.dialog.charlieSaysBigShipApproaching")
require("scripts.model.encounter.travelEncounters.dialog.leavingArtemisAtEnd")

--------------------------------------------------------------------------
--startDialog
--start the given dialog 
--------------------------------------------------------------------------
function model.dialog.startDialog(dialog)
	local durationBeforeFade = 2
	local fadeDuration = 2

	gameState.dialog = dialog
	frontController.dispatch(frontController.DIALOG_SCREEN)
	while not screens.dialogScreen.dialog:isDialogComplete() do
		coroutine.yield()
	end
	screenUtil.wait(durationBeforeFade)
	screenUtil.fadeScreen(screens.dialogScreen.layers.layer, fadeDuration)
--	gameState.dialog = nil
end


--------------------------------------------------------------------------
--getOptionsList
--This will return the object that holds the options list.
--This is an extension of a util.getArrayList object.
--------------------------------------------------------------------------
function model.dialog.getOptionsList()
	local optionsList = {}
	optionsList.optionsArrayList = util.getArrayList()
	
	--------------------------------------------------------------------------
	--add an option to the optionsList
	--name is the function name of the option
	--parent is the parent's function name
	--wasSelected is the function name of an option that must have been selected before this option will appear
	--conditionFunction is a function that will return a boolean and evaluate an additional condition that must be met before the option is displayed
	--actionFunction is a function that will be executed if this option is selected
	--question is the string for the question posed by the pc to the npc
	--response is the response from the npc for this question
	--------------------------------------------------------------------------
	function optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
		local option = {}
		option.name = name
		option.parent = parent
		option.wasSelected = wasSelected
		option.conditionFunction = conditionFunction
		option.actionFunction = actionFunction
		option.question = question
		option.response = response
		
		self.optionsArrayList:add(option)
	end

	--------------------------------------------------------------------------
	--returns the object at the given index 
	--------------------------------------------------------------------------
	function optionsList:get(index)
		return self.optionsArrayList[index]
	end

	--------------------------------------------------------------------------
	--returns the length of the optionsArrayList 
	--------------------------------------------------------------------------
	function optionsList:getLength()
		return self.optionsArrayList.length
	end

	return optionsList
end


--------------------------------------------------------------------------
--getDialog
--this is the base object for all dialogs
--
--functions extending this will be in the individual dialog files under the model.dialog
--folder.
--optionsList this is a list of all the options in the order they should appear 
--selectedOptions this is an object that will hold keys to options that have been selected
--getOptions() will return a list of the options available at this time
--the following functions must be implemented by the extending class
--getPortrait() will return the deck, names list and index for the portrait
--startDialog() will return the greeting
--isDialogComplete() true if the dialog is complete
--------------------------------------------------------------------------
function model.dialog.getDialog(functionName)
	local dialog = {}
	dialog.functionName = functionName
	dialog.currentOption = nil
	dialog.optionsList = model.dialog.getOptionsList()
	dialog.options = {}
	dialog.selectedOptions = {}


	--------------------------------------------------------------------------
	--run through all the options and see if they will be displayed.  If they are displayed then put them into the return
	--list and return them.
	--------------------------------------------------------------------------
	function dialog:getOptions()
		local option = nil
		local returnList = util.getArrayList()
		local hasChildren = false
		--if the dialog has ended then just return an empty list
		if self:isDialogComplete() then
			return returnList
		end
		--check if the currently selected option has any children.  If it does then only the children should be displayed
		if dialog.currentOption ~= nil then
			for i=1, self.optionsList:getLength() do
				option = self.optionsList:get(i)
				if dialog.currentOption == option.parent then
					hasChildren = true
					break
				end
			end
		end
		--go through all the options and add the ones that will be displayed to the returnList		
		for i=1, self.optionsList:getLength() do
			option = self.optionsList:get(i)
			--an option can only be selected once
			if dialog.selectedOptions[option.name] == nil then
				--if there is a condition functions set check it first
				if option.conditionFunction == nil or (option.conditionFunction ~= nil and option.conditionFunction()) then
					--now check if an option must have been selected for this one to be displayed
					if option.wasSelected == nil or (option.wasSelected ~= nil and dialog.selectedOptions[option.wasSelected] ~= nil) then
						--finally check if this option has a parent...if the current option is the parent then this one will be displayed
						if (not hasChildren and option.parent == nil) or (option.parent ~= nil and dialog.currentOption == option.parent) then
							local returnOption = {}
							returnOption.name = option.name
							returnOption.question = option.question
							returnOption.response = option.response
							returnList:add(returnOption)
						end
					end
				end
			end
		end
		return returnList
	end

	--------------------------------------------------------------------------
	--select the option, call it's action function and return it's information
	--------------------------------------------------------------------------
	function dialog:selectOption(name)
		local option = nil
		for i=1, self.optionsList:getLength() do
			option = self.optionsList:get(i)
			if option.name == name then
				break
			end
		end
		self.currentOption = name
		self.selectedOptions[name] = true
		
		local returnOption = {}
		returnOption.name = option.name
		returnOption.question = option.question
		returnOption.response = option.response
		returnOption.actionFunction = option.actionFunction
		
		return returnOption
	end


	return dialog
end
