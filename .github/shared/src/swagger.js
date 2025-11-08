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
 * @property {Object[]} [refs]
 */

const infoSchema = z.object({
  "x-typespec-generated": z.array(z.object({ emitter: z.string().optional() })).optional(),
});
/**
 * @typedef {import("zod").infer<typeof infoSchema>} InfoObject
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
  info: infoSchema.optional(),
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
   * @type {string | undefined}
   */
  #content;

  /**
   * Content of swagger file, represented as an untyped JSON object
   *
   *  @type {unknown | undefined}
   */
  #contentJSON;

  /**
   * Content of swagger file, represented as a typed object
   *
   * @type {SwaggerObject | undefined}
   * */
  #contentObject;

  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /**
   * Map of the operations in this swagger, using `operationId` as key
   *
   * @type {Map<string, Operation> | undefined}
   */
  #operations;

  /** @type {string} absolute path */
  #path;

  /**
   * @type {Map<string, Swagger> | undefined}
   */
  #refs;

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

  /**
   * Content of swagger file, either loaded from `#path` or passed in via `options`.
   *
   * @returns {Promise<string>}
   * @throws {SpecModelError}
   */
  async #getContent() {
    if (this.#content === undefined) {
      const path = this.#path;

      this.#content = await this.#wrapError(
        async () => await readFile(path, { encoding: "utf8" }),
        "Failed to read file for swagger",
      );
    }

    return this.#content;
  }

  /**
   * @returns {Promise<unknown>} Content of swagger file, represented as an untyped JSON object
   * @throws {SpecModelError}
   */
  async #getContentJSON() {
    if (this.#contentJSON === undefined) {
      const content = await this.#getContent();

      this.#contentJSON = await this.#wrapError(
        () => /** @type {unknown} */ (JSON.parse(content)),
        "Failed to parse JSON for swagger",
      );
    }

    return this.#contentJSON;
  }

  /**
   * @returns {Promise<SwaggerObject>} Content of swagger file, represented as a typed object
   * @throws {SpecModelError}
   */
  async #getContentObject() {
    if (this.#contentObject === undefined) {
      const contentJSON = await this.#getContentJSON();

      this.#contentObject = await this.#wrapError(
        () => swaggerSchema.parse(contentJSON),
        "Failed to parse schema for swagger",
      );
    }

    return this.#contentObject;
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
    if (this.#refs === undefined) {
      const path = this.#path;
      const contentJSON = await this.#getContentJSON();

      const schema = await this.#wrapError(
        async () =>
          await $RefParser.resolve(path, contentJSON, {
            resolve: { file: excludeExamples, http: false },
          }),
        "Failed to resolve file for swagger",
      );

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
    if (this.#operations === undefined) {
      const contentObject = await this.#getContentObject();

      this.#operations = new Map();

      // Process regular paths
      if (contentObject.paths) {
        for (const [path, pathObject] of Object.entries(contentObject.paths)) {
          this.#addOperations(this.#operations, path, pathObject);
        }
      }

      // Process x-ms-paths (Azure extension)
      if (contentObject["x-ms-paths"]) {
        for (const [path, pathObject] of Object.entries(contentObject["x-ms-paths"])) {
          this.#addOperations(this.#operations, path, pathObject);
        }
      }
    }

    return this.#operations;
  }

  /**
   *
   * @param {Map<string, Operation>} operations
   * @param {string} path
   * @param {PathObject} pathObject
   * @returns {void}
   */
  #addOperations(operations, path, pathObject) {
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
    return preview(this.#path)
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
