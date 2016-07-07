--####################################
-- clarenceRepairsMade.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for Clarence after the repairs have been made to the ship at the artemis colony.
--####################################

--namespace model.dialog

function model.dialog.clarenceRepairsMade()
	local dialog = model.dialog.getDialog("clarenceRepairsMade")

	function dialog:getPortrait()
		if dialog.currentOption == "repairsComplete" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "repairsComplete2" or dialog.currentOption == "repairsComplete4" or dialog.currentOption == "bye" then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		end
	end

	function dialog:startDialog()
		return "Well Captain, looks like the repairs are complete.  12 days work, not bad at all.\n"..
			"And Captain.  This ship is amazing.  Fully powered it's a match for a destroyer.  Right now I've increased your power output a little."..
			"  You'll be able to modify what systems you want the extra power to go toward...make it count."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "repairsComplete5" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("repairsComplete", nil, nil, nil, nil,
		"Excellent work.",
		"I agree, the ship is powerful now.  You can increase power to an additional ship's system.")
	dialog.optionsList:add("repairsComplete2", "repairsComplete", nil, nil, nil,
		"(continue)...",
		"With increased energy we'll be able to make use of some the more interesting weapons, good work.")
	dialog.optionsList:add("repairsComplete3", "repairsComplete2", nil, nil, nil,
		"(continue)...",
		"I've also installed the star maps you wanted Captain.  You should have new star systems displayed on the ship's "..
		"map.\n\nAnother thing, the Llaxon now know your ship's subspace signature; they are sure to try attacking while we "..
		"travel.  We should expect resistance from now on.\n\n...They may have also found the coordinates of this colony.")
	dialog.optionsList:add("repairsComplete4", "repairsComplete3", nil, nil, nil,
		"(continue)...",
		"Any ground assault would be met harshly by our resistance fighters.  They should be able to hold out.  We do need to find assistance "..
		"quickly though as the colony doesn't have the ability to fend off aerial bombardments.")
	dialog.optionsList:add("repairsComplete5", "repairsComplete4", nil, nil, nil,
		"Let's get moving, there's no time to waste.",
		"Agreed.")

	return dialog
end
