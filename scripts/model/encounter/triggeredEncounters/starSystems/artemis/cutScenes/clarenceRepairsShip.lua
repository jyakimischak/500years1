--####################################
-- clarenceRepairsShip.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when Clarence repairs the ship.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--clarenceRepairsShip
--this will be played when Clarence is fixing the ship on artemis
--------------------------------------------------------------------------
function model.cutScenes.clarenceRepairsShip()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The ship lands at the Artemis Colony where repairs take place.")
			screens.cutSceneScreen.captions:add("12 days later Clarence has finished the upgrades.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
