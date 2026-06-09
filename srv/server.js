const cds = require('@sap/cds');
const { roleBasedLimiter } = require('../utils/middlewares');

cds.on('bootstrap', (app) => {
  console.log('CALLING SERVER WITH RATE LIMITTING');
  app.use(roleBasedLimiter);
});
