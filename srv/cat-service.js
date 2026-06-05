const cds = require('@sap/cds');
const { timestampLogger } = require('../utils');

module.exports = class CatlogSerivice extends cds.ApplicationService {
  init() {
    this.on('orderedBook', async (payload) => {
      console.log('Some payload after ordering book!');
    });

    this.before('READ', 'Books', async (req) => {
      const now = req.timestamp;
      await timestampLogger(now);
    });

    return super.init();
  }
};
