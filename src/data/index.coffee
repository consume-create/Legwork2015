# Home
test_home = require "./work/some-project"
home_slides = [test_home]

# About
test_about = require "./work/some-project"
about_slides = [test_about]

# Work
test_work = require "./work/some-project"
work_slides = [test_work]

data = {
	"pages": {
		"home": {
			"slides": home_slides
		},
		"about": {
			"slides": about_slides
		},
		"work": {
			"slides": work_slides
		}
	}
}

module.exports = data