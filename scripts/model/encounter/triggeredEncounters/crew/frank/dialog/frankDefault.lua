--####################################
-- frankDefault.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when speaking with Frank.
--####################################

--namespace model.dialog

function model.dialog.frankDefault()
	local dialog = model.dialog.getDialog("frankDefault")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "frank.png"
	end

	function dialog:startDialog()
		return "Good day to you, Captain."
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
	dialog.optionsList:add("ants", nil, nil, nil, nil,
		"What do you think of the Ants?",
		"I don't understand a species that so desperately lacks basic morality.  If any of us have a chance at surviving, the Ants "..
		"must be eliminated; at any cost.")
	dialog.optionsList:add("nude", nil, nil, nil, nil,
		"Why did you retire to a naturalist colony?",
		"The people at my colony are honest and down to earth.  They have helped me live simply and mindfully.\n\n"..
		"As much as I love the structure that clothing can provide, I have to admit it is interesting to experience it's absence.")
	dialog.optionsList:add("buddy", nil, nil, nil, nil,
		"What is that on your shoulder?",
		"That's just my Aider, military issue.")
	dialog.optionsList:add("buddy2", nil, "buddy", nil, nil,
		"What is an Aider?",
		"It's a military grade personal computer.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Nice talking with you, Frank.",
		"Goodbye.")

	return dialog
end
