--####################################
-- proctorMakeRepairs.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the proctor when you go back to artemis after Clarence has agreed to assist with repairing the ship and
-- supplying you with star maps.
--####################################

--namespace model.dialog

function model.dialog.proctorMakeRepairs()
	local dialog = model.dialog.getDialog("proctorMakeRepairs")

	function dialog:getPortrait()
		if dialog.currentOption == "clarenceHelp2" then
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		else
			return charactersGfxQuads, charactersNames, "proctor.png"
		end
	end

	function dialog:startDialog()
		return "Captain."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "clarenceHelp4" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("clarenceHelp", nil, nil, nil, nil,
		"Clarence has agreed to help us.",
		"Good news.  We're in your dept Clarence.  Is there anything you need?")
	dialog.optionsList:add("clarenceHelp2", "clarenceHelp", nil, nil, nil,
		"(continue)...",
		"Just a quiet place to work; thank you.")
	dialog.optionsList:add("clarenceHelp3", "clarenceHelp2", nil, nil, nil,
		"(continue)...",
		"I'm sure we can arrange that.  Captain, land when you're ready.")
	dialog.optionsList:add("clarenceHelp4", "clarenceHelp3", nil, nil, nil,
		"See you soon.",
		"Take care.")

	return dialog
end
