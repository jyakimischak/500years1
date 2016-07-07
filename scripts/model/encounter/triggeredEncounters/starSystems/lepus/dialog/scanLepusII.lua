--####################################
-- scanLepusII.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for a scan of the daughter planet.
--####################################

--namespace model.dialog

function model.dialog.scanLepusII()
	local dialog = model.dialog.getDialog("scanLepusII")

	function dialog:getPortrait()
		if dialog.currentOption == "bye" then
			return charactersGfxQuads, charactersNames, "lilepus.png"
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
		"I don't like that...")

	return dialog
end
