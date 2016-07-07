--####################################
-- llaxonAlyaI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog when the Llaxon fleet attacks you at Alya I.
--####################################

--namespace model.dialog

function model.dialog.llaxonAlyaI()
	local dialog = model.dialog.getDialog("llaxonAlyaI")

	function dialog:getPortrait()
		if dialog.currentOption == "doingHere2" or dialog.currentOption == "doingHere3" or dialog.currentOption == "distressSignal2" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "whyBomb3" then
			if gameState.francisDead then
				return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
			else
				return crewGfxQuads, crewNames, "clarenceWithGoat.png"
			end
		elseif dialog.currentOption == "whyBomb4" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return charactersGfxQuads, charactersNames, "llaxonPilot.png"
		end
	end

	function dialog:startDialog()
		return "Morsels...hhhHHrhrheeh.\n\nThis planet belongs to the glory of the Llaxon race.  Our tendrils reach out to you in an embrace of friendship!"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "launchProbe" or dialog.currentOption == "die" or dialog.currentOption == "leave" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("doingHere", nil, nil, nil, nil,
		"Why are you here?",
		"NAAWWaawhhehhe.  We are here for scientific discovery.  Friendship, and happy things.\n\nI would offer you an invitation to join me for a feast upon "..
		"my ship.  We have much to........discussss..eHhEheh")
	dialog.optionsList:add("doingHere2", "doingHere", nil, nil, nil,
		"(continue)...",
		"Not this again.  Captain, permission to open fire?")
	dialog.optionsList:add("doingHere3", "doingHere2", nil, nil, nil,
		"Not yet Charlie.",
		"Alright Captain.")
	dialog.optionsList:add("doingHere4", "doingHere3", nil, nil, nil,
		"Thank you but I must decline the offer.",
		"FINE!")

	dialog.optionsList:add("whyBomb", nil, nil, nil, nil,
		"Why did you bomb the research station?",
		"Oh yes, we had to for the glory of the Llaxon race!  hehehhe.")
	dialog.optionsList:add("whyBomb2", "whyBomb", nil, nil, nil,
		"I don't understand.",
		"They were stealing our research!  The humans!  This planet is under the direct control of the mighty Llaxon empire.  The remaining humans are now "..
		"under our authority.  yesssss.")
	dialog.optionsList:add("whyBomb3", "whyBomb2", nil, nil, nil,
		"(continue)...",
		"Come off it now.  Captain hurry up and shoot.  I'm tired of hearing this...and you heard him.  There are humans down there to save.")
	dialog.optionsList:add("whyBomb4", "whyBomb3", nil, nil, nil,
		"(continue)...",
		"Clarence may be correct friend.  I'm not sure we can get very far talking to a Llaxon.")

	dialog.optionsList:add("distressSignal", nil, nil, nil, nil,
		"We received a distress signal from the planet.",
		"BAAaa!  LIES!  There is no distress signal, LEAVE!  I didn't want to feast \"with\" you anyways!")
	dialog.optionsList:add("distressSignal2", "distressSignal", nil, nil, nil,
		"(continue)...",
		"Well, you won't mind if we send a probe down to check on it then will you?")
	dialog.optionsList:add("distressSignal3", "distressSignal2", nil, nil, nil,
		"(continue)...",
		"NO!  Launching the probe onto our planet is an act of war.  We will have no choice but to destroy you!")

	dialog.optionsList:add("launchProbe", nil, "distressSignal3", nil,
		function()
			gameState.AlyaILlaxonProvoked = true
		end,
		"Launch the probe.",
		"AH!  Die human Captain!")

	dialog.optionsList:add("die", nil, nil, nil,
		function()
			gameState.AlyaILlaxonProvoked = true
		end,
		"Charlie, open fire.",
		"AH!  Mistake human Captain!")

	dialog.optionsList:add("leave", nil, nil, nil, nil,
		"We'll be leaving.",
		"BYE!")

	return dialog
end
