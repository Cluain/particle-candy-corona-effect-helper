-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local storyboard = require "storyboard"


-- event listeners for tab buttons:
local function onFirstView( event )
	storyboard.gotoScene( "view1" )
end

local function onSecondView( event )
	storyboard.gotoScene( "view2" )
end


Properties = {}
Properties[1] = {name = "lifeTime", min = 100, max = 10000, default = 5000, isInteger = true}
Properties[2] = {name = "weight", min = -2, max = 2, default = 0, isInteger = false}
Properties[3] = {name = "directionVariation", min = 0, max = 360, default = 0, isInteger = true}
Properties[4] = {name = "velocityStart", min = 0, max = 500, default = 200, isInteger = true}
Properties[5] = {name = "velocityVariation", min = 0, max = 300, default = 0, isInteger = true}
Properties[6] = {name = "velocityChange", min = -10, max = 10, default = 0, isInteger = true}
Properties[7] = {name = "rotationStart", min = 0, max = 360, default = 0, isInteger = true}
Properties[8] = {name = "rotationVariation", min = 0, max = 360, default = 0, isInteger = true}
Properties[9] = {name = "rotationChange", min = -10, max = 10, default = 0, isInteger = true}
Properties[10] = { name = "autoOrientation", min = 0, max = 1, default = 1, isInteger = true, isBoolean = true}
Properties[11] = { name = "useEmitterRotation", min = 0, max = 1, default = 1, isInteger = true, isBoolean = true}
Properties[12] = { name = "alphaStart", min = 0, max = 1, default = 1, isInteger = false}
Properties[13] = { name = "alphaVariation", min = 0, max = 1, default = 0, isInteger = false}
Properties[14] = { name = "fadeInSpeed", min = 0, max = 1, default = 0, isInteger = false}
Properties[15] = { name = "fadeOutSpeed", min = -1, max = 0, default = -0.100, isInteger = false}
Properties[16] = { name = "fadeOutDelay", min = 0, max = 10000, default = 3000, isInteger = true}
Properties[17] = { name = "scaleStart", min = 0, max = 10, default = 1, isInteger = false}
Properties[18] = { name = "scaleVariation", min = -2, max = 2, default = 0, isInteger = false}
Properties[19] = { name = "scaleInSpeed", min = 0, max = 2, default = 0, isInteger = false}
Properties[20] = { name = "scaleMax", min = 0, max = 10, default = 1, isInteger = false}
Properties[21] = { name = "scaleOutDelay", min = 0, max = 5000, default = 0, isInteger = true}
Properties[22] = { name = "scaleOutSpeed", min = -1, max = 0, default = 0, isInteger = false}
Properties[23] = { name = "colorStartR", min = 0, max = 255, default = 0, isInteger = true}
Properties[24] = { name = "colorStartG", min = 0, max = 255, default = 0, isInteger = true}
Properties[25] = { name = "colorStartB", min = 0, max = 255, default = 0, isInteger = true}
Properties[26] = { name = "colorChangeR", min = -255, max = 255, default = 0, isInteger = true}
Properties[27] = { name = "colorChangeG", min = -255, max = 255, default = 0, isInteger = true}
Properties[28] = { name = "colorChangeB", min = -255, max = 255, default = 0, isInteger = true }
Properties[29] = { name = "emissionRate", min = 1, max = 30, default = 5, isInteger = true }
Properties[30] = { name = "emissionAngle", min = 0, max = 359, default = 90, isInteger = true }

Sliders = {}

-- table to setup buttons
local tabButtons = {
	{ label="Settings", up="icon1.png", down="icon1-down.png", width = 32, height = 32, onPress=onFirstView, selected=true },
	{ label="Test", up="icon2.png", down="icon2-down.png", width = 32, height = 32, onPress=onSecondView },
}

-- create the actual tabBar widget
local tabBar = widget.newTabBar{
	top = display.contentHeight - 50,	-- 50 is default height for tabBar widget
	buttons = tabButtons
}

onFirstView()	-- invoke first tab button's onPress event manually