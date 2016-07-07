--####################################
-- noOneLeftAtArtemis.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking with Charlie about how no one is left at the Artemis colony.
--####################################

--namespace model.dialog

function model.dialog.noOneLeftAtArtemis()
	local dialog = model.dialog.getDialog("noOneLeftAtArtemis")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain, there's no response."
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
		"Charlie, scan the colony.",
		"Yes sir.")

	return dialog
end
