// @ts-check

import $RefParser from "@apidevtools/json-schema-ref-parser";
import { relative, resolve } from "path";
import { mapAsync } from "./array.js";
import { resolveCheckAccess } from "./fs.js";

/**
 * @typedef {import('./spec-model.js').SpecModel} SpecModel
 * @typedef {import('./spec-model.js').ToJSONOptions} ToJSONOptions
 */

export class Swagger {
  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {string} absolute path */
  #path;

  /** @type {Set<Swagger> | undefined} */
  #refs;

  /** @type {SpecModel} backpointer to owning SpecModel */
  #specModel;

  /**
   * @param {SpecModel} specModel
   * @param {string} path
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   */
  constructor(specModel, path, options) {
    this.#specModel = specModel;
    this.#path = resolveCheckAccess(path);
    this.#logger = options?.logger;
  }

  /**
   * @returns {Promise<Set<Swagger>>}
   */
  async getRefs() {
    if (!this.#refs) {
      const schema = await $RefParser.resolve(this.#path, {
        resolve: { http: false },
      });

      const refPaths = schema
        .paths("file")
        // Exclude examples
        .filter((p) => !example(p))
        // Exclude ourself
        .filter((p) => resolve(p) !== resolve(this.#path));

      this.#refs = new Set(
        refPaths.map((p) => new Swagger(this.#specModel, p)),
      );
    }

    return this.#refs;
  }

  /**
   * @returns {string} absolute path
   */
  get path() {
    return this.#path;
  }

  /**
   * @param {ToJSONOptions} [options]
   * @returns {Promise<Object>}
   */
  async toJSONAsync(options) {
    return {
      path: options?.relativePaths
        ? relative(this.#specModel.folder, this.#path)
        : this.#path,
      refs: options?.includeRefs
        ? await mapAsync(
            [...(await this.getRefs())].sort((a, b) =>
              a.path.localeCompare(b.path),
            ),
            async (s) =>
              // Do not include swagger refs transitively, otherwise we could get in infinite loop
              await s.toJSONAsync({ ...options, includeRefs: false }),
          )
        : undefined,
    };
  }

  toString() {
    return `Swagger(${this.#path}, {logger: ${this.#logger}})`;
  }
}

// TODO: Remove duplication with changed-files.js (which currently requires paths relative to repo root)

/**
 * @param {string} [file]
 * @returns {boolean}
 */
function example(file) {
  // Folder name "examples" should match case for consistency across specs
  return typeof file === "string" && json(file) && file.includes("/examples/");
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
function json(file) {
  // Extension "json" with any case is a valid JSON file
  return typeof file === "string" && file.toLowerCase().endsWith(".json");
}
