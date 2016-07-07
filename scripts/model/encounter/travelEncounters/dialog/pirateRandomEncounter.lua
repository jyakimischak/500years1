--####################################
-- pirateRandomEncounter.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for a random encounter with the pirates.
--####################################

--namespace model.dialog

function model.dialog.pirateRandomEncounter()
	local dialog = model.dialog.getDialog("pirateRandomEncounter")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "pirate.png"
	end

	function dialog:startDialog()
		return "Disable your shields and prepare to be boarded."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "openFire" or dialog.currentOption == "must" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("openFire", nil, nil, nil, nil,
		"Charlie, open fire.",
		"Mistake...")
	dialog.optionsList:add("no", nil, nil, nil, nil,
		"We can't do that.",
		"Then we'll destroy you and pick through the carnage.")
	dialog.optionsList:add("must", nil, "no", nil, nil,
		"If you must.",
		"Sorry, it's not personal.")

	return dialog
end
