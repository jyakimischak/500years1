--####################################
-- charlieSaysBigShipApproaching.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for Charlie telling the captain that a large ship is approaching.
--####################################

--namespace model.dialog

function model.dialog.charlieSaysBigShipApproaching()
	local dialog = model.dialog.getDialog("charlieSaysBigShipApproaching")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain; there is a massive ship approaching us.  I recommend caution."
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
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Thank you.",
		"Captain.")

	return dialog
end
