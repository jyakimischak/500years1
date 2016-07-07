--####################################
-- leavingTheGroveBeforeKillingAnts.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when you leave the Grove during the Ant attack before killing the ants.
--####################################

--namespace model.dialog

function model.dialog.leavingTheGroveBeforeKillingAnts()
	local dialog = model.dialog.getDialog("leavingTheGroveBeforeKillingAnts")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "frank.png"
	end

	function dialog:startDialog()
		return "Captain!  The Grove is in danger, we have to help them!"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "headThere" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("headThere", nil, nil, nil, nil,
		"We'll head there immediately.",
		"Thank you Captain.")

	return dialog
end
