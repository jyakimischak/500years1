--####################################
-- castorAfter.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking with the Malvar after everything.
--####################################

--namespace model.dialog

function model.dialog.castorAfter()
	local dialog = model.dialog.getDialog("castorAfter")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "malvarWithoutCoat.png"
	end

	function dialog:startDialog()
		return "Thank you again Captain, and good luck!."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "thanks" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("thanks", nil, nil, nil, nil,
		"Thank you.",
		"Goodbye.")

	return dialog
end
