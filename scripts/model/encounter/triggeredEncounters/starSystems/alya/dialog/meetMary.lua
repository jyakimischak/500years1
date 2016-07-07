--####################################
-- meetMary.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog when you meet Mary on Alya I.
--####################################

--namespace model.dialog

function model.dialog.meetMary()
	local dialog = model.dialog.getDialog("meetMary")

	function dialog:getPortrait()
		if dialog.currentOption == "whoAreYou2" or dialog.currentOption == "fromArtemis3" or dialog.currentOption == "coordinates" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "fromArtemis2" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return charactersGfxQuads, charactersNames, "mary.png"
		end
	end

	function dialog:startDialog()
		return "Thank Om.  I thought I was going to be enslaved by those Llaxons for the rest of my life!  I owe you one."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "sendHelp2" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("whoAreYou", nil, nil, nil, nil,
		"Who am I speaking with?",
		"My name's Mary, I'm the head engineer here at the Alya research facility.  The Llaxon killed the rest of the staff, including all the scientists when "..
		"they attacked.  It's about time the space fleet did something about them.")
	dialog.optionsList:add("whoAreYou2", "whoAreYou", nil, nil, nil,
		"(continue)...",
		"We've had trouble from them before.  I think it's about time they crawled back into the ocean where they came from.")
	dialog.optionsList:add("whoAreYou3", "whoAreYou2", nil, nil, nil,
		"(continue)...",
		"I can't disagree with you.  So, were you here to drop off supplies?  Where you headed?  I'm pretty anxious to get going.")

	dialog.optionsList:add("fromArtemis", nil, "whoAreYou", nil, nil,
		"We're from the Artemis colony.",
		"Cute.  I'm not in the mood for jokes though, I just saw all my co-workers melted in front of me.  Now who are you really?")
	dialog.optionsList:add("fromArtemis2", "fromArtemis", nil, nil, nil,
		"(continue)...",
		"We're deeply sorry for your loss.  It's awful.  We understand, we've been through a lot too.  My sister was eaten by the Ants when I was young.  "..
		"It's never easy to see people you care about taken from you.")
	dialog.optionsList:add("fromArtemis3", "fromArtemis2", nil, nil, nil,
		"(continue)...",
		"It's true, we're from the Artemis.  Scan our ship; you'll see that we're telling the truth.")
	dialog.optionsList:add("fromArtemis4", "fromArtemis3", nil, nil, nil,
		"(continue)...",
		"I can't, the entire computer system's fried.  It'll take me months to get it back up and running again.\n\nI'm not sure if you're from the Artemis, "..
		"hell, I barely even remember history class.  All I care about is that you'll be able to take me home.  When can you come get me?")
	dialog.optionsList:add("fromArtemis5", "fromArtemis4", nil, nil, nil,
		"Where would you like us to take you?",
		"Any human colony is fine with me, but I'd prefer to stay away from New Earth...too much politics for my liking.")

	dialog.optionsList:add("coordinates", nil, "fromArtemis", nil, nil,
		"We're looking for human colonies.",
		"We don't have the coordinates to any human colonies.  We were sent from the Artemis colony to find help.  Do you have coordinates?")
	dialog.optionsList:add("coordinates2", "coordinates", nil, nil, nil,
		"(continue)...",
		"You've got to be joking.  Seriously!  The computers are FRIED!  I don't have any information to give you.")
	dialog.optionsList:add("coordinates3", "coordinates2", nil, nil, nil,
		"(continue)...",
		"I'm sorry, sorry.  Alright.  Could you please send help when you reach a colony?  I'd rather stay here and start cleaning the systems up "..
		"than come with you; no offense.  The Llaxon shouldn't be back any time soon, you cleaned up their fleet and they'll stay away for a while.")

	dialog.optionsList:add("llaxonAttack", nil, nil, nil, nil,
		"Why did the Llaxon attack you?",
		"They're after our research into the biofuel produced by bacteria in the oceans of this planet.  It's an untapped power source.  Several species "..
		"have discovered this planet and tried to harness the energy here, but the fuel is just too unstable.  You're likely to blow yourself up if you try to use it; hell "..
		"the oceans here explode every now and then.")
	dialog.optionsList:add("llaxonAttack2", "llaxonAttack", nil, nil, nil,
		"(continue)...",
		"I've come up with a process of refining it though and I've built a few prototype generators.  It's stable and can increase the power output of our ships.")
		
	dialog.optionsList:add("sendHelp", nil, "coordinates", nil, nil,
		"We'll send help.",
		"Thank you.  I'll be waiting for you to get back.  Before you go I have a present for saving me from those Llaxon.  Land and I'll install a biofuel "..
		"generator prototype in your ship.")
	dialog.optionsList:add("sendHelp2", "sendHelp", nil, nil, nil,
		"Thank you.",
		"See you soon Captain.")

	return dialog
end
