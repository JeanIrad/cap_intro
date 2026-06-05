class CustomError extends Error {
  constructor(statusCode, message, stack) {
    super(message, stack);
    this.statusCode = statusCode;
  }
}

module.exports = CustomError;
