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
	storyboard.gotoScene( "settingsTab" )
end

local function onSecondView( event )
	storyboard.gotoScene( "testTab" )
end

local function onThirdView (event)
    storyboard.gotoScene("settingsTwoTab")
end

DefaultProperties = {}
BackgroundSliders = {}
BackgroundProperties = {}
ParticleImage = {}

require("configuration")

BackgroundProperties[1] = { name = "backgroundR", min = 0, max = 255, default = BackgroundColor[1], isInteger = true}
BackgroundProperties[2] = { name = "backgroundG", min = 0, max = 255, default = BackgroundColor[2], isInteger = true}
BackgroundProperties[3] = { name = "backgroundB", min = 0, max = 255, default = BackgroundColor[3], isInteger = true }
BackgroundProperties[4] = { name = "useBackgroundImg", min = 0, max = 1, default = BackgroundImageEnabled, isBoolean = true }

Properties = {}
Properties[1] = {name = "lifeTime", min = 100, max = 10000, default = DefaultProperties.lifeTime, isInteger = true}
Properties[2] = {name = "weight", min = -2, max = 2,  default = DefaultProperties.weight, isInteger = false}
Properties[3] = {name = "directionVariation", min = 0, max = 360,  default = DefaultProperties.directionVariation, isInteger = true}
Properties[4] = {name = "velocityStart", min = 0, max = 500,  default = DefaultProperties.velocityStart, isInteger = true}
Properties[5] = {name = "velocityVariation", min = 0, max = 300,  default = DefaultProperties.velocityVariation, isInteger = true}
Properties[6] = {name = "velocityChange", min = -10, max = 10,  default = DefaultProperties.velocityChange, isInteger = true}
Properties[7] = {name = "rotationStart", min = 0, max = 360,  default = DefaultProperties.rotationStart, isInteger = true}
Properties[8] = {name = "rotationVariation", min = 0, max = 360,  default = DefaultProperties.rotationVariation, isInteger = true}
Properties[9] = {name = "rotationChange", min = -10, max = 10,  default = DefaultProperties.rotationChange, isInteger = true}
Properties[10] = { name = "autoOrientation", min = 0, max = 1,  default = DefaultProperties.autoOrientation, isBoolean = true}
Properties[11] = { name = "useEmitterRotation", min = 0, max = 1,  default = DefaultProperties.useEmitterRotation, isBoolean = true}
Properties[12] = { name = "alphaStart", min = 0, max = 1,  default = DefaultProperties.alphaStart, isInteger = false}
Properties[13] = { name = "alphaVariation", min = 0, max = 1,  default = DefaultProperties.alphaVariation, isInteger = false}
Properties[14] = { name = "fadeInSpeed", min = 0, max = 1,  default = DefaultProperties.fadeInSpeed, isInteger = false}
Properties[15] = { name = "fadeOutSpeed", min = -1, max = 0,  default = DefaultProperties.fadeOutSpeed, isInteger = false}
Properties[16] = { name = "fadeOutDelay", min = 0, max = 10000,  default = DefaultProperties.fadeOutDelay, isInteger = true}
Properties[17] = { name = "scaleStart", min = 0, max = 10,  default = DefaultProperties.scaleStart, isInteger = false}
Properties[18] = { name = "scaleVariation", min = -2, max = 2,  default = DefaultProperties.scaleVariation, isInteger = false}
Properties[19] = { name = "scaleInSpeed", min = 0, max = 2,  default = DefaultProperties.scaleInSpeed, isInteger = false}
Properties[20] = { name = "scaleMax", min = 0, max = 10,  default = DefaultProperties.scaleMax, isInteger = false}
Properties[21] = { name = "scaleOutDelay", min = 0, max = 5000,  default = DefaultProperties.scaleOutDelay, isInteger = true}
Properties[22] = { name = "scaleOutSpeed", min = -1, max = 0,  default = DefaultProperties.scaleOutSpeed, isInteger = false}
Properties[23] = { name = "colorModification", min = 0, max = 1,  default = DefaultProperties.colorModification, isBoolean = true}
Properties[24] = { name = "colorStartR", min = 0, max = 255,  default = DefaultProperties.colorStartR, isInteger = true}
Properties[25] = { name = "colorStartG", min = 0, max = 255,  default = DefaultProperties.colorStartG, isInteger = true}
Properties[26] = { name = "colorStartB", min = 0, max = 255,  default = DefaultProperties.colorStartB, isInteger = true}
Properties[27] = { name = "colorChangeR", min = -255, max = 255,  default = DefaultProperties.colorChangeR, isInteger = true}
Properties[28] = { name = "colorChangeG", min = -255, max = 255,  default = DefaultProperties.colorChangeG, isInteger = true}
Properties[29] = { name = "colorChangeB", min = -255, max = 255,  default = DefaultProperties.colorChangeB, isInteger = true }
Properties[30] = { name = "emissionRate", min = 1, max = 30,  default = DefaultProperties.emissionRate, isInteger = true }
Properties[31] = { name = "emissionAngle", min = 0, max = 359,  default = DefaultProperties.emissionAngle, isInteger = true }

Sliders = {}

-- table to setup buttons
local tabButtons = {
	{ label="Settings", up="icon1.png", down="icon1-down.png", width = 32, height = 32, onPress=onFirstView, selected=true },
    { label="Settings 2", up="icon1.png", down="icon1-down.png", width=32, height = 32, onPress=onThirdView },
	{ label="Test", up="icon2.png", down="icon2-down.png", width = 32, height = 32, onPress=onSecondView },
}

-- create the actual tabBar widget
local tabBar = widget.newTabBar{
	top = display.contentHeight - 50,	-- 50 is default height for tabBar widget
	buttons = tabButtons
}

onFirstView()	-- invoke first tab button's onPress event manually
