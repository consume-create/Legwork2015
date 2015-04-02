# Namespace
window.LW = window.LW || {}

# Slide title max
LW.TITLE_MAX = 16

# Landing slide constant
LW.LANDING_SLIDE = 'landing'

# Slide type constants

# NOTE:
# To add a new slide type, you must:
# 1. Define a const slide type in ./env
# 2. Add a data file to ./data/* where you would like to use the slide
# 3. Add the slide model, view and controller (extend the base model and controller classes)
# 4. Require the model and controller in the page controller and add a condition to the build method

LW.slide_types = {}
# Home Slides
LW.slide_types.HOME = 'home'
# About Slides
LW.slide_types.ABOUT = 'about'
LW.slide_types.ABOUT_PROCESS = 'about-process'
LW.slide_types.ABOUT_VIDEO = 'about-video'
# Work Slides
LW.slide_types.WORK = 'work'
LW.slide_types.FEATURED_WORK = 'featured-work'

# Medium constants

# NOTE:
# To add a new medium, add it to ./styles/_featured-work.sass and ./public/images/mediums@2x.png

LW.mediums = []
LW.mediums.DESKTOP = "desktop"
LW.mediums.MOBILE = "mobile"
LW.mediums.ANIMATION = "animation"
LW.mediums.THREE_DIMENSIONAL = "three-dimensional"
LW.mediums.EXPERIMENTAL = "experimental"

LW.callouts = []
LW.callouts.ABOUT = "about"
LW.callouts.LAUNCH = "launch"
LW.callouts.WATCH = "watch"

# RGB constants

# NOTE:
# These are the 9 colors from the color palette
# The loop in order by every other one and repeat
# Make sense? Of course not. Just trust this. It works.

LW.colors = [
	[195,85,71],
	[218,153,81],
	[148,189,151],
	[116,136,165],
	[162,116,165],
	[195,105,71],
	[218,176,81],
	[104,167,184],
	[129,116,165]
]

# Slide detail media constants

LW.media = []
LW.media.IMAGE = "media-image"
LW.media.VIDEO = "media-video"
LW.media.SLIDESHOW = "media-slideshow"