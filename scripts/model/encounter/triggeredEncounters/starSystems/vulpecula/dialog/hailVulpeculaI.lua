--####################################
-- hailVulpeculaI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog when you hail vulpecula 1, the takataka ambassador world.
--####################################

--namespace model.dialog

function model.dialog.hailVulpeculaI()
	local dialog = model.dialog.getDialog("hailVulpeculaI")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain.\n\nI'm sure that they're receiving our hails, but it looks like they don't want to talk.\n\nWe're wasting our time here."
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
