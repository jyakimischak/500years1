--####################################
-- crew.lua
-- author: Jonas Yakimischak
--
-- This holds objects for information on the 6 possible crew members.
--####################################

--namespace model.crew

--------------------------------------------------------------------------
--crew
--the following functions will return the crew object.
--------------------------------------------------------------------------

function model.crew.oleg()
	local crew = {}
	crew.functionName = "oleg"
	crew.firstName = "Oleg"
	crew.lastName = "Dvorkin"
	crew.information = "Dvorkin, Oleg\n"..
		"Profession: Pilot"
	crew.background = "Background\n"..
		"---------------\n".. 
		"\n".. 
		"Oleg Dvorkin is a pilot from the Artemis colony.\n".. 
		"\n".. 
		"During the Ant occupation Oleg was a freedom fighter with the resistance.  He was decorated many times for valor in combat.\n".. 
		"\n".. 
		"After the Ant occupation ended Oleg was selected to join the special forces; recently established by The Proctor.  There he was trained "..
		"to become a pilot using simulators.\n".. 
		"\n".. 
		"Oleg achieved the highest level of competency out of all the program candidates and was selected to join the Artemis expedition.\n".. 
		"\n".. 
		"Currently he is the pilot on your ship; as well as an old friend." 
	return crew
end

function model.crew.charlie()
	local crew = {}
	crew.functionName = "charlie"
	crew.firstName = "Charlie"
	crew.lastName = "Lowsley"
	crew.information = "Lowsley, Charlie\n"..
		"Profession: Weapons Specialist"
	crew.background = "Background\n"..
		"---------------\n"..
		"\n"..
		"Charlie Lowsley is a weapons specialist with the Artemis colony\n"..
		"\n"..
		"Charlie was a freedom fighter during the Ant occupation.  She was the leader of a resistance band that specialized in targeted explosions.  "..
		"She designed and developed smart bombs that strike distant targets using AI guidance systems.\n"..
		"\n"..
		"She is known for taking a hard-line stance against the Ant collaborators (especially The Proctor).\n"..
		"\n"..
		"Even though she opposes him, The Proctor enlisted Charlie into the Artemis special forces due to her extensive background in weapons "..
		"engineering.  For these reasons she was chosen for the Artemis expedition.\n"..
		"\n"..
		"She is currently the tactical officer on your ship; as well as an old friend."
	return crew
end

function model.crew.clarence()
	local crew = {}
	crew.functionName = "clarence"
	crew.firstName = "Clarence"
	crew.lastName = "Savery"
	crew.information = "Savery, Clarence\n"..
		"Profession: Engineer"
	crew.background = "Background\n"..
		"---------------\n"..
		"\n"..
		"Clarence Savery is an engineer whose ancestors came from The Giza, one of the four colony ships sent from Earth before it died.\n"..
		"\n"..
		"His colony was taken over by the Llaxon when they crawled out of the water and began their rein of terror across the galaxy.\n"..
		"\n"..
		"Clarence is the only survivor of The Giza colony, the others having been exterminated by the Llaxon.  He was living on a planet in the Cursa "..
		"system when we found him, building weapons for the Llaxon.  According to Clarence, his weapons backfire 2% of the time, destroying the ship that "..
		"they are attached to.  It's his revenge against the Llaxon.  Clarence was building a planetary defense system that "..
		"would function in a similar manner when we found him, but he was unable to implement it.\n"..
		"\n"..
		"Clarence has a pet goat named Francis that he is very fond of.  Both of them have limited immunity to radiation; genetic mutations that his "..
		"ancestors gained during their time aboard The Giza.\n"..
		"\n"..
		"Clarence is a bright and trustworthy companion."
	return crew
end

function model.crew.jarvis()
	local crew = {}
	crew.functionName = "jarvis"
	crew.firstName = "Jarvis"
	crew.lastName = "N/A"
	crew.information = "N/A, Jarvis\n"..
		"Profession: Ambassador"
	crew.background = "Background\n"..
		"---------------\n"..
		"\n"..
		"Jarvis is an ambassador of the Takataka empire.\n"..
		"\n"..
		"He was sent to speak with us when we first met the Takataka.  It turns out that the Takataka send ambasadors to start negotiations as a "..
		"distraction tactic when encountering a species.  While discussions are happening they attack, giving them an element of surprise.\n"..
		"\n"..
		"Being an ambassador Jarvis did not expect to live past his assignment.  He seems obsessed with \"refreshments\" and \"tree houses\".\n"..
		"\n"..
		"Jarvis does not seem all together trustworthy."
	return crew
end

function model.crew.frank()
	local crew = {}
	crew.functionName = "frank"
	crew.firstName = "Frank"
	crew.lastName = "Stone"
	crew.information = "Captain Stone, Frank\n"..
		"Profession: Captain, One World Marine Corps, Retired\n"
	crew.background = "Background\n"..
		"---------------\n"..
		"\n"..
		"Captain Frank Stone is proud of his service with the One World Marine Corps; discussing it when anyone shows interest.\n"..
		"\n"..
		"Captain Stone spent most of his career in front line conflicts with hostile species.  He's fought the Llaxon, the Takataka, the Ungiri, and even "..
		"the Ants.\n"..
		"\n"..
		"He has since retired to a clothing optional colony, The Grove, to spend his remaining years in a state of calm relaxation."
	return crew
end

function model.crew.yepp()
	local crew = {}
	crew.functionName = "yepp"
	crew.firstName = "Yepp"
	crew.lastName = "N/A"
	crew.information = "Yepp\n"..
		"Profession: Baby Space Ant\n"
	crew.background = "Background\n"..
		"---------------\n"..
		"\n"..
		"Yepp is a baby Space Ant that was born on your ship.\n"..
		"\n"..
		"He is telepathic and may have been placed there by the Ants to track the movements of your ship as you explored the galaxy.\n"..
		"\n"..
		"Clarence is fairly sure that he can block potential tracking attempts by the Ants by lining Yepp's quarters with special plating; rendering Yepp safe to keep "..
		"on board the ship."
	return crew
end
