--####################################
-- olegIntro2.lua
-- author: Jonas Yakimischak
--
-- This dialog will be kicked off either after oleg shows the how to navigate cutscene or the player decides they don't
-- want to see the instructions.
--####################################

--namespace model.dialog

function model.dialog.olegIntro2()
	local dialog = model.dialog.getDialog("olegIntro2")

	function dialog:getPortrait()
		if dialog.currentOption == "howIsTheShip2" or
		   dialog.currentOption == "introWhatNow2" or
		   dialog.currentOption == "introWhatNow4"
		then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return crewGfxQuads, crewNames, "oleg.png"
		end
	end

	function dialog:startDialog()
		return "Alright friend, let's talk about what we need to do."
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
	dialog.optionsList:add("howIsTheShip", nil, nil, nil, nil,
		"How is the ship doing Oleg?",
		"It's flying; but I'm not sure for how long.  The thing's been out of commission so long that most of the wiring is just rust.  "..
		"Navigation system should take coordinates; that's a plus at least.  But I think I'll have to make corrections on the fly...how about we not "..
		"travel too far until that gets repaired.")
	dialog.optionsList:add("howIsTheShip2", "howIsTheShip", nil, nil, nil,
		"Charlie, how about the weapons systems?",
		"It looks like we have a considerable complement of nuclear torpedoes.  Not the most elegant weapons; but they are effective at long range.  "..
		"The torpedo bays need work though, as do the shields and armor.  If we meet much resistance we're going to have a bad day Captain.")
	dialog.optionsList:add("introWhatNow", nil, nil, nil, nil,
		"What do you think we should do next?",
		"We should check in with The Proctor.  He'll be looking for a report on the ship's status.  I'm sure he'll have orders for us...")
	dialog.optionsList:add("introWhatNow2", "introWhatNow", nil, nil, nil,
		"(continue)...",
		"...or we could think for ourselves...")
	dialog.optionsList:add("introWhatNow3", "introWhatNow2", nil, nil, nil,
		"(continue)...",
		"Even if you don't want to take orders from him, he has the coordinates we need.  Without those we're just floating...")
	dialog.optionsList:add("introWhatNow4", "introWhatNow3", nil, nil, nil,
		"(continue)...",
		"Alright; let's play along for now Oleg...but we can't just follow orders blindly!  A lot of people are depending on us...let's not forget that.")
	dialog.optionsList:add("bye", nil, "introWhatNow", nil, nil,
		"Let's go visit the Proctor.",
		"Sounds good.  Head to Artemis and we can speak with him.")

	return dialog
end
