--####################################
-- askClarence.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when the player asks Clarence about the ant egg.
--####################################

--namespace model.dialog

function model.dialog.askClarence()
	local dialog = model.dialog.getDialog("askClarence")

	function dialog:getPortrait()
		if dialog.currentOption == "egg2" then
			return crewGfxQuads, crewNames, "frank.png"
		elseif dialog.currentOption == "egg3" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "egg4" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "egg5" then
			return crewGfxQuads, crewNames, "jarvis.png"
		elseif dialog.currentOption == "egg6" then
			return crewGfxQuads, crewNames, "yepp.png"
		else
			return crewGfxQuads, crewNames, "clarenceWithGoat.png"
		end
	end

	function dialog:startDialog()
		return "Captain?"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "egg6" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("egg", nil, nil, nil, nil,
		"The egg was in engineering.",
		"I know it Captain.  I don't know how the scans missed it...some sort of cloak.  I noticed when it started shakin' and you all "..
		"came running.")
	dialog.optionsList:add("egg2", "egg", nil, nil, nil,
		"(continue)...",
		"Where did you pick that thing up?")
	dialog.optionsList:add("egg3", "egg2", nil, nil, nil,
		"(continue)...",
		"It's one of *their* young.  An Ant is forming...I've never seen one of their children, but I've "..
		"seen the eggs many times.  I cared for them as a child; before I escaped and joined the resistance.")
	dialog.optionsList:add("egg4", "egg3", nil, nil, nil,
		"(continue)...",
		"I'll take care of it.")
	dialog.optionsList:add("egg5", "egg4", nil, nil, nil,
		"(continue)...",
		"Wait!  Could I have it?  One can never have too many refreshments.")
	dialog.optionsList:add("egg6", "egg5", nil, nil, nil,
		"(continue)...",
		"Yepp?")

	return dialog
end
