--####################################
-- llaxonDestroyerDistress.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for Charlie saying that the Llaxon destroyer is attacking Artemis.
--####################################

--namespace model.dialog

function model.dialog.llaxonDestroyerDistress()
	local dialog = model.dialog.getDialog("llaxonDestroyerDistress")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain!  We're picking up a distress call from The Proctor.  He says that a destroyer class ship is above the colony demanding that "..
			"he joins them for \"ritualistic feasting\" or they will bomb the colony."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "return" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("return", nil, nil, nil, nil,
		"Charlie; let The Proctor know we're on our way.",
		"Yes Sir.")

	return dialog
end
