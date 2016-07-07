--####################################
-- clarenceBeforeRepairs.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking with Clarence about making repairs to the ship and getting starmaps.  This will happen when talking to
-- Clarence right after getting him for your crew.
--####################################

--namespace model.dialog

function model.dialog.clarenceBeforeRepairs()
	local dialog = model.dialog.getDialog("clarenceBeforeRepairs")

	function dialog:getPortrait()
		if dialog.currentOption == "howIsGoat2" or dialog.currentOption == "repairShip3" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "repairShip2" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		end
	end

	function dialog:startDialog()
		return "Well now Captain, me and Francis are grateful for all you've done for us."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "bye" or dialog.currentOption == "speakWithProctor" then
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
		"I'm doin' fine Captain.  Leaving home wasn't exactly difficult; nothing but bad memories there now.  One day, with luck, "..
		"I'll be able to show the Llaxons exactly how I feel about them.\n\nEnough of that for now though.")
	dialog.optionsList:add("howIsGoat", nil, nil, nil, nil,
		"How is your goat?",
		"Francis is a fighter Captain.  No need to worry about him, he'll pull through.")
	dialog.optionsList:add("howIsGoat2", "howIsGoat", nil, nil, nil,
		"(continue)...",
		"Isn't that touching?")
	dialog.optionsList:add("repairShip", nil, nil, nil,
		function()
			gameState.quests.repairs.gotLocations = true
		end,
		"Could you help us with repairs to our ship?",
		"Absolutely Captain.  I brought quite a bit of equipment with me from Cursa.  Including upgrades for your ship "..
		"systems and weapons.  If you have a safe place we can land I can start on the repairs, it should only take a couple weeks to set everything up.")
	dialog.optionsList:add("repairShip2", "repairShip", nil, nil, nil,
		"(continue)...",
		"Old friends and new; bringing salvation to my people.  We'll remember this always Clarence!")
	dialog.optionsList:add("repairShip3", "repairShip2", nil, nil, nil,
		"(continue)...",
		"Clarence, if I ever forget.  Remind me that I like you.")
	dialog.optionsList:add("repairShip4", "repairShip3", nil, nil, nil,
		"Do you have a star map?",
		"In fact I do Captain.  I'll install it into the ship computer when I'm making the upgrades.")
	dialog.optionsList:add("bye", nil, nil,
		function()
			--if we asked Clarence for help and he agreed then set the gameState flag
			return dialog.selectedOptions.repairShip == nil
		end, nil,
		"I'll speak with you later.",
		"Until then.")
	dialog.optionsList:add("speakWithProctor", nil, "repairShip", nil, nil,
		"Let's speak with The Proctor and start the repairs.",
		"Sounds like a plan.")

	return dialog
end
