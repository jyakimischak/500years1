--####################################
-- quests.lua
-- author: Jonas Yakimischak
--
-- This holds objects for the quests in the game.
--####################################

--namespace model.quests

--this is a reverse order list of all the quests
model.quests.allQuests = util.getArrayList()
--model.quests.allQuests:add("c1q6")
--model.quests.allQuests:add("c1q5")
--model.quests.allQuests:add("c1q4")
--model.quests.allQuests:add("c1q3")
--model.quests.allQuests:add("c1q2")
model.quests.allQuests:add("repairs")
model.quests.allQuests:add("theBeginning")

--------------------------------------------------------------------------
--quests
--the following functions will return the quest objects.
--------------------------------------------------------------------------

function model.quests.theBeginning()
	local quest = {}
	quest.functionName = "theBeginning"
	quest.name = "The Beginning"
	
	function quest:getLogEntry()
		if not gameState.quests.theBeginning.complete then
			return "The Beginning\n"..
				"\n"..
				"I've acquired an old ship from the ruins of the Artemis.  It must have been the old captain's yacht.  It's still in working condition but is in serious need of repairs.  I'm not sure how long it will stay together without replacement parts.\n"..
				"\n"..
				"Oleg and Charlie came with me along with a crew of 30.\n"..
				"\n"..
				"We'll need to search the nearby star systems for usable parts; The Proctor should be able to transfer the coordinates to us when we contact him.  Without those coordinates it would take us years to reach even the closest star system..."
		else
			return "The Beginning\n"..
				"\n"..
				"I've acquired an old ship from the ruins of the Artemis.  It must have been the old captain's yacht.  It's still in working condition but is in serious need of repairs.  I'm not sure how long it will stay together without replacement parts.\n"..
				"\n"..
				"Oleg and Charlie came with me along with a crew of 30.\n"..
				"\n"..
				"The Proctor transferred the coordinates of an old alien scrap world, Cursa, to us.  He instructed us to go to that world for repairs.  We should be able to find an old star map on one of the old hulks...I hope..."
		end
	end

	return quest
end


function model.quests.repairs()
	local quest = {}
	quest.functionName = "repairs"
	quest.name = "The Ship Needs Repairs"
	
	function quest:getLogEntry()
		if not gameState.quests.repairs.complete then
			return "The Ship Needs Repairs\n"..
				"\n"..
				"The ship is in serious need of repairs.  The Proctor has given us coordinates to an old scrap world, Cursa.  There we should be able to salvage parts to faciliate making some repairs.\n"..
				"\n"..
				"The doesn't solve the problem of getting a star map though.  Without coordinates to star systems we won't be able to make sub-space jumps.  That means it would take years to reach even the closest star systems; that would mean the end for our colony.\n"..
				"\n"..
				"The Proctor feels that we might be able to salvage a starmap from one of the old hulks on the planet's surface.  I hope he's right..."
		else
			return "The Ship Needs Repairs\n"..
				"\n"..
				"We have aquired some new members for our crew.  An engineer Clarence, and his goat Francis.\n"..
				"\n"..
				"We've also made some enemies in the process.  The Llaxon race; a type of bipedial squid was holding Franis captive and forcing him to create space craft and weapons for them.  Clarence has built defects into the weapons that makes them backfire often...he was apparently attempting to destroy the race by using the same tricks on a planetary defense system (which he was not able to finish before we rescued him)."
		end
	end

	return quest
end


