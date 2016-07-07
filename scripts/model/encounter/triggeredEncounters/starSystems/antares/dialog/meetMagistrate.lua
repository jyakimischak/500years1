--####################################
-- meetMagistrate.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when you meet the magistrate at Antares.
--####################################

--namespace model.dialog

function model.dialog.meetMagistrate()
	local dialog = model.dialog.getDialog("meetMagistrate")

	function dialog:getPortrait()
		if dialog.currentOption == "frankHi" or dialog.currentOption == "frankHi4" or dialog.currentOption == "frankHi6" then
			return crewGfxQuads, crewNames, "frank.png"
		else
			return charactersGfxQuads, charactersNames, "magistrate.png"
		end
	end

	function dialog:startDialog()
		return "Hello.  Your ships configuration is not known to us; neither human or alien.\n\nMay I ask who you are and what the purpose of your visit is?"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "assist" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("frankHi", nil, nil, nil, nil,
		"(continue)...",
		"Magistrate.  Pardon our intrusion.  I'm Captain Frank Stone, One World Marine Corps, Retired.  This ship is from the Artemis Colony, come to ask "..
		"for our assistance.  Could we...")
	dialog.optionsList:add("frankHi2", "frankHi", nil, nil, nil,
		"(continue)...",
		"What!  What do you mean from the Artemis Colony.  Now Captain, tell me what this is all about!")
	dialog.optionsList:add("frankHi3", "frankHi2", nil, nil, nil,
		"We are from the Artemis Colony.",
		"The Artemis as in THE ARTEMIS that left Earth all those long years ago?  What kind of trickery is this?")
	dialog.optionsList:add("frankHi4", "frankHi3", nil, nil, nil,
		"(continue)...",
		"Magistrate; I'm telling you the truth.  They are from the Artemis and they saved The Grove, the colony where I retired to, from an "..
		"Ant hive attack.  I have no reason to doubt them, and look at their ship.  It's old Earth-tech; can't be anything else.")
	dialog.optionsList:add("frankHi5", "frankHi4", nil, nil, nil,
		"(continue)...",
		"As I'm sure you know Captain Stone, as Om has said, only the Rhodes was saved when Earth was destroyed.  We are the chosen people.  The other colonies "..
		"fell off the chosen path and disappeared into madness and despair.")
	dialog.optionsList:add("frankHi6", "frankHi5", nil, nil, nil,
		"(continue)...",
		"Those are stories Magistrate, I've heard them too.  But here we have...")
	dialog.optionsList:add("frankHi7", "frankHi6", nil, nil, nil,
		"(continue)...",
		"THE WORDS OF OM ARE NOT STORIES CAPTAIN STONE!\n\nAh, but where are my manners.  Hello Captain, and hello to your crew.  You are in need of assistance?")
	dialog.optionsList:add("assist", "frankHi7", nil, nil, nil,
		"Yes.  Our colony needs help.",
		"Please, tell me more.")

	return dialog
end
