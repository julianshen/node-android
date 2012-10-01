var android;
try {
    android = require('android');
} catch(e) {
}

/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , http = require('http')
  , path = require('path');

var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

app.get('/', routes.index);
app.get('/users', user.list);

var server = http.createServer(app);

var io = require('socket.io').listen(server);

server.listen(app.get('port'), function(){
    console.log("Express server listening on port " + app.get('port'));
    if(typeof(alog) !== 'undefined') {
        alog.d("nodejs-demo", "Express server listening on port " + app.get('port'));
    }
});

io.sockets.on('connection', function (socket) {
  socket.emit('news', { hello: 'Android' });
  socket.on('my other event', function (data) {
      console.log(data);
      if(typeof(alog) !== 'undefined') {
          alog.d("nodejs-demo", data);
      }
    });
});


