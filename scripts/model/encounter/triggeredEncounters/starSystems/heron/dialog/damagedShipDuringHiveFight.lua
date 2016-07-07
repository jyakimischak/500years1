--####################################
-- damagedShipDuringHiveFight.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for after the fight with the Hive at The Grove.  Then ships engines overload and Clarence asks to land.
--####################################

--namespace model.dialog

function model.dialog.damagedShipDuringHiveFight()
	local dialog = model.dialog.getDialog("damagedShipDuringHiveFight")

	function dialog:getPortrait()
		if dialog.currentOption == "repairs" or dialog.currentOption == "repairs2" then
			return crewGfxQuads, crewNames, "frank.png"
		else
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		end
	end

	function dialog:startDialog()
		return "Captain.  We pretty near spent the power cells on that last fight.  Things are smoking.  We need to land and make repairs."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "repairs2" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("repairs", nil, nil, nil, nil,
		"(continue)...",
		"Land at The Grove.  We have facilities that should suffice, and your crew could use a couple of days relaxation; they've earned it!")
	dialog.optionsList:add("repairs2", "repairs", nil, nil, nil,
		"Thank you.",
		"No thanks necessary!")

	return dialog
end
