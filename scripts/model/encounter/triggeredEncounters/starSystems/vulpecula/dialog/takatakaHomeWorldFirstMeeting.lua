--####################################
-- takatakaHomeWorldFirstMeeting.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the first meeting with the takataka on their home world.
--####################################

--namespace model.dialog

function model.dialog.takatakaHomeWorldFirstMeeting()
	local dialog = model.dialog.getDialog("takatakaHomeWorldFirstMeeting")

	function dialog:getPortrait()
		if dialog.currentOption == "talkToAmbassador2" or dialog.currentOption == "talkToAmbassador3" then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return charactersGfxQuads, charactersNames, "takatakaPilot.png"
		end
	end

	function dialog:startDialog()
		return "Who and why and where and WHO!?."
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
	dialog.optionsList:add("talkToAmbassador", nil, nil, nil, nil,
		"We're from a human Colony and could use assistance.",
		"Wait!  What!? Talk talk talk talk.  NO!\n\nYes yes, send the abbassador.  You talk to the ambassador!  He comes now now NOW.")
	dialog.optionsList:add("talkToAmbassador2", "talkToAmbassador", nil, nil, nil,
		"(continue)...",
		"Captain; I don't like this one bit.  I'd caution against letting that ambassador onto the ship.")
	dialog.optionsList:add("talkToAmbassador3", "talkToAmbassador2", nil, nil, nil,
		"Noted.  Let's see what he has to say though.",
		"Alright; But I'm getting the boys ready, just in case.")
	dialog.optionsList:add("bye", "talkToAmbassador3", nil, nil, nil,
		"Send over the ambassador.",
		"Yes, he comes!")

	return dialog
end
