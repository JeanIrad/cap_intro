exports.handleGetRequests = async function (req) {
  const startTime = new Date();
  console.log('Hello', req.timestamp);

  const endTime = new Date();
  const serverTime = endTime - startTime;

  return req.info(`ALL IS FINE, server time ${serverTime}`);
};

exports.handleCreateHardwareTypes = async function (req) {
  console.log('REQUEST', req.data);
  return req.info('BYOSE NISAWA');
};
