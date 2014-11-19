# Import page / slide data

# Home
home = require "./home/landing"

# About
about = require "./about/landing"

# Work
work = require "./work/landing"
some_project = require "./work/some-project"
some_other_project = require "./work/some-project"


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
				"landing": home,
				"some-project": some_project,
				"some-other-project": some_other_project
			}
		}
	}
}

module.exports = data