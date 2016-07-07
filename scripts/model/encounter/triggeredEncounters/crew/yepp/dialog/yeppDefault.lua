--####################################
-- yeppDefault.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when speaking with Yepp.
--####################################

--namespace model.dialog

function model.dialog.yeppDefault()
	local dialog = model.dialog.getDialog("yeppDefault")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "yepp.png"
	end

	function dialog:startDialog()
		return "Yep yepp?"
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
	dialog.optionsList:add("parents", nil, nil, nil, nil,
		"Do you have parents?",
		"Yepp!")
	dialog.optionsList:add("ship", nil, nil, nil, nil,
		"Why are you on the ship?",
		"Yepp.  yepp.  yeppppp.")
	dialog.optionsList:add("yepp", nil, nil, nil, nil,
		"Yepp?",
		"YEPP! Yepp, yep.  Yeppp yepp.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Good talking with you.",
		"Yepp.")

	return dialog
end
