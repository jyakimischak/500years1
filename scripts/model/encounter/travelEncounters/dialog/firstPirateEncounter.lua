--####################################
-- firstPirateEncounter.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the first pirate encounter.
--####################################

--namespace model.dialog

function model.dialog.firstPirateEncounter()
	local dialog = model.dialog.getDialog("firstPirateEncounter")

	function dialog:getPortrait()
		if dialog.currentOption == "whoAreYou2" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "whoAreYou3" or dialog.currentOption == "cantDoThat2" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return charactersGfxQuads, charactersNames, "pirate.png"
		end
	end

	function dialog:startDialog()
		return "Disable your shields and prepare to be boarded."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "cantDoThat3" or dialog.currentOption == "die" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("whoAreYou", nil, nil, nil, nil,
		"Who am I speaking to?",
		"That's not your concern.  Please lower you shields or your ship will be destroyed.")
	dialog.optionsList:add("whoAreYou2", "whoAreYou", nil, nil, nil,
		"(continue)...",
		"Captain, I think we've got a privateer on our hands.  Why don't we let him on board, it might be fun.")
	dialog.optionsList:add("whoAreYou3", "whoAreYou2", nil, nil, nil,
		"(continue)...",
		"Friend.  Let's just deal with this quickly, we have important work we need to be doing.")
	dialog.optionsList:add("whatDoYouWant", nil, nil, nil, nil,
		"What do you want?",
		"Anything of value, including your ship.")
	dialog.optionsList:add("whatHappensToUs", nil, "whatDoYouWant", nil, nil,
		"What happens to us if you take our ship?",
		"You'll be free to go.  We'll leave you in the escape pods and you can send out a distress signal.  Now; LOWER YOUR SHIELDS!")
	dialog.optionsList:add("cantDoThat", nil, "whatHappensToUs", nil, nil,
		"I'm sorry, I can't do that.",
		"Please do reconsider Captain.  I don't want to destroy your ship, it looks like quite the prize.  But we will attack if you leave us no choice.")
	dialog.optionsList:add("cantDoThat2", "cantDoThat", nil, nil, nil,
		"(continue)...",
		"Captain.  If they want to rush toward death let them.  There is no salvation for some men.")
	dialog.optionsList:add("cantDoThat3", "cantDoThat2", nil, nil, nil,
		"I'm sorry, I can't let you take our ship.",
		"I'm sorry to hear that Captain.  Prepare yourself!")
	dialog.optionsList:add("die", nil, "whatHappensToUs", nil, nil,
		"Die!",
		"Time to end this!")

	return dialog
end
