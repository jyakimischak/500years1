--####################################
-- cutScenes.lua
-- author: Jonas Yakimischak
--
-- This will setup the cutScenes for the game.
--####################################

--namespace model.cutScenes

---------------------
--triggered encounter cutscenes for other
---------------------
--introduction
require("scripts.model.encounter.triggeredEncounters.other.introduction.cutScenes.introCutScene")

---------------------
--triggered encounter cutscenes for crew
---------------------
--Oleg
require("scripts.model.encounter.triggeredEncounters.crew.oleg.cutScenes.howToNavigate")
--Charlie
require("scripts.model.encounter.triggeredEncounters.crew.charlie.cutScenes.combatTutorial")

---------------------
--triggered encounter cutscenes for star systems
---------------------
--Artemis star system
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.cutScenes.clarenceRepairsShip")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.cutScenes.scanArtemis")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.cutScenes.artemisDeserted")
require("scripts.model.encounter.triggeredEncounters.starSystems.artemis.cutScenes.shipTrail")
--Vulpecula star system
require("scripts.model.encounter.triggeredEncounters.starSystems.vulpecula.cutScenes.jarvisArrives")
--Syrma star system
require("scripts.model.encounter.triggeredEncounters.starSystems.syrma.cutScenes.charlieTalksToJarvis")
--Castor star system
require("scripts.model.encounter.triggeredEncounters.starSystems.castor.cutScenes.planetIsMoved")
--Heron star system
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.cutScenes.frankArrives")
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.cutScenes.landForRepairs")
require("scripts.model.encounter.triggeredEncounters.starSystems.heron.cutScenes.francisDead")
--Hydra star system
require("scripts.model.encounter.triggeredEncounters.starSystems.hydra.cutScenes.landOnHydraI")
--Alya star system
require("scripts.model.encounter.triggeredEncounters.starSystems.alya.cutScenes.landOnAlyaI")
--Antares star system
require("scripts.model.encounter.triggeredEncounters.starSystems.antares.cutScenes.speakWithMagistrate")
require("scripts.model.encounter.triggeredEncounters.starSystems.antares.cutScenes.antaresShoreLeave")

--------------------------------------------------------------------------
--playCutScene
--fade the given layer and play the given cut scene
--------------------------------------------------------------------------
function model.cutScenes.playCutScene(layerToFade, cutScene)
	local fadeDuration = 3

	screenUtil.fadeScreen(layerToFade, fadeDuration)
	model.cutScenes[cutScene]()
	while not model.cutScenes.complete do
		coroutine.yield()
	end
end

