--####################################
-- fonts.lua
-- author: Jonas Yakimischak
--
-- This will handle managing fonts
--####################################

--namespace fonts

fonts.charcodes = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-"

fonts.grStylusFont = MOAIFont.new()
fonts.grStylusFont:loadFromTTF ( "fonts/GR_Stylus.ttf", fonts.charcodes, 7.5, 163 )
