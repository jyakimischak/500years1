--####################################
-- speakWithMagistrate.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when you speak with the Magistrate asking for help.
--####################################

--namespace model.cutScenes


function model.cutScenes.speakWithMagistrate()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("You speak with the Magistrate telling him everything that has happened so far.")
			screens.cutSceneScreen.captions:add("He is so intent upon hearing of your colony that Yepp is never mentioned.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
