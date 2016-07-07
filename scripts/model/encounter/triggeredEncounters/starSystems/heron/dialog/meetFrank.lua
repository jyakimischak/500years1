--####################################
-- meetFrank.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when the player meets Frank at The Grove
--####################################

--namespace model.dialog

function model.dialog.meetFrank()
	local dialog = model.dialog.getDialog("meetFrank")

	function dialog:getPortrait()
		if dialog.currentOption == "oneWorld2" or dialog.currentOption == "help" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "oneWorld4" or dialog.currentOption == "theGrove2" or dialog.currentOption == "help2" then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return crewGfxQuads, crewNames, "frankNude.png"
		end
	end

	function dialog:startDialog()
		return "Looking to retire?\n"..
		"\n"..
		"No, no...you look a bit young for that....hmm.  Not a freight ship...\n"..
		"\n"..
		"You just here to gawk...WELL?  Out with it, I ain't got all day!  What do you want?"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "help5" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("hello", nil, nil, nil, nil,
		"Hello",
		"Yes, and hello to you Captain.  Now, how can I help you.  It's a nice day and I've got a lot of relaxing to do!")
	dialog.optionsList:add("whoAreYou", nil, "hello", nil, nil,
		"Who am I speaking with?",
		"Captain Frank Stone, One World Marine Corps, Retired.  And currently I'm the acting director of The Grove.")
	dialog.optionsList:add("oneWorld", nil, "whoAreYou", nil, nil,
		"What is One World?",
		"What?  Where have you been, every human belongs to One World.")
	dialog.optionsList:add("oneWorld2", "oneWorld", nil, nil, nil,
		"(continue)...",
		"We're from the Artemis colony.  We've been held captive by the Ants!")
	dialog.optionsList:add("oneWorld3", "oneWorld2", nil, nil, nil,
		"(continue)...",
		"What in Om's name are you talking about?...\n"..
		"\n"..
		"If that's true...that's impossible.")
	dialog.optionsList:add("oneWorld4", "oneWorld3", nil, nil, nil,
		"(continue)...",
		"I assure you it's true.  Scan our ship...it's the Captain's yacht off the Artemis...with some modifications of course.")
	dialog.optionsList:add("oneWorld5", "oneWorld4", nil, nil, nil,
		"(continue)...",
		"Om help us.  I'm so sorry, we didn't know.  We thought you were all lost.  If you survived, the others might still be out there...")
	dialog.optionsList:add("oneWorld6", "oneWorld5", nil, nil, nil,
		"What others?",
		"The other ships from Earth...this is all ancient history now.  The Artemis, Giza, Alexandria and Rhodes were sent out when Earth was dying.  "..
		"The Rhodes made it to establish the new human world.  We sent out scouts but the other ships were never heard from again.  "..
		"Then the Ants attacked.")
	dialog.optionsList:add("oneWorld7", "oneWorld6", nil, nil, nil,
		"(continue)...",
		"The great war started.  Om rose up and commanded our victory; he drove the Ants back and established victory for all of "..
		"humankind.  The One World began...humans above all others, as it must be.")
	dialog.optionsList:add("theGrove", nil, "whoAreYou", nil, nil,
		"What is the Grove?",
		"The Grove is a retreat for those who wish to live out their retirement years in a natural setting...and I gather from your "..
		"ignorance on the subject that you are not here to \"gawk\" as I spoke earlier.")
	dialog.optionsList:add("theGrove2", "theGrove", nil, nil, nil,
		"(continue)...",
		"No, we're not here to *gawk* Captain Stone.  We have more important matters to attend to.\n"..
		"\n"..
		"But, now that you mention it...and I'm sure I'll regret asking this.  Why are you nude?")
	dialog.optionsList:add("theGrove3", "theGrove2", nil, nil, nil,
		"(continue)...",
		"Heh.  We're a naturalist colony...nudist camp.  It's a lifestyle free from the stresses of modern life.  And a welcome break from "..
		"my life in the marines.")
	dialog.optionsList:add("help", nil, "oneWorld", nil, nil,
		"Our colony needs help.",
		"Please Captain Stone.  We were sent to find help if we can.  You're the first humans that we've had contact with that weren't pirates!  Or worse off than we are right now.")
	dialog.optionsList:add("help2", "help", nil, nil, nil,
		"(continue)...",
		"Our colony was taken over by the Ants, we've been fighting them for years Sir.  Guerrilla tactics.  They finally left and no one knows why or how.")
	dialog.optionsList:add("help3", "help2", nil, nil, nil,
		"(continue)...",
		"Why would they leave?  That makes no sense.  They fought us to the death every time.  We finally found a method of blinding them.  "..
		"They haven't been able to find the coordinates to our colonies in 2 centuries.\n"..
		"\n"..
		"I have a bad feeling about things.  I have a bit of a hunch, may I scan your ship?")
	dialog.optionsList:add("help4", "help3", nil, nil, nil,
		"Yes.",
		"Alright.  As I suspected, there is something on your ship Captain.  It's an Ant egg...and it looks like it's about to hatch.  Permission to come "..
		"aboard Sir?  I can't miss seeing this...")
	dialog.optionsList:add("help5", "help4", nil, nil, nil,
		"See you soon.",
		"I'll be heading your way...")

	return dialog
end
