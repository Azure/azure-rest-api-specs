// @ts-check

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
