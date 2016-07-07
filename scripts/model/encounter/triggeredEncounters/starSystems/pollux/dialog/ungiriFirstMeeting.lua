--####################################
-- ungiriFirstMeeting.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the first meeting with the Ungiri.
--####################################

--namespace model.dialog

function model.dialog.ungiriFirstMeeting()
	local dialog = model.dialog.getDialog("ungiriFirstMeeting")

	function dialog:getPortrait()
		if dialog.currentOption == "ants2" or
			dialog.currentOption == "help2" or
			dialog.currentOption == "help5" or
			dialog.currentOption == "lepus2"
		then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "askAboutMalvar3"
		then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return charactersGfxQuads, charactersNames, "ungiri.png"
		end
	end

	function dialog:startDialog()
		return "Welcome prospective consumer!  Allow me to welcome you with my utmost sincerity to our humble planet."
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
	dialog.optionsList:add("whoAreYou", nil, nil, nil, nil,
		"Who are you?",
		"I am a vassal of the Ungiri race.  Trained to offer you the most profitable deals; allowing both of our peoples to prosper.")
	dialog.optionsList:add("whoAreUngiri", nil, "whoAreYou", nil, nil,
		"Who are the Ungiri?",
		"The Ungiri are an ancient race of traders; steeped in knowledge and history.  If you need goods look no "..
		"further.  We will supply what you need; at prices you can afford...guaranteed!")
	dialog.optionsList:add("asteroids", nil, nil, nil, nil,
		"Why are there asteroids in your solar system?",
		"Ah...those are not asteroids; those where once planets!  You see my people are lithotrophic.  We consume minerals directly for sustenance.  \n\n"..
		"There aren't many calories in rocks...so over the years we, well, ate those planets.  Even our once great home world was eaten.")
	dialog.optionsList:add("whyNotEaten", "", "asteroids", nil, nil,
		"Why has this planet not been eaten?",
		"We tried.  It turns out that we have a severe allergy to the minerals found here.  Good thing for us too or we might have been without a proper "..
		"home in Pollux.  That would have been a devastating blow to our people!")
	dialog.optionsList:add("whereGetPlanets", nil, "whyNotEaten", nil, nil, 
		"Where do you get food now?",
		"Well...as a matter of fact we've developed a technology to move entire planets.  We move the planets here to our system and then we have a new "..
		"source of food.  We're particularly interested in exotic minerals...delicacies.")
	dialog.optionsList:add("askAboutMalvar", nil, nil,
		function()
			return gameState.metMalvar and not gameState.quests.malvarPlanet.lepusAgreedToHelp
		end, nil,
		"We met the Malvar, their planet is too far from its sun.",
		"Well, that we can help with.  We have the technology to move their planet closer to their star and brighten their lives!  "..
		"For a fair price of course.")
	dialog.optionsList:add("askAboutMalvar2", "askAboutMalvar", nil, nil,
		function()
			gameState.quests.malvarPlanet.learnedAboutUngiriPlanetMover = true
		end,
		"What can they trade?",
		"Well, do they have any unused planets in their system with unusual minerals?  That would be a fair trade...assuming the minerals were of "..
		"a sufficient quality.")
	dialog.optionsList:add("askAboutMalvar3", "askAboutMalvar2", nil, nil, nil,
		"(continue)...",
		"No.  They only have one planet in their system, and I think they might want to keep it.")
	dialog.optionsList:add("askAboutMalvar4", "askAboutMalvar3", nil, nil, nil,
		"(continue)...",
		"Ah, what a pity.  Well, if they have any holdings in other systems or know of a rare, unclaimed planet then we are more than willing to trade.")
	dialog.optionsList:add("ants", nil, nil, nil, nil,
		"Have you met the Ants?",
		"Yes, yes we have.  They're devils.  We've had some of our colonies attacked by them.  They always fight and never trade...it's just "..
		"not good for business!  Luckily they haven't found Pollux yet or we'd have a war on our hands.")
	dialog.optionsList:add("ants2", "ants", nil, nil, nil,
		"(continue)...",
		"I feel your pain...we all feel your pain...")
	dialog.optionsList:add("ants3", "ants2", nil, nil, nil,
		"Do you know where they come from?",
		"No, and we don't want to know.  We just want them away from us.  Far far away.")
	dialog.optionsList:add("help", nil, nil, nil, nil,
		"Our colony needs assistance?",
		"Well, it's not our custom to offer help without a fair trade being involved.  I'm not sure what you would like us to do...")
	dialog.optionsList:add("help2", "help", nil, nil, nil,
		"(continue)...",
		"Please, anything you can do.")
	dialog.optionsList:add("help3", "help2", nil, nil, nil,
		"(continue)...",
		"Well...what do you have to trade.  Make me an offer.")
	dialog.optionsList:add("help4", "help3", nil, nil, nil,
		"We don't have anything.",
		"Then I'm sorry.  I won't be able to help you.")
	dialog.optionsList:add("help5", "help4", nil, nil, nil,
		"(continue)...",
		"If you won't help do you at least know the coordinates of any human colonies where we might get assistance?")
	dialog.optionsList:add("help6", "help5", nil, nil, nil,
		"(continue)...",
		"No, sorry.  We don't deal with the human colonies...they never really want to trade.")
	dialog.optionsList:add("lepus", nil, nil,
		function()
			return gameState.quests.malvarPlanet.lepusAgreedToHelp
		end,
		function()
			gameState.quests.malvarPlanet.ungiriAgreedToMovePlanet = true
		end,
		"We found a planet to trade for helping the Malvar.",
		"Oh, a trade...now that does sound excellent.  Please tell me about this planet.")
	dialog.optionsList:add("lepus2", "lepus", nil, nil, nil,
		"(continue)...",
		"It is a mineral rich planet that was created by Lepus, a living planet in the solar system.  I'm sure you'll love it.")
	dialog.optionsList:add("lepus3", "lepus2", nil, nil, nil,
		"(continue)...",
		"Now that does sound perfect.  Please transfer the coordinates to us and we'll go visit this planet.  If everything is in order we'll head to "..
		"the Castor system to meet you and move the planet.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Thank you for your time.",
		"Please come back soon, we're always willing to trade!")

	return dialog
end
