--####################################
-- takatakaHomeWorldWithJarvis.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for the takataka home world when you have Jarvis in your crew.
--####################################

--namespace model.dialog

function model.dialog.takatakaHomeWorldWithJarvis()
	local dialog = model.dialog.getDialog("takatakaHomeWorldWithJarvis")

	function dialog:getPortrait()
		if dialog.currentOption == "talkToAmbassador2" then
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
		"I think we've been through this before.",
		"Talk talk talk talk talk talk talk.  No, no...ambassador, yes yes!.")
	dialog.optionsList:add("talkToAmbassador2", "talkToAmbassador", nil, nil, nil,
		"(continue)...",
		"Do they really think we're going to buy that bit again.  Seriously.")
	dialog.optionsList:add("talkToAmbassador3", "talkToAmbassador2", nil, nil, nil,
		"We've already spoken to an ambassador..",
		"Ah...ok ok ok ok.  Then yes.  ATTACK!")
	dialog.optionsList:add("bye", "talkToAmbassador3", nil, nil, nil,
		"If we must.",
		"Yes yes yes...")

	return dialog
end
