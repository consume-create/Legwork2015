# Import page / slide data

# Home
home = require './home/landing'
summary = require './home/summary'
services = require './home/services'
recognition = require './home/recognition'
contact = require './home/contact'
careers = require './home/careers'

# Animation
animation = require './work/animation/landing'
einstein_bros_twist_dip = require './work/animation/einstein-bros-twist-dip'
nike_us_open = require './work/animation/nike-us-open'
allstate_survival_guide = require './work/animation/allstate-survival-guide'
ello_control = require './work/animation/ello-control'
nissan_zero_gravity = require './work/animation/nissan-zero-gravity'
ny_times_debt_deal = require './work/animation/ny-times-debt-deal'
alameda_new_leaf = require './work/animation/alameda-new-leaf'


# Interactive
interactive = require './work/interactive/landing'
#the_dancelab = require './work/interactive/the-dancelab'
nike_snkrs_xpress = require './work/interactive/nike-snkrs-xpress'
#fotl_the_tuck_effect = require './work/interactive/fotl-the-tuck-effect'
laika_the_boxtrolls = require './work/interactive/laika-the-boxtrolls'
kentucky_fried_chicken = require './work/interactive/kentucky-fried-chicken'
coke_building_of_memories = require './work/interactive/coke-building-of-memories'
google_roll_it = require './work/interactive/google-roll-it'

# Error
error = require './error'

# Describe the structure of the site

# NOTE:
# Adding to the "pages" object adds a page to the site with a button in the main nav.
# Adding to the "slides" object within a page adds a slide to the page. A landing slide
# is required. The slide will URL will be "/[page object key]" for the landing slide and
# will be "/[page object key]/[slide object key]" for any subsequent slides.

data = {
  "pages": {
    "home": {
      "slides": {
        "landing": home
        "summary": summary,
        "services": services,
        "recognition": recognition,
        "contact": contact,
        "careers": careers
      },
      "color_index": 0
    },
    "animation": {
      "slides": {
        "landing": animation,
        "einstein-bros-twist-dip": einstein_bros_twist_dip,
        "nike-us-open": nike_us_open,
        "allstate-survival-guide": allstate_survival_guide,
        "ello-control": ello_control,
        "nissan-zero-gravity": nissan_zero_gravity,
        "ny-times-debt-deal": ny_times_debt_deal,
        "alameda-new-leaf": alameda_new_leaf
      },
      "color_index": 1
    },
    "interactive": {
      "slides": {
        "landing": interactive,
        # "the-dancelab": the_dancelab,
        "nike-snkrs-xpress": nike_snkrs_xpress,
        # "fotl-the-tuck-effect": fotl_the_tuck_effect,
        "laika-the-boxtrolls": laika_the_boxtrolls,
        "kentucky-fried-chicken": kentucky_fried_chicken,
        "coke-building-of-memories": coke_building_of_memories,
        "google-roll-it": google_roll_it
      },
      "color_index": 3
    }
  },
  "error": error
}

module.exports = data
