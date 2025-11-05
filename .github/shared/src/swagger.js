import $RefParser, { ResolverError } from "@apidevtools/json-schema-ref-parser";
import { readFile } from "fs/promises";
import { dirname, relative, resolve } from "path";
import { inspect } from "util";
import { z } from "zod";
import { mapAsync } from "./array.js";
import { example } from "./changed-files.js";
import { includesSegment } from "./path.js";
import { SpecModelError } from "./spec-model-error.js";
import { embedError } from "./spec-model.js";

/**
 * @typedef {import('./spec-model.js').ErrorJSON} ErrorJSON
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
 * @typedef {Object} SwaggerJSON
 * @property {string} path
 * @property {Object[]} [refs]
 */

const pathSchema = z.record(z.string(), z.object({ operationId: z.string().optional() }));
/**
 * @typedef {import("zod").infer<typeof pathSchema>} PathObject
 */

const pathsSchema = z.record(z.string(), pathSchema);
/**
 * @typedef {import("zod").infer<typeof pathsSchema>} PathsObject
 */

const swaggerSchema = z.object({
  paths: pathsSchema.optional(),
  "x-ms-paths": pathsSchema.optional(),
});
/**
 * @typedef {import("zod").infer<typeof swaggerSchema>} SwaggerObject
 *
 * @example
 * const swagger = {
 *   "paths": {
 *     "/foo": {
 *       "get": {
 *         "operationId": "Foo_Get"
 *       },
 *       "put": {
 *         "operationId": "Foo_CreateOrUpdate"
 *       }
 *     },
 *     "/bar": { ... }
 *   },
 *   "x-ms-paths": {
 *     "/baz": { ... }
 *   }
 * };
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
  /**
   * Content of swagger file, either loaded from `#path` or passed in via `options`.
   *
   * Reset to `undefined` after `#data` is loaded to save memory.
   *
   * @type {string | undefined}
   */
  #content;

  // map of the operations in this swagger with key as 'operation_id
  /** @type {{operations: Map<string, Operation>, refs: Map<string, Swagger>} | undefined} */
  #data;

  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {string} absolute path */
  #path;

  /** @type {Tag | undefined} Tag that contains this Swagger */
  #tag;

  /**
   * @param {string} path
   * @param {Object} [options]
   * @param {string} [options.content] If specified, is used instead of reading path from disk
   * @param {import('./logger.js').ILogger} [options.logger]
   * @param {Tag} [options.tag]
   */
  constructor(path, options = {}) {
    const { content, logger, tag } = options;

    const rootDir = dirname(tag?.readme?.path ?? "");
    this.#path = resolve(rootDir, path);

    this.#content = content;
    this.#logger = logger;
    this.#tag = tag;
  }

  async #getData() {
    if (!this.#data) {
      // Only read file if #content is exactly undefined, to allow setting #content to empty string
      // to simulate an empty file
      if (this.#content === undefined) {
        try {
          this.#content = await readFile(this.#path, {
            encoding: "utf8",
          });
        } catch (error) {
          if (error instanceof Error) {
            throw new SpecModelError(`Failed to read file for swagger: ${this.#path}`, {
              cause: error,
              source: this.#path,
              tag: this.#tag?.name,
              readme: this.#tag?.readme?.path,
            });
          }

          throw error;
        }
      }

      /** @type {Map<string, Operation>} */
      const operations = new Map();

      const swagger = swaggerSchema.parse(JSON.parse(this.#content));
      // Process regular paths
      if (swagger.paths) {
        for (const [path, pathObject] of Object.entries(swagger.paths)) {
          this.addOperations(operations, path, pathObject);
        }
      }

      // Process x-ms-paths (Azure extension)
      if (swagger["x-ms-paths"]) {
        for (const [path, pathObject] of Object.entries(swagger["x-ms-paths"])) {
          this.addOperations(operations, path, pathObject);
        }
      }

      let schema;
      try {
        schema = await $RefParser.resolve(this.#path, this.#content, {
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

      const refs = new Map(
        refPaths.map((p) => {
          const swagger = new Swagger(p, {
            logger: this.#logger,
            tag: this.#tag,
          });
          return [swagger.path, swagger];
        }),
      );

      this.#data = { operations, refs };

      // Clear #content to save memory, since it's no longer needed after #data is loaded
      this.#content = undefined;
    }

    return this.#data;
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
    return (await this.#getData()).refs;
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
   * @returns {Promise<Map<string, Operation>>}
   */
  async getOperations() {
    return (await this.#getData()).operations;
  }

  /**
   *
   * @param {Map<string, Operation>} operations
   * @param {string} path
   * @param {PathObject} pathObject
   * @returns {void}
   */
  addOperations(operations, path, pathObject) {
    for (const [method, operation] of Object.entries(pathObject)) {
      if (operation.operationId !== undefined && method !== "parameters") {
        const operationObj = {
          id: operation.operationId,
          httpMethod: method.toUpperCase(),
          path: path,
        };
        operations.set(operation.operationId, operationObj);
      }
    }
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
   * @returns {string} version kind (stable or preview)
   */
  get versionKind() {
    return includesSegment(this.#path, "preview")
      ? API_VERSION_LIFECYCLE_STAGES.PREVIEW
      : API_VERSION_LIFECYCLE_STAGES.STABLE;
  }

  /**
   * @param {ToJSONOptions} [options]
   * @returns {Promise<SwaggerJSON|ErrorJSON>}
   */
  async toJSONAsync(options = {}) {
    const { includeRefs, relativePaths } = options;

    return await embedError(
      async () => ({
        path:
          relativePaths && this.#tag?.readme?.specModel
            ? relative(this.#tag?.readme?.specModel.folder, this.#path)
            : this.#path,
        refs: includeRefs
          ? await mapAsync(
              [...(await this.getRefs()).values()].sort((a, b) => a.path.localeCompare(b.path)),
              async (s) =>
                // Do not include swagger refs transitively, otherwise we could get in infinite loop
                await s.toJSONAsync({ ...options, includeRefs: false }),
            )
          : undefined,
      }),
      options,
    );
  }

  toString() {
    return `Swagger(${this.#path}, {logger: ${inspect(this.#logger)}})`;
  }
}

// API version lifecycle stages
export const API_VERSION_LIFECYCLE_STAGES = Object.freeze({
  PREVIEW: "preview",
  STABLE: "stable",
});
