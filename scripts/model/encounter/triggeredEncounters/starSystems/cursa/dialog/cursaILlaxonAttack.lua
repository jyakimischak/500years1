--####################################
-- cursaILlaxonAttack.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when the Llaxon attack after Clarence joins your crew.
--####################################

--namespace model.dialog

function model.dialog.cursaILlaxonAttack()
	local dialog = model.dialog.getDialog("cursaILlaxonAttack")

	function dialog:getPortrait()
		return charactersGfxQuads, charactersNames, "llaxonPilot.png"
	end

	function dialog:startDialog()
		return "Morsels!  Our tendrils reach out to you now.  Hehhhhhrh\n\nClarence must be left alone.  There is much work he must do yet!"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "bye" or
		   dialog.currentOption == "cantDoThat"
		then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("whyDoYouNeedHim", nil, nil, nil, nil,
		"What do you need Clarence for?",
		"He must continue his work!  Our tendrils must spread.")
	dialog.optionsList:add("cantDoThat", nil, "whyDoYouNeedHim", nil, nil,
		"I'm sorry; Clarence is coming with us.",
		"HHHHeheh.  Then you must all die!\n\nThere will be no feasting with you...")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Time to die.",
		"HHHHHSeesssshheh!")

	return dialog
end