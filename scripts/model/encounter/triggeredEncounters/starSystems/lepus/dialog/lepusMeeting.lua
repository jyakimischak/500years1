--####################################	
-- lepusMeeting.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when you speak to Lepus but have not yet made any deals with the Ungiri.
--####################################

--namespace model.dialog

function model.dialog.lepusMeeting()
	local dialog = model.dialog.getDialog("lepusMeeting")

	function dialog:getPortrait()
		if dialog.currentOption == "malvar3" or dialog.currentOption == "ants2" or dialog.currentOption == "ungiri2" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "ungiri4" then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return charactersGfxQuads, charactersNames, "lepus.png"
		end
	end

	function dialog:startDialog()
		return "Visitors.  Interesting visitors.  With interesting scanners.  Like before, coming to meet Lepus."
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
	dialog.optionsList:add("hello", nil, nil, nil, nil,
		"Hello, the Malvar sent us to speak with you.",
		"Malvar...an old name.  Not the oldest or the fondest.  We spoke long and shared knowledge.  They found some knowledge...uncomfortable")
	dialog.optionsList:add("malvar", nil, "hello", nil, nil,
		"What do you know about the Malvar?",
		"I know of their once cruelty and their repentance.  I know of their conquests.  Raining terror over many worlds.  I had to converse with them "..
		"on these matters and ensured it would not continue.")
	dialog.optionsList:add("malvar2", "malvar", nil, nil, nil,
		"Ensured it would not continue?",
		"The young often do not understand life.  The Malvar are very young compared to Lepus.  They were open to listening and I told them things.  "..
		"I shared some understanding.  They have been thinking about these things ever since at the cost of all they had gained.  Perhaps I should "..
		"have been more kind...")
	dialog.optionsList:add("malvar3", "malvar2", nil, nil, nil,
		"(continue)...",
		"Care must be taken when kindness is given.")
	dialog.optionsList:add("notOldest", nil, "hello", nil, nil,
		"You mentioned the Malvar were not the oldest.",
		"Yes, not the oldest or fondest.  There are the old ones.  I do not think they took a name.  Long before Lepus they were here.")
	dialog.optionsList:add("notOldest2", "notOldest", nil, nil, nil,
		"Interesting; do you think they could offer us assistance.",
		"Yes.  They could.  But their help comes with a price.  Avoid them.  They do not have an inherent sense of good and evil.")
	dialog.optionsList:add("knowledge", nil, "hello", nil, nil,
		"What knowledge did you give the Malvar.",
		"I showed them how ethical responsibility is necessary for the long-term prosperity of any sapient life form.  I believe they have been trying to "..
		"think of a loop hole.  Poor Malvar.")
	dialog.optionsList:add("ants", nil, "hello", nil, nil,
		"Have you encountered an insectoid species?",
		"Many, very many over many years...")
	dialog.optionsList:add("ants2", "ants", nil, nil, nil,
		"(continue)...",
		"You'd remember these ones.  They enslave planets!")
	dialog.optionsList:add("ants3", "ants2", nil, nil, nil,
		"(continue)...",
		"Yes.  I know the ones.  They were not able to listen.  I showed them that it is wrong to harvest the organic material of sentient "..
		"races.  They were not able to understand.  I have not seen them again for many many years.  Physical force should be used when dealing with them.")
	dialog.optionsList:add("ungiri", nil, "hello",
		function()
			return not gameState.quests.malvarPlanet.lepusAgreedToHelp
		end,
		function()
			gameState.quests.malvarPlanet.lepusAgreedToHelp = true
		end,
		"The Malvar's planet is encased in ice.",
		"Poor poor Malvar.  They learned so well my lessons.  Is there any way that you can help them?")
	dialog.optionsList:add("ungiri2", "ungiri", nil, nil, nil,
		"(continue)...",
		"In fact there is.  We met a race called the Ungiri.  They have the ability to move the Malvar home world closer to its sun!")
	dialog.optionsList:add("ungiri3", "ungiri2", nil, nil, nil,
		"(continue)...",
		"That seems like a fair solution.  Then why speak with Lepus?  Why were you sent to me?")
	dialog.optionsList:add("ungiri4", "ungiri3", nil, nil, nil,
		"(continue)...",
		"The Ungiri will not assist the Malvar unless we find a mineral rich planet for them as trade.  The Malvar felt that you may be able to assist "..
		"with this.")
	dialog.optionsList:add("ungiri5", "ungiri4", nil, nil, nil,
		"(continue)...",
		"They want one of my children?  That could be acceptable, 2 did not gain conscience...only Lilepus awoke.  This seems like a fair trade.  "..
		"Perhaps with that the poor Malvar can begin life anew.  Tell the Ungiri to meet me, I will discuss things with them.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"We'll speak with you again later.",
		"Goodbye.")

	return dialog
end
