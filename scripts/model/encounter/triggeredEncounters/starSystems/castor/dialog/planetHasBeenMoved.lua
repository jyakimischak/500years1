--####################################
-- planetHasBeenMoved.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking with the Malvar right after their planet has been moved.
--####################################

--namespace model.dialog

function model.dialog.planetHasBeenMoved()
	local dialog = model.dialog.getDialog("planetHasBeenMoved")

	function dialog:getPortrait()
		if dialog.currentOption == "thankYou" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "thankYou2" then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return charactersGfxQuads, charactersNames, "malvarWithoutCoat.png"
		end
	end

	function dialog:startDialog()
		return "Captain!  Oh Captain.  Look, I'm not wearing my coat!  I can actually *feel* the sun.  It's amazing."
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
	dialog.optionsList:add("good", nil, nil, nil, nil,
		"I'm glad that things are working well for you.",
		"They are Captain and it's all thanks to you.  My brain is moving faster, everything is so perfect.  Captain, if my people ever rain destruction "..
		"throughout the cosmos again, humanity will hold a special place in our hearts.  We remember our friends Captain!")
	dialog.optionsList:add("meditation", nil, "good", nil, nil,
		"Are you done meditating?",
		"No, I suppose we aren't.  We still have a lot to think about...but it's very hard to think when the warmth is in your bones.")
	dialog.optionsList:add("coordinates", nil, "good", nil, nil,
		"Do you have the coordinates?",
		"Yes, of course Captain.  Here are the coordinates to the one human outpost that we have on record.  Good luck!")
	dialog.optionsList:add("thankYou", "coordinates", nil, nil, nil,
		"(continue)...",
		"Thank you for renewing our hope.  Our colony needs us!")
	dialog.optionsList:add("thankYou2", "thankYou", nil, nil, nil,
		"(continue)...",
		"Thank you.  We will remember this.")
	dialog.optionsList:add("bye", nil, "coordinates", nil, nil,
		"Thank you and goodbye.",
		"Thank you Captain.")

	return dialog
end
