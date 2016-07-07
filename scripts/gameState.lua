--####################################
-- gameState.lua
-- author: Jonas Yakimischak
--
-- This holds the current state of the game (location, ship, crew, etc)
--####################################

--namespace gameState


--------------------------------------------------------------------------
-- newGameState
-- setup a new gameState object.
--------------------------------------------------------------------------
function newGameState()
	--------------------------------------------------------------------------
	--This is true if the ship is traveling.
	--------------------------------------------------------------------------
	gameState.traveling = false
	
	--------------------------------------------------------------------------
	--If the ship is traveling then these will be set to the x, y, rot values for the ship
	--------------------------------------------------------------------------
	gameState.travelingX, gameState.travelingY, gameState.travelingRot = nil, nil, nil
	
	--------------------------------------------------------------------------
	--This will hold the travel destination of the ship
	--------------------------------------------------------------------------
	gameState.destination = nil  
	
	--------------------------------------------------------------------------
	--This is the function name of the current location on the star map.
	--------------------------------------------------------------------------
	gameState.currentLocation = nil
	
	--------------------------------------------------------------------------
	--This is the function name of the current planet on the planet screen.
	--------------------------------------------------------------------------
	gameState.currentPlanet = nil
	
	--------------------------------------------------------------------------
	--This is an array of strings.  Each string is the function name of the method that returns a given star map location from modal.starMapLocations
	--------------------------------------------------------------------------
	gameState.visibleStarMapLocations = nil
	
	--------------------------------------------------------------------------
	--What crew members do you have; set to false by default
	--------------------------------------------------------------------------
	gameState.crew = {}
	gameState.crew.oleg = false
	gameState.crew.charlie = false
	gameState.crew.clarence = false
	gameState.crew.jarvis = false
	gameState.crew.frank = false
	gameState.crew.yepp = false
	
	--------------------------------------------------------------------------
	--crew details - if on the crew details screen then this is the member that is being viewed
	--------------------------------------------------------------------------
	gameState.crewDetailsViewing = nil
	
	--------------------------------------------------------------------------
	--This is the total energy that the PC has, based upon where they are in the story
	--------------------------------------------------------------------------
	gameState.shipTotalEnergy = nil
	
	--------------------------------------------------------------------------
	--This is the total armor that the PC has; always stays the same
	--------------------------------------------------------------------------
	gameState.shipTotalArmor = 1000
	
	--------------------------------------------------------------------------
	--What pc ship weapons do you have; set to false by default
	--------------------------------------------------------------------------
	gameState.pcWeapons = {}
	gameState.pcWeapons.nuclearTorpedoes = true
	gameState.pcWeapons.laserBeam = true
	gameState.pcWeapons.miniGun = true
	gameState.pcWeapons.fissionTorpedoes = true
	gameState.pcWeapons.ionBeam = true
	gameState.pcWeapons.massDriver = true
	gameState.pcWeapons.antiMatterTorpedoes = true
	gameState.pcWeapons.plasmaCannon = true
	gameState.pcWeapons.coilGun = true
	
	--------------------------------------------------------------------------
	--What pc ship engines do you have; set to false by default
	--------------------------------------------------------------------------
	gameState.pcEngines = {}
	gameState.pcEngines.level1 = true
	gameState.pcEngines.level2 = true
	gameState.pcEngines.level3 = true
	
	--------------------------------------------------------------------------
	--What pc ship computer do you have; set to true by default
	--------------------------------------------------------------------------
	gameState.pcComputer = {}
	gameState.pcComputer.level1 = true
	gameState.pcComputer.level2 = true
	gameState.pcComputer.level3 = true
	
	--------------------------------------------------------------------------
	--What pc ship shields do you have; set to true by default
	--------------------------------------------------------------------------
	gameState.pcShields = {}
	gameState.pcShields.level1 = true
	gameState.pcShields.level2 = true
	gameState.pcShields.level3 = true
	
	--------------------------------------------------------------------------
	--What does the pc ship have equipped
	--------------------------------------------------------------------------
	gameState.pcShipEquippedWeapon = nil
	gameState.pcShipEquippedEngines = nil
	gameState.pcShipEquippedComputer = nil
	gameState.pcShipEquippedShields = nil
	
	
	--------------------------------------------------------------------------
	--Quests...this is the state information related to quests
	--------------------------------------------------------------------------
	gameState.quests = {}
	--this is just the quest to begin the game...nothing really here
	gameState.quests.theBeginning = {}
	gameState.quests.theBeginning.started = false
	--this is the quest to repair the ship at the beginning of the game.
	gameState.quests.repairs = {}
	gameState.quests.repairs.started = false
	gameState.quests.repairs.spokeWithLlaxon = false
	gameState.quests.repairs.cursaIScanned = false
	gameState.quests.repairs.cursaIProbeLaunched = false
	gameState.quests.repairs.cursaIHailed = false
	gameState.quests.repairs.gotLocations = false
	gameState.quests.repairs.complete = false
	--this is the small quest to get the coordinates from Jarvis
	gameState.quests.jarvisCoordinates = {}
	gameState.quests.jarvisCoordinates.gaveResortCoordinates = false
	gameState.quests.jarvisCoordinates.gaveActualCoordinates = false
	gameState.quests.jarvisCoordinates.comlete = false
	--this is the quest to help the Malvar move their planet closer to the sun
	gameState.quests.malvarPlanet = {}
	gameState.quests.malvarPlanet.learnedAboutUngiriPlanetMover = false
	gameState.quests.malvarPlanet.learnedAboutLepus = false
	gameState.quests.malvarPlanet.lepusAgreedToHelp = false
	gameState.quests.malvarPlanet.ungiriAgreedToMovePlanet = false
	gameState.quests.malvarPlanet.movedPlanet = false
	--bringing yepp to the human colony
	gameState.quests.yepp = {}
	gameState.quests.yepp.foundOutAntsAttackingTheGrove = false
	gameState.quests.yepp.savedTheGrove = false
	gameState.quests.yepp.shipHasBeenRepaired = false
	gameState.quests.yepp.backToArtemis = false
	gameState.quests.yepp.backAtArtemis = false
	gameState.quests.yepp.humanDestroyerKilled = false
	
	--------------------------------------------------------------------------
	--Non-quest flags...these are flags that are not associated with any specific quest line
	--------------------------------------------------------------------------
	gameState.metLlaxon = false
	gameState.metTakataka = false
	gameState.metUngiri = false
	gameState.encounteredPirates = false
	gameState.metMalvar = false
	gameState.metLepus = false
	gameState.francisDead = false
	gameState.hailedAntaresIII = false
	--hydra side quest
	gameState.scannedHydraI = false
	gameState.landedHydraI = false
	--alya side quest
	gameState.scannedAlyaI = false
	gameState.AlyaILlaxonProvoked = false
	gameState.AlyaILlaxonDefeated = false
	gameState.probedAlyaI = false
	gameState.alyaIMetMary = false
	--llaxon destroyer attack
	gameState.llaxonDestroyerAttacked = false
	gameState.llaxonDestroyerKilled = false
	--pirate destroyer
	gameState.pirateDestroyerKilled = false
	
	--------------------------------------------------------------------------
	--Dialog...this is the functionName of the npc dialog that you are engaged in
	--------------------------------------------------------------------------
	gameState.dialog = nil
end
