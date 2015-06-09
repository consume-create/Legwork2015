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
LW.slide_types.HOME_COVER = 'home-cover'
LW.slide_types.HOME_FEATURE = 'home-feature'

# Work Slides
LW.slide_types.ANIMATION_COVER = 'animation-cover'
LW.slide_types.INTERACTIVE_COVER = 'interactive-cover'
LW.slide_types.WORK_FEATURE = 'work-feature'

# Medium constants

# NOTE:
# To add a new medium, add it to ./styles/_featured-work.sass and ./public/images/mediums@2x.png

LW.mediums = []
LW.mediums.WEB = "web"
LW.mediums.ANIMATION = "animation"
LW.mediums.THREE_DIMENSIONAL = "three-dimensional"
LW.mediums.EXPERIENTIAL = "experiential"
LW.mediums.ILLUSTRATION = "illustration"
LW.mediums.GAME = "game"
LW.mediums.LIVE_ACTION = "live-action"
LW.mediums.SOUND = "sound"

LW.callouts = []
LW.callouts.ABOUT = "about"
LW.callouts.LAUNCH = "launch"
LW.callouts.WATCH = "watch"

# RGB constants

# NOTE:
# These are the 9 colors from the color palette
# They loop in order by every other one and repeat
# Make sense? Of course not. Just trust this. It works.

LW.colors = [
	[238,202,70],
	[75,181,234],
	[250,113,94],
	[76,214,188],
	[168,86,239],
	[253,95,101]
]

# Slide detail media constants

LW.media = []
LW.media.IMAGE = "media-image"
LW.media.VIDEO = "media-video"
LW.media.SLIDESHOW = "media-slideshow"