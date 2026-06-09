'use strict';

const cds = require('@sap/cds');

module.exports = class AssetManagementService extends cds.ApplicationService {
  async init() {
    this.before('CREATE', 'Requests', async (req) => {
      console.log('Before Create Request................................');
      const { requestedType_code } = req.data;

      const asset = await SELECT.one
        .from('it.assets.management.Assets')
        .where({ type_code: requestedType_code, status: 'Available' });
    });

    this.after('UPDATE', 'Requests', async (data, req) => {
      const { allocatedAsset_ID, approvalStatus } = data;

      if (approvalStatus === 'Approved' && allocatedAsset_ID) {
        await UPDATE('it.assets.management.Assets')
          .set({ status: 'Assigned' })
          .where({ ID: allocatedAsset_ID });
      }

      if (approvalStatus === 'Rejected' && allocatedAsset_ID) {
        await UPDATE('it.assets.management.Assets')
          .set({ status: 'Available', currentEmployee_ID: null })
          .where({ ID: allocatedAsset_ID });
      }
    });

    await super.init();
  }
};
