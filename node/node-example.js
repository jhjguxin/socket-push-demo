// sudo apt-get install nodejs
// nodejs node-example.js # maby node node-example.js

var net = require('net');

var server = net.createServer(function (socket) {
  socket.write('Echo server\r\n');
  socket.pipe(socket);
});

server.listen(1337, '127.0.0.1');
console.log('Server running at http://127.0.0.1:1337/');
