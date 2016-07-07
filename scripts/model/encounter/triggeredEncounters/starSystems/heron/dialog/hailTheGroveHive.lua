--####################################
-- hailTheGroveHive.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when the player asks Charlie to hail the hive at The Grove.
--####################################

--namespace model.dialog

function model.dialog.hailTheGroveHive()
	local dialog = model.dialog.getDialog("hailTheGroveHive")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain, you really want me to try hailing that thing?  I don't think it even has a communicator."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "try" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("try", nil, nil, nil, nil,
		"Let's try to hail them.",
		"Alright, here we go.")

	return dialog
end
