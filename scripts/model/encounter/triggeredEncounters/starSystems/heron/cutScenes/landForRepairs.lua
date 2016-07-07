--####################################
-- landForRepairs.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when the ship lands at The Grove for repairs.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--frankArrives
--------------------------------------------------------------------------
function model.cutScenes.landForRepairs()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The ship lands at The Grove and the repairs begin.")
			screens.cutSceneScreen.captions:add("The crew also takes this opportunity to have shore leave.")
			screens.cutSceneScreen.captions:add("When the repairs are complete Clarence comes to speak to you and looks panicked...")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
