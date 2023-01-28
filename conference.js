const app = require('express')();
const server = require('http').createServer(app);
const io = require('socket.io')(server,{
    cors: {
        origin: "*"
      }
});
const port = process.env.PORT || 3001;

server.listen(port, function() {
  console.log(`Listening on port ${port}`);
});

io.on('connection', socket => {

  socket.on('join-room', (roomId, userId) => {
    socket.join(roomId)
    socket.to(roomId).emit('user-connected', userId)
      io.to(socket.id,"self-connected",socket.id)
    console.log("user connected:"+socket.id)

    socket.on('disconnect', () => {
      socket.to(roomId).emit('user-disconnected', userId)
    })
  })
})

module.exports = app