--####################################
-- afterMeetingMary.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog when you hail Mary after having already met her.
--####################################

--namespace model.dialog

function model.dialog.afterMeetingMary()
	local dialog = model.dialog.getDialog("afterMeetingMary")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "mary.png"
	end

	function dialog:startDialog()
		return "Hi Captain.  Have you managed to find any human colonies yet?"
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
	dialog.optionsList:add("no", nil, nil, nil, nil,
		"No sorry.",
		"Oh well.  I'll keep my hopes up.  Thanks for checking in on me.")
	dialog.optionsList:add("bye", "no", nil, nil, nil,
		"Bye",
		"Farewell.")

	return dialog
end
