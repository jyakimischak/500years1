--####################################
-- frankWarns.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when you first hail Antares III and Franks tells you to be nice.
--####################################

--namespace model.dialog

function model.dialog.frankWarns()
	local dialog = model.dialog.getDialog("frankWarns")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "frank.png"
	end

	function dialog:startDialog()
		return "Captain.  Before you hail the colony can we have a quick word?"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "willDo" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("speak", nil, nil, nil, nil,
		"Absolutely, speak your mind.",
		"Captain, this is a high security planet.  They will have the planetary defenses aimed at us now.  The Magistrate is, I'm sure, "..
		"waiting for our hail now.")
	dialog.optionsList:add("magistrate", "speak", nil, nil, nil,
		"Who is the Magistrate?",
		"The Magistrate will be a One World representative tasked with the responsibility of running this colony in the name of Om.  "..
		"His rank holds both a secular and religious position in human society.")
	dialog.optionsList:add("goOn", "magistrate", nil, nil, nil,
		"Go on.",
		"When we hail the Magistrate refer to him by title only.  And let me introduce you, I have rank in the military.  I have clearance "..
		"to be here and the Magistrate will recognize that.")
	dialog.optionsList:add("willDo", "goOn", nil, nil, nil,
		"Will do.",
		"Thank you.")

	return dialog
end
