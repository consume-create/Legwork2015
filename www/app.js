// APP
var express      = require('express'),
    path         = require('path'),
    logger       = require('morgan');

// ROUTES
var routes = require('./routes/index');

// CREATE EXPRESS APP
var app = express();

// SET VIEW ENGINE AND MAP HTML TO IT
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');

// SETUP STATIC DIRECTORIES AND APP VIEWS
if(process.env.NODE_ENV != "production"){
  app.use(express.static(path.join(__dirname, '../public')));
  app.set('views', path.join(__dirname, '../public'));
} else {
  app.use(express.static(path.join(__dirname, '../dist')));
  app.set('views', path.join(__dirname, '../dist'));
}

// SET APP ROUTES
app.use('/', routes);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// ERRORS

// production error handler
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.location('/404');  
});


module.exports = app;
