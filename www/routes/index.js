var express = require('express');
var router = express.Router();

router.get('/*', function(req, res, next) {
	res.render('index.html');
	// res.json({hello:"world"})
});

module.exports = router;
