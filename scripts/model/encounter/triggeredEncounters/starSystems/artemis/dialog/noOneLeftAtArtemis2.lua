--####################################
-- noOneLeftAtArtemis2.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking with Charlie about how no one is left at the Artemis colony.
--####################################

--namespace model.dialog

function model.dialog.noOneLeftAtArtemis2()
	local dialog = model.dialog.getDialog("noOneLeftAtArtemis2")

	function dialog:getPortrait()
		if dialog.currentOption == "bad" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "bad2" then
			return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
		else
			return crewGfxQuads, crewNames, "charlie.png"
		end
	end

	function dialog:startDialog()
		return "Captain. There's no one at the colony!"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "land" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("bad", nil, nil, nil, nil,
		"(continue)...",
		"What!  Check the scanners, something isn't right.")
	dialog.optionsList:add("bad2", "bad", nil, nil, nil,
		"(continue)...",
		"There ain't nothing wrong with the scanners.  What ever's wrong is down at the colony, not on the ship.")
	dialog.optionsList:add("land", "bad2", nil, nil, nil,
		"Let's land to investigate.",
		"Agreed.")

	return dialog
end
