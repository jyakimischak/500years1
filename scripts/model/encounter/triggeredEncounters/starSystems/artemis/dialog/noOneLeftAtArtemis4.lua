--####################################
-- noOneLeftAtArtemis4.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking with charlie at the end of the game.
--####################################

--namespace model.dialog

function model.dialog.noOneLeftAtArtemis4()
	local dialog = model.dialog.getDialog("noOneLeftAtArtemis4")

	function dialog:getPortrait()
		if dialog.currentOption == "who" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "who2" then
			return crewGfxQuads, crewNames, "frank.png"
		elseif dialog.currentOption == "who3" then
			return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
		else
			return crewGfxQuads, crewNames, "charlie.png"
		end
	end

	function dialog:startDialog()
		return "It was the One World.  Damn it, we never should have trusted them!"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "who5" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("who", nil, nil, nil, nil,
		"(continue)...",
		"True, but we had to trust someone.  No one can live alone, as an island.")
	dialog.optionsList:add("who2", "who", nil, nil, nil,
		"(continue)...",
		"I'll help any way I can.  I'm in this with you now.")
	dialog.optionsList:add("who3", "who2", nil, nil, nil,
		"(continue)...",
		"Me too Captain.")
	dialog.optionsList:add("who4", "who3", nil, nil, nil,
		"(continue)...",
		"Alright, then let's prepare.  I suppose we must repair the ship and then head back to Antares; we need to find out what happened to our friends and family.")
	dialog.optionsList:add("who5", "who4", nil, nil, nil,
		"Begin the repairs.",
		"Yes sir.")

	return dialog
end
