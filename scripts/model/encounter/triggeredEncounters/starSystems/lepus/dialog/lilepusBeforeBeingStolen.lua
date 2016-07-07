--####################################
-- lilepusBeforeBeingStolen.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when lilepus when you talk to her before she has been stolen.
--####################################

--namespace model.dialog

function model.dialog.lilepusBeforeBeingStolen()
	local dialog = model.dialog.getDialog("lilepusBeforeBeingStolen")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "lilepus.png"
	end

	function dialog:startDialog()
		return "Hello strangers."
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
	dialog.optionsList:add("hello", nil, nil, nil, nil,
		"Hello Lilepus",
		"You should really speak with mommy.")
	dialog.optionsList:add("bye", "hello", nil, nil, nil,
		"We will.  Goodbye.",
		"Goodbye.")

	return dialog
end
