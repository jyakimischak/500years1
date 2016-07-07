--####################################
-- llaxonDestroyer.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for talking to the Llaxon destroyer attacking the Artemis colony.
--####################################

--namespace model.dialog

function model.dialog.llaxonDestroyer()
	local dialog = model.dialog.getDialog("llaxonDestroyer")

	function dialog:getPortrait()
		if dialog.currentOption == "leave2" then
			return crewGfxQuads, crewNames, "jarvis.png"
		elseif dialog.currentOption == "leave3" then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return charactersGfxQuads, charactersNames, "llaxonPilot.png"
		end
	end

	function dialog:startDialog()
		return "HHrhhehhhh.  It's the puny Captain and the puny ship.  Join us for a feast aboard the destroyer and bring Clarence along."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "lastWarn" or dialog.currentOption == "die" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("howGetHere", nil, nil, nil, nil,
		"How did you find our colony?",
		"Your sub space signature...we followed it.  It lead us to this lovely little colony.  Ripe for feasting.  RIPE!")
	dialog.optionsList:add("leave", nil, nil, nil, nil,
		"Please leave.",
		"HHEHHEhehehhe.  NO!  Give us Clarence!  We won't ask again, we'll destroy everything...nothing will remain.")
	dialog.optionsList:add("leave2", "leave", nil, nil, nil,
		"(continue)...",
		"Meheh.  Captain!  That's an old Takataka ship.  It shouldn't be much of a match for us.  Big, but not very powerful.  And they painted it an awful "..
			"color.  That won't help either.")
	dialog.optionsList:add("leave3", "leave2", nil, nil, nil,
		"(continue)...",
		"Jarvis is right Captain.  I've scanned the ship and they have minimal weapons.  Two plasma turrets; take those out and they'll be dead in space.")
	dialog.optionsList:add("lastWarn", nil, "leave3", nil, nil,
		"Leave now.  This is your last warning",
		"PAHheheh.  DIE!")
	dialog.optionsList:add("die", nil, nil, nil, nil,
		"Charlie, open fire.",
		"AAHAHHahhh.")

	return dialog
end
