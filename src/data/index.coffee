# Import page / slide data

# Home
home = require './home/landing'

# About
about = require './about/landing'
summary = require './about/summary'
services = require './about/services'
accolades = require './about/accolades'
contact = require './about/contact'
careers = require './about/careers'

# Work
work = require './work/landing'
the_boxtrolls = require './work/interactive/the-boxtrolls'
newton = require './work/interactive/newton'
cokes_building_of_memories = require './work/interactive/cokes-building-of-memories'
hands_on_ron_burgundy = require './work/interactive/hands-on-ron-burgundy'
birth_control_myths = require './work/motion/birth-control-myths'
nissan_leaf = require './work/motion/nissan-leaf'
appendix_01 = require './work/appendix-01'

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
			}
		},
		"about": {
			"slides": {
				"landing": about,
				"summary": summary,
				"services": services,
				"accolades": accolades,
				"contact": contact,
				"careers": careers
			}
		},
		"work": {
			"slides": {
				"landing": work,
				"the-boxtrolls": the_boxtrolls,
				"newton": newton,
				"cokes-building-of-memories": cokes_building_of_memories,
				"hands-on-ron-burgundy": hands_on_ron_burgundy,
				"birth-control-myths": birth_control_myths,
				"nissan-leaf": nissan_leaf,
				"appendix-01": appendix_01
			}
		}
	}
}

module.exports = data