--####################################
-- launchCursaI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when Cursa I has a probe launched.
--####################################

--namespace model.dialog

function model.dialog.launchCursaI()
	local dialog = model.dialog.getDialog("launchCursaI")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Alright, the probe's landed on the planet successfully.\n\nCaptain.  It looks like there's a human down there with a...goat.  "..
		"He has a workshop and it looks like he's building weapons.\n\nYou can hail him when you're ready..."
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
