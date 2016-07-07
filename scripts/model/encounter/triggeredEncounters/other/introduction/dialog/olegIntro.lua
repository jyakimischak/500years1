--####################################
-- olegIntro.lua
-- author: Jonas Yakimischak
--
-- This holds the introduction dialog for Oleg.
--####################################

--namespace model.dialog

function model.dialog.olegIntro()
	local dialog = model.dialog.getDialog("olegIntro")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "oleg.png"
	end

	function dialog:startDialog()
		return "We're off that rock friend. It finally feels like we're doing something...real.  Something our children will be proud of."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "bye" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("helpWithInterface", nil, nil, nil, nil,
		"How are you Oleg?",
		"I'm doing fine Captain.\n\nWould you like me to brief you on your ships navigation interface?")
	dialog.optionsList:add("helpWithInterfaceYes", "helpWithInterface", nil, nil,
		function()
			model.encounter.getTriggeredEncounter("showHowToNavigateCutSceneForIntro")
		end,
		"Yes",
		"")
	dialog.optionsList:add("helpWithInterfaceNo", "helpWithInterface", nil, nil,
		function()
			model.encounter.getTriggeredEncounter("skipToOlegIntro2")
		end,
		"No",
		"")

	return dialog
end
