--####################################
-- noMatchForHumanDestroyer.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for Charlie saying we're no match for the human destroyer.
--####################################

--namespace model.dialog

function model.dialog.noMatchForHumanDestroyer()
	local dialog = model.dialog.getDialog("noMatchForHumanDestroyer")

	function dialog:getPortrait()
		if dialog.currentOption == "help" or dialog.currentOption == "help2" or dialog.currentOption == "help3" then
			return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
		else
			return crewGfxQuads, crewNames, "charlie.png"
		end
	end

	function dialog:startDialog()
		return "Captain, we're no match for that destroyer; and I don't think we can outrun them either."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "help3" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("help", nil, nil, nil, nil,
		"(continue)...",
		"I think I can help with that Captain.")
	dialog.optionsList:add("help2", "help", nil, nil, nil,
		"How?",
		"Well Captain.  I'm pretty sure that I can overload these engines.  It will give us full power for a short time.\n\nOf course it might also "..
		"destroy the ship.")
	dialog.optionsList:add("help3", "help2", nil, nil, nil,
		"Do it.",
		"Alright, here we go.")

	return dialog
end
