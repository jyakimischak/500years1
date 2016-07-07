--####################################
-- landOnAlyaI.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when the ships lands on Alya I and has the generator installed.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--landOnHydraI
--------------------------------------------------------------------------
function model.cutScenes.landOnAlyaI()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The ship lands at the research station on Alya I.")
			screens.cutSceneScreen.captions:add("Mary installs the biofuel generator.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
