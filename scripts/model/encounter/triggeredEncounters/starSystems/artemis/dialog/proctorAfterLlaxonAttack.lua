--####################################
-- proctorAfterLlaxonAttack.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the proctor after you destroy the llaxon destroyer.
--####################################

--namespace model.dialog

function model.dialog.proctorAfterLlaxonAttack()
	local dialog = model.dialog.getDialog("proctorAfterLlaxonAttack")

	function dialog:getPortrait()
		if dialog.currentOption == "llaxon" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return charactersGfxQuads, charactersNames, "proctor.png"
		end
	end

	function dialog:startDialog()
		return "Captain.  Very good to see you.  I'm glad you got here in time, things might have gotten ugly.\n\nWho attacked us?"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "llaxon3" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("llaxon", nil, nil, nil, nil,
		"The Llaxon.",
		"Yes, the Llaxon.  They're that horrible alien race that was holding Clarence captive.  They've been hounding us since we saved him and I doubt that's "..
		"the last we've seen of them.")
	dialog.optionsList:add("llaxon2", "llaxon", nil, nil, nil,
		"(continue)...",
		"We'll have to be prepare in the future.  We'll start on building planetary weapons.  It will take some time but we don't want to be left defenseless "..
			"again.\n\nThank you Captain.")
	dialog.optionsList:add("llaxon3", "llaxon2", nil, nil, nil,
		"We should continue with our mission.",
		"Goodbye, and good luck.")

	return dialog
end
