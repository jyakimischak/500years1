--####################################
-- pirateDestroyerEncounter.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the pirate destroyer and the pirate queen.
--####################################

--namespace model.dialog

function model.dialog.pirateDestroyerEncounter()
	local dialog = model.dialog.getDialog("pirateDestroyerEncounter")

	function dialog:getPortrait()
		if dialog.currentOption == "who2" then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return charactersGfxQuads, charactersNames, "pirateQueen.png"
		end
	end

	function dialog:startDialog()
		return "What have I found.  A very small ship that has been causing my boys a lot of trouble.  Now, it's best to surrender quickly, I may get angry."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "no" or dialog.currentOption == "die" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("who", nil, nil, nil, nil,
		"Who are you?",
		"Heh.  I'm an entrepreneur of sorts.  Now, I would really like to end this discussion without bloodshed.  How about it Captain?")
	dialog.optionsList:add("who2", "who", nil, nil, nil,
		"(continue)...",
		"Captain.  This is nothing more than a little pirate Queen.  Let's take care of this, we have work to do.")
	dialog.optionsList:add("who3", "who2", nil, nil, nil,
		"(continue)...",
		"Pirate Queen.  I like that.  I like that a lot.\n\nNow surrender!")
	dialog.optionsList:add("no", nil, "who3", nil, nil,
		"I'm sorry.  I can't do that.",
		"Then die Captain.")
	dialog.optionsList:add("die", nil, "who3", nil, nil,
		"Charlie, open fire.",
		"Wrong move Captain.")

	return dialog
end
