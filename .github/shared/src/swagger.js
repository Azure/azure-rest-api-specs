// @ts-check

import $RefParser, { ResolverError } from "@apidevtools/json-schema-ref-parser";
import { readFile } from "fs/promises";
import { basename, dirname, relative, resolve } from "path";
import { mapAsync } from "./array.js";
import { includesFolder } from "./path.js";
import { SpecModelError } from "./spec-model-error.js";
import { existsSync, readFileSync } from "fs";
import { API_VERSION_LIFECYCLE_STAGES } from "./breaking-change.js";

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
 * @typedef {Operation & {swagger: string}} LegacyOperation
 * @property {string} swagger - Path to the swagger file containing this operation
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

  /** @type {string}  swagger version*/
  #version;

  /** @type {string} version kind*/
  #versionKind;

  /** * @type {string} file name of the swagger file, e.g. "LongRunningBackend.json" */
  #fileName;

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
    this.#version = getVersionFromInputFile(this.#path) || "";
    this.#versionKind = dirname(this.#path).includes("/preview/")
      ? API_VERSION_LIFECYCLE_STAGES.PREVIEW
      : API_VERSION_LIFECYCLE_STAGES.STABLE;
    this.#fileName = getBaseNameForSwagger(this.#path, this.#version);
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
              if (
                typeof operation === "object" &&
                operation.operationId &&
                method !== "parameters"
              ) {
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
              if (
                typeof operation === "object" &&
                operation.operationId &&
                method !== "parameters"
              ) {
                this.#operations.push({
                  id: operation.operationId,
                  httpMethod: method.toUpperCase(),
                  path: path,
                });
              }
            }
          }
        }

        // Sort operations by id and store in instance variable
        this.#operations.sort((a, b) => a.id.localeCompare(b.id));
      } catch {
        throw new SpecModelError(`Failed to read operations from swagger: ${this.#path}`);
      }
    }
    return this.#operations;
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
   * @returns {string} swagger version
   */
  get version() {
    return this.#version;
  }

  /**
   * @returns {string} version kind (stable or preview)
   */
  get versionKind() {
    return this.#versionKind;
  }

  /**
   * @returns {string} file name of the swagger file
   */
  get fileName() {
    return this.#fileName;
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
 * Get base name for swagger file
 * @param {string} filePath - Path to swagger file
 * @param {string} [version] - Version string to use for base name
 * @returns {string} - Base name for the swagger file
 */
function getBaseNameForSwagger(filePath, version = "") {
  if (version) {
    const segments = filePath.split("/");
    const index = segments.findIndex((v) => v.startsWith(version));
    if (index !== -1) {
      return segments.slice(index + 1).join("/");
    }
  }
  return basename(filePath);
}

/**
 * Extract version string from input file path
 * @param {string} filePath - Path to the input file
 * @param {boolean} [withPreview=false] - Whether to include preview suffix
 * @returns {string | undefined} - Version string extracted from path
 */
export function getVersionFromInputFile(filePath, withPreview = false) {
  const apiVersionRegex = /^\d{4}-\d{2}-\d{2}(|-preview|-privatepreview|-alpha|-beta|-rc)$/;
  const segments = filePath.split("/");

  if (filePath.indexOf("data-plane") !== -1) {
    if (segments && segments.length > 1) {
      for (const s of segments.entries()) {
        if (["stable", "preview"].some((v) => v === s[1])) {
          const version = segments[s[0] + 1];
          if (version) {
            return apiVersionRegex.test(version) && !withPreview
              ? version.substring(0, 10)
              : version;
          }
        }
      }
    }
  } else {
    if (segments && segments.length > 1) {
      for (const s of segments) {
        if (apiVersionRegex.test(s)) {
          return withPreview ? s : s.substring(0, 10);
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
 * Get preceding swagger version for a specific lifecycle stage
 * @param {string} targetSwaggerPath - Path to the swagger file to find predecessors for
 * @param {Swagger[]} availableSwaggers - Array of swagger objects to search within
 * @param {string} versionKind - Version lifecycle stage (PREVIEW or STABLE)
 * @returns {string | undefined} - Path to preceding version or undefined if not found
 */
function getPrecedingSwaggerByType(targetSwaggerPath, availableSwaggers, versionKind) {
  const targetSwagger = availableSwaggers.find((s) => s.path === targetSwaggerPath);
  if (!targetSwagger) {
    return undefined;
  }

  const currentVersion = targetSwagger.version;
  const fileName = targetSwagger.fileName;

  try {
    const versionsOfType = availableSwaggers.filter(
      (swagger) =>
        swagger.fileName === fileName &&
        swagger.versionKind === versionKind &&
        swagger.version <= currentVersion &&
        swagger.path !== targetSwaggerPath,
    );

    if (versionsOfType.length > 0) {
      const mostRecent = versionsOfType.reduce((previous, current) =>
        previous.version > current.version ? previous : current,
      );
      return mostRecent.path;
    }
  } catch {
    // Version not found or error occurred
  }

  return undefined;
}

/**
 * Get preceding swagger versions for a given swagger file
 * @param {string} targetSwaggerPath - Path to the swagger file to find predecessors for
 * @param {Swagger[]} availableSwaggers - Array of swagger objects to search within
 * @returns {{preview?: string, stable?: string}} - Paths to preceding versions
 */
/**
 * Get operations from all previous versions that also exist in current swagger
 * @param {string} targetSwaggerPath - Path to the current swagger file
 * @param {Swagger[]} availableSwaggers - Array of swagger objects to search within
 * @returns {Promise<LegacyOperation[]>} - Operations that exist in both previous versions and current version
 */
export async function getLegacyVersionOperations(targetSwaggerPath, availableSwaggers) {
  /** @type {LegacyOperation[]} */
  let result = [];

  const targetSwagger = availableSwaggers.find((s) => s.path === targetSwaggerPath);
  if (!targetSwagger) {
    return result;
  }

  const fileName = targetSwagger.fileName;
  const currentVersion = targetSwagger.version;

  // Get operations from current swagger file
  const currentOperations = await targetSwagger.getOperations();

  // Get all previous versions of the same file name including stable and preview
  const previousVersionSwaggers = availableSwaggers
    .filter(
      (swagger) =>
        swagger.fileName === fileName &&
        swagger.version < currentVersion &&
        swagger.path !== targetSwaggerPath,
    )
    .sort((a, b) => a.version.localeCompare(b.version));

  // Collect operations from all previous versions that also exist in current version
  for (const previousSwagger of previousVersionSwaggers) {
    try {
      const previousOperations = await previousSwagger.getOperations();

      // Find operations that exist in both this previous version AND current version
      const matchingOperations = previousOperations
        .filter((operation) => {
          return currentOperations.some(
            (currentOp) =>
              currentOp.path === operation.path &&
              currentOp.id === operation.id &&
              currentOp.httpMethod === operation.httpMethod,
          );
        })
        .map((o) => {
          // Add swagger file reference to track which old version contained this operation
          return { ...o, swagger: previousSwagger.path };
        });

      result.push(...matchingOperations);
    } catch {
      // Skip versions that can't be processed
    }
  }

  return result;
}

/**
 * Get preceding swagger versions for a given swagger file
 * @param {string} targetSwaggerPath - Path to the swagger file to find predecessors for
 * @param {Swagger[]} availableSwaggers - Array of swagger objects to search within
 * @returns {{preview?: string, stable?: string}} - Paths to preceding versions
 */
export function getPrecedingSwaggers(targetSwaggerPath, availableSwaggers) {
  return {
    preview: getPrecedingSwaggerByType(
      targetSwaggerPath,
      availableSwaggers,
      API_VERSION_LIFECYCLE_STAGES.PREVIEW,
    ),
    stable: getPrecedingSwaggerByType(
      targetSwaggerPath,
      availableSwaggers,
      API_VERSION_LIFECYCLE_STAGES.STABLE,
    ),
  };
}
