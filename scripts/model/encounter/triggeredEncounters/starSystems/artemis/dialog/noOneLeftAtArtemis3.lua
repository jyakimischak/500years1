--####################################
-- noOneLeftAtArtemis3.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking with Oleg at the colony.
--####################################

--namespace model.dialog

function model.dialog.noOneLeftAtArtemis3()
	local dialog = model.dialog.getDialog("noOneLeftAtArtemis3")

	function dialog:getPortrait()
		if dialog.currentOption == "left" then
			return crewGfxQuads, crewNames, "frank.png"
		elseif dialog.currentOption == "left2" or dialog.currentOption == "left4" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "left3" then
			return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
		else
			return crewGfxQuads, crewNames, "oleg.png"
		end
	end

	function dialog:startDialog()
		return "It's not the Ants, this isn't their way.\n\nNo blood; no bodies.  Those One World people had something to do with this, I know it."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "left4" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("left", nil, nil, nil, nil,
		"(continue)...",
		"Of course it was them Oleg, they just attacked us.  But I don't understand it; not yet at any rate.  I need time to think about this.")
	dialog.optionsList:add("left2", "left", nil, nil, nil,
		"(continue)...",
		"Everyone we know is gone and I want revenge more than answers.  I never trusted The Proctor, and if he had something to do with this then "..
		"I'd like a word with him.")
	dialog.optionsList:add("left3", "left2", nil, nil, nil,
		"Let's head back to Antares.",
		"Can't right now Captain.  The ship's fried, we overloaded it.  I've got to rewire most of the systems.  It's going to take a while.")
	dialog.optionsList:add("left4", "left3", nil, nil, nil,
		"Charlie, scan for ships in the area.",
		"Will do Captain.")

	return dialog
end
