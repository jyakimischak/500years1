--####################################
-- leavingArtemisAtEnd.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog when the player leave the artemis system at the end of the game.
--####################################

--namespace model.dialog

function model.dialog.leavingArtemisAtEnd()
	local dialog = model.dialog.getDialog("leavingArtemisAtEnd")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "oleg.png"
	end

	function dialog:startDialog()
		return "Friend, please.  We're excited to see home.  Can we please return to the Artemis colony now?"
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
		"Alright Oleg, we'll head back.",
		"Thank you.")

	return dialog
end
