--####################################
-- meetYepp.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when Yepp comes out of the egg.
--####################################

--namespace model.dialog

function model.dialog.meetYepp()
	local dialog = model.dialog.getDialog("meetYepp")

	function dialog:getPortrait()
		if dialog.currentOption == "yepp2" or dialog.currentOption == "yepp8" then
			return crewGfxQuads, crewNames, "oleg.png"
		elseif dialog.currentOption == "yepp3" or dialog.currentOption == "yepp5" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "yepp4" or dialog.currentOption == "yepp6" then
			return crewGfxQuads, crewNames, "jarvis.png"
		elseif dialog.currentOption == "yepp7" or dialog.currentOption == "yepp9" then
			return crewGfxQuads, crewNames, "frank.png"
		else
			return crewGfxQuads, crewNames, "yepp.png"
		end
	end

	function dialog:startDialog()
		return "Yepp?  Yyyyepppp.  Yep!"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "yepp10" then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("yepp", nil, nil, nil, nil,
		"The voice is in my head.",
		"Yeppppppppp.  Yep!")
	dialog.optionsList:add("yepp2", "yepp", nil, nil, nil,
		"(continue)...",
		"I can hear it too Captain.  I think he's hungry.")
	dialog.optionsList:add("yepp3", "yepp2", nil, nil, nil,
		"(continue)...",
		"We are NOT feeding that thing Captain.  Even if we did, what would an Ant eat...")
	dialog.optionsList:add("yepp4", "yepp3", nil, nil, nil,
		"(continue)...",
		"No!  Feed me, Jarvis likes food.  I'll take the baby Ant; I was going to make an omelette with the egg, but I can do a nice roast maybe.")
	dialog.optionsList:add("yepp5", "yepp4", nil, nil, nil,
		"(continue)...",
		"One more word Jarvis.  Please give me a reason.")
	dialog.optionsList:add("yepp6", "yepp5", nil, nil, nil,
		"(continue)...",
		"OH!  Yes, no...joking.  I'm allergic to shell-food; I wouldn't eat him.")
	dialog.optionsList:add("yepp7", "yepp6", nil, nil, nil,
		"(continue)...",
		"Well.  Captain.  Now we have a bit of an issue here.  What are we going to do with...him.  Why do I know he's male?")
	dialog.optionsList:add("yepp8", "yepp7", nil, nil, nil,
		"(continue)...",
		"They're telepaths.  They project their thoughts...we must be picking up how he feels.")
	dialog.optionsList:add("yepp9", "yepp8", nil, nil, nil,
		"(continue)...",
		"Captain.  I think we need to take him in.  Somewheres less inhabited but with a strong military presence.  Here Captain, I'm uploading "..
		"the coordinates to the Antares system.  There's a colony there, and more importantly there is a special operations military facility.  "..
		"I'm sure they wouldn't mind helping out your people as well Captain.")
	dialog.optionsList:add("yepp10", "yepp9", nil, nil, nil,
		"Let's get going.",
		"Yepp!")

	return dialog
end
