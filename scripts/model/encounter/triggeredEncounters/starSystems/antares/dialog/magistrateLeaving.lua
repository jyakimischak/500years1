--####################################
-- magistrateLeaving.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when the magistrate sends you off back home.
--####################################

--namespace model.dialog

function model.dialog.magistrateLeaving()
	local dialog = model.dialog.getDialog("magistrateLeaving")

	function dialog:getPortrait()
		if dialog.currentOption == "thankYou" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return charactersGfxQuads, charactersNames, "magistrate.png"
		end
	end

	function dialog:startDialog()
		return "The day has finally come for you to leave us and head back home.  We do hope that you enjoyed your time here and that you will visit.\n\n"..
		"Your Proctor is excited to have you back."
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
	dialog.optionsList:add("thankYou", nil, nil, nil, nil,
		"Thank you.",
		"Yes, thank you Magistrate.  We'll remember our time here fondly.")
	dialog.optionsList:add("bye", "thankYou", nil, nil, nil,
		"Good bye",
		"Safe journey Captain.")

	return dialog
end
