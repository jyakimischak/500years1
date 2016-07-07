--####################################
-- introCutScene.lua
-- author: Jonas Yakimischak
--
-- This holds the introduction cut scene for the game.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--introCutScene
--this is the introduction to the game.
--------------------------------------------------------------------------
function model.cutScenes.introCutScene()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			textureUtil.loadTextures(textureUtil.INTRO)
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = introGfxQuads, introNames
--			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = util.loadTexturePack("texturePacks/cutScenes/intro/introPack.lua", "texturePacks/cutScenes/intro/introPack.png")
			screens.cutSceneScreen.sceneIndex = "introScene1.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The Earth was finished; we had to get out.")
			screens.cutSceneScreen.captions:add("We set up cities in space; cities that could last for centuries.")
			screens.cutSceneScreen.captions:add("We sent them out into the stars.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end
			screenUtil.fadeScreen(screens.cutSceneScreen.layers.layer, 3)
			screens.cutSceneScreen.sceneIndex = "introScene2.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("We named them after the ancient wonders.")
			screens.cutSceneScreen.captions:add("The Giza, The Alexandria, the Rhodes;")
			screens.cutSceneScreen.captions:add("and our home The Artemis.")
			screens.cutSceneScreen.captions:add("Our wonders from the old world.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end
			screenUtil.fadeScreen(screens.cutSceneScreen.layers.layer, 3)
			screens.cutSceneScreen.sceneIndex = "introScene3.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("100 years into the stars; that's when we found our new home.")
			screens.cutSceneScreen.captions:add("100 years alone in space.")
			screens.cutSceneScreen.captions:add("Then they came.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end
			screenUtil.fadeScreen(screens.cutSceneScreen.layers.layer, 3)
			screens.cutSceneScreen.sceneIndex = "introScene4.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("Insects; Ants. They enslaved us.")
			screens.cutSceneScreen.captions:add("They fed on us.")
			screens.cutSceneScreen.captions:add("They controlled us.")
			screens.cutSceneScreen.captions:add("400 years of captivity.")
			screens.cutSceneScreen.captions:add("Then they vanished.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end
			screenUtil.fadeScreen(screens.cutSceneScreen.layers.layer, 3)
			screens.cutSceneScreen.sceneIndex = "introScene5.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("I was sent to the ruins of the Artemis.")
			screens.cutSceneScreen.captions:add("I found an ancient ship within the ruins.")
			screens.cutSceneScreen.captions:add("We finally have our chance;")
			screens.cutSceneScreen.captions:add("after 500 years.........")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			textureUtil.loadTextures(textureUtil.NON_COMBAT)
			model.cutScenes.complete = true
		end
	)
end
