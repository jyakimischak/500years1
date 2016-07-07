--####################################
-- scanLepusI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for a scan of Lepus.
--####################################

--namespace model.dialog

function model.dialog.scanLepusI()
	local dialog = model.dialog.getDialog("scanLepusI")

	function dialog:getPortrait()
		if dialog.currentOption == "bye" then
			return charactersGfxQuads, charactersNames, "lepus.png"
		else
			return crewGfxQuads, crewNames, "charlie.png"
		end
	end

	function dialog:startDialog()
		return "Captain.  I actually can't believe how mineral rich this planet is......"
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
		"(continue)...",
		"Interesting...")

	return dialog
end
