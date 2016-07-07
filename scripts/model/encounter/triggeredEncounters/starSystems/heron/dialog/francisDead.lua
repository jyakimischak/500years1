--####################################
-- francisDead.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when everyone finds out Francis is dead.
--####################################

--namespace model.dialog

function model.dialog.francisDead()
	local dialog = model.dialog.getDialog("francisDead")

	function dialog:getPortrait()
		if
			dialog.currentOption == "seenHim" or
			dialog.currentOption == "seenHim3" or
			dialog.currentOption == "seenHim5" or
			dialog.currentOption == "seenHim6" or
			dialog.currentOption == "seenHim8" or
			dialog.currentOption == "seenHim10" or
			dialog.currentOption == "seenHim12" or
			dialog.currentOption == "seenHim15" or
			dialog.currentOption == "seenHim17"
		then
			return crewGfxQuads, crewNames, "jarvis.png"
		elseif dialog.currentOption == "seenHim2" or dialog.currentOption == "seenHim16" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "seenHim4" or dialog.currentOption == "seenHim13" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "seenHim7" then
			return crewGfxQuads, crewNames, "frank.png"
		else
			return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
		end
	end

	function dialog:startDialog()
		return "Alright everyone.  Now the Captain here was nice enough to call you all together to help me find my poor Francis.\n"..
		"\n"..
		"I don't know where he's run off to."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "seenHim17" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("seenHim", nil, nil, nil, nil,
		"Has anyone seen him?",
		"Look everyone!  I brought refreshments!  We need more refreshments and since no one was bringing any Jarvis has brought enough for all!")
	dialog.optionsList:add("seenHim2", "seenHim", nil, nil, nil,
		"(continue)...",
		"JARVIS!  If you don't shut up I'm going to pull your whiskers out; slowly; one at a time.\n"..
		"\n"..
		"Do you understand me?")
	dialog.optionsList:add("seenHim3", "seenHim2", nil, nil, nil,
		"(continue)...",
		"AH!  But...Jarvis...Refreshments....make people happy?")
	dialog.optionsList:add("seenHim4", "seenHim3", nil, nil, nil,
		"(continue)...",
		"Honestly Jarvis.  Have some heart.  Can't you see the man is upset because Francis is missing.")
	dialog.optionsList:add("seenHim5", "seenHim4", nil, nil, nil,
		"(continue)...",
		"Umm...yes.  Jarvis?   I'm sorry, I'm confused.  I don't think I know a Francis.")
	dialog.optionsList:add("seenHim6", "seenHim5", nil, nil, nil,
		"Francis is Clarence's pet goat.",
		"Um hmmm.  Yes, and a goat would be?")
	dialog.optionsList:add("seenHim7", "seenHim6", nil, nil, nil,
		"(continue)...",
		"Jarvis.  Goats are 4 legged animals that humans keep for livestock.  Clarence had one as a...pet.  The animal that accompanied him.")
	dialog.optionsList:add("seenHim8", "seenHim7", nil, nil, nil,
		"(continue)...",
		"Oh!  Yes, oh...yes.  Francis; I see.")
	dialog.optionsList:add("seenHim9", "seenHim8", nil, nil, nil,
		"(continue)...",
		"Where did you see 'im?  Please tell me.  Tell me!")
	dialog.optionsList:add("seenHim10", "seenHim9", nil, nil, nil,
		"(continue)...",
		"Yes.  The thing is...refreshments....")
	dialog.optionsList:add("seenHim11", "seenHim10", nil, nil, nil,
		"(continue)...",
		"I DON'T WANT ANY DAMNED REFRESHMENTS!  Now; you're going to tell me where Francis is and you're going to tell me right now.")
	dialog.optionsList:add("seenHim12", "seenHim11", nil, nil, nil,
		"(continue)...",
		"Jarvis!  See, well.  You kept it and were not eating it...so I thought.  Why not make refreshments for all the crew so they will "..
		"be happy.\n"..
		"\n"..
		"I thought you were saving it for an occasion, and this seemed like a good one.")
	dialog.optionsList:add("seenHim13", "seenHim12", nil, nil, nil,
		"(continue)...",
		"No.  Jarvis.  Please.  You didn't make sandwiches out of our friend's pet did you?")
	dialog.optionsList:add("seenHim14", "seenHim13", nil, nil, nil,
		"(continue)...",
		"There will be a reckoning.  Your people will learn fear...")
	dialog.optionsList:add("seenHim15", "seenHim14", nil, nil, nil,
		"(continue)...",
		"AH!  Jarvis?")
	dialog.optionsList:add("seenHim16", "seenHim15", nil, nil, nil,
		"Charlie, get him out of here.",
		"Yes Sir.")
	dialog.optionsList:add("seenHim17", "seenHim16", nil, nil, nil,
		"Go with her.",
		"Please?....")

	return dialog
end
