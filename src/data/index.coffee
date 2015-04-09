# Import page / slide data

# Home
home = require './home/landing'
summary = require './about/summary'
services = require './about/services'
recognition = require './about/recognition'
contact = require './about/contact'
careers = require './about/careers'

# Animation
animation = require './work/animation/landing'
nissan_zero_gravity = require './work/animation/nissan-zero-gravity'
bc4u_what_if = require './work/animation/bc4u-what-if'
leinenkugel_social_shandy = require './work/animation/leinenkugel-social-shandy'
clifford_still_museum = require './work/animation/clifford-still-museum'
ny_times_debt_deal = require './work/animation/ny-times-debt-deal'
climate_reality_pledge = require './work/animation/climate-reality-pledge'
alameda_new_leaf = require './work/animation/alameda-new-leaf'

# Interactive
interactive = require './work/interactive/landing'
the_boxtrolls = require './work/interactive/the-boxtrolls'
newton = require './work/interactive/newton'
cokes_building_of_memories = require './work/interactive/cokes-building-of-memories'
hands_on_ron_burgundy = require './work/interactive/hands-on-ron-burgundy'

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
      }
    },
    "animation": {
      "slides": {
        "landing": animation,
        "nissan-zero-gravity": nissan_zero_gravity,
        "bc4u-what-if": bc4u_what_if,
        "leinenkugel-social-shandy": leinenkugel_social_shandy,
        "clifford-still-museum": clifford_still_museum,
        "ny-times-debt-deal": ny_times_debt_deal,
        "climate-reality-pledge": climate_reality_pledge,
        "alameda-new-leaf": alameda_new_leaf
      }
    },
    "interactive": {
      "slides": {
        "landing": interactive,
        "the-boxtrolls": the_boxtrolls,
        "newton": newton,
        "cokes-building-of-memories": cokes_building_of_memories,
        "hands-on-ron-burgundy": hands_on_ron_burgundy
      }
    }
  }
}

module.exports = data