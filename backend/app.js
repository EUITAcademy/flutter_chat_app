import { WebSocketServer } from 'ws';

const wss = new WebSocketServer({ port: 8080 });

const messages = [];

wss.on('connection', function connection(ws) {

  ws.on('message', function message(data) {

    const parsedData = JSON.parse(data);
    const userName = parsedData.userName;
    const message = parsedData.message;

    if (userName && message) {
      messages.push({
        userName: userName,
        message: message,
      });
      ws.send(JSON.stringify(messages));
      console.log('received: %s', data);
    } else {
      console.log('invalid data received!');
    }

  });

  ws.send(JSON.stringify(messages));
});


