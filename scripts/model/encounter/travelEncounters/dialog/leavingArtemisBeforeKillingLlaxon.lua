--####################################
-- leavingArtemisBeforeKillingLlaxon.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when you leave Artemis without killing the llaxon destroyer.
--####################################

--namespace model.dialog

function model.dialog.leavingArtemisBeforeKillingLlaxon()
	local dialog = model.dialog.getDialog("leavingArtemisBeforeKillingLlaxon")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "oleg.png"
	end

	function dialog:startDialog()
		return "Friend, we must save the colony from the destroyer."
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
		"We'll head back immediately.",
		"Good.")

	return dialog
end
