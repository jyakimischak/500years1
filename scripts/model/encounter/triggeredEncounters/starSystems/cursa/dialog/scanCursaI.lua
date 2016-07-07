--####################################
-- scanCursaI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when Cursa I is scanned.
--####################################

--namespace model.dialog

function model.dialog.scanCursaI()
	local dialog = model.dialog.getDialog("scanCursaI")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain.  There's a lot of radiation down there.  I'm not sure how we're going to get the parts we need.  I don't think "..
		"anything could live there.\n\nWait.  I'm picking up life signs.  Two beings.  I recommend launching a drone to investigate."
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
