--####################################
-- scanLepusOther.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when a planet in the Lepus system that is not the mother or daughter is scanned.
--####################################

--namespace model.dialog

function model.dialog.scanLepusOther()
	local dialog = model.dialog.getDialog("scanLepusOther")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain.  This planet's incredibly mineral rich.  This looks like it's just what the Ungiri are after."
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
