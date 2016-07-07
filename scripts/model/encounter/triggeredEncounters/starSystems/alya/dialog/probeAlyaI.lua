--####################################
-- probeAlyaI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog when you launch a probe on Alya I.
--####################################

--namespace model.dialog

function model.dialog.probeAlyaI()
	local dialog = model.dialog.getDialog("probeAlyaI")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain, it looks like there is a woman in an underwater facility.  She's let our probe in and has established communications.  "..
		"You can hail her when you're ready."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "thankYou" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("thankYou", nil, nil, nil, nil,
		"Thank you.",
		"You're welcome Captain.")

	return dialog
end
