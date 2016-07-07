--####################################
-- meetJarvis.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the first meeting with Jarvis.
--####################################

--namespace model.dialog

function model.dialog.meetJarvis()
	local dialog = model.dialog.getDialog("meetJarvis")

	function dialog:getPortrait()
		if dialog.currentOption == "assistance2" or dialog.currentOption == "talkALot2" or dialog.currentOption == "talkALot3" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "assistance3" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "assistance4" then
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		else
			return crewGfxQuads, crewNames, "jarvis.png"
		end
	end

	function dialog:startDialog()
		return "An absolute pleasure to meet you.  I'll be your ambassador today.  I've taken the name Jarvis to add a degree of "..
		"comfort for our discussions.\n\nWill there be refreshments?"
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
	dialog.optionsList:add("tellAboutJarvis", nil, nil, nil, nil,
		"Tell me about yourself.",
		"Where to begin.  I was born on the home world, of course, and was selected at a very young age to enter the noble "..
		"profession of ambassadorship.  I was then sent off to a utopian world where all ambassadors live; our first planet.  It's amazing there...")
	dialog.optionsList:add("tellAboutJarvis2", "tellAboutJarvis", nil, nil, nil,
		"(continue)...",
		"It's a paradise there on Vulpecula I.  I lived in tree house...TREE HOUSE.  Can you believe that.  No predators are left "..
		"on the planet, the Takataka soldiers exterminated them years ago when the colony was established.  There I went to "..
		"school to be an official ambassador.  And here is my first chance to do any real work...")
	dialog.optionsList:add("tellAboutJarvis3", "tellAboutJarvis2", nil, nil, nil,
		"(continue)...",
		"So, now I'm here on my official ambassadorial assignment.  I get a name finally (you know us runts don't get names).  And "..
		"I get to go in a spaceship and talk to new and interesting creatures.  I'll miss my tree house though.  Oh well...perhaps "..
		"we can get those refreshments now?")
	dialog.optionsList:add("tellAboutTakataka", nil, nil, nil, nil,
		"Tell me about the Takataka.",
		"Alright, we are a strong and even tempered people.\n\nNot really actually; we're more of a strong, angry, colonialistic "..
		"people.  Our soldiers have crossed the cosmos seeking worlds to add to our great empire.")
	dialog.optionsList:add("tellAboutTakataka2", "tellAboutTakataka", nil, nil, nil,
		"(continue)...",
		"Our soldiers swarm enemies, after attempts at peaceful negotiations of course.  Our ships surround our enemies and overwhelm them "..
		"with superior numbers.  We are always willing to die for the Takataka race!  Well, they are, I'm not.  I'm a runt...runts are "..
		"not allowed to fight, or have names, or hold office, other than the office of ambassador of course.")
	dialog.optionsList:add("tellAboutTakataka3", "tellAboutTakataka2", nil, nil, nil,
		"(continue)...",
		"Takataka soldiers make up the majority of the population; taking time off from fighting to perform the other jobs necessary "..
		"for massive interstellar expansion.  Farming, cooking, cleaning, research and engineering.  Our soldiers do all of these jobs.  "..
		"Ambassadors on the other had live a life of absolute pleasure; until our assignment that is.")
	dialog.optionsList:add("tellAboutTakataka4", "tellAboutTakataka3", nil, nil, nil,
		"(continue)...",
		"Soldiers are dropped on Vulpecula II for an initiation ritual.  They must survive in horrible conditions that many do not live "..
		"through.  Ambassadors go to Vulpecula I to sit by the beach.")
	dialog.optionsList:add("tellAboutTakataka5", "tellAboutTakataka4", nil, nil, nil,
		"(continue)...",
		"In Takataka culture it is considered polite to give refreshments to guest, especially ambassadors.  Perhaps in the form of "..
		"sandwiches made with fresh meats and cheeses?")
	dialog.optionsList:add("ants", nil, nil, nil, nil,
		"Do you know about the ant aliens?",
		"Insectoid aliens that enslave other races?  No, I haven't heard of them.  Sometimes species can live right next to "..
		"each other and never meet.  Most species tend to stick to the routes they have established with interstellar coordinates.  "..
		"It's much easier then trying to fly places by conventional means; that takes too long.")
	dialog.optionsList:add("ants2", "ants", nil, nil, nil,
		"(continue)...",
		"We have these insects back at home that make clicking sounds when you hold them.  It's actually a sonic weapon used on "..
		"predators, but of course we're too large for it to have any effect on us.  It is rather loud though and can be employed "..
		"for a bit of entertainment on occasion.")
	dialog.optionsList:add("ants3", "ants2", nil, nil, nil,
		"(continue)...",
		"There was a time that my friend was sleeping by the beach after enjoying delightful snack time.  I snuck up "..
		"behind him and dropped the clickey-beetle right in his mouth!  The clicking made it sound like he was in fact a large "..
		"version of the clickey-beetle.  Excellent!\n\nThen he ate the beetle.")
	dialog.optionsList:add("assistance", nil, nil, nil, nil,
		"Can the Takataka help us.",
		"I suppose we could help you.  If you give me the coordinates of your home world/colony world we can send assistance immediately, I'm sure.")
	dialog.optionsList:add("assistance2", "assistance", nil, nil, nil,
		"(continue)...",
		"I don't really think we want the help of an aggressive, colonialist species.")
	dialog.optionsList:add("assistance3", "assistance2", nil, nil, nil,
		"(continue)...",
		"I agree; why not find out what he wants and we can get out of here in one piece.")
	dialog.optionsList:add("assistance4", "assistance3", nil, nil, nil,
		"(continue)...",
		"Francis doesn't like him, or them or any of this Captain.  I feel death coming near as sure as anything.")
	dialog.optionsList:add("assistance5", "assistance4", nil, nil, nil,
		"I'm sorry, I can't give you the coordinates.",
		"Oh well, no need really.  I was just trying something, but I don't think it would work anyways.\n\n*sigh*\n\nBack to my ambassadorial duties.")
	--this option can appear multiple times and will cut short one of Jarvis' rants
	local heardEnoughQuestion = "I think I've heard enough about this topic."
	local headEnoughResponse = "Of course, please pardon my carrying on." 
	dialog.optionsList:add("tellAboutJarvisHeardEnough", "tellAboutJarvis", nil, nil, nil, heardEnoughQuestion, headEnoughResponse)
	dialog.optionsList:add("tellAboutJarvis2HeardEnough", "tellAboutJarvis2", nil, nil, nil, heardEnoughQuestion, headEnoughResponse)
	dialog.optionsList:add("tellAboutTakatakaHeardEnough", "tellAboutTakataka", nil, nil, nil, heardEnoughQuestion, headEnoughResponse)
	dialog.optionsList:add("tellAbout2TakatakaHeardEnough", "tellAboutTakataka2", nil, nil, nil, heardEnoughQuestion, headEnoughResponse)
	dialog.optionsList:add("tellAbout3TakatakaHeardEnough", "tellAboutTakataka3", nil, nil, nil, heardEnoughQuestion, headEnoughResponse)
	dialog.optionsList:add("tellAbout4TakatakaHeardEnough", "tellAboutTakataka4", nil, nil, nil, heardEnoughQuestion, headEnoughResponse)
	dialog.optionsList:add("antsHeardEnough", "ants", nil, nil, nil, heardEnoughQuestion, headEnoughResponse)
	dialog.optionsList:add("antsHeardEnough2", "ants2", nil, nil, nil, heardEnoughQuestion, headEnoughResponse)
	dialog.optionsList:add("talkALot", nil, nil,
		function()
		   return dialog.selectedOptions.tellAboutJarvis ~= nil and
			   dialog.selectedOptions.tellAboutTakataka ~= nil and
			   dialog.selectedOptions.ants ~= nil and
			   dialog.selectedOptions.assistance ~= nil
		end, nil,
		"You're speaking a lot.",
		"Oh yes, that's one of the qualities of a good ambassador.  We need to be, and I quote,\n\n\"Runts that talk talk "..
		"talk\"\n\nAnd I suppose I fit those qualifications.  I'm small for my species and I do enjoy discussing almost any topic.")
	dialog.optionsList:add("talkALot2", "talkALot", nil, nil, nil,
		"(continue)...",
		"Captain.  I think our guest here has been distracting us.")
	dialog.optionsList:add("talkALot3", "talkALot2", nil, nil, nil,
		"Charlie, check the scanners.",
		"As I thought.  There are Takataka fighters inbound.  I'll send the boys to take care of Mr. Jarvis here.  "..
		"We'll need to prepare for a fight.")
	dialog.optionsList:add("bye", "talkALot3", nil, nil, nil,
		"(continue)...",
		"Refreshments!?...........")

	return dialog
end
