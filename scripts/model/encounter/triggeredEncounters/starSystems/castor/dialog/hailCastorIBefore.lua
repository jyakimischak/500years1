--####################################
-- hailCastorIBefore.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for talking to the Malvar before we have moved their planet.
--####################################

--namespace model.dialog

function model.dialog.hailCastorIBefore()
	local dialog = model.dialog.getDialog("hailCastorIBefore")

	function dialog:getPortrait()
		if dialog.currentOption == "ungiriPlanetMover2" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "ungiriPlanetMover4" or dialog.currentOption == "whoAreYou2" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return charactersGfxQuads, charactersNames, "malvarWithCoat.png"
		end
	end

	function dialog:startDialog()
		return "Well, what have we here?  Visitors to our frozen little world."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "findHelp" then
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
		"Oh me.  I'm just a humble Malvar, Captain.  Please note that out planet is currently encased in ice and we have no resources for you to plunder.")
	dialog.optionsList:add("whoAreYou2", "whoAreYou", nil, nil, nil,
		"(continue)...",
		"I assure you that we are not here for any sort of plundering activities!")
	dialog.optionsList:add("whoAreYou3", "whoAreYou2", nil, nil, nil,
		"(continue)...",
		"Oh.  Well, all right.  Then why are you here?  We live a solemn life of reflection...a cold solemn life of reflection.  I'm not sure if we "..
		"have anything to offer you.")
	dialog.optionsList:add("aboutMalvar", nil, "whoAreYou", nil, nil,
		"Tell me about the Malvar.",
		"Well, we are a very peaceful people...even more-so since our sun receded.  This used to be a thriving planet until about 100 years ago.  "..
		"Our sun collapsed in on itself; I've seen the vids...it was spectacular.  But, then the cold came and that's where we are now.")
	dialog.optionsList:add("aboutPast", nil, nil, nil, nil,
		"You have advanced communications, why not space ships?",
		"We had spaceships once Captain.  Actually we likely do still have many under the ice.  But that was a long time ago and we were a "..
		"different people then.  Technology has a way of changing a species.  We made war, conquered stars, destroyed entire races, and for what?\n\n"..
		"Now we prefer to sit and think about what we've done.")
	dialog.optionsList:add("ungiriPlanetMover", nil, nil,
		function()
			return gameState.quests.malvarPlanet.learnedAboutUngiriPlanetMover and
				not gameState.quests.malvarPlanet.learnedAboutLepus
		end, nil,
		"We've met the Ungiri, they can move your planet.",
		"What?  Really.  They have the technology to move entire planets?  That's amazing, and strange.  We never really moved them, mostly just "..
		"conquered them...sometimes blew them up.  So, when can we get started?")
	dialog.optionsList:add("ungiriPlanetMover2", "ungiriPlanetMover", nil, nil, nil,
		"(continue)...",
		"It's not that simple.  The Ungiri don't just help people, they want something in return.")
	dialog.optionsList:add("ungiriPlanetMover3", "ungiriPlanetMover2", nil, nil, nil,
		"(continue)...",
		"Great.  Because we have a lot to offer on our LITTLE ICE BALL HERE!!  No no, I'm sorry.  Meditation...positive thoughts.\n\n"..
		"So, what do the Ungiri want?")
	dialog.optionsList:add("ungiriPlanetMover4", "ungiriPlanetMover3", nil, nil, nil,
		"(continue)...",
		"They are Lithovores and it seems that they would like a planet to eat.  Something with nice, rare minerals.")
	dialog.optionsList:add("ungiriPlanetMover5", "ungiriPlanetMover4", nil, nil, nil,
		"(continue)...",
		"Well, we only have the one planet...so I think that might be out.  Will they accept anything else?")
	dialog.optionsList:add("ungiriPlanetMover6", "ungiriPlanetMover5", nil, nil, nil,
		"They will accept coordinates to a system with planets.",
		"Hmmm...ok, That we can probably dig up.  A system with an unclaimed planet with rare minerals.  Ok ok ok...I know a place.  "..
		"I can guarantee that no one's been there for years.  It's a nice place...but you might want to speak with her first, she might get "..
		"upset if you just send the vultures after her...but, she's always willing to make a deal.")
	dialog.optionsList:add("ungiriPlanetMover7", "ungiriPlanetMover6", nil, nil,
		function()
			gameState.quests.malvarPlanet.learnedAboutLepus = true
			gameState.visibleStarMapLocations:add("lepus")
		end,
		"Her?",
		"Ya, go meet her and ask if she can help us.  Her name's Lepus; the system's named after her.  I've put the coordinates on your star "..
		"map Captain.\n\nThank you.")
	dialog.optionsList:add("ants", nil, nil, nil, nil,
		"Have you met the Ants?",
		"Yes, my people know them.  We learn about it in school...there were many battles and they learned to respect our power.  But that was long "..
		"ago.  Since our enlightenment we haven't had contact with their race.")
	dialog.optionsList:add("help", nil, nil, nil, nil,
		"We could use your assistance.",
		"I'm sorry Captain.  We don't have any resources that we could help you with.  We might be able to find a human colony for you, but our government "..
		"currently would not be willing to share that information with you..."..
		"they don't know if it would be \"misused\".  Perhaps if you could help us they might make an exception...")
	dialog.optionsList:add("help2", "help", nil, nil, nil,
		"What could we help you with?",
		"Well, any technology that would assist us in restoring our sun would be more than welcomed.  We can't live like this forever...our population "..
		"is in a decline.  We've thought long and hard about all the trouble we've caused and now we'd like to not live in the ice...")
	dialog.optionsList:add("lepusWillHelp", nil, nil,
		function()
			return gameState.quests.malvarPlanet.lepusAgreedToHelp
		end, nil,
		"Lepus agreed to help.",
		"Fantastic!  Please contact the Ungiri and arrange things.")
	dialog.optionsList:add("findHelp", nil, nil, nil, nil,
		"I'll see if I can find anything.",
		"Thank you Captain.")

	return dialog
end
