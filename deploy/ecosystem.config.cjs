module.exports = {
  apps: [{
    name: 'passkru-api',
    cwd: './server',
    script: 'src/server.js',
    env: { NODE_ENV: 'production', PORT: 5000 },
    max_memory_restart: '400M',
  }],
};
