--####################################
-- starMapLocations.lua
-- author: Jonas Yakimischak
--
-- This holds all locations that can be visited on the star map.
--####################################

--namespace model.starMapLocations

--------------------------------------------------------------------------
--locations
--the following functions will return the location object.
--
--The planet objects may contain 2 functions, action1() and action2().  These will be used when displaying the action buttons on the planet screen.
--If the functions are implemented then they should return 2 strings, the id (equal to the triggered encounter name) and the display name.
--
--note on planets...the min distance to sun is around the -300 mark and the max distance from sun is around the 450 mark 
--------------------------------------------------------------------------

--------------------------------------------------------------------------
--Artemis
--Artemis is the system where the pc's colony is.
--------------------------------------------------------------------------
function model.starMapLocations.artemis()
	local location = {}
	location.functionName = "artemis"
	location.name = "Artemis"
	location.textureName = "yellowStar.png"
	location.width = 70
	location.height = 70
	location.starMapLocX = -1600
	location.starMapLocY = -300

	location.planets = util.getArrayList()
	local artemis1 = model.starMapLocations.getPlanet()
	artemis1.functionName = "artemis1"
	artemis1.name = "Artemis I"
	artemis1.textureName = "artemis1.png"
	artemis1.width = 70
	artemis1.height = 70
	artemis1.locX = 0
	artemis1.locY = 0
	artemis1.information = "-Desert\n"..
		"-Diameter: 130,000 km\n"..
		"-Mass: 5.72e26 kg\n"..
		"\n"..
		"Artemis I is the lone barren planet in the Artemis system.  This system was selected by the crew of the Artemis space "..
		"craft as a suitable home for their relocation settlement.  The single moon of Artemis I is Earth like and suitable for "..
		"human populations.  The planet was seen as mineral rich and available for mining operations that would sustain the colony in the future.\n"..
		"\n"..
		"Mining operations did not occur due to the Ant occupation.  The population of the colony was controlled and never reached "..
		"a size where additional resources were necessary."
	location.planets:add(artemis1)

	local artemis1_1 = model.starMapLocations.getPlanet()
	artemis1_1.functionName = "artemis1_1"
	artemis1_1.name = "Artemis Colony"
	artemis1_1.textureName = "artemis1-1.png"
	artemis1_1.width = 30
	artemis1_1.height = 30
	artemis1_1.locX = 0
	artemis1_1.locY = -90
	function artemis1_1:action1()
		return "hailArtemis1_1", "Hail"
	end
	artemis1_1.information = "-Terrestrial (moon)\n"..
		"-Diameter: 4,100 km\n"..
		"-Mass: 9.10e22 kg\n"..
		"\n"..
		"The artemis colony was established by the crew of the Artemis space craft.  A population of approximately 1 million landed "..
		"and began a settlement.  The settlement grew to around 1.2 million when the Ants invaded.  The Ants met little resistance from "..
		"the population of the colony; no formal military existed and most resources were being routed into industrialization of the moon.\n"..
		"\n"..
		"Over the years of occupation groups of loosely connected guerilla fighters joined to combat to The Ants; you were a captain in this organization.\n"..
		"\n"..
		"The Ants maintained the population level hovering around the 500,000 mark; feeding on or culling the additional humans.\n"..
		"\n"..
		"Little is known of the Ants even through the 400 years we were enslaved by them.  They communicated with very few of us and used a telepathic means.\n"..
		"\n"..
		"The Proctor was our representative to them and is the one who has spoken with them the most.\n"..
		"\n"..
		"After the Ants left the Proctor took up an office as magistrate for the colony."
	location.planets:add(artemis1_1)

	return location
end

--------------------------------------------------------------------------
--Cursa
--This is the home system of the Llaxon race.  You get Clarence from this system.
--------------------------------------------------------------------------
function model.starMapLocations.cursa()
	local location = {}
	location.functionName = "cursa"
	location.name = "Cursa"
	location.textureName = "redStar.png"
	location.width = 100
	location.height = 100
	location.starMapLocX = -2000
	location.starMapLocY = -200
	
	location.planets = util.getArrayList()
	local cursaI = model.starMapLocations.getPlanet()
	cursaI.functionName = "cursaI"
	cursaI.name = "Cursa I"
	cursaI.textureName = "cursa1.png"
	cursaI.width = 50
	cursaI.height = 50
	cursaI.locX = 0
	cursaI.locY = 0
	function cursaI:action1()
		if not gameState.quests.repairs.cursaIScanned then
			return "scanCursaI", "Scan"
		elseif not gameState.quests.repairs.cursaIProbeLaunched then
			return "launchCursaI", "Launch"
		-- if Clarence isn't in your crew then you can hail him
		elseif not gameState.crew.clarence then
			return "hailCursaI", "Hail"
		end
	end
	cursaI.information = "-Radioactive\n"..
		"-Diameter: 4,350 km\n"..
		"-Mass: 3.21e23 kg\n"..
		"\n"..
		"Cursa I was detected by the Artemis during the escape from Earth.\n"..
		"\n"..
		"The planet is highly radioactive; having been used as a scrap yard by some ancient race.  Husks of old ships litter the "..
		"planet's surface, leaking radiation from their engine cores.\n"..
		"\n"..
		"The planet is not hospitable to life."
	location.planets:add(cursaI)
	
	local cursaII = model.starMapLocations.getPlanet()
	cursaII.functionName = "cursaII"
	cursaII.name = "Cursa II"
	cursaII.textureName = "cursa2.png"
	cursaII.width = 80
	cursaII.height = 80
	cursaII.locX = 300
	cursaII.locY = 0
	function cursaII:action1()
		return "hailCursaII", "Hail"
	end
	cursaII.information = "-Ocean\n"..
		"-Diameter: 14,100 km\n"..
		"-Mass: 6.21e24 kg\n"..
		"\n"..
		"Cursa II is covered in deep oceans with no proper land masses.  The water is covered with a thick layer of algae that "..
		"forms a makeshift surface to the world.\n"..
		"\n"..
		"This is the home planet of the space faring race the Llaxons.  The Llaxon recently (within the last 500 years) moved to the "..
		"algae surface of the planet after having evolved in the oceans below.  They developed sublight drives in the first 200 years of "..
		"living on the surface.\n"..
		"\n"..
		"Having achieved inter-planetary flight; they found the wrecks of ships on Cursa I and developed Faster Than Light travel soon after.\n"..
		"\n"..
		"Culturally the Llaxon are a corrupt race, still working from an instinctual needs to dominate others by force."
	location.planets:add(cursaII)
	
	return location
end


--------------------------------------------------------------------------
--Vulpecula
--This is the home system of the Takataka.  You get Jarvis from this system.
--------------------------------------------------------------------------
function model.starMapLocations.vulpecula()
	local location = {}
	location.functionName = "vulpecula"
	location.name = "Vulpecula"
	location.textureName = "yellowStar.png"
	location.width = 70
	location.height = 70
	location.starMapLocX = -800
	location.starMapLocY = 1200

	location.planets = util.getArrayList()
	local vulpeculaI = model.starMapLocations.getPlanet()
	vulpeculaI.functionName = "vulpeculaI"
	vulpeculaI.name = "Vulpecula I"
	vulpeculaI.textureName = "vulpecula1.png"
	vulpeculaI.width = 40
	vulpeculaI.height = 40
	vulpeculaI.locX = -250
	vulpeculaI.locY = 0
	function vulpeculaI:action1()
		return "hailVulpeculaI", "Hail"
	end
	vulpeculaI.information = "-Terrestrial\n"..
		"-Diameter: 4,100 km\n"..
		"-Mass: 3.12e23 kg\n"..
		"\n"..
		"Vulpecula I is a hot tropical world that is covered in jungle and oceans.  By any standards the world is a paradise.  An abundance "..
		"of food can be found in the local vegetation, and there are no large predators present in the planet's eco system.\n"..
		"\n"..
		"This world is used to house the ambassador class of the Takataka people.  The ambassadors are the runts of the litter and considered "..
		"not suitable for normal Takataka society.  They are sent to Vulpecula I to live and be trained for their role as ambassadors.  "..
		"The Takataka have a need for a large number of ambassadors as they have a tendency to attack enemies while negotiations are being conducted.  "..
		"As a result many races will kill the Takataka envoys as they approach."
	location.planets:add(vulpeculaI)

	local vulpeculaII = model.starMapLocations.getPlanet()
	vulpeculaII.functionName = "vulpeculaII"
	vulpeculaII.name = "Vulpecula II"
	vulpeculaII.textureName = "vulpecula2.png"
	vulpeculaII.width = 50
	vulpeculaII.height = 50
	vulpeculaII.locX = -100
	vulpeculaII.locY = 0
	vulpeculaII.information = "-Toxic\n"..
		"-Diameter: 11,396 km\n"..
		"-Mass: 4.76e24 kg\n"..
		"\n"..
		"Vulpecula II is a toxic planet, having little ecosystem to speak of.  Water is present (though highly contaminated) on the "..
		"planet, and some flora and fauna are present.\n"..
		"\n"..
		"This world is used by the Takataka rodent populations of the solar system for coming of age rituals.  Young men and women are "..
		"dropped off on this planet and must live there for 1 month.  Those who survive are welcomed into society.  This situation does "..
		"promote cannibalism during the trial."
	location.planets:add(vulpeculaII)

	local vulpeculaIII = model.starMapLocations.getPlanet()
	vulpeculaIII.functionName = "vulpeculaIII"
	vulpeculaIII.name = "Vulpecula III"
	vulpeculaIII.textureName = "vulpecula3.png"
	vulpeculaIII.width = 80
	vulpeculaIII.height = 80
	vulpeculaIII.locX = 50
	vulpeculaIII.locY = 0
	function vulpeculaIII:action1()
		return "hailVulpeculaIII", "Hail"
	end
	vulpeculaIII.information = "-Terrestrial\n"..
		"-Diameter: 13,528 km\n"..
		"-Mass: 6.13e24 kg\n"..
		"\n"..
		"The home world of the Takataka rodent people.\n"..
		"\n"..
		"Vulpecula III is an Earth like planet with large oceans and forests.  Most fauna on the planet consists of smaller mammals.  "..
		"These small mammals are what the Takataka evolved from.  They rose to dominance more through size than through intelligence, "..
		"sentience evolving as a coping mechanism to deal with over population.\n"..
		"\n"..
		"The Takataka people take great pride in strength, their society largly being based on power challanges.  In this way they are "..
		"similar to the Llaxon people of Cursa, but with a much older culture.\n"..
		"\n"..
		"Techologically advanced, they should be seen as a real threat.\n"..
		"\n"..
		"Note negotiations are commonly used as a distraction tactic.  Consider an ambassadorial "..
		"envoy the precursor to attack."
	location.planets:add(vulpeculaIII)

	local vulpeculaIV = model.starMapLocations.getPlanet()
	vulpeculaIV.functionName = "vulpeculaIV"
	vulpeculaIV.name = "Vulpecula IV"
	vulpeculaIV.textureName = "vulpecula4.png"
	vulpeculaIV.width = 150
	vulpeculaIV.height = 150
	vulpeculaIV.locX = 200
	vulpeculaIV.locY = 0
	vulpeculaIV.information = "-Gas Giant\n"..
		"-Diameter: 134,752 km\n"..
		"-Mass: 1.45e27 kg\n"..
		"\n"..
		"A large gas giant in the Vulpecula system."
	location.planets:add(vulpeculaIV)

	local vulpeculaV = model.starMapLocations.getPlanet()
	vulpeculaV.functionName = "vulpeculaV"
	vulpeculaV.name = "Vulpecula V"
	vulpeculaV.textureName = "vulpecula5.png"
	vulpeculaV.width = 30
	vulpeculaV.height = 30
	vulpeculaV.locX = 350
	vulpeculaV.locY = 0
	vulpeculaV.information = "-Desert\n"..
		"-Diameter: 3,187 km\n"..
		"-Mass: 1.31e21 kg\n"..
		"\n"..
		"A dwarf planet in the Vulpecula system."
	location.planets:add(vulpeculaV)

	return location
end


--------------------------------------------------------------------------
--Pollux
--This is the home system of the Ungiri race.
--------------------------------------------------------------------------
function model.starMapLocations.pollux()
	local location = {}
	location.functionName = "pollux"
	location.name = "Pollux"
	location.textureName = "yellowStar.png"
	location.width = 80
	location.height = 80
	location.starMapLocX = -2000
	location.starMapLocY = 900

	location.planets = util.getArrayList()
	local polluxI = model.starMapLocations.getPlanet()
	polluxI.functionName = "polluxI"
	polluxI.name = "Pollux I"
	polluxI.textureName = "pollux1.png"
	polluxI.width = 30
	polluxI.height = 30
	polluxI.locX = -250
	polluxI.locY = 0
	polluxI.information = "-Desert\n"..
		"-Diameter: 1,132 km\n"..
		"-Mass: 8.72e21 kg\n"..
		"\n"..
		"This is the remaining core of a planet consumed by the Ungiri people."
	location.planets:add(polluxI)

	local polluxII = model.starMapLocations.getPlanet()
	polluxII.functionName = "polluxII"
	polluxII.name = "Pollux II"
	polluxII.textureName = "pollux2.png"
	polluxII.width = 25
	polluxII.height = 25
	polluxII.locX = -130
	polluxII.locY = 0
	polluxII.information = "-Desert\n"..
		"-Diameter: 970 km\n"..
		"-Mass: 1.16e21 kg\n"..
		"\n"..
		"This is the remaining core of a planet consumed by the Ungiri people."
	location.planets:add(polluxII)

	local polluxIII = model.starMapLocations.getPlanet()
	polluxIII.functionName = "polluxIII"
	polluxIII.name = "Pollux III"
	polluxIII.textureName = "pollux3.png"
	polluxIII.width = 30
	polluxIII.height = 30
	polluxIII.locX = -20
	polluxIII.locY = 0
	polluxIII.information = "-Desert\n"..
		"-Diameter: 432 km\n"..
		"-Mass: 5.23e18 kg\n"..
		"\n"..
		"Pollux III is the original home planet of the Ungiri people.\n"..
		"\n"..
		"The Ungiri people are a very old lithotrophic species that developed on Pollux III.  They consumed the majority of their planet "..
		"and relocated to Pollux IV centuries ago."
	location.planets:add(polluxIII)

	local polluxIV = model.starMapLocations.getPlanet()
	polluxIV.functionName = "polluxIV"
	polluxIV.name = "Pollux IV"
	polluxIV.textureName = "pollux4.png"
	polluxIV.width = 80
	polluxIV.height = 80
	polluxIV.locX = 90
	polluxIV.locY = 0
	function polluxIV:action1()
		return "hailPolluxIV", "Hail"
	end
	polluxIV.information = "-Terrestrial\n"..
		"-Diameter: 47,183 km\n"..
		"-Mass: 4.27e25 kg\n"..
		"\n"..
		"Pollux IV is the new home world of the Ungiri people.\n"..
		"\n"..
		"Pollux IV is an Earth like planet having a diverse ecosystem with an abundance of plant and animal life.\n"..
		"\n"..
		"The Ungiri people are a lithotrophic species, consuming minerals for subsistance.  They desimated the majority of the "..
		"planets in their solar system over thousands of years (including their original home world Pollux III); finally developing inter "..
		"stellar travel to find additional resources.\n"..
		"\n"..
		"Pollux IV has been saved from consumption because the majority of the minerals present in the planet are toxic to the Ungiri.\n"..
		"\n"..
		"The Ungiri are generally a peaceful people, interested in finding new sources of minerals to sustain their empire."
	location.planets:add(polluxIV)

	local polluxV = model.starMapLocations.getPlanet()
	polluxV.functionName = "polluxV"
	polluxV.name = "Pollux V"
	polluxV.textureName = "pollux5.png"
	polluxV.width = 150
	polluxV.height = 150
	polluxV.locX = 230
	polluxV.locY = 0
	polluxV.information = "-Gas Giant\n"..
		"-Diameter: 60,846 km\n"..
		"-Mass: 2.52e26 kg\n"..
		"\n"..
		"A Gas Giant in the Pollux system."
	location.planets:add(polluxV)

	local polluxVI = model.starMapLocations.getPlanet()
	polluxVI.functionName = "polluxVI"
	polluxVI.name = "Pollux VI"
	polluxVI.textureName = "pollux6.png"
	polluxVI.width = 30
	polluxVI.height = 30
	polluxVI.locX = 360
	polluxVI.locY = 0
	polluxVI.information = "-Desert\n"..
		"-Diameter: 1,542 km\n"..
		"-Mass: 1.28e21 kg\n"..
		"\n"..
		"This is the remaining core of a planet consumed by the Ungiri people."
	location.planets:add(polluxVI)

	return location
end

--------------------------------------------------------------------------
--Chara
--------------------------------------------------------------------------
function model.starMapLocations.chara()
	local location = {}
	location.functionName = "chara"
	location.name = "Chara"
	location.textureName = "blueStar.png"
	location.width = 60
	location.height = 60
	location.starMapLocX = -1000
	location.starMapLocY = -1200

	location.planets = util.getArrayList()
	local charaI = model.starMapLocations.getPlanet()
	charaI.functionName = "charaI"
	charaI.name = "Chara I"
	charaI.textureName = "chara1.png"
	charaI.width = 40
	charaI.height = 40
	charaI.locX = -250
	charaI.locY = 0
	charaI.information = "-Radioactive\n"..
		"-Diameter: 4,285 km\n"..
		"-Mass: 3.18e23 kg\n"..
		"\n"..
		"Chara I is a small Radioactive world."
	location.planets:add(charaI)

	local charaII = model.starMapLocations.getPlanet()
	charaII.functionName = "charaII"
	charaII.name = "Ground Fight Fight"
	charaII.textureName = "chara2.png"
	charaII.width = 70
	charaII.height = 70
	charaII.locX = -100
	charaII.locY = 0
	charaII.information = "-Irradiated Mineral\n"..
		"-Diameter: 23,946 km\n"..
		"-Mass: 8.26e24 kg\n"..
		"\n"..
		"Ground Fight Fight is a medium sized desert planet with no atmosphere that is used for war games by the Takataka.\n"..
		"The surface is marked with scars from years of munitions fire as the Takataka ground forces attempt to kill each other in \"mock\" combat."
	location.planets:add(charaII)

	local charaII_I = model.starMapLocations.getPlanet()
	charaII_I.functionName = "charaII_I"
	charaII_I.name = "Space Fight Fight"
	charaII_I.textureName = "chara2_1.png"
	charaII_I.width = 20
	charaII_I.height = 20
	charaII_I.locX = -100
	charaII_I.locY = -90
	charaII_I.information = "-Desert\n"..
		"-Diameter: 3,935 km\n"..
		"-Mass: 8.48e22 kg\n"..
		"\n"..
		"A small barren moon with a thin atmosphere that acts as an observation tower during the Takataka space flight war games."
	location.planets:add(charaII_I)

	local charaIII = model.starMapLocations.getPlanet()
	charaIII.functionName = "charaIII"
	charaIII.name = "Chara III"
	charaIII.textureName = "chara3.png"
	charaIII.width = 30
	charaIII.height = 30
	charaIII.locX = 400
	charaIII.locY = 0
	charaIII.information = "-Desert\n"..
		"-Diameter: 2,172 km\n"..
		"-Mass: 1.93e22 kg\n"..
		"\n"..
		"A dwarf planet in the Chara system."
	location.planets:add(charaIII)

	return location
end

--------------------------------------------------------------------------
--Alya
--------------------------------------------------------------------------
function model.starMapLocations.alya()
	local location = {}
	location.functionName = "alya"
	location.name = "Alya"
	location.textureName = "redStar.png"
	location.width = 90
	location.height = 90
	location.starMapLocX = -1600
	location.starMapLocY = 1400

	location.planets = util.getArrayList()
	local alyaI = model.starMapLocations.getPlanet()
	alyaI.functionName = "alyaI"
	alyaI.name = "Alya I"
	alyaI.textureName = "alya1.png"
	alyaI.width = 50
	alyaI.height = 50
	alyaI.locX = -100
	alyaI.locY = 0
	function alyaI:action1()
		if not gameState.scannedAlyaI then
			return "scanAlyaI", "Scan"
		elseif not gameState.probedAlyaI then
			return "probeAlyaI", "Launch"
		else
			return "hailAlyaI", "Hail"
		end
	end
	alyaI.information = "-Ocean\n"..
		"-Diameter: 8,212 km\n"..
		"-Mass: 1.12e24 kg\n"..
		"\n"..
		"Alya I is an ocean planet with unique bacterial species.  They are able metabolize certain impurities in the oceans and excrete an unstable "..
		"chemical.  Research has been done to see if the chemical excretion can be used as a power source but so far it has proven too unstable for any "..
		"practicle use.  All species have abandoned the effort and the planet has been left deserted."
	location.planets:add(alyaI)

	local alyaII = model.starMapLocations.getPlanet()
	alyaII.functionName = "alyaII"
	alyaII.name = "Alya II"
	alyaII.textureName = "alya2.png"
	alyaII.width = 200
	alyaII.height = 200
	alyaII.locX = 250
	alyaII.locY = 0
	alyaII.information = "-Gas Giant\n"..
		"-Diameter: 184,639 km\n"..
		"-Mass: 2.27e27 kg\n"..
		"\n"..
		"A gas giant in the Alya system."
	location.planets:add(alyaII)

	return location
end


--------------------------------------------------------------------------
--Hydra
--huge red star with nothing of interest.
--------------------------------------------------------------------------
function model.starMapLocations.hydra()
	local location = {}
	location.functionName = "hydra"
	location.name = "Hydra"
	location.textureName = "redStar.png"
	location.width = 200
	location.height = 200
	location.starMapLocX = -1800
	location.starMapLocY = -1050

	location.planets = util.getArrayList()
	local hydraI = model.starMapLocations.getPlanet()
	hydraI.functionName = "hydraI"
	hydraI.name = "Hydra I"
	hydraI.textureName = "hydra1.png"
	hydraI.width = 70
	hydraI.height = 70
	hydraI.locX = 280
	hydraI.locY = 0
	function hydraI:action1()
		if not gameState.scannedHydraI then
			return "scanHydraI", "Scan"
		elseif not gameState.landedHydraI then
			return "landHydraI", "Land"
		end
	end
	hydraI.information = "-Irradiated\n"..
		"-Diameter: 2,943 km\n"..
		"-Mass: 2.05e22 kg\n"..
		"\n"..
		"Hydra I is the last remaining planet in the Hydra system.  This is a dwarf planet that would have been in the edge of the "..
		"original solar system.  The other planets were swallowed by the star is it grew into a red giant."
	location.planets:add(hydraI)

	return location
end


--------------------------------------------------------------------------
--Lepus
--The system with the living planet.
--------------------------------------------------------------------------
function model.starMapLocations.lepus()
	local location = {}
	location.functionName = "lepus"
	location.name = "Lepus"
	location.textureName = "blueStar.png"
	location.width = 80
	location.height = 80
	location.starMapLocX = 1900
	location.starMapLocY = -1000

	location.planets = util.getArrayList()
	local lepusI = model.starMapLocations.getPlanet()
	lepusI.functionName = "lepusI"
	if not gameState.metLepus then
		lepusI.name = "Lepus I"
	else
		lepusI.name = "Lepus"
	end
	lepusI.textureName = "lepus.png"
	lepusI.width = 200
	lepusI.height = 200
	lepusI.locX = -200
	lepusI.locY = 0
	function lepusI:action1()
		if not gameState.metLepus then
			return "scanLepusI", "Scan"
		else
			return "hailLepusI", "Hail"
		end
	end
	if not gameState.metLepus then
		lepusI.information = "-Unknown\n"..
			"-Diameter: Unknown\n"..
			"-Mass: Unknown\n"..
			"\n"..
			"There is no information associated with this planet in the star map."
	else
		lepusI.information = "-Terrestrial\n"..
			"-Diameter: 215,372 km\n"..
			"-Mass: 8.52e27 kg\n"..
			"\n"..
			"Lepus is the first planet in the Lepus system and is intelligent.  Although genderless Lepus prefers to "..
			"be address as \"her\", likely steming from her maternal instincts.  She has produced 3 child planets "..
			"in her system but only the closest to her, Lilpeus, managed to attain intelligence.\n"..
			"\n"..
			"Lepus (along with Lilpeus) are able to talk by modulating the sounds made by shifting their tectonic "..
			"plates.  This gives Lepus a low, deafening voice that can be picked up using a radio.\n"..
			"\n"..
			"Lepus has lived for countless years and is unable to leave her system; this makes her hungry for "..
			"knowledge of the outside world.\n"..
			"\n"..
			"Lepus was responsible for ending the Malvar \"reign of terror\" that took the galaxy.  She convinced "..
			"them to stop conquering intelligent races and does feel a sense of responsibility for them."
	end
	location.planets:add(lepusI)

	local lepusII = model.starMapLocations.getPlanet()
	lepusII.functionName = "lepusII"
	if not gameState.metLepus then
		lepusII.name = "Lepus II"
	else
		lepusII.name = "Lilepus"
	end
	lepusII.textureName = "lilepus.png"
	lepusII.width = 70
	lepusII.height = 70
	lepusII.locX = 0
	lepusII.locY = 0
	function lepusII:action1()
		if not gameState.metLepus then
			return "scanLepusII", "Scan"
		else
			return "hailLepusII", "Hail"
		end
	end
	if not gameState.metLepus then
		lepusII.information = "-Unknown\n"..
			"-Diameter: Unknown\n"..
			"-Mass: Unknown\n"..
			"\n"..
			"There is no information associated with this planet in the star map."
	else
		lepusII.information = "-Terrestrial\n"..
			"-Diameter: 122,938 km\n"..
			"-Mass: 5.25e26 kg\n"..
			"\n"..
			"Lilepus is the only intelligent daughter of Lepus.  She was created by solidifying an asteroid field and "..
			"and infusing it with the same rare minerals that make up the mother.\n"..
			"\n"..
			"Lilepus is still learning and will defer to her mother when asked questions."
	end
	location.planets:add(lepusII)

	local lepusIII = model.starMapLocations.getPlanet()
	lepusIII.functionName = "lepusIII"
	lepusIII.name = "Lepus III"
	lepusIII.textureName = "debris1.png"
	lepusIII.width = 50
	lepusIII.height = 50
	lepusIII.locX = 200
	lepusIII.locY = 0
	function lepusIII:action1()
		if not gameState.quests.malvarPlanet.ungiriAgreedToMovePlanet then
			return "scanLepusOther", "Scan"
		else
			return nil;
		end
	end
	if not gameState.metLepus then
		lepusIII.information = "-Unknown\n"..
			"-Diameter: Unknown\n"..
			"-Mass: Unknown\n"..
			"\n"..
			"There is no information associated with this planet in the star map."
	else
		lepusIII.information = "-Terrestrial\n"..
			"-Diameter: 14,501 km\n"..
			"-Mass: 6.83e24 kg\n"..
			"\n"..
			"A child of Lepus that never attained intelligence.\n"..
			"\n"..
			"Note that this planet is very mineral rich."
	end
	location.planets:add(lepusIII)

	if not gameState.quests.malvarPlanet.movedPlanet then
		local lepusIV = model.starMapLocations.getPlanet()
		lepusIV.functionName = "lepusIV"
		lepusIV.name = "Lepus IV"
		lepusIV.textureName = "debris2.png"
		lepusIV.width = 40
		lepusIV.height = 40
		lepusIV.locX = 300
		lepusIV.locY = 0
		function lepusIV:action1()
			if not gameState.quests.malvarPlanet.ungiriAgreedToMovePlanet then
				return "scanLepusOther", "Scan"
			else
				return nil
			end
		end
		if not gameState.metLepus then
			lepusIV.information = "-Unknown\n"..
				"-Diameter: Unknown\n"..
				"-Mass: Unknown\n"..
				"\n"..
				"There is no information associated with this planet in the star map."
		else
			lepusIV.information = "-Terrestrial\n"..
				"-Diameter: 13,024 km\n"..
				"-Mass: 6.10e24 kg\n"..
				"\n"..
				"A child of Lepus that never attained intelligence.\n"..
				"\n"..
				"Note that this planet is very mineral rich."
		end
		location.planets:add(lepusIV)
	end

	return location
end


--------------------------------------------------------------------------
--Syrma
--The vacation system.
--------------------------------------------------------------------------
function model.starMapLocations.syrma()
	local location = {}
	location.functionName = "syrma"
	location.name = "Syrma"
	location.textureName = "yellowStar.png"
	location.width = 80
	location.height = 80
	location.starMapLocX = 1430
	location.starMapLocY = 850

	location.planets = util.getArrayList()
	local syrmaI = model.starMapLocations.getPlanet()
	syrmaI.functionName = "syrmaI"
	syrmaI.name = "Syrma I"
	syrmaI.textureName = "syrma1.png"
	syrmaI.width = 30
	syrmaI.height = 30
	syrmaI.locX = -250
	syrmaI.locY = 0
	syrmaI.information = "-Radioactive\n"..
		"-Diameter: 5,739 km\n"..
		"-Mass: 5.73e23 kg\n"..
		"\n"..
		"Syrma I is a small radioactive planet in the Syrma system.  The Syrma corporation offers tours to visitors interested "..
		"in a more exotic relaxation experience.\n\n"..
		"To register for a tour contact the Syrma Corporation's main office at Syrma III."
	location.planets:add(syrmaI)

	local syrmaII = model.starMapLocations.getPlanet()
	syrmaII.functionName = "syrmaII"
	syrmaII.name = "Syrma II"
	syrmaII.textureName = "syrma2.png"
	syrmaII.width = 50
	syrmaII.height = 50
	syrmaII.locX = -150
	syrmaII.locY = 0
	syrmaII.information = "-Ocean\n"..
		"-Diameter: 11,374 km\n"..
		"-Mass: 4.93e24 kg\n"..
		"\n"..
		"The ocean world of the Syrma system, Syrma II is known for it's huge expanses of crisp blue water.  The Syrma corporation has "..
		"many pleasure cruise options available to interested visitors.  These range from whale watching tours to adults only adventures.\n\n"..
		"To register for a tour contact the Syrma Corporation's main office at Syrma III."
	location.planets:add(syrmaII)

	local syrmaIII = model.starMapLocations.getPlanet()
	syrmaIII.functionName = "syrmaIII"
	syrmaIII.name = "Syrma III"
	syrmaIII.textureName = "syrma3.png"
	syrmaIII.width = 70
	syrmaIII.height = 70
	syrmaIII.locX = -50
	syrmaIII.locY = 0
	function syrmaIII:action1()
		return "hailSyrmaIII", "Hail"
	end
	syrmaIII.information = "-Terrestrial\n"..
		"-Diameter: 12,118 km\n"..
		"-Mass: 5.87e24 kg\n"..
		"\n"..
		"Syrma III is the primary resort world of the Syrma Corporation.  The entire planet is dedicated to making visitors welcome; having "..
		"entertainment options for all species available.\n\n"..
		"The Syrma Corporation specialises in multi-species vacation packages."
	location.planets:add(syrmaIII)

	local syrmaIV = model.starMapLocations.getPlanet()
	syrmaIV.functionName = "syrmaIV"
	syrmaIV.name = "Syrma IV"
	syrmaIV.textureName = "syrma4.png"
	syrmaIV.width = 140
	syrmaIV.height = 140
	syrmaIV.locX = 150
	syrmaIV.locY = 0
	syrmaIV.information = "-Gas Giant\n"..
		"-Diameter: 118,362 km\n"..
		"-Mass: 4.38e26 kg\n"..
		"\n"..
		"Syrma IV is a medium sized Gas Giant in the Syrma system.  The Syrma Corporation offers tours of the outer gas rim to interested visitors.\n\n"..
		"To register for a tour contact the Syrma Corporation's main office at Syrma III."
	location.planets:add(syrmaIV)

	local syrmaV = model.starMapLocations.getPlanet()
	syrmaV.functionName = "syrmaV"
	syrmaV.name = "Syrma V"
	syrmaV.textureName = "syrma5.png"
	syrmaV.width = 25
	syrmaV.height = 25
	syrmaV.locX = 300
	syrmaV.locY = 0
	syrmaV.information = "-Desert\n"..
		"-Diameter: 4,583 km\n"..
		"-Mass: 2.85e23 kg\n"..
		"\n"..
		"Syrma V is a small desert planet in the Syrma system.  Its barren deserts offer visitors a unique low-G hiking experience.\n\n"..
		"To register for a tour contact the Syrma Corporation's main office at Syrma III."
	location.planets:add(syrmaV)

	return location
end


--------------------------------------------------------------------------
--Castor
--The Malvar home system.
--------------------------------------------------------------------------
function model.starMapLocations.castor()
	local location = {}
	location.functionName = "castor"
	location.name = "Castor"
	location.textureName = "redStar.png"
	location.width = 50
	location.height = 50
	location.starMapLocX = 1200
	location.starMapLocY = 200

	location.planets = util.getArrayList()
	local castorI = model.starMapLocations.getPlanet()
	castorI.functionName = "castorI"
	castorI.name = "Castor I"
	--if the planet has not been moved then it should be an ice ball
	if not gameState.quests.malvarPlanet.movedPlanet then
		castorI.textureName = "castor1Before.png"
	else
		castorI.textureName = "castor1After.png"
	end
	castorI.width = 70
	castorI.height = 70
	if not gameState.quests.malvarPlanet.movedPlanet then
		castorI.locX = 400
	else
		castorI.locX = -300
	end
	castorI.locY = 0
	function castorI:action1()
		return "hailCastorI", "Hail"
	end
	castorI.information = "-Terrestrial\n"..
		"-Diameter: 13,473 km\n"..
		"-Mass: 4.72e24 kg\n"..
		"\n"..
		"Castor I is the home planet of the Malvar.\n\n"..
		"The Malvar are an ancient gastropod race that were once space faring.  Long ago the Malvar were militant and controlled much of the "..
		"galaxy.  They grew to hate violence; seeing technology as the catalyst to their aggression they grounded their entire fleet and "..
		"as a species collectively decided to take a period of meditation.  During this period their sun quickly receded leaving their home world "..
		"an inhospitable tundra.\n\n"..
		"The Malvar; having come to terms with their warlike past, are ready to once again journey to the stars.  Unfortunately their planet's "..
		"resources are buried under a layer of ice."
	location.planets:add(castorI)

	return location
end


--------------------------------------------------------------------------
--Heron
--This is the system with the nudist colony.
--------------------------------------------------------------------------
function model.starMapLocations.heron()
	local location = {}
	location.functionName = "heron"
	location.name = "Heron"
	location.textureName = "yellowStar.png"
	location.width = 80
	location.height = 80
	location.starMapLocX = 450
	location.starMapLocY = -580

	location.planets = util.getArrayList()
	local heronI = model.starMapLocations.getPlanet()
	heronI.functionName = "heronI"
	heronI.name = "Heron I"
	heronI.textureName = "heron1.png"
	heronI.width = 30
	heronI.height = 30
	heronI.locX = -230
	heronI.locY = 0
	heronI.information = "-Radioactive\n"..
		"-Diameter: 4,792 km\n"..
		"-Mass: 3.01e23 kg\n"..
		"\n"..
		"A small radioactive planet in the Heron system.  The Grove colony harvests the atmosphere for fuel."
	location.planets:add(heronI)

	local heronII = model.starMapLocations.getPlanet()
	heronII.functionName = "heronII"
	heronII.name = "Heron II"
	heronII.textureName = "heron2.png"
	heronII.width = 40
	heronII.height = 40
	heronII.locX = -140
	heronII.locY = 0
	heronII.information = "-Radioactive\n"..
		"-Diameter: 10,909 km\n"..
		"-Mass: 1.93e24 kg\n"..
		"\n"..
		"A small radioactive planet in the Heron system.  The Grove colony harvests the atmosphere for fuel."
	location.planets:add(heronII)

	local theGrove = model.starMapLocations.getPlanet()
	theGrove.functionName = "theGrove"
	theGrove.name = "The Grove"
	theGrove.textureName = "theGrove.png"
	theGrove.width = 60
	theGrove.height = 60
	theGrove.locX = -30
	theGrove.locY = 0
	function theGrove:action1()
		if not gameState.crew.frank then
			return "hailTheGrove", "Hail"
		elseif gameState.quests.yepp.savedTheGrove and not gameState.quests.yepp.shipHasBeenRepaired then
			return "landAtTheGrove", "Land"
		end
	end
	theGrove.information = "-Terrestrial\n"..
		"-Diameter: 11,480 km\n"..
		"-Mass: 5.36e24 kg\n"..
		"\n"..
		"The third planet in the Heron system is named for the colony on it.  A \"naturalist retreat\" where many of the well-to-do "..
		"from the human colonies go to retire.  The warmer-than-Earth temperatures offered by the planet are ideal for the unencumbered "..
		"lifestyle residents of the colony adhere to.\n"..
		"\n"..
		"The colony is self-sustaining and low impact, harvesting energy and minerals from the surrounding planets.  They also have "..
		"an extensive automated farming operation that requires little human intervention...leaving a lot of time for relaxation."
	location.planets:add(theGrove)

	local peach = model.starMapLocations.getPlanet()
	peach.functionName = "peach"
	peach.name = "The Peach"
	peach.textureName = "peach.png"
	peach.width = 130
	peach.height = 130
	peach.locX = 230
	peach.locY = 0
	peach.information = "-Gas Giant\n"..
		"-Diameter: 53,682 km\n"..
		"-Mass: 9.09e25 kg\n"..
		"\n"..
		"A medium sized gas giant in the Heron system.  The residents of The Grove named it The Peach because it resembles the fruit "..
		"when viewed through a telescope from their planet."
	location.planets:add(peach)

	local heronV = model.starMapLocations.getPlanet()
	heronV.functionName = "heronV"
	heronV.name = "Heron V"
	heronV.textureName = "heron5.png"
	heronV.width = 25
	heronV.height = 25
	heronV.locX = 380
	heronV.locY = 0
	heronV.information = "-Barren\n"..
		"-Diameter: 3,004 km\n"..
		"-Mass: 1.52e22 kg\n"..
		"\n"..
		"This small barren planet contains some rare elements that The Grove mines for electronic systems.  There is an automated mining "..
		"operation on the planet."
	location.planets:add(heronV)

	if gameState.quests.yepp.foundOutAntsAttackingTheGrove and not gameState.quests.yepp.savedTheGrove then
		local hive = model.starMapLocations.getPlanet()
		hive.functionName = "hive"
		hive.name = "Ant Hive"
		hive.textureName = "hive.png"
		hive.width = 23
		hive.height = 23
		hive.locX = 0
		hive.locY = -100
		function hive:action1()
			return "hailTheGroveHive", "Hail"
		end
		hive.information = "An Ant Hive that is threatening The Grove colony.\n"..
			"\n"..
			"Ant Hives are the means by which the Ants travel between star systems.  It is a living mass of Ants that have attached "..
			"themselves together.  The Hive uses some of the members for fuel, some for weapons fire, etc.  "..
			"The specifics of how it operates have not yet been thoroughly studied.\n"..
			"\n"..
			"The Ant Hive has nodules that emit venom that can destroy a star ship."
		location.planets:add(hive)
	end

	return location
end


--------------------------------------------------------------------------
--Antares
--This is the system with the human colony.
--------------------------------------------------------------------------
function model.starMapLocations.antares()
	local location = {}
	location.functionName = "antares"
	location.name = "Antares"
	location.textureName = "redStar.png"
	location.width = 40
	location.height = 40
	location.starMapLocX = 350
	location.starMapLocY = 820

	location.planets = util.getArrayList()
	local antaresI = model.starMapLocations.getPlanet()
	antaresI.functionName = "antaresI"
	antaresI.name = "Antares I"
	antaresI.textureName = "antares1.png"
	antaresI.width = 30
	antaresI.height = 30
	antaresI.locX = -320
	antaresI.locY = 0
	antaresI.information = "-Barren\n"..
		"-Diameter: 11,989 km\n"..
		"-Mass: 4.77e24 kg\n"..
		"\n"..
		"A barren planet in the Antares system."
	location.planets:add(antaresI)

	local antaresII = model.starMapLocations.getPlanet()
	antaresII.functionName = "antaresII"
	antaresII.name = "Antares II"
	antaresII.textureName = "antares2.png"
	antaresII.width = 35
	antaresII.height = 35
	antaresII.locX = -220
	antaresII.locY = 0
	antaresII.information = "-Barren\n"..
		"-Diameter: 12,849 km\n"..
		"-Mass: 5.08e24 kg\n"..
		"\n"..
		"A barren planet in the Antares system."
	location.planets:add(antaresII)

	local antaresIII = model.starMapLocations.getPlanet()
	antaresIII.functionName = "antaresIII"
	antaresIII.name = "Antares III"
	antaresIII.textureName = "antares3.png"
	antaresIII.width = 45
	antaresIII.height = 45
	antaresIII.locX = -100
	antaresIII.locY = 0
	function antaresIII:action1()
		return "hailAntaresIII", "Hail"
	end
	antaresIII.information = "-Barren\n"..
		"-Diameter: 14,492 km\n"..
		"-Mass: 6.27e24 kg\n"..
		"\n"..
		"Antares III is a barren lifeless planet.  It was chosen as an ideal site for a human military research facility.  "..
		"The rotation cycle of the planet is in sync with its revolution cycle, meaning that one side of the planet is always facing "..
		"the sun.  This gives the research facility a constant source of light for its solar generators.  A colony is built "..
		"around the research facility housing the families of scientists and military personnel.  Access to the space around the "..
		"planet is strictly prohibited.\n"..
		"\n"..
		"Colony operations are overseen by an Om Magistrate.  Magistrates act on behalf of Om and the One World empire ministries.  "..
		"Though not directly in charge of military operations, they do have final say on anything related to the colonies that they "..
		"oversee.  It is considered proper custom to address them by title."
	location.planets:add(antaresIII)

	local antaresIV = model.starMapLocations.getPlanet()
	antaresIV.functionName = "antaresIV"
	antaresIV.name = "Antares IV"
	antaresIV.textureName = "antares4.png"
	antaresIV.width = 27
	antaresIV.height = 27
	antaresIV.locX = 120
	antaresIV.locY = 0
	antaresIV.information = "-Barren\n"..
		"-Diameter: 10,881 km\n"..
		"-Mass: 4.52e24 kg\n"..
		"\n"..
		"A barren planet in the Antares system."
	location.planets:add(antaresIV)

	return location
end


--------------------------------------------------------------------------
-- getPlanet
-- This will return a planet object.  It will setup the action functions returning nil by default.
--------------------------------------------------------------------------
function model.starMapLocations.getPlanet()
	local planet = {}
	function planet:action1()
		return nil, nil
	end
	function planet:action2()
		return nil, nil
	end
	return planet
end

--------------------------------------------------------------------------
--functions for loading/retrieving the location/planet props
--NOTE: these are all assumed to be square props
--------------------------------------------------------------------------
model.starMapLocations.propBaseWidth = 300

--------------------------------------------------------------------------
-- loadTextures
-- load up the decks for all of the location and planet props
--------------------------------------------------------------------------
function model.starMapLocations.loadTextures()
	--locations
	model.starMapLocations.gfxQuadsLocations, model.starMapLocations.namesLocations, starMapLocationsTex = util.loadTexturePack("texturePacks/locations/locationsPack.lua", "texturePacks/locations/locationsPack.png")
	for key, value in pairs(model.starMapLocations.namesLocations) do
		model.starMapLocations.gfxQuadsLocations:setRect(value, model.starMapLocations.propBaseWidth / 2 * -1, model.starMapLocations.propBaseWidth / 2 * -1, model.starMapLocations.propBaseWidth / 2, model.starMapLocations.propBaseWidth / 2)
	end
	--planets
	model.starMapLocations.gfxQuadsPlanets, model.starMapLocations.namesPlanets, planetsTex = util.loadTexturePack("texturePacks/planets/planetsPack.lua", "texturePacks/planets/planetsPack.png")
	for key, value in pairs(model.starMapLocations.namesPlanets) do
		model.starMapLocations.gfxQuadsPlanets:setRect(value, model.starMapLocations.propBaseWidth / 2 * -1, model.starMapLocations.propBaseWidth / 2 * -1, model.starMapLocations.propBaseWidth / 2, model.starMapLocations.propBaseWidth / 2)
	end
end

--------------------------------------------------------------------------
-- getLocationProp
-- get a location prop that is scaled properly
-- this takes a location object and returns the prop that is sized correctly based on the size (with an optional scale value)
--------------------------------------------------------------------------
function model.starMapLocations.getLocationProp(location, scale)
	local propScale = 1
	if scale ~= nil then
		propScale = scale
	end
	local prop = MOAIProp2D.new()
	prop:setDeck(model.starMapLocations.gfxQuadsLocations)
	prop:setIndex(model.starMapLocations.namesLocations[location.textureName])
	prop:setScl(location.width / model.starMapLocations.propBaseWidth * propScale, location.height / model.starMapLocations.propBaseWidth * propScale)
	return prop
end

--------------------------------------------------------------------------
-- getPlanetProp
-- get a planet prop that is scaled properly
-- this takes a planet object and returns the prop that is sized correctly based on the size (with an optional scale value)
--------------------------------------------------------------------------
function model.starMapLocations.getPlanetProp(planet, scale)
	local propScale = 1
	if scale ~= nil then
		propScale = scale
	end
	local prop = MOAIProp2D.new()
	prop:setDeck(model.starMapLocations.gfxQuadsPlanets)
	prop:setIndex(model.starMapLocations.namesPlanets[planet.textureName])
	prop:setScl(planet.width / model.starMapLocations.propBaseWidth * propScale, planet.height / model.starMapLocations.propBaseWidth * propScale)
	return prop
end
