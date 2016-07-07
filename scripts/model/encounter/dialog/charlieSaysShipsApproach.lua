--####################################
-- charlieSaysShipsApproach.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for Charlie telling the captain that ships are approaching.
--####################################

--namespace model.dialog

function model.dialog.charlieSaysShipsApproach()
	local dialog = model.dialog.getDialog("charlieSaysShipsApproach")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain; ships are approaching.  I recommend caution."
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
