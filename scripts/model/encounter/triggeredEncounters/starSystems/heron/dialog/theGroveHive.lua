--####################################
-- theGroveHive.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when the player asks Charlie to hail the hive at The Grove.
--####################################

--namespace model.dialog

function model.dialog.theGroveHive()
	local dialog = model.dialog.getDialog("theGroveHive")

	function dialog:getPortrait()
		if dialog.currentOption == "canHear" or dialog.currentOption == "howFind3" or dialog.currentOption == "yepp2"
			or dialog.currentOption == "die"
		then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "howFind2" then
			return crewGfxQuads, crewNames, "frank.png"
		elseif dialog.currentOption == "homeWorld2" or dialog.currentOption == "yepp3" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "yepp4" then
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		elseif dialog.currentOption == "yepp5" then
			return crewGfxQuads, crewNames, "jarvis.png"
		else
			return charactersGfxQuads, charactersNames, "antTelepathy.png"
		end
	end

	function dialog:startDialog()
		return "Humans."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "die2" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("canHear", nil, nil, nil, nil,
		"(continue)...",
		"Captain, I can hear it in my head.  This must be how The Proctor spoke with them.")
	dialog.optionsList:add("humans", "canHear", nil, nil, nil,
		"(continue)...",
		"Humans.  Hear us.  Leave this place.  It's not for you now.")
	dialog.optionsList:add("howFind", nil, "humans", nil, nil,
		"How did you find this place?",
		"We tracked you.  You lead us to many interesting places, but none as interesting as this.")
	dialog.optionsList:add("howFind2", "howFind", nil, nil, nil,
		"(continue)...",
		"It's the blasted egg captain.  They can follow him somehow and can break through our barriers!")
	dialog.optionsList:add("howFind3", "howFind2", nil, nil, nil,
		"(continue)...",
		"We need to take care of this now!  We'll take care of Yepp after...")
	dialog.optionsList:add("homeWorld", nil, "humans", nil, nil,
		"Where is your home world?",
		"Stupid Humans!  Pathetic.  We'll be keeping that information to ourselves.")
	dialog.optionsList:add("homeWorld2", "homeWorld", "humans", nil, nil,
		"(continue)...",
		"It was worth a try.")
	dialog.optionsList:add("yepp", nil, "humans", nil, nil,
		"Why did you put an egg on our ship?",
		"To track your movements.  To find more Humans...you were evading us too effectively.  When we take the data banks from this colony "..
		"you will no longer be needed.  We can return to your Artemis.")
	dialog.optionsList:add("yepp2", "yepp", "humans", nil, nil,
		"(continue)...",
		"Permission to fire Captain?")
	dialog.optionsList:add("yepp3", "yepp2", "humans", nil, nil,
		"(continue)...",
		"Friends; they must not survive.  Do not allow them to touch the colony.  NEVER AGAIN!.")
	dialog.optionsList:add("yepp4", "yepp3", "humans", nil, nil,
		"(continue)...",
		"We're all with you Captain.")
	dialog.optionsList:add("yepp5", "yepp4", "humans", nil, nil,
		"(continue)...",
		"Um?")
	dialog.optionsList:add("leave", nil, "humans", nil, nil,
		"Leave this place now.",
		"No Human.  We'll never leave you again.")
	dialog.optionsList:add("die", nil, "yepp", nil, nil,
		"Charlie, permission to fire granted.",
		"Yes Sir.")
	dialog.optionsList:add("die2", "die", nil, nil, nil,
		"(continue)...",
		"Fools.")

	return dialog
end
