--####################################
-- jarvisDefault.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when speaking with Jarvis.
--####################################

--namespace model.dialog

function model.dialog.jarvisDefault()
	local dialog = model.dialog.getDialog("jarvisDefault")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "jarvis.png"
	end

	function dialog:startDialog()
		return "Ah, Captain! How nice to see you. Did I ever tell you about that time in my tree house when..."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "Goodbye" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("yes", nil, nil, nil, nil,
		"Yes, you did I believe.",
		"Oh, alright then Captain.")
	dialog.optionsList:add("ants", nil, "yes", nil, nil,
		"What do you think of the Ants?",
		"They don't seem like an agreeable bunch to me.  And is it true they don't have any fur on their bodies!?  You humans are strange "..
		"enough with your sparse little tufts, but none at all!?  It's a bit revolting, almost makes me lose my appetite.")
	dialog.optionsList:add("food", nil, "yes", nil, nil,
		"For someone so obsessed with food, I'd expect you to be...\"larger\".",
		"Us Takataka have very fast metabolisms, so our love of food is written in our genes.  I am small for my race, but for a Takataka "..
		"to be soft around the edges is quite unusual.  A small percentage of our population does have a disposition for it, but they play "..
		"a special role in our society.")
	dialog.optionsList:add("food2", "food", nil, nil, nil,
		"What do you mean?",
		"Yes, well, I guess you are not aware, but they are a delicacy on our world.  Nothing I have ever tried of course!\n\nSince we're on the subject of "..
		"food, I've been meaning to talk with you about meal times.")
	dialog.optionsList:add("mealTime", nil, "food", nil, nil,
		"What about meal times?",
		"I do prefer to eat every hour. Right after a nap, and right before a nap.  And in the morning of course.  I'm afraid your daily allotment of "..
		"three rations a day is just barely enough to sustain poor little Jarvis.")
	dialog.optionsList:add("mealTime2", "mealTime", nil, nil, nil,
		"Well, that's all you get.",
		"JARVIS!  Um, well.  If that's how it has to be Captain.  um.  Well, perhaps snacks?")
	dialog.optionsList:add("Goodbye", nil, "yes", nil, nil,
		"Goodbye Jarvis.",
		"Bye bye.")

	return dialog
end
