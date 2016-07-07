--####################################
-- proctorTheBeginning.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the proctor for whe the game begins..
--####################################

--namespace model.dialog

function model.dialog.proctorTheBeginning()
	local dialog = model.dialog.getDialog("proctorTheBeginning")

	function dialog:getPortrait()
		if dialog.currentOption == "needsRepairs" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "needsRepairs2" then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return charactersGfxQuads, charactersNames, "proctor.png"
		end
	end

	function dialog:startDialog()
		if not gameState.quests.repairs.started then
 			return "Captain!  It's good to see you out there.  This is a great day for our little colony.  How is the ship running?"
		else
			return "Captain."
		end
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
	dialog.optionsList:add("needsRepairs", nil, nil, 
		function()
			return not gameState.quests.repairs.started
		end, nil,
		"Here is the report.",
		"The ship hasn't aged particularly well Proctor.  Essentially every system needs repairs.  The engines are almost shot; navigation should "..
		"function, for nearby systems.  We also don't have enough power for all systems to run at peak efficiency.")
	dialog.optionsList:add("needsRepairs2", "needsRepairs", nil, nil, nil,
		"(continue)...",
		"Weapons systems are functional but I don't have the power output to use the level 3 weaponry.  We do have what we need, assuming we can increase the energy generators.")
	dialog.optionsList:add("needsRepairs3", "needsRepairs2", nil, nil, nil,
		"(continue)...",
		"Good.  With a little bit of work, and luck you'll have the ship fully operational soon.")
	dialog.optionsList:add("nextSteps", nil, nil, nil, nil,
		"What are our next steps?",
		"Frankly we need help.  I think we need to seek out the other human colonies.  Someone must have survived.  The only coordinates I "..
		"have are for the old scrap world, Cursa.  The one our forefathers discovered.  There should be enough parts there for you to repair "..
		"the ship at least.  And, hopefully there will be an old star map we can use.  I'll transfer the coordinates to your ship.  Good luck.")
	dialog.optionsList:add("howAreThings", nil, nil, nil, nil,
		"How are things in the colony?",
		"Things haven't changed much since you left.  We're beginning work on re-educating the population.  We need outside assistance though; "..
		"resources are running low.  We can't sustain ourselves for long this way. We're all counting on you Captain!")
	dialog.optionsList:add("bye", nil, "nextSteps", nil, nil,
		"I'll hail you when I have more news.",
		"I'm looking forward to it Captain.")

	return dialog
end
