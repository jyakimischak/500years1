--####################################
-- textLookup.lua
-- author: Jonas Yakimischak
--
-- This will handle text lookups.
--####################################

--namespace textLookup

--default to english
textLookup.selectedLanguage = textLookup.ENGLISH

--supported languages
textLookup.ENGLISH = "english"


--------------------------------------------------------------------------
-- initializeLanguage
--
-- Initialize the selected language.
--------------------------------------------------------------------------
function textLookup.initializeLanguage()
	if textLookup.selectedLanguage == textLookup.ENGLISH then
		require("scripts.textLookup.englishText")
	end
end


