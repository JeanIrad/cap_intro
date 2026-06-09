const cds = require('@sap/cds');
const {
  handleGetRequests,
  handleCreateHardwareTypes,
} = require('../utils/services/admin');

class Admin extends cds.ApplicationService {
  init() {
    this.before('CREATE', 'HardwareTypes', handleCreateHardwareTypes);
    this.on('READ', 'Requests', handleGetRequests);

    return super.init();
  }
}

module.exports = {
  Admin,
};
