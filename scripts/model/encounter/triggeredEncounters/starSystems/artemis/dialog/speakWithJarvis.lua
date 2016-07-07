--####################################
-- proctorSpeakWithJarvis.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the proctor when you have Jarvis in you crew but have not yet gotten any coordinates from him.
--####################################

--namespace model.dialog

function model.dialog.proctorSpeakWithJarvis()
	local dialog = model.dialog.getDialog("proctorSpeakWithJarvis")

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
	dialog.optionsList:add("haveJarvis", nil, nil, nil, nil,
		"Proctor, we've met an alien ambassador named Jarvis.",
		"Interesting.  Is he willing to help?")
	dialog.optionsList:add("haveJarvis2", "haveJarvis", nil, nil, nil,
		"No.  His people attacked us.",
		"Hmmm.  Well, see what information you can get from him.  He may know of a human colony that we can ask for assistance.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"I'll contact you when I have more news.",
		"Thank you Captain.")

	return dialog
end
