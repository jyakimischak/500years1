--####################################
-- proctorSpeakWithClarence.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the proctor when you go back to artemis right after getting Clarence on your team.  The proctor will ask you
-- to speak with Clarence to see if he can repair the ship and if he has any starmaps.
--####################################

--namespace model.dialog

function model.dialog.proctorSpeakWithClarence()
	local dialog = model.dialog.getDialog("proctorSpeakWithClarence")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "proctor.png"
	end

	function dialog:startDialog()
		return "Captain."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "bye" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("haveClarence", nil, nil, nil, nil,
		"Proctor, we've met a human engineer.", "Excellent; is he able to help with repairs to the ship?",
		"Excellent; is he able to help with repairs to the ship?")
	dialog.optionsList:add("clarenceCanHelp", "haveClarence", nil, nil, nil,
		"Yes, he is willing to help.",
		"Speak with him and let me know what he needs.  We don't have much but we'll assist with anything we can.  This may be our "..
		"only hope.\n\nRemember to ask him about star maps as well, he might know something.")
	dialog.optionsList:add("bye", "clarenceCanHelp", nil, nil, nil,
		"I'll contact you after speaking with Clarence.",
		"I'm looking forward to it Captain.")

	return dialog
end
