--####################################
-- francisMissing.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when Clarence says that Francis is missing.
--####################################

--namespace model.dialog

function model.dialog.francisMissing()
	local dialog = model.dialog.getDialog("francisMissing")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
	end

	function dialog:startDialog()
		return "Captain!  Have you seen Francis around anywheres?"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "going" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("no", nil, nil, nil, nil,
		"No I'm sorry I haven't.",
		"He's missing.  I don't think he'd a' run off.  We've been together a long time and he's never done that.")
	dialog.optionsList:add("lastSeen", nil, "no", nil, nil,
		"Where did you last see him.",
		"Last I seen him he was rummaging around in some old wiring...he like to chew on them.  I got busy with the repairs and I lost track "..
		"of him.")
	dialog.optionsList:add("goToShip", nil, "no", nil, nil,
		"Maybe he went back to the ship.",
		"Hmmm.  He might have I suppose.  Let's go check.")
	dialog.optionsList:add("call", nil, "goToShip", nil, nil,
		"I'll call the crew to help look.",
		"Thank you Captain.")
	dialog.optionsList:add("going", nil, "call", nil, nil,
		"Let's go.",
		"Ok.")

	return dialog
end
