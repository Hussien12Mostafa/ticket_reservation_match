const mongoose = require('mongoose');
const dotenv = require('dotenv');
const WebSocket=require('ws');
const bookingController = require('./controllers/bookingController');


process.on('uncaughtException', err => {
  console.log('UNCAUGHT EXCEPTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  process.exit(1);
});

dotenv.config({ path: './config.env' });
const app = require('./app');
const { response } = require('./app');

const DB = process.env.DATABASE.replace(
  '<PASSWORD>',
  process.env.DATABASE_PASSWORD
);

mongoose.set("strictQuery", false);
mongoose
  .connect(DB, {
    useNewUrlParser: true,
  })
  .then(() => console.log('DB connection successful!'));

const port = process.env.PORT || 3000;
const server = app.listen(port, () => {
  console.log(`App running on port ${port}...`);
});

const wss = new WebSocket.WebSocketServer({ server: server });

wss.on('connection', function connection(ws) {
  ws.on('message', async function message(data) {
    let socketData=JSON.parse(data.toString('utf8'))
    if(socketData.action!="disconnect")
    {
      socketResponse = await bookingController.getMatchReservedSeats(socketData)
      ws.send(JSON.stringify(socketResponse));
    }
  });

});

process.on('unhandledRejection', err => {
  console.log('UNHANDLED REJECTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  server.close(() => {
    process.exit(1);
  });
});

process.on('SIGTERM', () => {
  console.log('👋 SIGTERM RECEIVED. Shutting down gracefully');
  server.close(() => {
    console.log('💥 Process terminated!');
  });
});
