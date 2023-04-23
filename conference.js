const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();

// Create a proxy middleware function
const proxy = createProxyMiddleware({
  target: 'ws://localhost:7880',
  changeOrigin: true,
});

// Use the proxy middleware for all requests to /livekit
app.use('/livekit', proxy);

// Start the server
app.listen(4001, () => {
  console.log('Server listening on port 3000');
});