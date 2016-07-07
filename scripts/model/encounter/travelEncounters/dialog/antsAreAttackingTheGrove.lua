--####################################
-- antsAreAttackingTheGrove.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for Charlie saying that Ants are attacking The Grove.
--####################################

--namespace model.dialog

function model.dialog.antsAreAttackingTheGrove()
	local dialog = model.dialog.getDialog("antsAreAttackingTheGrove")

	function dialog:getPortrait()
		if dialog.currentOption == "hive" then
			return crewGfxQuads, crewNames, "frank.png"
		else
			return crewGfxQuads, crewNames, "charlie.png"
		end
	end

	function dialog:startDialog()
		return "Captain!  We're picking up a distress call from The Grove.  An Ant hive has entered their system."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "hive2" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("hive", nil, nil, nil, nil,
		"(continue)...",
		"Captain!  We need to go back.  They'll be helpless and we're their best chance to get help.")
	dialog.optionsList:add("hive2", "hive", nil, nil, nil,
		"Charlie; let The Grove know we're on our way.",
		"Yes Sir.")

	return dialog
end
