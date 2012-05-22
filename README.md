ver 0.5b

# Changelog

## ver 0.5b
- Fixed issue with boolean values - 0 would display as true in settings tab

## ver 0.5a
- Fixed issue with stable build incompatibility. Now works fine on both daily and stable builds.

## ver 0.5
- Added sliders descriptions (copy from Particle Candy website - hope they don't mind) - toggle it on/off using button at the top
- Added new sliders for emission shape and random motion mode (more coming)
- Added scrollable view to facilitate more sliders and descriptions
- Corrected few slider ranges

## ver 0.4
- Added Particle counter
- Added ability to set background image [edit configuration.lua]

## ver 0.3
- Fixed issue with Boolean fields
- Added a slider for enabling/disabling color modifications of the used sprite

## ver 0.2
- Added configuration.lua file to store default settings
- Added new tab to allow background color changes
- Improved logging to allow easy copy & paste of default values
- Exposed particle image configuration in configuration.lua file

# Installation

1.  Copy lib_particle_candy.lua file to this project
2.  Run project in simulator

# Usage

Use sliders in Settings tab to adjust Particle Type Properties and Emitter settings.
You can adjust the background color of Test tab using sliders in Settings Two tab.
Switch to tab Test to view your settings in action.
You can adjust default settings, background settings and particle image in `configuration.lua` file.
Every time you switch to tab Test your settings will be printed to console, in a format allowing easy copy & paste to `configuration.lua` file.

# Limitations

For now only simple Particle Type properties are adjustable. If you want something more you can raise a feature request [or pull request :) ].

# More info and discussion about this code...

can be found here:
https://developer.anscamobile.com/code/particle-candy-effects-creator

