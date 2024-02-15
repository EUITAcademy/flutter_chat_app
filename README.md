# Welcome to Shop App!

This is a walkthrough how to set up the backend server. And REST api documentation for test server.
# Set up Backend
### How to Run server.
1. Backend is located at in **backend** folder of the project.
2. To run backend you need to have Node.js installed on the computer. In order to run npm commands. Install node: https://nodejs.org/en
3. After that open terminal and go to **backend** folder. In terminal:
 `cd /Users/jack/Projects/flutter_chat_app/backend`
 next run server with `node app.js`.
 4. Now server is running, to quit server use ***control + C***. To run again use `node app.js`.



## Backend api

### Change localhost to local ip address
You can test local server **only** with local emulator installed on your computer. Test Server runs on *http://localhost:8080*. Unfortunately emulator doesn't understand localhost, so you need to change localhost to your local ip address. To change it you need to go to *Wifi-Settings/your connected network / tap details(three dots)/ network settings*, then you will see your local ip address. It should be similar to `193.172.21.17`

Now in starter project you need to change `localhost:8080` with `*your_ip*:8080`.
1. Go to *lib/screens/chat_screen.dart*. There change wsUrl to this format:

     final wsUrl = Uri.parse('**ws://191.153.11.10:8080**');

## WEBSOCKET API

Base url of server is `http://localhost:8080`

#### SEND MESSAGE

**Data Format**: `{
  'userName': 'Jack Panda',
  'message': 'Test message',  }`



