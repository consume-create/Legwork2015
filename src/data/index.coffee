# Import page / slide data

# Home
home = require "./home/landing"

# About
about = require "./about/landing"

# Work
work = require "./work/landing"
the_boxtrolls = require "./work/featured/the-boxtrolls"
appendix_01 = require "./work/appendix-01/appendix-01"

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
				"landing": about
			}
		},
		"work": {
			"slides": {
				"landing": work,
				"the-boxtrolls": the_boxtrolls,
				"appendix-01": appendix_01
			}
		}
	}
}

module.exports = data