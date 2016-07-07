--####################################
-- clarenceDefault.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when speaking with Clarence.
--####################################

--namespace model.dialog

function model.dialog.clarenceDefault()
	local dialog = model.dialog.getDialog("clarenceDefault")

	function dialog:getPortrait()
		if gameState.francisDead then
			return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
		else
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		end
	end

	function dialog:startDialog()
		if gameState.francisDead then
			return "Hi Captain."
		else
			return "Captain!  It's good to see you."
		end
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
	dialog.optionsList:add("howAreYou", nil, nil,
		function()
			return not gameState.francisDead 
		end, nil,
		"How are you Clarence?",
		"I'm doing fine Captain.  I'm not sure if I thanked you for saving me from the Llaxon.\n\nThank you.")
	dialog.optionsList:add("howAreYou2", nil, nil,
		function()
			return gameState.francisDead 
		end, nil,
		"How are you Clarence?",
		"Not good Captain.  The rat ate my friend.")
	dialog.optionsList:add("howAreYou3", "howAreYou2", nil, nil, nil,
		"I'm sorry.",
		"It's not your fault.  Things like this happen to me.  But I make the best of it and carry on.")
	dialog.optionsList:add("francis", nil, nil,
		function()
			return not gameState.francisDead 
		end, nil,
		"How is Francis doing?",
		"Oh, he's just fine Captain.  He's been nibbling on the power relays, but I put a little hot sauce on them and he learned his lesson.")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Goodbye.",
		"Take care.")

	return dialog
end
