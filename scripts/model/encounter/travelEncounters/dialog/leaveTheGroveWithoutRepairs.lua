--####################################
-- leaveTheGroveWithoutRepairs.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for after the fight with the Hive at The Grove.  Then ships engines overload and Clarence asks to land.
--####################################

--namespace model.dialog

function model.dialog.leaveTheGroveWithoutRepairs()
	local dialog = model.dialog.getDialog("leaveTheGroveWithoutRepairs")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "clarenceWithGoat.png"
	end

	function dialog:startDialog()
		return "Captain, we can't travel without making repairs.  The ship could tear apart."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "headBack" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("headBack", nil, nil, nil, nil,
		"Alright Clarence, we'll head back.",
		"Captain.")

	return dialog
end
