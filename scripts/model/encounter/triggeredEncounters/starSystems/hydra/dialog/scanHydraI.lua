--####################################
-- scanHydraI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking to Charlie after you scan the Hydra planet.
--####################################

--namespace model.dialog

function model.dialog.scanHydraI()
	local dialog = model.dialog.getDialog("scanHydraI")

	function dialog:getPortrait()
		if dialog.currentOption == "useful2" or dialog.currentOption == "useful4" then
			if gameState.francisDead then
				return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
			else
				return crewGfxQuads, crewNames, "clarenceWithGoat.png"
			end
		elseif dialog.currentOption == "useful3" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return crewGfxQuads, crewNames, "charlie.png"
		end
	end

	function dialog:startDialog()
		return "Captain.  It looks like there are a lot of radio active minerals on this planet.  Likely due to the close proximity to "..
			"that massive star."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "useful6" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("useful", nil, nil, nil, nil,
		"Could these minerals be useful to us or the colony?",
		"They could be Captain....")
	dialog.optionsList:add("useful2", "useful", nil, nil, nil,
		"(continue)...",
		"CAPTAIN!  Jump around and call me Aunt Sally!  That's lawrencium!  It's not typically stable naturally.  If we could get some aboard I could "..
		"use it to increase the power yield of the ship.")
	dialog.optionsList:add("useful3", "useful2", nil, nil, nil,
		"(continue)...",
		"What would that kind of radiation do to the ship?  Could we even survive?")
	dialog.optionsList:add("useful4", "useful3", nil, nil, nil,
		"(continue)...",
		"We'd survive for sure, but the ship would likely take some damage.  I think it would weaken the hull in a way I couldn't repair; it would need ".. 
		"to be replaced.  So, that's permanent damage.  I think our armor would suffer a 10% loss from this.\n\nIt might be worth it though.")
	dialog.optionsList:add("useful5", "useful4", nil, nil, nil,
		"(continue)...",
		"Well, that would weaken us.  I don't think I'd enjoy having our defenses permanently lowered.  It's up to you though Captain.  Give the orders "..
		"and we'll land.")
	dialog.optionsList:add("useful6", "useful5", nil, nil, nil,
		"Thank you.",
		"Captain.")

	return dialog
end
