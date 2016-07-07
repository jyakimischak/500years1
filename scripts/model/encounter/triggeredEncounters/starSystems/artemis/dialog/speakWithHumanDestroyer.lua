--####################################
-- speakWithHumanDestroyer.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking with the human destroyer at the end of the game.
--####################################

--namespace model.dialog

function model.dialog.speakWithHumanDestroyer()
	local dialog = model.dialog.getDialog("speakWithHumanDestroyer")

	function dialog:getPortrait()
		if dialog.currentOption == "what" or dialog.currentOption == "die" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "what2" or dialog.currentOption == "doing2" then
			return crewGfxQuads, crewNames, "frank.png"
		else
			return charactersGfxQuads, charactersNames, "humanPilot.png"
		end
	end

	function dialog:startDialog()
		return "Enemy of the One World; prepare to be destroyed."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "die" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("what", nil, nil, nil, nil,
		"(continue)...",
		"What is this, another pirate?")
	dialog.optionsList:add("what2", "what", nil, nil, nil,
		"(continue)...",
		"That's no pirate Charlie, that's a bloody One World destroyer class ship.\n\nWhat's the meaning of this!")
	dialog.optionsList:add("what3", "what2", nil, nil, nil,
		"(continue)...",
		"Just following orders.  There's no point in resisting Captain.")
	dialog.optionsList:add("doing", nil, "what3", nil, nil,
		"What are you doing here?",
		"Our orders are to wait here for your ship and destroy it, simple as that.")
	dialog.optionsList:add("doing2", "doing", nil, nil, nil,
		"(continue)...",
		"That makes no sense!  I'm Captain Frank Stone, One World Marine Corps, Retired.  Who gave those orders!")
	dialog.optionsList:add("doing3", "doing2", nil, nil, nil,
		"(continue)...",
		"I know who you are, I was briefed on the ship's crew complement.\n\nAnd the name of my CO is classified Captain Stone.  I'm sorry.")
	dialog.optionsList:add("safe", nil, "what3", nil, nil,
		"Is the colony safe?",
		"Oh yes.  They're safe and sound.  Don't worry about that.")
	dialog.optionsList:add("die", nil, "what3", nil, nil,
		"Charlie.  Get rid of them.",
		"Yes sir.")

	return dialog
end
