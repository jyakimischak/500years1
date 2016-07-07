--####################################
-- talkToMommy.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when lilepus is scanned without scanning lepus first.
--####################################

--namespace model.dialog

function model.dialog.talkToMommy()
	local dialog = model.dialog.getDialog("talkToMommy")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "lilepus.png"
	end

	function dialog:startDialog()
		return "Mommy said that there were strange things that the visitors do.  Uncomfortable things...please stop."
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
	dialog.optionsList:add("sorry", nil, nil, nil, nil,
		"I'm sorry.",
		"I understand your sorry.")
	dialog.optionsList:add("whoIsMommy", "sorry", nil, nil, nil,
		"Who is your mommy.",
		"She is what made me.  Find her near our star.")
	dialog.optionsList:add("bye", "whoIsMommy", nil, nil, nil,
		"I will, Sorry again.",
		"No harm was done.")

	return dialog
end
