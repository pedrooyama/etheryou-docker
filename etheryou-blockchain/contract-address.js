var http = require('http');

var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("__CONTRACT_ADDRESS__\n");
});

server.listen(__CONTRACT_ADDRESS_SERVER_PORT__);

