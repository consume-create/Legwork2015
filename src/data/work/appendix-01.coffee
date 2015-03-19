# Import page / slide data
birth_control_myths = require './motion/birth-control-myths'
hands_on_ron_burgundy = require './interactive/hands-on-ron-burgundy'
cokes_building_of_memories = require './interactive/cokes-building-of-memories'
ello = require './motion/ello'
climate_reality = require './motion/climate-reality'
nissan_leaf = require './motion/nissan-leaf'

# Describe the structure of this appendix
# NOTE: Each appendix can contain no more than SIX projects
data = {
  "browser_title": "Legwork Studio / Appendix 01",
  "slide_type": LW.slide_types.APPENDIXED_WORK,
  "rgb": [218,153,81],
  "projects": [
    birth_control_myths,
    hands_on_ron_burgundy,
    cokes_building_of_memories,
    ello,
    climate_reality,
    nissan_leaf
  ]
}

module.exports = data