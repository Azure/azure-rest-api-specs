// @ts-check

import $RefParser, { ResolverError } from "@apidevtools/json-schema-ref-parser";
import { readFile } from "fs/promises";
import { dirname, relative, resolve } from "path";
import { mapAsync } from "./array.js";
import { SpecModelError } from "./spec-model-error.js";

/**
 * @typedef {import('./spec-model.js').Tag} Tag
 * @typedef {import('./spec-model.js').ToJSONOptions} ToJSONOptions
 */

/**
 * @type {import('@apidevtools/json-schema-ref-parser').ResolverOptions}
 */
const excludeExamples = {
  order: 1,
  canRead: true,
  read: async (
    /** @type import('@apidevtools/json-schema-ref-parser').FileInfo */
    file,
  ) => {
    if (example(file.url)) {
      return "";
    }
    return await readFile(file.url, { encoding: "utf8" });
  },
};

export class Swagger {
  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {string} absolute path */
  #path;

  /** @type {Map<string, Swagger> | undefined} */
  #refs;

  /** @type {Tag | undefined} Tag that contains this Swagger */
  #tag;

  /**
   * @param {string} path
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   * @param {Tag} [options.tag]
   */
  constructor(path, options) {
    const rootDir = dirname(options?.tag?.readme?.path ?? "");
    this.#path = resolve(rootDir, path);
    this.#logger = options?.logger;
    this.#tag = options?.tag;
  }

  /**
   * @returns {Promise<Map<string, Swagger>>}
   */
  async getRefs() {
    if (!this.#refs) {
      let schema;
      try {
        schema = await $RefParser.resolve(this.#path, {
          resolve: { file: excludeExamples, http: false },
        });
      } catch (error) {
        if (error instanceof ResolverError) {
          throw new SpecModelError(
            `Failed to resolve file for swagger: ${this.#path}`,
            {
              cause: error,
              source: error.source,
              tag: this.#tag?.name,
              readme: this.#tag?.readme?.path,
            },
          );
        }

        throw error;
      }

      const refPaths = schema
        .paths("file")
        // Exclude examples
        .filter((p) => !example(p))
        // Exclude ourself
        .filter((p) => resolve(p) !== resolve(this.#path));

      this.#refs = new Map(
        refPaths.map((p) => {
          const swagger = new Swagger(p, {
            logger: this.#logger,
            tag: this.#tag,
          });
          return [swagger.path, swagger];
        }),
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
   * @returns {Tag | undefined} Tag that contains this Swagger
   */
  get tag() {
    return this.#tag;
  }

  /**
   * @param {ToJSONOptions} [options]
   * @returns {Promise<Object>}
   */
  async toJSONAsync(options) {
    return {
      path:
        options?.relativePaths && this.#tag?.readme?.specModel
          ? relative(this.#tag?.readme?.specModel.folder, this.#path)
          : this.#path,
      refs: options?.includeRefs
        ? await mapAsync(
            [...(await this.getRefs()).values()].sort((a, b) =>
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
