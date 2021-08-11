const webSocketsServerPort = 8000;
const webSocketServer = require("websocket").server;
const http = require("http");
const { v4: uuidv4 } = require("uuid");

const server = http.createServer();
server.listen(webSocketsServerPort);
console.log("listening on port 8000");

const wsServer = new webSocketServer({
  httpServer: server,
});

connections = {};

wsServer.on("request", function (request) {
  const connection = request.accept(null, request.origin);

  connection.on("message", function (message) {
    if (message.type == "utf8") {
      try {
        data = JSON.parse(message.utf8Data);
        if (data.type == "message") {
          id = uuidv4();
          content = data.content;
          sender = data.sender;
          reciever = data.reciever;
          timestamp = new Date().getTime();

          if (connections[data.reciever] != undefined) {
            connections[data.reciever].sendUTF(
              JSON.stringify({
                content: content,
                sender: sender,
                timestamp: timestamp,
              })
            );
          }
        }

        if (data.type == "login") {
          connection.userID = data.id;
          connections[data.id] = connection;
        }
      } catch {}
    }
  });

  connection.on("close", function () {
    if (connection.userID != undefined) {
      delete connections[connection.userID];
    }
  });
});
