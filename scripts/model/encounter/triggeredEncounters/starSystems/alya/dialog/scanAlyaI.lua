--####################################
-- scanAlyaI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog when you scan Alya I.
--####################################

--namespace model.dialog

function model.dialog.scanAlyaI()
	local dialog = model.dialog.getDialog("scanAlyaI")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain, it looks like there is a research station floating on the planet's surface...and it's recently been attacked."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "sendProbe2" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("moreInfo", nil, nil, nil, nil,
		"Can you get any more information?",
		"I'll focus the scans on the research station, let's see what happened here.")
	dialog.optionsList:add("moreInfo2", "moreInfo", nil, nil, nil,
		"(continue)...",
		"It looks like there are plasma burns on the station...and Captain.  It looks like this was a human station.")
	dialog.optionsList:add("moreInfo3", "moreInfo2", nil, nil, nil,
		"(continue)...",
		"Wait, I'm picking up a faint distress call from below the ocean's surface.")
	dialog.optionsList:add("scanForShips", nil, nil, nil, nil,
		"Scan the surrounding area for ships.",
		"There is a large fleet of Llaxon ships nearby.  It doesn't look like they've noticed us yet.")
	dialog.optionsList:add("sendProbe1", nil, "moreInfo3", nil, nil,
		"Send a communication probe.",
		"That got someone's attention, 13 Llaxon fighters inbound.")
	dialog.optionsList:add("sendProbe2", "sendProbe1", nil, nil, nil,
		"Battle stations.",
		"Captain.")

	return dialog
end
