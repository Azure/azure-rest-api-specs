import $RefParser from "@apidevtools/json-schema-ref-parser";
import { readFile } from "fs/promises";
import { dirname, relative } from "path";
import { inspect } from "util";
import { z } from "zod";
import { mapAsync } from "./array.ts";
import { KeyedCache } from "./cache.ts";
import { example, preview } from "./changed-files.ts";
import { resolveCached, resolvePairCached } from "./path.ts";
import { SpecModelError } from "./spec-model-error.ts";
import { embedError } from "./spec-model.ts";

export type ErrorJSON = import("./spec-model.ts").ErrorJSON;

export type Tag = import("./spec-model.ts").Tag;

export type ToJSONOptions = import("./spec-model.ts").ToJSONOptions;

export interface Operation {
  id: string;
  path: string;
  httpMethod: string;
}

export interface SwaggerJSON {
  path: string;
  operations?: Operation[];
  refs?: object[];
}

const infoSchema = z.object({
  "x-typespec-generated": z.array(z.object({ emitter: z.string().optional() })).optional(),
});
export type InfoObject = import("zod").infer<typeof infoSchema>;

// https://swagger.io/specification/v2/#operation-object
const operationSchema = z.object({ operationId: z.string().optional() });
export type OperationObject = import("zod").infer<typeof operationSchema>;

// TODO: Consider narrowing to only the field names in the spec ("get", "put", etc)
// https://swagger.io/specification/v2/#path-item-object
const pathSchema = z
  .object({
    parameters: z.array(z.unknown()).optional(),
  })
  .catchall(operationSchema);
export type PathObject = import("zod").infer<typeof pathSchema>;

// https://swagger.io/specification/v2/#paths-object
const pathsSchema = z.record(z.string(), pathSchema);
export type PathsObject = import("zod").infer<typeof pathsSchema>;

// https://swagger.io/specification/v2/#swagger-object
const swaggerSchema = z.object({
  info: infoSchema.optional(),
  paths: pathsSchema.optional(),
  "x-ms-paths": pathsSchema.optional(),
});
export type SwaggerObject = import("zod").infer<typeof swaggerSchema>;
/**
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

const excludeExamples: import("@apidevtools/json-schema-ref-parser").ResolverOptions = {
  order: 1,
  canRead: true,
  read: async (file: import("@apidevtools/json-schema-ref-parser").FileInfo) => {
    if (example(file.url)) {
      return "";
    }
    return await readFile(file.url, { encoding: "utf8" });
  },
};

export class Swagger {
  /**
   * Caches the contents of files on disk, using the resolved path as the key.
   */
  static #contentCache: KeyedCache<string, Promise<string>> = new KeyedCache();

  /**
   * Caches JSON objects parsed from text, using the resolved path (or content string itself) as the key.
   */
  static #contentJsonCache: KeyedCache<string, Promise<unknown>> = new KeyedCache();

  /**
   * Caches SwaggerObject objects parsed from JSON objects, using the resolved path (or content string itself) as the key.
   */
  static #contentObjectCache: KeyedCache<string, Promise<SwaggerObject>> = new KeyedCache();

  /**
   * Caches operations extracted from a SwaggerObject, using the resolved path (or content string itself) as the key.
   */
  static #operationsCache: KeyedCache<string, Promise<Map<string, Operation>>> = new KeyedCache();

  /**
   * Caches reference paths extracted from a JSON object, using the resolved path (or content string itself) as the key.
   *
   * Swagger objects should not be cached statically, because they may belong to different Tags, Readmes, or SpecModels.
   */
  static #refPathCache: KeyedCache<string, Promise<string[]>> = new KeyedCache();

  /**
   * Optional content of swagger file, passed in via `options`.  If undefined, content is loaded from `#path`.
   */
  #content: string | undefined;

  #logger: import("./logger.ts").ILogger | undefined;

  #path: string;

  #tag: Tag | undefined;

  #allRefs: Map<string, Swagger> | undefined;

  #refs: Map<string, Swagger> | undefined;

  #examples: Map<string, Swagger> | undefined;

  constructor(
    path: string,
    options: { content?: string; logger?: import("./logger.ts").ILogger; tag?: Tag } = {},
  ) {
    const { content, logger, tag } = options;

    const rootDir = dirname(tag?.readme?.path ?? "");
    this.#path = resolvePairCached(rootDir, path);

    this.#content = content;
    this.#logger = logger;
    this.#tag = tag;
  }

  /**
   * @returns Content of swagger file, represented as a string, either loaded from `#path` or passed in via `options`
   * @throws {SpecModelError}
   */
  async #getContent(): Promise<string> {
    return (
      this.#content ??
      (await Swagger.#contentCache.getOrCreate(
        this.#path,
        async () =>
          await this.#wrapError(
            async () => await readFile(this.#path, { encoding: "utf8" }),
            "Failed to read file for swagger",
          ),
      ))
    );
  }

  /**
   * @returns Content of swagger file, represented as an untyped JSON object
   * @throws {SpecModelError}
   */
  async #getContentJSON(): Promise<unknown> {
    return await Swagger.#contentJsonCache.getOrCreate(
      this.#content ?? this.#path,
      async () =>
        await this.#wrapError(
          async () => JSON.parse(await this.#getContent()) as unknown,
          "Failed to parse JSON for swagger",
        ),
    );
  }

  /**
   * @returns Content of swagger file, represented as a typed object
   * @throws {SpecModelError}
   */
  async #getContentObject(): Promise<SwaggerObject> {
    return await Swagger.#contentObjectCache.getOrCreate(
      this.#content ?? this.#path,
      async () =>
        await this.#wrapError(
          async () => swaggerSchema.parse(await this.#getContentJSON()),
          "Failed to parse schema for swagger",
        ),
    );
  }

  /**
   * @returns Map of swaggers referenced from this swagger, using `path` as key
   */
  async getRefs(): Promise<Map<string, Swagger>> {
    if (this.#refs === undefined) {
      const allRefs = await this.#getRefs();

      // filter out any paths that are examples
      const filtered = new Map([...allRefs].filter(([path]) => !example(path)));

      this.#refs = filtered;
    }
    return this.#refs;
  }

  async #getRefs() {
    if (this.#allRefs === undefined) {
      // Safe to cache refPaths statically, since it's just an array of string paths
      const refPaths = await Swagger.#refPathCache.getOrCreate(
        this.#content ?? this.#path,
        async () => {
          const contentJSON = await this.#getContentJSON();

          const schema = await this.#wrapError(
            async () =>
              await $RefParser.resolve(this.#path, contentJSON, {
                resolve: { file: excludeExamples, http: false },
              }),
            "Failed to resolve file for swagger",
          );

          return (
            schema
              .paths("file")
              // Exclude ourself
              .filter((p) => resolveCached(p) !== resolveCached(this.#path))
          );
        },
      );

      // Swagger objects should not be cached statically, because they may belong to different Tags, Readmes, or SpecModels.
      // But, they are safe to cache in this instance.
      this.#allRefs = new Map(
        refPaths.map((p) => {
          const swagger = new Swagger(p, {
            logger: this.#logger,
            tag: this.#tag,
          });
          return [swagger.path, swagger];
        }),
      );
    }

    return this.#allRefs;
  }

  /**
   * @returns Map of examples referenced from this swagger, using `path` as key
   */
  async getExamples(): Promise<Map<string, Swagger>> {
    if (this.#examples === undefined) {
      const allRefs = await this.#getRefs();

      // filter out any paths that are examples
      const filtered = new Map([...allRefs].filter(([path]) => example(path)));

      this.#examples = filtered;
    }
    return this.#examples;
  }

  /**
   * @returns Map of the operations in this swagger, using `operationId` as key
   */
  async getOperations(): Promise<Map<string, Operation>> {
    return await Swagger.#operationsCache.getOrCreate(this.#content ?? this.#path, async () => {
      const contentObject = await this.#getContentObject();

      const operations: Map<string, Operation> = new Map();

      // Process regular paths
      if (contentObject.paths) {
        for (const [path, pathObject] of Object.entries(contentObject.paths)) {
          this.#addOperations(operations, path, pathObject);
        }
      }

      // Process x-ms-paths (Azure extension)
      if (contentObject["x-ms-paths"]) {
        for (const [path, pathObject] of Object.entries(contentObject["x-ms-paths"])) {
          this.#addOperations(operations, path, pathObject);
        }
      }

      return operations;
    });
  }

  /**
   * @returns True if the spec was generated from TypeSpec
   */
  async getTypeSpecGenerated(): Promise<boolean> {
    const contentObject = await this.#getContentObject();
    return contentObject.info?.["x-typespec-generated"] !== undefined;
  }

  #addOperations(operations: Map<string, Operation>, path: string, pathObject: PathObject): void {
    for (const [method, operation] of Object.entries(
      pathObject as Omit<PathObject, "parameters">,
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
   * @returns absolute path
   */
  get path(): string {
    return this.#path;
  }

  /**
   * @returns Tag that contains this Swagger
   */
  get tag(): Tag | undefined {
    return this.#tag;
  }

  /**
   * @returns version kind (stable or preview)
   */
  get versionKind(): string {
    return preview(this.#path)
      ? API_VERSION_LIFECYCLE_STAGES.PREVIEW
      : API_VERSION_LIFECYCLE_STAGES.STABLE;
  }

  async toJSONAsync(options: ToJSONOptions = {}): Promise<SwaggerJSON | ErrorJSON> {
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
   * @throws {SpecModelError}
   */
  async #wrapError<T>(func: () => T | Promise<T>, message: string): Promise<T> {
    try {
      return await func();
    } catch (error) {
      /* v8 ignore else -- defensive rethrow */
      if (error instanceof Error) {
        throw new SpecModelError(`${message}: ${this.#path}`, {
          cause: error,
          source: this.#path,
          tag: this.#tag?.name,
          readme: this.#tag?.readme?.path,
        });
      } else {
        throw error;
      }
    }
  }
}

// API version lifecycle stages
export const API_VERSION_LIFECYCLE_STAGES = Object.freeze({
  PREVIEW: "preview",
  STABLE: "stable",
});
