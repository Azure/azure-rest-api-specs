// @ts-check

// Ignore code coverage since code is simple but hard to mock
/* v8 ignore start */

/**
 * @interface
 */
export class ILogger {
  /**
   * @param {string} message
   */
  debug(message) {}

  /**
   * @param {string} message
   */
  info(message) {}

  /**
   * @returns {boolean}
   */
  isDebug() {
    return false;
  }
}
