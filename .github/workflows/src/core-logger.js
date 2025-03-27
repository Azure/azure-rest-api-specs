// @ts-check

import { ILogger } from "../../src/logger.js";

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
