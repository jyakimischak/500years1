--####################################
-- magistrateAfterAskingForHelp.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog that happens after asking the Magistrate for help.
--####################################

--namespace model.dialog

function model.dialog.magistrateAfterAskingForHelp()
	local dialog = model.dialog.getDialog("magistrateAfterAskingForHelp")

	function dialog:getPortrait()
		if dialog.currentOption == "thankYou" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "thankYou2" then
			return crewGfxQuads, crewNames, "charlie.png"
		else
			return charactersGfxQuads, charactersNames, "magistrate.png"
		end
	end

	function dialog:startDialog()
		return "Well.  That is quite the ordeal you've been through.  Rest assured The One World will help your colony.  We'll send ships immediately with "..
		"provisions and medical supplies.  We're quite interested in meeting this Proctor of yours; I'm sure there is a lot we have to discuss."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "thankYou6" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("thankYou", nil, nil, nil, nil,
		"Thank you Magistrate.",
		"Yes, thank you.  We owe you much for this showing of friendship!")
	dialog.optionsList:add("thankYou2", "thankYou", nil, nil, nil,
		"(continue)...",
		"I'm glad that you no longer doubt we are from the Artemis.  Our colony survived, and now needs your help.  Thank you.")
	dialog.optionsList:add("thankYou3", "thankYou2", nil, nil, nil,
		"(continue)...",
		"Now that we're sending ships please land and make use of our facilities.  You and your crew can use a little bit of shore leave after all you've "..
		"been through and we're happy to host you.  We'll let you know as soon as we speak to your Proctor, and many of our staff are eager to meet you.")
	dialog.optionsList:add("thankYou4", "thankYou3", nil, nil, nil,
		"(continue)...",
		"Keep in mind that this is a military facility.  Radio silence is enforced and there are some areas that are restricted.")
	dialog.optionsList:add("thankYou5", "thankYou4", nil, nil, nil,
		"(continue)...",
		"Now Captain.  Please join us.  We are honored to welcome our lost brothers and sisters back.")
	dialog.optionsList:add("thankYou6", "thankYou5", nil, nil, nil,
		"Thank you for your kindness.",
		"See you soon Captain.")

	return dialog
end
