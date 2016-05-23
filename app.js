var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var routes = require('./routes/index');

// Database URI
global.databaseURI =  "postgres://vanhunick:dolphins@depot:5432/SWEN303vanhunick";
global.databaseURI = "postgres://swen303:SWEN303@localhost:5432/SWEN303";




// Regular routes
var users = require('./routes/users');
var register = require('./routes/register');
var sell = require('./routes/sell');
var cart = require('./routes/cart');
var searching = require('./routes/searching');
var product = require('./routes/product');
var account = require('./routes/account');
var payment = require('./routes/payment');
var admin = require('./routes/admin');
var newQueue = require('./routes/new');

// Endpoints
var login = require('./routes/login-post');
var usersEndpoint = require("./routes/users-endpoint");
var categoriesEndpoint = require("./routes/categories-endpoint");
var inviteCodesEndpoint = require("./routes/invite-code-endpoint");
var valuationEndpoint = require("./routes/valuation-endpoint");
var transactionsEndpoint = require("./routes/transactions-endpoint");

//Just for testing
var product = require('./routes/product');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

    

app.use('/', routes);
app.use('/', searching);
app.use('/users', users);
app.use('/register', register);
app.use('/product', product);
app.use('/sell', sell);
app.use('/login', login);
app.use('/cart', cart);
app.use('/product', product);
app.use('/users-endpoint', usersEndpoint);
app.use('/account', account);
app.use('/categories', categoriesEndpoint);
app.use('/invite-code-endpoint', inviteCodesEndpoint);
app.use('/payment', payment);
app.use('/admin', admin);
app.use('/new', newQueue);
app.use('/valuation', valuationEndpoint);
app.use('/transactions', transactionsEndpoint);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});



// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    console.log(err.status);



    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
 
    if(err.status === 404){
      res.render('404');    
    }
    else {
      res.render('500');    
    }

  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
