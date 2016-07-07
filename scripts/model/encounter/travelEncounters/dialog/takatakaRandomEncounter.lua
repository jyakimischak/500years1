--####################################
-- takatakaRandomEncounter.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for a random encounter with the takataka.
--####################################

--namespace model.dialog

function model.dialog.takatakaRandomEncounter()
	local dialog = model.dialog.getDialog("takatakaRandomEncounter")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "takatakaPilot.png"
	end

	function dialog:startDialog()
		return "YES YES yes yes yes.  We found you.  Now we will PUNISH!"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "die" or dialog.currentOption == "must" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("die", nil, nil, nil, nil,
		"DIE!",
		"NO NO no no no yes!!!")
	dialog.optionsList:add("leave", nil, nil, nil, nil,
		"Please leave us alone.",
		"Talk is not good to talk.  Fight and DIE!")
	dialog.optionsList:add("must", nil, "leave", nil, nil,
		"If I must.",
		"YYYYAAAAAAEEEEESSYYYYY")

	return dialog
end
