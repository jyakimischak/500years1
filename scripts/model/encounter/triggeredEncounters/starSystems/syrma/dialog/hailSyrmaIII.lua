--####################################
-- hailSyrmaIII.lua
-- author: Jonas Yakimischak
--
-- This holds the dialog for when hailing Syrma III.
--####################################

--namespace model.dialog

function model.dialog.hailSyrmaIII()
	local dialog = model.dialog.getDialog("hailSyrmaIII")

	function dialog:getPortrait()
		if dialog.currentOption == "aboutSyrma2" or dialog.currentOption == "help" or dialog.currentOption == "askJarvis3" then
			return crewGfxQuads, crewNames, "charlie.png"
		elseif dialog.currentOption == "askJarvis" or dialog.currentOption == "askJarvis2" or dialog.currentOption == "askJarvis4" then
			return crewGfxQuads, crewNames, "jarvis.png"
		elseif dialog.currentOption == "ants2" or dialog.currentOption == "help3" then
			return crewGfxQuads, crewNames, "oleg.png"
		else
			return charactersGfxQuads, charactersNames, "syrmaConsultant.png"
		end
	end

	function dialog:startDialog()
		return "Welcome to the Syrma system!  How can I help make your stay as pleasurable as possible?"
	end
	
	function dialog:isDialogComplete()
		if dialog.currentOption == "bye" or dialog.currentOption == "askJarvis4"
		then
			return true
		end
		return false
	end
	
	--------------------------------------------------------------------------
	--options
	--optionsList:add(name, parent, wasSelected, conditionFunction, actionFunction, question, response)
	--------------------------------------------------------------------------
	dialog.optionsList:add("aboutSyrma", nil, nil, nil, nil,
		"Tell me about Syrma.",
		"Ah.  Syrma is the galaxy's premier rest and relaxation destination.")
	dialog.optionsList:add("aboutSyrma2", "aboutSyrma", nil, nil, nil,
		"(continue)...",
		"Where the hell are we Captain?")
	dialog.optionsList:add("aboutResort", nil, "aboutSyrma", nil, nil,
		"Tell me about the resorts.",
		"Oh.  The resorts offered on Syrma III cater to any and all desires.  Species specific facilities are located around the planet so "..
		"that all visitor's may feel welcomed and fulfilled in their choice of Syrma as a vacation destination.")
	dialog.optionsList:add("aboutSyrmaI", nil, "aboutResort", nil, nil,
		"Tell me about Syrma I.",
		"Syrma I is the planet in our system that is closest to the sun.  We offer exotic cruises for our clients that wish to see "..
		"the wonders and beauty of a primordial world.  While there you will see acidic oceans, super volcanoes and a sunrise the comes straight from your dreams.")
	dialog.optionsList:add("aboutSyrmaII", nil, "aboutResort", nil, nil,
		"Tell me about Syrma II",
		"The Ocean planet and home of our Syrma cruise line.  Hundreds of pleasure cruise options await you.  Whale watching, relaxation, adult excitement.  "..
		"Anything your heart desires.")
	dialog.optionsList:add("aboutSyrmaIV", nil, "aboutResort", nil, nil,
		"Tell me about Syrma IV",
		"Have you ever wanted to see a Gas Giant up close?  Now you can with our outer atmosphere tours.  You'll dip into the planet's gas "..
		"clouds and be surrounded by colors you didn't think were possible in nature.")
	dialog.optionsList:add("aboutSyrmaV", nil, "aboutResort", nil, nil,
		"Tell me about Syrma V",
		"Syrma V is our destination for those with an adventurous spirit.  We offer low gravity hiking tours through the deserts of our barren "..
		"outer world.")
	dialog.optionsList:add("ants", nil, nil, nil, nil,
		"Have you encountered the Ants?",
		"Hmmm, an insectoid species.  No.  We have not had them as guests yet.  Do you know where their home world is?  We would like "..
		"to extend invitations to them.")
	dialog.optionsList:add("ants2", "ants", nil, nil, nil,
		"(continue)...",
		"No!  We don't know where they come from you bastard!  They're pure evil!")
	dialog.optionsList:add("ants3", "ants2", nil, nil, nil,
		"(continue)...",
		"Even the very evil can sometimes use a vacation.")
	dialog.optionsList:add("help", nil, nil, nil, nil,
		"Could you offer us assistance?",
		"Our colony was enslaved by the Ants.  We need any help that you could offer.")
	dialog.optionsList:add("help2", "help", nil, nil, nil,
		"(continue)...",
		"I'm sorry.  Syrma keeps a neutral position in the galaxy and cannot offer any aid.  We do sympathize with your troubles though and can "..
		"offer your people a discount on your next stay with us.")
	dialog.optionsList:add("help3", "help2", nil, nil, nil,
		"(continue)...",
		"Bastard!  Please, for a fellow human!")
	dialog.optionsList:add("help4", "help3", nil, nil, nil,
		"(continue)...",
		"I'm sorry.  I am not in fact human.  I'm a holographic projection of an attractive member of your species; providing you with a comfortable "..
		"interface where you can purchase your vacation packages.")
	dialog.optionsList:add("askJarvis", nil, "aboutSyrma",
		function()
			return not gameState.quests.jarvisCoordinates.gaveActualCoordinates
		end,
		function()
			gameState.quests.jarvisCoordinates.gaveActualCoordinates = true
		end,
		"Why are we here Jarvis?",
		"Captain.  In order to better serve you in my capacity as an ambassador, I've made the decision that a vacation is needed!  "..
		"You've been looking very tense Captain.  Perhaps after a few months here at Syrma you'll be better able to assist your people "..
		"with all they need.  And just look!  The refreshments here are the best in the entire galaxy.")
	dialog.optionsList:add("askJarvis2", "askJarvis", nil, nil, nil,
		"Do you have any other coordinates?",
		"Captain please.  Of course I have additional coordinates.  Several worlds are known to me, but none as sweet as this.  Do you know "..
		"that they have a resort specifically setup for Takataka like myself here.  I can stay in a tree house again...TREE HOUSE!\n\n"..
		"I think that after only a few short months here we can be on our way and complete your mission.  Not much to ask I'd say.")
	dialog.optionsList:add("askJarvis3", "askJarvis2", nil, nil, nil,
		"Charlie, speak with him.",
		"With pleasure Captain.\n\nNow Jarvis, please follow me.  We need to speak in private for a moment.")
	dialog.optionsList:add("askJarvis4", "askJarvis3", nil, nil, nil,
		"(continue)...",
		"I don't want to go with her...")
	dialog.optionsList:add("bye", nil, nil, nil, nil,
		"We'll be leaving.",
		"Please return soon!")

	return dialog
end