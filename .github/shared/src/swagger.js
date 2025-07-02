// @ts-check

import $RefParser, { ResolverError } from "@apidevtools/json-schema-ref-parser";
import { readFile } from "fs/promises";
import { dirname, relative, resolve } from "path";
import { mapAsync } from "./array.js";
import { includesFolder } from "./path.js";
import { SpecModelError } from "./spec-model-error.js";
import { existsSync, readFileSync } from "fs";

/**
 * @typedef {import('./spec-model.js').Tag} Tag
 * @typedef {import('./spec-model.js').ToJSONOptions} ToJSONOptions
 */

/**
 * @typedef {Object} Operation
 * @property {string} id - The operation ID
 * @property {string} path - API path
 * @property {string} httpMethod - HTTP method (GET, POST, etc.)
 */

/**
 * @typedef {Object} SwaggerVersion
 * @property {string} version
 * @property {'stable' | 'preview'} kind
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

  /** @type {Operation[]} map of the operations in this swagger*/
  #operations;

  /** @type {string}  */

  /**
   * @param {string} path
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   * @param {Tag} [options.tag]
   */
  constructor(path, options) {
    const rootDir = dirname(options?.tag?.readme?.path ?? "");
    this.#path = resolve(rootDir, path);
    this.#operations = [];
    this.#logger = options?.logger;
    this.#tag = options?.tag;
  }

  /**
   * @returns {Promise<Map<string, Swagger>>}
   */
  async getRefs() {
    const allRefs = await this.#getRefs();

    // filter out any paths that are examples
    const filtered = new Map([...allRefs].filter(([path]) => !example(path)));

    return filtered;
  }

  async #getRefs() {
    if (!this.#refs) {
      let schema;
      try {
        schema = await $RefParser.resolve(this.#path, {
          resolve: { file: excludeExamples, http: false },
        });
      } catch (error) {
        if (error instanceof ResolverError) {
          throw new SpecModelError(`Failed to resolve file for swagger: ${this.#path}`, {
            cause: error,
            source: error.source,
            tag: this.#tag?.name,
            readme: this.#tag?.readme?.path,
          });
        }

        throw error;
      }

      const refPaths = schema
        .paths("file")
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
   * @returns {Promise<Map<string, Swagger>>}
   */
  async getExamples() {
    const allRefs = await this.#getRefs();

    // filter out any paths that are examples
    const filtered = new Map([...allRefs].filter(([path]) => example(path)));

    return filtered;
  }

  /**
   * @returns {Promise<Operation[]>}
   */
  async getOperations() {
    if (this.#operations.length === 0) {
      try {
        const content = await readFile(this.#path, "utf8");
        const swagger = JSON.parse(content);
        // Process regular paths
        if (swagger.paths) {
          for (const [path, pathItem] of Object.entries(swagger.paths)) {
            for (const [method, operation] of Object.entries(pathItem)) {
              if (typeof operation === "object" && operation.operationId && method !== "parameters") {
                this.#operations.push({
                  id: operation.operationId,
                  httpMethod: method.toUpperCase(),
                  path: path,
                });
              }
            }
          }
        }

        // Process x-ms-paths (Azure extension)
        if (swagger["x-ms-paths"]) {
          for (const [path, pathItem] of Object.entries(swagger["x-ms-paths"])) {
            for (const [method, operation] of Object.entries(pathItem)) {
              if (typeof operation === "object" && operation.operationId && method !== "parameters") {
                this.#operations.push({
                  id: operation.operationId,
                  httpMethod: method.toUpperCase(),
                  path: path,
                });
              }
            }
          }
        }
      } catch {
        throw new SpecModelError(`Failed to read operations from swagger: ${this.#path}`);
      }
    }
    return this.#operations;
  }

  /**
   * @returns {SwaggerVersion} Extracts version information from swagger path
   */
  getVersion() {

  }

  /**
   * @returns {Promise<{preview?: Swagger, stable?: Swagger}>}
   */
  async getPreceedingSwaggers() {
    this.tag?.readme?.specModel?.getSwaggers();
  }

  async getLegacyVersionOperations() {}

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
            [...(await this.getRefs()).values()].sort((a, b) => a.path.localeCompare(b.path)),
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
  return typeof file === "string" && json(file) && includesFolder(file, "examples");
}

/**
 * @param {string} [file]
 * @returns {boolean}
 */
function json(file) {
  // Extension "json" with any case is a valid JSON file
  return typeof file === "string" && file.toLowerCase().endsWith(".json");
}

/**
 * Extract version string from input file path (matches original TypeScript implementation)
 * @param {string} filePath - Path to the input file
 * @param {boolean} [withPreview=false] - Whether to include preview suffix
 * @returns {string | undefined} - Version string extracted from path
 */
function getVersionFromInputFile(filePath, withPreview = false) {
  const apiVersionRegex = /^\d{4}-\d{2}-\d{2}(|-preview|-privatepreview|-alpha|-beta|-rc)$/;
  const segments = filePath.split("/");

  if (filePath.indexOf("data-plane") !== -1) {
    if (segments && segments.length > 1) {
      for (const s of segments.entries()) {
        if (["stable", "preview"].some((v) => v === s[1])) {
          const version = segments[s[0] + 1];
          if (version) {
            return apiVersionRegex.test(version) && !withPreview ? version.substr(0, 10) : version;
          }
        }
      }
    }
  } else {
    if (segments && segments.length > 1) {
      for (const s of segments) {
        if (apiVersionRegex.test(s)) {
          return withPreview ? s : s.substr(0, 10);
        }
      }
    }
  }

  if (existsSync(filePath)) {
    try {
      return JSON.parse(readFileSync(filePath).toString())?.info?.version;
    } catch {
      console.warn(`Failed to parse version from file: ${filePath}`);
    }
  }

  return undefined;
}

/**
 * Get version type from swagger file path
 * @param {string} swaggerPath - Path to swagger file
 * @returns {ApiVersionLifecycleStage} - Version type
 */
function getVersionType(swaggerPath) {
  return dirname(swaggerPath).includes("/preview/") ? "preview" : "stable";
}