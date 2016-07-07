--####################################
-- llaxonRandomEncounter.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for a random encounter with the llaxon.
--####################################

--namespace model.dialog

function model.dialog.llaxonRandomEncounter()
	local dialog = model.dialog.getDialog("llaxonRandomEncounter")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "llaxonPilot.png"
	end

	function dialog:startDialog()
		return "HHrhehehhe.  HUMAN!  Clarence stealerssss.  We will board you now for Clarence and feasting!"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "noReturn" or dialog.currentOption == "die" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("die", nil, nil, nil, nil,
		"DIE!",
		"NO.")
	dialog.optionsList:add("why", nil, nil, nil, nil,
		"Why do you want Clarence?",
		"He must be returned.  We demand it!  He is ours.")
	dialog.optionsList:add("noReturn", nil, "why", nil, nil,
		"We can't give Clarence to you.",
		"Hahhehehehahheh.  Then you will be destroyed!")

	return dialog
end
