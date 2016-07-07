--####################################
-- charlieAfterWeGetJarvis.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for Charlie right after we get Jarvis.
--####################################

--namespace model.dialog

function model.dialog.charlieAfterWeGetJarvis()
	local dialog = model.dialog.getDialog("charlieAfterWeGetJarvis")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain.  It looks like we'll be stuck with Jarvis now.  I've given him a room and I'll be keeping an eye on "..
		"him.\n\nYou should speak with him when you have a free moment.  Might as well see if he's useful for something."
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
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Thank you.",
		"Captain.")

	return dialog
end
