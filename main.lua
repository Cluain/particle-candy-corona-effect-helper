-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.HiddenStatusBar )

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
Properties[1] = {name = "lifeTime", min = 100, max = 10000, default = DefaultProperties.lifeTime, isInteger = true, desc = "Lifetime (in milliseconds). Particle will be deleted if lifetime expired or alpha/scale reached a value below 0.001"}
Properties[2] = {name = "weight", min = -2, max = 2,  default = DefaultProperties.weight, isInteger = false, desc = "Weight of the particle. If positive, the particle will tend to fall downwards, if negative, the particle will rise"}
Properties[3] = {name = "directionVariation", min = 0, max = 360,  default = DefaultProperties.directionVariation, isInteger = true, desc = "Emission direction variation (in degrees). A particle will be emitted into the direction where the emitter points. Use this value to randomly alter the emission angle at a certain amount." }
Properties[4] = {name = "velocityStart", min = 0, max = 500,  default = DefaultProperties.velocityStart, isInteger = true, desc = "The initial velocity of the particle (in pixels per second)." }
Properties[5] = {name = "velocityVariation", min = 0, max = 300,  default = DefaultProperties.velocityVariation, isInteger = true, desc = "Range of randomly added speed variation per particle." }
Properties[6] = {name = "velocityChange", min = -10, max = 10,  default = DefaultProperties.velocityChange, isInteger = false, desc = "Velocity change over time. Use positive numbers to speed-up the particle, negative to dampen the particle. A value of 0 will keep the initial speed." }
Properties[7] = {name = "rotationStart", min = 0, max = 360,  default = DefaultProperties.rotationStart, isInteger = true, desc = "The initial rotation of the particle (in degrees)." }
Properties[8] = {name = "rotationVariation", min = 0, max = 360,  default = DefaultProperties.rotationVariation, isInteger = true, desc = "Range of randomly added rotation variation per particle (in degrees)." }
Properties[9] = {name = "rotationChange", min = -360, max = 360,  default = DefaultProperties.rotationChange, isInteger = true, desc = "Rotation change over time. Use positive numbers to rotate clockwise, negative to rotate counter-clockwise. A value of 0 will disable automatic rotation." }
Properties[10] = { name = "autoOrientation", min = 0, max = 1,  default = DefaultProperties.autoOrientation, isBoolean = true, desc = "If true, the particle will be automatically aligned to its travel direction. Useful for sparks or water fountains." }
Properties[11] = { name = "useEmitterRotation", min = 0, max = 1,  default = DefaultProperties.useEmitterRotation, isBoolean = true, desc = "If true, the particle will inherit the emitter's rotation (emitter's rotation will be added then)." }
Properties[12] = { name = "alphaStart", min = 0, max = 1,  default = DefaultProperties.alphaStart, isInteger = false, desc = "The initial alpha value of the particle (particles do also inherit the current emitter's alpha)." }
Properties[13] = { name = "alphaVariation", min = 0, max = 1,  default = DefaultProperties.alphaVariation, isInteger = false, desc = "Randomly added variation to the initial alpha value." }
Properties[14] = { name = "fadeInSpeed", min = 0, max = 1,  default = DefaultProperties.fadeInSpeed, isInteger = false, desc = "The fade-in speed (within one second)." }
Properties[15] = { name = "fadeOutSpeed", min = -1, max = 0,  default = DefaultProperties.fadeOutSpeed, isInteger = false, desc = "The fade-out speed (within one second). Must be negative." }
Properties[16] = { name = "fadeOutDelay", min = 0, max = 10000,  default = DefaultProperties.fadeOutDelay, isInteger = true, desc = "Delay (in milliseconds) when fade-out starts. Leave to 0 to disable fade-out." }
Properties[17] = { name = "scaleStart", min = 0, max = 10,  default = DefaultProperties.scaleStart, isInteger = false, desc = "The initial scale of the particle." }
Properties[18] = { name = "scaleVariation", min = -2, max = 2,  default = DefaultProperties.scaleVariation, isInteger = false, desc = "Randomly added variation to the initial scale value." }
Properties[19] = { name = "scaleInSpeed", min = 0, max = 2,  default = DefaultProperties.scaleInSpeed, isInteger = false, desc = "The scale-in speed (within one second)." }
Properties[20] = { name = "scaleMax", min = 0, max = 10,  default = DefaultProperties.scaleMax, isInteger = false, desc = "Sets a maximum scale for the particle. If set to 2.0, for example, the particle stops growing once it reached a scale of 2.0 (the double of its normal size)." }
Properties[21] = { name = "scaleOutDelay", min = 0, max = 5000,  default = DefaultProperties.scaleOutDelay, isInteger = true, desc = "Delay (in milliseconds) when scale-out starts. Leave to 0 to disable scale-out." }
Properties[22] = { name = "scaleOutSpeed", min = -1, max = 0,  default = DefaultProperties.scaleOutSpeed, isInteger = false, desc = "The scale-out speed (within one second). Must be negative." }
Properties[23] = { name = "colorModification", min = 0, max = 1,  default = DefaultProperties.colorModification, isBoolean = true, desc = "Indicates whether following color settings take effect or not" }
Properties[24] = { name = "colorStartR", min = 0, max = 255,  default = DefaultProperties.colorStartR, isInteger = true, desc = "Define the red to tint the particle image with." }
Properties[25] = { name = "colorStartG", min = 0, max = 255,  default = DefaultProperties.colorStartG, isInteger = true, desc = "Define the green color to tint the particle image with." }
Properties[26] = { name = "colorStartB", min = 0, max = 255,  default = DefaultProperties.colorStartB, isInteger = true, desc = "Define the blue color to tint the particle image with." }
Properties[27] = { name = "colorChangeR", min = -255, max = 255,  default = DefaultProperties.colorChangeR, isInteger = true, desc = "Specify the color change of a particle per second." }
Properties[28] = { name = "colorChangeG", min = -255, max = 255,  default = DefaultProperties.colorChangeG, isInteger = true, desc = "Specify the color change of a particle per second." }
Properties[29] = { name = "colorChangeB", min = -255, max = 255,  default = DefaultProperties.colorChangeB, isInteger = true , desc = "Specify the color change of a particle per second." }
Properties[30] = { name = "emissionShape", min = 0, max = 3,  default = DefaultProperties.emissionShape, isInteger = true , desc = "0 = Point, 1 = Line, 2 = Ring, 3 = Disc" }
Properties[31] = { name = "emissionRadius", min = 0, max = 1000,  default = DefaultProperties.emissionRadius, isInteger = true , desc = "See emissionShape. Defines the size of the emission shape." }
Properties[32] = { name = "randomMotionMode", min = 0, max = 2,  default = DefaultProperties.randomMotionMode, isInteger = true , desc = "0 = Random motion disabled (default). 1 = Linear random direction change. 2 = Smooth random direction change." }
Properties[33] = { name = "randomMotionInterval", min = 1, max = 10000,  default = DefaultProperties.randomMotionInterval, isInteger = true , desc = " If randomMotionMode is enabled, particle will change it's direction randomly in frequent intervals. This parameter specifies the delay between direction changes in MilliSecs." }
Properties[34] = { name = "randomMotionAmount", min = 1, max = 360,  default = DefaultProperties.randomMotionAmount, isInteger = true , desc = "Maximum number of degrees to randomly vary by at each direction change interval." }
Properties[35] = { name = "emissionRate", min = 1, max = 30,  default = DefaultProperties.emissionRate, isInteger = true , desc = "The amount of particles to emit per second." }
Properties[36] = { name = "emissionAngle", min = 0, max = 359,  default = DefaultProperties.emissionAngle, isInteger = true , desc = "Emitter's initial rotation angle" }

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
