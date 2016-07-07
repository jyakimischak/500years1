--####################################
-- jarvisResortCoordinates.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when Jarvis gives us the coordinates to the resort.
--####################################

--namespace model.dialog

function model.dialog.jarvisResortCoordinates()
	local dialog = model.dialog.getDialog("jarvisResortCoordinates")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "jarvis.png"
	end

	function dialog:startDialog()
		return "Captain!  Meetings require refreshments to make the most of the discussion.  Perhaps we could have sugared drinks and dried meats?"
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
	dialog.optionsList:add("howAreYou", nil, nil, nil, nil,
		"How are you?",
		"Well Captain I've been both better and worse.  When I was...")
	dialog.optionsList:add("howAreYou2", "howAreYou", nil, nil, nil,
		"Let's discuss something else.",
		"...of course.  What would you like to know.")
	dialog.optionsList:add("help", nil, nil, nil,
		function()
			gameState.quests.jarvisCoordinates.gaveResortCoordinates = true
			gameState.visibleStarMapLocations:add("syrma")
		end,
		"Do you know any human colonies?",
		"Well...hmm.  Yes yes I suppose I do Captain.  And I'd be more than happy to share the coordinates with you.  But my memory is becoming fuzzy "..
		"from the lack of proper food energy...")
	dialog.optionsList:add("help2", "help", nil, nil, nil,
		"Alright, I'll get some food.",
		"Oh..oh oh yes.  This is much better.  Now, I do remember a human colony that we should visit.  I'm sure they'll help with your cause.  "..
		"I've entered the coordinates into the ships computer for you.  It's in the Syrma system.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Goodbye.",
		"Until next time Captain.")

	return dialog
end
