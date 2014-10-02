
/**
 * Module dependencies.
 */

var express = require('express');
//var routes = require('./routes');
//var user = require('./routes/user');
var http = require('http');
var path = require('path');
var _ = require('underscore');
var fs = require('fs');
Q = require('q');

var RedisStore = require('connect-redis')(express);

// Configuracion BBDD
var confDB = require('./config/db');
var mongoose = require('mongoose');

mongoose.connect(confDB.db.uri, confDB.db.options); //Conexion con mongo

mongoose.connection.on('open', function() {         //Evento de control a conectar.
    console.log(confDB.db.messageOpen);
});

mongoose.connection.on('error', function(err){      //Evvento de control al fallar la conexion
    console.log(err);
});

var app = express();

var access_logfile = fs.createWriteStream('./logs/access.log', {flags: 'a'});
var oneWeek = 86400000 * 7;

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(express.cookieParser("DYhG93b0qyJfsadf23sdfsFSsfIxfs2guVoUubWwvniR2G0FgaC9mi"));
app.use(express.session({store: new RedisStore(), secret: 'DYhG9320qyJfsadf233534534542FSsfIxfs2guVoUubWwvniR2G0FgaC9mi'} ));
app.use(app.router);
// LOG accesos
app.use(express.logger({stream: access_logfile}));
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

//app.get('/', routes.index);
//app.get('/users', user.list);



// Probando Q.js Deferred y promises

function fs_readFile(file, encoding) {
  // creamos el deferred
  var deferred = Q.defer();

  fs.readFile(file, encoding, function (err, data) {
    if (err) deferred.reject(err); // rechazar el deferred
    else
      setTimeout(function(){
        deferred.resolve(data);
      }, 5000);

    //else deferred.resolve(data); // resolver el deferred con los datos leidos
  });

  return deferred.promise; // Al final de la funcion siempre retornar un objeto promise
}

/*
function fs_writeFile(aescribir) {
  // creamos el deferred
  var deferred = Q.defer();

  fs.writeFile('./probando.txt', function (err) {
    if (err) deferred.reject(err); // rechazar el deferred
    else
      setTimeout(function(){
        deferred.resolve(data);
      }, 5000);

    //else deferred.resolve(true); // resolver el deferred con los datos leidos
  });

  return deferred.promise; // Al final de la funcion siempre retornar un objeto promise
}
*/


// Lee package.json, done (luego) ejecuta los console log
/*fs_readFile('./package.json', 'utf8').done(function(data){
  console.log(data);
});*/

// Este promise es un espia

promise = fs_readFile('./package.json','utf8');

promise.done(function(data){
  console.log(data);
});

promise.fail(function(){
  console.log("ERRORRRRRRR");
});




http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
require('./router')(app);