--####################################
-- proctorDefault.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the proctor when he doesn't have much to say.
--####################################

--namespace model.dialog

function model.dialog.proctorDefault()
	local dialog = model.dialog.getDialog("proctorDefault")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "proctor.png"
	end

	function dialog:startDialog()
		return "Captain."
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
	dialog.optionsList:add("howAreThings", nil, nil, nil, nil,
		"How are things at the colony?",
		"We're holding out.\n\nSupplied should last quite a while but they won't last forever.\n\nWe're all counting on you captain.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"I'll contact you when I have more news.",
		"Good luck.")

	return dialog
end
