import $RefParser from "@apidevtools/json-schema-ref-parser";
import { readFile } from "fs/promises";
import { dirname, relative, resolve } from "path";
import { inspect } from "util";
import { z } from "zod";
import { mapAsync } from "./array.js";
import { example, preview } from "./changed-files.js";
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
 * @property {Operation[]} [operations]
 * @property {Object[]} [refs]
 */

// https://swagger.io/specification/v2/#operation-object
const operationSchema = z.object({ operationId: z.string().optional() });
/**
 * @typedef {import("zod").infer<typeof operationSchema>} OperationObject
 */

// TODO: Consider narrowing to only the field names in the spec ("get", "put", etc)
// https://swagger.io/specification/v2/#path-item-object
const pathSchema = z
  .object({
    parameters: z.array(z.unknown()).optional(),
  })
  .catchall(operationSchema);
/**
 * @typedef {import("zod").infer<typeof pathSchema>} PathObject
 */

// https://swagger.io/specification/v2/#paths-object
const pathsSchema = z.record(z.string(), pathSchema);
/**
 * @typedef {import("zod").infer<typeof pathsSchema>} PathsObject
 */

// https://swagger.io/specification/v2/#swagger-object
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
 *       "parameters": [ ... ],
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

  // operations: Map of the operations in this swagger, using `operationId` as key
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
      const path = this.#path;

      const content =
        this.#content ??
        (await this.#wrapError(
          async () => await readFile(path, { encoding: "utf8" }),
          "Failed to read file for swagger",
        ));

      /** @type {Map<string, Operation>} */
      const operations = new Map();

      const swaggerJson = await this.#wrapError(
        () => /** @type {unknown} */ (JSON.parse(content)),
        "Failed to parse JSON for swagger",
      );

      /** @type {SwaggerObject} */
      const swagger = await this.#wrapError(
        () => swaggerSchema.parse(swaggerJson),
        "Failed to parse schema for swagger",
      );

      // Process regular paths
      if (swagger.paths) {
        for (const [path, pathObject] of Object.entries(swagger.paths)) {
          this.#addOperations(operations, path, pathObject);
        }
      }

      // Process x-ms-paths (Azure extension)
      if (swagger["x-ms-paths"]) {
        for (const [path, pathObject] of Object.entries(swagger["x-ms-paths"])) {
          this.#addOperations(operations, path, pathObject);
        }
      }

      const schema = await this.#wrapError(
        async () =>
          await $RefParser.resolve(this.#path, swaggerJson, {
            resolve: { file: excludeExamples, http: false },
          }),
        "Failed to resolve file for swagger",
      );

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
   * @returns {Promise<Map<string, Swagger>>} Map of swaggers referenced from this swagger, using `path` as key
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
   * @returns {Promise<Map<string, Swagger>>} Map of examples referenced from this swagger, using `path` as key
   */
  async getExamples() {
    const allRefs = await this.#getRefs();

    // filter out any paths that are examples
    const filtered = new Map([...allRefs].filter(([path]) => example(path)));

    return filtered;
  }

  /**
   * @returns {Promise<Map<string, Operation>>} Map of the operations in this swagger, using `operationId` as key
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
  #addOperations(operations, path, pathObject) {
    for (const [method, operation] of Object.entries(
      /** @type {Omit<PathObject, "parameters">} */ (pathObject),
    )) {
      if (method !== "parameters" && operation.operationId !== undefined) {
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
    return preview(this.#path)
      ? API_VERSION_LIFECYCLE_STAGES.PREVIEW
      : API_VERSION_LIFECYCLE_STAGES.STABLE;
  }

  /**
   * @param {ToJSONOptions} [options]
   * @returns {Promise<SwaggerJSON|ErrorJSON>}
   */
  async toJSONAsync(options = {}) {
    const { includeOperations, includeRefs, relativePaths } = options;

    return await embedError(
      async () => ({
        path:
          relativePaths && this.#tag?.readme?.specModel
            ? relative(this.#tag?.readme?.specModel.folder, this.#path)
            : this.#path,
        operations: includeOperations
          ? [...(await this.getOperations()).values()].map((o) => {
              // Create new object with properties in preferred output order
              return { path: o.path, httpMethod: o.httpMethod, id: o.id };
            })
          : undefined,
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

  /**
   * Returns value of `func()`, wrapping any `Error` in `SpecModelError`
   *
   * @template T
   * @param {() => T | Promise<T>} func
   * @param {string} message
   * @returns {Promise<T>}
   * @throws {SpecModelError}
   */
  async #wrapError(func, message) {
    try {
      return await func();
    } catch (error) {
      if (error instanceof Error) {
        throw new SpecModelError(`${message}: ${this.#path}`, {
          cause: error,
          source: this.#path,
          tag: this.#tag?.name,
          readme: this.#tag?.readme?.path,
        });
      } /* v8 ignore start: defensive rethrow */ else {
        throw error;
      }
      /* v8 ignore stop */
    }
  }
}

// API version lifecycle stages
export const API_VERSION_LIFECYCLE_STAGES = Object.freeze({
  PREVIEW: "preview",
  STABLE: "stable",
});
