--####################################
-- textureUtil.lua
-- author: Jonas Yakimischak
--
-- Function for managing textures
--####################################

--namespace textureUtil

textureUtil.START = "start"
textureUtil.NON_COMBAT = "nonCombat"
textureUtil.COMBAT = "combat"
textureUtil.INTRO = "intro"
textureUtil.TUTORIAL = "tutorial"
textureUtil.OUTRO = "outro"
--textureUtil.LLAXON = "llaxon"
--textureUtil.LLAXON_DESTROYER = "llaxonDestroyer"
--textureUtil.PIRATE = "pirate"
--textureUtil.PIRATE_DESTROYER = "pirateDestroyer"
--textureUtil.TAKATAKA = "takataka"
--textureUtil.ANT_HIVE = "antHive"
--textureUtil.HUMAN_DESTROYER = "humanDestroyer"
--

--------------------------------------------------------------------------
-- This will load the permanent textures
--------------------------------------------------------------------------
function textureUtil.loadPermTextures()
	sharedGfxQuads, sharedNames = util.loadTexturePack("texturePacks/shared/sharedPack.lua", "texturePacks/shared/sharedPack.png")  
	sharedGfxQuads:setRect(sharedNames["bannerBackground.png"], -550, -35, 550, 35)
	sharedGfxQuads:setRect(sharedNames["starBackground.png"], -657, -385, 657, 385)
	screenUtil.loadStarTextures()   
	shipsGfxQuads, shipsNames = util.loadTexturePack("texturePacks/ships/shipsPack.lua", "texturePacks/ships/shipsPack.png")
end

--------------------------------------------------------------------------
-- This will add a text box to the screen.
--------------------------------------------------------------------------
function textureUtil.loadTextures(type)
	textureUtil.unloadAll()
	
	if type == textureUtil.START then
		textureUtil.loadStart()
	elseif type == textureUtil.NON_COMBAT then
		textureUtil.loadNonCombat()
	elseif type == textureUtil.COMBAT then
		textureUtil.loadCombat()
--	elseif type == textureUtil.LLAXON then
--		textureUtil.loadLlaxon()
--	elseif type == textureUtil.LLAXON_DESTROYER then
--		textureUtil.loadLlaxonDestroyer()
--	elseif type == textureUtil.PIRATE then
--		textureUtil.loadPirate()
--	elseif type == textureUtil.PIRATE_DESTROYER then
--		textureUtil.loadPirateDestroyer()
--	elseif type == textureUtil.TAKATAKA then
--		textureUtil.loadTakataka()
--	elseif type == textureUtil.ANT_HIVE then
--		textureUtil.loadAntHive()
--	elseif type == textureUtil.HUMAN_DESTROYER then
--		textureUtil.loadHumanDestroyer()
		
	elseif type == textureUtil.INTRO then
		textureUtil.loadIntro()
	elseif type == textureUtil.TUTORIAL then
		textureUtil.loadTutorial()
	elseif type == textureUtil.OUTRO then
		textureUtil.loadOutro()
	end
end

--------------------------------------------------------------------------
-- Unload all of the textures (except for the permanent ones)
--------------------------------------------------------------------------
function textureUtil.unloadAll()
print("*********** unloadAll")
	if splashTex ~= nil then
		splashTex:release()
	end
	splashGfxQuads, splashNames, splashTex = nil, nil, nil

	if crewTex ~= nil then
		crewTex:release()
	end 
	crewGfxQuads, crewNames, crewTex = nil, nil, nil  

	if charactersTex ~= nil then
		charactersTex:release()
	end
	charactersGfxQuads, charactersNames, charactersTex = nil, nil, nil
	  
	if starMapTex ~= nil then
		starMapTex:release()
	end
	starMapGfxQuads, starMapNames, starMapTex = nil, nil, nil
	  
	if starMapLocations ~= nil then
		starMapLocations:release()
	end
	model.starMapLocations.gfxQuadsLocations, model.starMapLocations.namesLocations, starMapLocationsTex =  nil, nil, nil
	 
	if planetsTex ~= nil then
		planetsTex:release()
	end
	model.starMapLocations.gfxQuadsPlanets, model.starMapLocations.namesPlanets, planetsTex =  nil, nil, nil
	
	if particlesTex ~= nil then
		particlesTex:release()
	end
	particlesGfxQuads, particlesNames, particlesTex = nil, nil, nil
	  
	if weaponsTex ~= nil then
		weaponsTex:release()
	end
	weaponsGfxQuads, weaponsNames, weaponsTex = nil, nil, nil

	if llaxonFighterTex ~= nil then
		llaxonFighterTex:release()
	end	  
	llaxonFighterGfxQuads, llaxonFighterNames, llaxonFighterTex = nil, nil, nil  

	if llaxonDestroyerTex ~= nil then
		llaxonDestroyerTex:release()
	end
	llaxonDestroyerGfxQuads, llaxonDestroyerNames, llaxonDestroyerTex = nil, nil, nil  

	if pirateTex ~= nil then
		pirateTex:release()
	end
	pirateGfxQuads, pirateNames, pirateTex = nil, nil, nil  

	if pirateDestroyerTex ~= nil then
		pirateDestroyerTex:release()
	end
	pirateDestroyerGfxQuads, pirateDestroyerNames, pirateDestroyerTex = nil, nil, nil  

	if takatakaTex ~= nil then
		takatakaTex:release()
	end
	takatakaGfxQuads, takatakaNames, takatakaTex = nil, nil, nil  

	if antHiveTex ~= nil then
		antHiveTex:release()
	end
	antHiveGfxQuads, antHiveNames, antHiveTex = nil, nil, nil  

	if humanDestroyerTex ~= nil then
		humanDestroyerTex:release()
	end
	humanDestroyerGfxQuads, humanDestroyerNames, humanDestroyerTex = nil, nil, nil  

	if battleFields1Tex ~= nil then
		battleFields1Tex:release()
	end
	battleFields1GfxQuads, battleFields1Names, battleFields1Tex = nil, nil, nil  

	if battleFields2Tex ~= nil then
		battleFields2Tex:release()
	end
	battleFields2GfxQuads, battleFields2Names, battleFields2Tex = nil, nil, nil  

	if tutorialTex ~= nil then
		tutorialTex:release()
	end
	tutorialGfxQuads, tutorialNames, tutorialTex = nil, nil, nil  

	if outroTex ~= nil then
		outroTex:release()
	end
	outroGfxQuads, outroNames, outroTex = nil, nil, nil

	if introTex ~= nil then
		introTex:release()
	end
	introGfxQuads, introNames, introTex = nil, nil, nil

	ships.llaxonFighterShipPropSized = false 
	ships.llaxonDestroyerShipPropSized = false
	ships.llaxonDestroyerTurretShipPropSized = false
	ships.pirateFighterShipPropSized = false
	ships.pirateMissleFighterShipPropSized = false
	ships.pirateDestroyerShipPropSized = false
	ships.pirateDestroyerTurretShipPropSized = false
	ships.takatakaFighterShipPropSized = false
	ships.takatakaLargeFighterShipPropSized = false
	ships.antHiveShipPropSized = false
	ships.antHiveTurretShipPropSized = false
	ships.humanDestroyerShipPropSized = false
	ships.humanDestroyerFrontTurretShipPropSized = false 
	ships.humanDestroyerRearTurretShipPropSized = false
	ships.humanDestroyerGunTurretShipPropSized = false
	ships.nuclearTorpedoPropSized = false
	ships.laserBeamPropSized = false
	ships.fissionTorpedoPropSized = false
	ships.ionBeamPropSized = false
	ships.antiMatterTorpedoPropSized = false 
	ships.plasmaCannonPropSized = false
	ships.llaxonFighterWeaponPropSized = false
	ships.takatakaFighterWeaponPropSized = false
	ships.takatakaLargeFighterWeaponPropSized = false
	ships.nuclearTorpedoPropSized = false
	ships.pirateDestroyerWeaponPropSized = false
	ships.antVenomWeaponPropSized = false
	ships.humanDestroyerFrontWeaponPropSized = false
	ships.humanDestroyerRearWeaponPropSized = false
	ships.shockwavesSized = false
	ships.explodePropsSized = false
	screens.battleScreen.asteroidsSized = false

	MOAISim.forceGarbageCollection()
end


function textureUtil.loadStart()
	splashGfxQuads, splashNames, splashTex = util.loadTexturePack("texturePacks/splash/splashPack.lua", "texturePacks/splash/splashPack.png")
end


function textureUtil.loadNonCombat()
	crewGfxQuads, crewNames, crewTex = util.loadTexturePack("texturePacks/crew/crewPack.lua", "texturePacks/crew/crewPack.png")  
	charactersGfxQuads, charactersNames, charactersTex = util.loadTexturePack("texturePacks/characters/charactersPack.lua", "texturePacks/characters/charactersPack.png")  
	starMapGfxQuads, starMapNames, starMapTex = util.loadTexturePack("texturePacks/starMap/starMapPack.lua", "texturePacks/starMap/starMapPack.png")  
	model.starMapLocations.loadTextures()
end


function textureUtil.loadCombat()
	particlesGfxQuads, particlesNames, particlesTex = util.loadTexturePack("texturePacks/particles/particlesPack.lua", "texturePacks/particles/particlesPack.png")  
	weaponsGfxQuads, weaponsNames, weaponsTex = util.loadTexturePack("texturePacks/weapons/weaponsPack.lua", "texturePacks/weapons/weaponsPack.png")  
	battleFields1GfxQuads, battleFields1Names, battleFields1Tex = util.loadTexturePack("texturePacks/battleFields/battleFieldsPack1.lua", "texturePacks/battleFields/battleFieldsPack1.png")  
	battleFields2GfxQuads, battleFields2Names, battleFields2Tex = util.loadTexturePack("texturePacks/battleFields/battleFieldsPack2.lua", "texturePacks/battleFields/battleFieldsPack2.png")  

--	llaxonFighterGfxQuads, llaxonFighterNames = util.loadTexturePack("texturePacks/ships/llaxon/llaxonFighterPack.lua", "texturePacks/ships/llaxon/llaxonFighterPack.png")  
--	llaxonFighterGfxQuads, llaxonFighterNames = util.loadTexturePack("texturePacks/ships/llaxon/llaxonFighterPack.lua", "texturePacks/ships/llaxon/llaxonFighterPack.png")  
--	llaxonDestroyerGfxQuads, llaxonDestroyerNames = util.loadTexturePack("texturePacks/ships/llaxon/llaxonDestroyerPack.lua", "texturePacks/ships/llaxon/llaxonDestroyerPack.png")  
--	pirateGfxQuads, pirateNames = util.loadTexturePack("texturePacks/ships/pirate/piratePack.lua", "texturePacks/ships/pirate/piratePack.png")  
--	pirateDestroyerGfxQuads, pirateDestroyerNames = util.loadTexturePack("texturePacks/ships/pirate/pirateDestroyerPack.lua", "texturePacks/ships/pirate/pirateDestroyerPack.png")  
--	takatakaGfxQuads, takatakaNames = util.loadTexturePack("texturePacks/ships/takataka/takatakaPack.lua", "texturePacks/ships/takataka/takatakaPack.png")  
--	antHiveGfxQuads, antHiveNames = util.loadTexturePack("texturePacks/ships/ant/antHivePack.lua", "texturePacks/ships/ant/antHivePack.png")  
--	humanDestroyerGfxQuads, humanDestroyerNames = util.loadTexturePack("texturePacks/ships/human/humanDestroyerPack.lua", "texturePacks/ships/human/humanDestroyerPack.png")  
end


function textureUtil.loadIntro()
	introGfxQuads, introNames, introTex = util.loadTexturePack("texturePacks/cutScenes/intro/introPack.lua", "texturePacks/cutScenes/intro/introPack.png")
end


function textureUtil.loadTutorial()
	tutorialGfxQuads, tutorialNames, tutorialTex = util.loadTexturePack("texturePacks/cutScenes/tutorial/tutorialPack.lua", "texturePacks/cutScenes/tutorial/tutorialPack.png")  
end


function textureUtil.loadOutro()
	outroGfxQuads, outroNames, outroTex = util.loadTexturePack("texturePacks/cutScenes/outro/outroPack.lua", "texturePacks/cutScenes/outro/outroPack.png")
end


function textureUtil.loadLlaxon()
	llaxonFighterGfxQuads, llaxonFighterNames, llaxonFighterTex = util.loadTexturePack("texturePacks/ships/llaxon/llaxonFighterPack.lua", "texturePacks/ships/llaxon/llaxonFighterPack.png")  
end


function textureUtil.loadLlaxonDestroyer()
	llaxonDestroyerGfxQuads, llaxonDestroyerNames, llaxonDestroyerTex = util.loadTexturePack("texturePacks/ships/llaxon/llaxonDestroyerPack.lua", "texturePacks/ships/llaxon/llaxonDestroyerPack.png")  
end


function textureUtil.loadPirate()
	pirateGfxQuads, pirateNames, pirateTex = util.loadTexturePack("texturePacks/ships/pirate/piratePack.lua", "texturePacks/ships/pirate/piratePack.png")  
end


function textureUtil.loadPirateDestroyer()
	pirateDestroyerGfxQuads, pirateDestroyerNames, pirateDestroyerTex = util.loadTexturePack("texturePacks/ships/pirate/pirateDestroyerPack.lua", "texturePacks/ships/pirate/pirateDestroyerPack.png")  
end


function textureUtil.loadTakataka()
	takatakaGfxQuads, takatakaNames, takatakaTex = util.loadTexturePack("texturePacks/ships/takataka/takatakaPack.lua", "texturePacks/ships/takataka/takatakaPack.png")  
end


function textureUtil.loadAntHive()
	antHiveGfxQuads, antHiveNames, antHiveTex = util.loadTexturePack("texturePacks/ships/ant/antHivePack.lua", "texturePacks/ships/ant/antHivePack.png")  
end


function textureUtil.loadHumanDestroyer()
	humanDestroyerGfxQuads, humanDestroyerNames, humanDestroyerTex = util.loadTexturePack("texturePacks/ships/human/humanDestroyerPack.lua", "texturePacks/ships/human/humanDestroyerPack.png")  
end


  