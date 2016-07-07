--####################################
-- charlieDefault.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when speaking with Charlie.
--####################################

--namespace model.dialog

function model.dialog.charlieDefault()
	local dialog = model.dialog.getDialog("charlieDefault")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Hello Captain, do you need something?"
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
	dialog.optionsList:add("tutorial", nil, nil, nil,
		function()
			model.encounter.getTriggeredEncounter("combatTutorialCutScene")
		end,
		"Could you tell me how combat works?",
		"")
	dialog.optionsList:add("ants", nil, nil, nil, nil,
		"What do you think of the Ants?",
		"What can I think about them!?  Those ruthless monsters nearly destroyed our entire population.  If it's the last thing I do I'll "..
		"make sure they get what they deserve.\n\n"..
		"In a way I miss my freedom fighter days, using explosives has a certain satisfaction that I can't get on a ship.")
	dialog.optionsList:add("fighter", nil, nil, nil, nil,
		"Did being a freedom fighter have an effect on you?",
		"Of course, that violence provided a purpose for me.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Bye Charlie.",
		"Goodbye Captain.")

	return dialog
end
