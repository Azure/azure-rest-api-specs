// @ts-check

import { mapAsync } from "./array.js";

/**
 * @typedef {import('./swagger.js').Swagger} Swagger
 * @typedef {import('./spec-model.js').ToJSONOptions} ToJSONOptions
 */

export class Tag {
  /** @type {Map<string, Swagger>} */
  #inputFiles;

  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {string} */
  #name;

  /**
   * @param {string} name
   * @param {Map<string, Swagger>} inputFiles
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   */
  constructor(name, inputFiles, options) {
    this.#name = name;
    this.#inputFiles = inputFiles;
    this.#logger = options?.logger;
  }

  /**
   * @returns {Map<string, Swagger>}
   */
  get inputFiles() {
    return this.#inputFiles;
  }

  /**
   * @returns {string}
   */
  get name() {
    return this.#name;
  }

  /**
   * @param {ToJSONOptions} [options]
   * @returns {Promise<Object>}
   */
  async toJSONAsync(options) {
    return {
      name: this.#name,
      inputFiles: await mapAsync(
        [...this.#inputFiles.values()].sort((a, b) =>
          a.path.localeCompare(b.path),
        ),
        async (s) => await s.toJSONAsync(options),
      ),
    };
  }

  toString() {
    return `Tag(${this.#name}, {logger: ${this.#logger}})`;
  }
}
