--####################################
-- charlieHasJarvisCoordinates.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when Charlie says she got the coordinates from Jarvis.
--####################################

--namespace model.dialog

function model.dialog.charlieHasJarvisCoordinates()
	local dialog = model.dialog.getDialog("charlieHasJarvisCoordinates")

	function dialog:getPortrait()
		return crewGfxQuads, crewNames, "charlie.png"
	end

	function dialog:startDialog()
		return "Captain; I've spoken to Jarvis.  He had the coordinates of one system, Castor...it doesn't look like there were any human "..
		"colonies though.  I've loaded them into the computer and you can now access them from the star map."
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "bye"
		then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"Thank you.",
		"Captain.")

	return dialog
end