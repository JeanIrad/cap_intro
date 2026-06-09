const cds = require('@sap/cds');
const { handleCancelRequest } = require('../utils/services/employees');

module.exports = class Employee extends cds.ApplicationService {
  init() {
    this.on('cancelRequest', 'Requests', handleCancelRequest);
    this.on('bootstrap', function (app) {
      console.log('App bootstrapping.....');
    });
    return super.init();
  }
};
