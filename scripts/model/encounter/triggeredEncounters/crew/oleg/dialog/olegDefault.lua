--####################################
-- olegDefault.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when speaking with Oleg.
--####################################

--namespace model.dialog

function model.dialog.olegDefault()
	local dialog = model.dialog.getDialog("olegDefault")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "oleg.png"
	end

	function dialog:startDialog()
		return "Ah, Captain. Good to see you!"
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
			model.encounter.getTriggeredEncounter("showHowToNavigateCutScene")
		end,
		"Could you tell me how the ship's navigation works?",
		"")
	dialog.optionsList:add("ants", nil, nil, nil, nil,
		"What do you think of the Ants?",
		"Gospodi, they have brought much sadness into our lives. Many died, and those who live carry wounds. Such disregard for "..
		"life.\n\n".. 
		"But I am very grateful for our new situation here. Opportunities! Plus, anything is better than fighting a hopeless "..
		"war, isn't it my friend?  Who knows, perhaps our actions today will help build a future for our children.")
	dialog.optionsList:add("ants2", "ants", nil, nil, nil,
		"I didn't know you had children.",
		"No no Captain, just a figure of speech.  I would like to have little ones of my own one day though.  I had a dear friend back at the "..
		"colony.  I didn't realize how I felt about her until I left for this mission.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Goodbye Oleg.",
		"Bye friend.")

	return dialog
end
