--####################################
-- minedHydraI.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for speaking to Clarence after he has mined the planet Hydra I.
--####################################

--namespace model.dialog

function model.dialog.minedHydraI()
	local dialog = model.dialog.getDialog("minedHydraI")

	function dialog:getPortrait()
		if gameState.francisDead then
			return crewGfxQuads, crewNames, "clarenceWithoutGoat.png"
		else
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		end
	end

	function dialog:startDialog()
		return "Success!  I've made the upgrades and we've increased the energy output.  You'll be able to route power to additional systems now Captain!"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "goodWork" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("goodWork", nil, nil, nil, nil,
		"Good work Clarence!",
		"Thank you Captain.")

	return dialog
end
