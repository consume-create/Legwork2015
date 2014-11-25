# Import page / slide data
birth_control_myths = require "./birth-control-myths"
hands_on_ron_burgundy = require "./hands-on-ron-burgundy"
cokes_building_of_memories = require "./cokes-building-of-memories"
ello = require "./ello"
climate_reality = require "./climate-reality"
nissan_leaf = require "./nissan-leaf"

# Describe the structure of this appendix

# NOTE: Each appendix can contain no more than SIX projects

data = {
  "browser_title": "Legwork Studio / Appendix 01",
  "slide_type": LW.slide_types.APPENDIXED_WORK,
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