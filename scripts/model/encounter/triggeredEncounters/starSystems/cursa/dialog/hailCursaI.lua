--####################################
-- hailCursaI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when hailing Cursa I (when Clarence is still on the planet).
--####################################

--namespace model.dialog

function model.dialog.hailCursaI()
	local dialog = model.dialog.getDialog("hailCursaI")

	function dialog:getPortrait()
		if dialog.currentOption == "weapons2" or
		   dialog.currentOption == "help3" or
		   dialog.currentOption == "sendLander"
		then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "help2"
		then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		end
	end

	function dialog:startDialog()
		if not gameState.quests.repairs.cursaIHailed then
			return "Ah, yes yes.  Hmmm, you look like a human....the Llaxon won't like this.\n\nFrancis, life's about to get interesting again.  Now that's something to be happy about."
		else
			return "Francis; our human friends have returned.  Any news from those Llaxon buggers?"
		end
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "bye" or
		   dialog.currentOption == "takeCare"
		then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("whoAreYou", nil, nil, nil, nil,
		"Hello.  Who am I speaking with?",
		"Well, well, well.  My names Clarence and this here is my friend Francis.  I'm the lead engineer at the old dump here "..
		"(well, truth be told I'm the only engineer left..the Llaxon haven't exactly been kind to my family).")
	dialog.optionsList:add("family", nil, "whoAreYou", nil, nil,
		"You mentioned your family.  What happened to them?",
		"The Llaxon killed them.  Well, starved them out is more like it.  We've been here for years, come from The Giza originally.  "..
		"When the Llaxon finally found us they killed all our livestock.  That made us dependent on the Llaxon for food....but they "..
		"wanted technology in exchange.")
	dialog.optionsList:add("howAreYouAlive", nil, nil, nil, nil,
		"Our scans show deadly radiation levels; how are you alive?",
		"Genetic mutations.  The story goes that part of The Giza was hit by a radiation storm.  Most folks died, but my family and "..
		"some of the goats managed to live.  We sorta adapted to it over the years.\n\nWe all got kind of a \"simple\" look to us as "..
		"a side effect.  Don't let that fool you, I was the lead engineer here even before my people were killed.")
	dialog.optionsList:add("whoIsGoat", nil, nil, nil, nil,
		"What's with the goat?",
		"Oh, this here is Francis.  He's the last of his kind and the only friend I have left.\n\nThe others were killed by the Llaxons; BUGDERDS!")
	dialog.optionsList:add("weapons", nil, nil, nil, nil,
		"So, you're building weapons for the Llaxons?",
		"Yes, I suppose I am.  That's what they wanted...the reason why they killed my people.\n\nI'll tell you a little secret "..
		"though.  These are high firing rate, low damage weapons.  In other words you have to shoot them a lot to do any damage.  "..
		"I've put in a 2% failure rate.  2% of the time they backfire.  I've killed more Llaxons with these then you could imagine.")
	dialog.optionsList:add("weapons2", "weapons", nil, nil, nil,
		"(continue)...",
		"Impressive work.  Have you thought about working this on a larger scale?")
	dialog.optionsList:add("weapons3", "weapons2", nil, nil, nil,
		"(continue)...",
		"Oh yes I have ma'am.  I'm working on convincing them to install a planetary defense system.  Then \"boom\"....no "..
		"more Llaxons.  (and no more supplies for me either....fair trade)")
	dialog.optionsList:add("llaxon", nil, nil, nil, nil,
		"Who are the Llaxon?",
		"The Llaxons embody greed and evil.  They crawled out of the water on their planet not long ago...still think things are "..
		"eat or be eaten.  They killed my people, and they're trying to take over more worlds (which might be difficult using the weapons I build for them).")
	dialog.optionsList:add("llaxon2", nil, nil, 
		function()
			return gameState.quests.repairs.spokeWithLlaxon and dialog.selectedOptions["llaxon"] ~= nil
		end, nil,
		"Speaking of eat or be eaten.  Then keep inviting me to \"feast\" with them.",
		"Ya, the Llaxon like to eat every new being they see.  They tried it first with my people...then they died of radiation poisoning.  "..
		"Never tried that again.  Of course, they found worse ways to torment us...")
	dialog.optionsList:add("help", nil, "whoAreYou", nil, nil,
		"We could use your help.",
		"What kind of help do you need?")
	dialog.optionsList:add("help2", "help", nil, nil, nil,
		"(continue)...",
		"Our ship...it comes off the Artemis herself.  It's as old as our stories.  Half the ship is rust at this point.  We "..
		"need parts.\n\nSomeone who knows how to install parts would be welcome as well...")
	dialog.optionsList:add("help3", "help2", nil, nil, nil,
		"(continue)...",
		"Our weapons systems could use an upgrade as well.  I could use some assistance; if it were offered.")
	dialog.optionsList:add("help4", "help3", nil, nil, nil,
		"(continue)...",
		"I see.")
	dialog.optionsList:add("help5", "help4", nil, nil, nil,
		"Well, what do you say Clarence?  Would you like to join us?",
		"Absolutely.  Come pick me up.  One thing though...the Llaxon are likely coming over for a little meet and greet with you.  "..
		"I make most of their weapons, propulsion system...well; I basically designed their entire fleet.  They don't have the best "..
		"ships, but they might be a match for a 500 year old relic...")
	dialog.optionsList:add("sendLander", "help5", nil, nil, nil,
		"Charlie, quickly land and pick him up.",
		"Right away captain...and I'll set up a radiation detox for our friends when they "..
		"arrive.\n\nI'd also advise you to make this quick as several ships are approaching.")
	dialog.optionsList:add("takeCare", "sendLander", nil, nil, nil,
		"Let's take care of those...Clarence, please stand by.",
		"See you soon...Captain.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"I'll be back to speak with you.",
		"Alright.")

	return dialog
end