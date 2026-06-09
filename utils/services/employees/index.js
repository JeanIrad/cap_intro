exports.handleCancelRequest = async function (req) {
  console.log('Request cancelling....', req.data);
  req.notify('Request cancelling...');
};
