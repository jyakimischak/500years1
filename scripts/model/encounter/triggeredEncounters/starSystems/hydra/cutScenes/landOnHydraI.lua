--####################################
-- landOnHydraI.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when the ships lands to gather minerals on Hydra I.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--landOnHydraI
--------------------------------------------------------------------------
function model.cutScenes.landOnHydraI()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The ship lands on Hydra I and Clarence gathers a large quantity of lawrencium.")
			screens.cutSceneScreen.captions:add("The armor plating degrades from exposure.")
			screens.cutSceneScreen.captions:add("Clarence proceeds to make the upgrades to the ship.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
