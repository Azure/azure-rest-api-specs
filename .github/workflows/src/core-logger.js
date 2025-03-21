// @ts-check

/**
 * @typedef {import('../../src/types.js').ILogger} ILogger
 */

/**
 * @implements {ILogger}
 */
export class CoreLogger {
  /** @type {import('github-script').AsyncFunctionArguments['core']} */
  #core;

  /**
   * @param {import('github-script').AsyncFunctionArguments['core']} core
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
