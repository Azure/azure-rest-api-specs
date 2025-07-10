// @ts-check

/**
 * @typedef {import('../../shared/src/logger.js').ILogger} ILogger
 */

/**
 * @implements {ILogger}
 */
export class CoreLogger {
  /** @type {import('@actions/github-script').AsyncFunctionArguments['core']} */
  #core;

  /**
   * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core
   */
  constructor(core) {
    this.#core = core;
  }

  /**
   * @param {string} message
   */
  debug(message) {
    this.#core.debug(message);
  }

  /**
   * @param {string} message
   */
  error(message) {
    this.#core.error(message);
  }

  /**
   * @param {string} message
   */
  info(message) {
    this.#core.info(message);
  }

  /**
   * @returns {boolean}
   */
  isDebug() {
    return this.#core.isDebug();
  }
}
