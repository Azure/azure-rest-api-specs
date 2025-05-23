// @ts-check

import { mapAsync } from "./array.js";
import { Swagger } from "./swagger.js";

/**
 * @typedef {import('./readme.js').Readme} Readme
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
   * Readme that contains this Tag
   * @type {Readme | undefined}
   */
  #readme;

  /**
   * @param {string} name
   * @param {string[]} inputFilePaths
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   * @param {Readme} [options.readme]
   */
  constructor(name, inputFilePaths, options) {
    this.#name = name;
    this.#logger = options?.logger;
    this.#readme = options?.readme;

    this.#inputFiles = new Map(
      inputFilePaths.map((p) => {
        let swagger = new Swagger(p, { logger: this.#logger, tag: this });
        return [swagger.path, swagger];
      }),
    );
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
   * @returns {Readme | undefined} Readme that contains this Tag
   */
  get readme() {
    return this.#readme;
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
