--####################################
-- ungiriWillMovePlanet.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking with the Malvar when the Ungiri come to move their planet.
--####################################

--namespace model.dialog

function model.dialog.ungiriWillMovePlanet()
	local dialog = model.dialog.getDialog("ungiriWillMovePlanet")

	function dialog:getPortrait()
		if dialog.currentOption == "great2" then
			return charactersGfxQuads, charactersNames, "ungiri.png"
		else
			return charactersGfxQuads, charactersNames, "malvarWithCoat.png"
		end
	end

	function dialog:startDialog()
		return "Captain!  You're back just in time.  The Ungiri are here with their planet mover!  They say it should take about 2 weeks for our planet "..
			"to be moved and to settle into it's new orbit."
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
	dialog.optionsList:add("great", nil, nil, nil, nil,
		"That's great!",
		"It is, it is Captain.")
	dialog.optionsList:add("great2", "great", nil, nil, nil,
		"(continue)...",
		"We should be getting started.  If everyone can please take their positions.  Captain, please mind that your ship does not interfere "..
		"with the graviton fields.")
	dialog.optionsList:add("bye", "great2", nil, nil, nil,
		"We will.",
		"Talk to you soon.")

	return dialog
end
