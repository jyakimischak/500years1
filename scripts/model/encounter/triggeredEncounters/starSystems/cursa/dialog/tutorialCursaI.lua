--####################################
-- tutorialCursaI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the combat tutorial at cursa I.
--####################################

--namespace model.dialog

function model.dialog.tutorialCursaI()
	local dialog = model.dialog.getDialog("tutorialCursaI")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain, do you need me to explain the combat systems to you?"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "yes" or dialog.currentOption == "no" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("yes", nil, nil, nil,
		function()
			showCursaCombatTutorial = true
		end,
		"Yes",
		"Alright Captain...")
	dialog.optionsList:add("no", nil, nil, nil, nil,
		"No",
		"Alright.  Let's get them Captain!")

	return dialog
end
