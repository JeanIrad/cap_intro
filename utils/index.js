const chalk = require('chalk');

function timestampLogger(timeStamp) {
  if (timeStamp) {
    const dateToLog = new Date(timeStamp);
    console.log(chalk.green(`[Logger] logs ${timeStamp}`));
  } else {
    console.log('No TimeStamp to log');
  }
}

module.exports = {
  timestampLogger,
};
