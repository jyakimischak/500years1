--####################################
-- llaxonLeader.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for llaxon leader.
--####################################

--namespace model.dialog

function model.dialog.llaxonLeader()
	local dialog = model.dialog.getDialog("llaxonLeader")

	function dialog:getPortrait()
		if dialog.currentOption == "whoAreTheLlaxon3" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "knowAboutAnts2" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return charactersGfxQuads, charactersNames, "llaxonLeader.png"
		end
	end

	function dialog:startDialog()
		--if you already have Clarence then they should be hostile
		if gameState.crew.clarence then
			return "HHehhehhh.  The Clarence stealers.  Well, why not come for ritualistic feasting.  There is much we must discuss!"
		else		
			return "Tastey souls around my planet.  I invite you to land and join me in ritualistic feasting! Hhheeehh"
		end
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "byeNoClarence" or dialog.currentOption == "byeClarence" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("whoAreYou", nil, nil, nil, nil,
		"May I ask who I'm speaking to?",
		"Hehehhh.  I'm The First Llaxon.  First on the surface, first in the waters.")
	dialog.optionsList:add("whoAreTheLlaxon", nil, nil, nil, nil,
		"What can you tell me about the Llaxon?",
		"We came from the deep to the surface.  This is our first world; the place of spawning.  Hhhehhe.\n\nI would enjoy telling you more in person...")
	dialog.optionsList:add("whoAreTheLlaxon2", "whoAreTheLlaxon", nil, nil, nil,
		"Maybe in a bit, I'd love to learn more about you now.",
		"hhehhHHhe. We are new to the surface; we come from the deeps.  We build tendils to stretch to other worlds.  We want to meet "..
		"all...and to feast...with...Frendshippp\n\nNOW!  Land for the FEAST!!  HeHhhhH!")
	dialog.optionsList:add("whoAreTheLlaxon3", "whoAreTheLlaxon2", nil, nil, nil,
		"(continue)...",
		"Why not land captain?  He seems like a pleasant fellow.  I'd like to meet him face to face, have a little conversation about manners...")
	dialog.optionsList:add("whoAreTheLlaxon4", "whoAreTheLlaxon3", nil, nil, nil,
		"No, we won't be joining you at this time.",
		"RRHHRHH. Fine!  But come soon.")
	dialog.optionsList:add("knowAboutAnts", nil, nil, nil, nil,
		"Have you encountered the Ant species before?",
		"They came down for the feast...hmmmhhm.  They said we lacked diversity...then left.  That is all I know of them.")
	dialog.optionsList:add("knowAboutAnts2", "knowAboutAnts", nil, nil, nil,
		"(continue)...",
		"Hmmm.  I'm thinking that the Ants were not interested in cultural diversity friend.  We'll need to think on this...")
	dialog.optionsList:add("canYouHelp", nil, nil, nil, nil,
		"We could use repairs or supplies, would you be able to assist us?",
		"Hhhehhh.  No.")
	dialog.optionsList:add("byeNoClarence", nil, nil,
		function()
			return not gameState.crew.clarence
		end, nil,
		"I'm leaving now.",
		"ARglgaga.  HHhehhh.  I'm sure you'll join me soon....")
	dialog.optionsList:add("byeClarence", nil, nil,
		function()
			return gameState.crew.clarence
		end, nil,
		"I'm leaving now.",
		"AAHHHHHAHH,  NO!  Clarence must be returned.  Our tendrils will greet you!")

	return dialog
end
