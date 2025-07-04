// @ts-check

import { readdir } from "fs/promises";
import { resolve } from "path";
import { flatMapAsync, mapAsync } from "./array.js";
import { Readme } from "./readme.js";
import { API_VERSION_LIFECYCLE_STAGES } from "./swagger.js";

/**
 * @typedef {Object} ToJSONOptions
 * @prop {boolean} [includeRefs]
 * @prop {boolean} [relativePaths]
 *
 * @typedef {import('./swagger.js').Swagger} Swagger
 * @typedef {import('./tag.js').Tag} Tag
 *
 * @typedef {Object} Operation
 * @property {string} id - The operation ID
 * @property {string} path - API path
 * @property {string} httpMethod - HTTP method (GET, POST, etc.)
 *
 */

export class SpecModel {
  /** @type {string} absolute path */
  #folder;

  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {Map<string, Readme> | undefined} */
  #readmes;

  /**
   * @param {string} folder
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   */
  constructor(folder, options) {
    this.#folder = resolve(folder);
    this.#logger = options?.logger;
  }

  /**
   * @returns {string} absolute path
   */
  get folder() {
    return this.#folder;
  }

  /**
   * Given a swagger file, return all the tags inside readme files that reference the file (directly or indirectly).
   * @param {string} swaggerPath
   * @returns {Promise<Map<string, Map<string, Tag>>>} map of readme paths to (map of tag names to Tag objects)
   */
  async getAffectedReadmeTags(swaggerPath) {
    const swaggerPathResolved = resolve(swaggerPath);

    /** @type {Map<string, Map<string, Tag>>} */
    const affectedReadmeTags = new Map();

    for (const readme of (await this.getReadmes()).values()) {
      for (const tag of (await readme.getTags()).values()) {
        for (const inputFile of tag.inputFiles.values()) {
          if (inputFile.path === swaggerPathResolved) {
            /** @type {Map<string, Tag>} */
            const tags = affectedReadmeTags.get(readme.path) ?? new Map();
            tags.set(tag.name, tag);
            affectedReadmeTags.set(readme.path, tags);

            // No need to check refs if the swagger file is directly referenced
            continue;
          }

          const refs = await inputFile.getRefs();
          if (refs.get(swaggerPathResolved)) {
            /** @type {Map<string, Tag>} */
            const tags = affectedReadmeTags.get(readme.path) ?? new Map();
            tags.set(tag.name, tag);
            affectedReadmeTags.set(readme.path, tags);
          }
        }
      }
    }

    return affectedReadmeTags;
  }

  /**
   * Given a swagger file, return the swagger files that are affected by the
   * changes in the given swagger file.
   * @param {string} swaggerPath
   * @returns {Promise<Map<string, Swagger>>} map of swagger paths to Swagger objects
   */
  async getAffectedSwaggers(swaggerPath) {
    const swaggerPathResolved = resolve(swaggerPath);

    /** @type {Map<string, Swagger>} */
    const affectedSwaggers = new Map();

    for (const readme of (await this.getReadmes()).values()) {
      for (const tag of (await readme.getTags()).values()) {
        for (const swagger of tag.inputFiles.values()) {
          // readme.md includes swaggerPath
          if (swagger.path === swaggerPathResolved) {
            affectedSwaggers.set(swagger.path, swagger);
          }

          const refs = await swagger.getRefs();

          // readme.md includes a.json
          //   a.json references swaggerPath
          const refToSwaggerPath = refs.get(swaggerPathResolved);
          if (refToSwaggerPath) {
            // Add the Swagger object for swaggerPath
            affectedSwaggers.set(refToSwaggerPath.path, refToSwaggerPath);

            // Add the Swagger object that references swaggerPath
            //
            // Example: a.json
            affectedSwaggers.set(swagger.path, swagger);
          }

          // readme.md includes a.json
          //   a.json references b.json
          //     b.json references swaggerPath
          for (const ref of refs.values()) {
            const refRefs = await ref.getRefs();
            const refRefToSwaggerPath = refRefs.get(swaggerPathResolved);
            if (refRefToSwaggerPath) {
              // Add the Swagger object for swaggerPath
              affectedSwaggers.set(refRefToSwaggerPath.path, refRefToSwaggerPath);

              // Add the Swagger object that references swaggerPath
              //
              // Example: b.json
              affectedSwaggers.set(ref.path, ref);

              // Add the Swagger object that references the Swagger object
              // that references swaggerPath
              //
              // Example: a.json
              //
              // Note: This may not be strictly necessary, since getRefs() includes
              // transitive references, so "a.json" should have already been added
              // above.  However, it's safer to add it, in case somehow it wasn't added
              // earlier, since we know it's in the dependency chain.
              affectedSwaggers.set(swagger.path, swagger);
            }
          }
        }
      }
    }

    // The swagger file supplied does not exist in the given specModel
    if (affectedSwaggers.size === 0) {
      throw new Error(`No affected swaggers found in specModel for ${swaggerPath}`);
    }

    return affectedSwaggers;
  }

  /**
   * @returns {Promise<Map<string, Readme>>} map of readme paths to readme Objects
   */
  async getReadmes() {
    if (!this.#readmes) {
      const files = await readdir(this.#folder, {
        recursive: true,
      });

      const readmePaths = files
        // filter before resolve to (slightly) improve perf, since filter only needs filename
        .filter(readme)
        .map((p) => resolve(this.#folder, p));

      this.#logger?.debug(`Found ${readmePaths.length} readme files`);

      this.#readmes = new Map(
        readmePaths.map((p) => {
          const readme = new Readme(p, {
            logger: this.#logger,
            specModel: this,
          });
          return [readme.path, readme];
        }),
      );
    }

    return this.#readmes;
  }

  async getSwaggers() {
    const readmes = [...(await this.getReadmes()).values()];
    const tags = await flatMapAsync(readmes, async (r) => [...(await r.getTags()).values()]);
    const swaggers = tags.flatMap((t) => [...t.inputFiles.values()]);
    return swaggers;
  }

  /**
   * @param {ToJSONOptions} [options]
   * @returns {Promise<Object>}
   */
  async toJSONAsync(options) {
    const readmes = await mapAsync(
      [...(await this.getReadmes()).values()].sort((a, b) => a.path.localeCompare(b.path)),
      async (r) => await r.toJSONAsync(options),
    );

    return {
      folder: this.#folder,
      readmes,
    };
  }

  /**
   * @returns {string}
   */
  toString() {
    return `SpecModel(${this.#folder}, {logger: ${this.#logger}}})`;
  }
}

// TODO: Remove duplication with changed-files.js (which currently requires paths relative to repo root)

/**
 * @param {string} [file]
 * @returns {boolean}
 */
function readme(file) {
  // Filename "readme.md" with any case is a valid README file
  return typeof file === "string" && file.toLowerCase().endsWith("readme.md");
}

/**
 * Get preceding swagger version for a specific lifecycle stage
 * @param {string} targetSwaggerPath - Path to the swagger file to find predecessors for
 * @param {Swagger[]} availableSwaggers - Array of swagger objects to search within
 * @param {string} versionKind - Version lifecycle stage (PREVIEW or STABLE)
 * @returns {Promise<string | undefined>} - Path to preceding version or undefined if not found
 */
async function getPrecedingSwaggerByType(targetSwaggerPath, availableSwaggers, versionKind) {
  const targetSwagger = availableSwaggers.find((s) => s.path === targetSwaggerPath);
  if (!targetSwagger) {
    return undefined;
  }

  const currentVersion = await targetSwagger.getVersion();
  const fileName = await targetSwagger.getFileName();

  try {
    // Load version info for all swaggers to enable filtering
    const swaggersWithVersions = await Promise.all(
      availableSwaggers.map(async (swagger) => ({
        swagger,
        version: await swagger.getVersion(),
        fileName: await swagger.getFileName(),
        versionKind: swagger.versionKind,
      })),
    );

    const versionsOfType = swaggersWithVersions.filter(
      (item) =>
        item.fileName === fileName &&
        item.versionKind === versionKind &&
        item.version <= currentVersion &&
        item.swagger.path !== targetSwaggerPath,
    );

    if (versionsOfType.length > 0) {
      const mostRecent = versionsOfType.reduce((previous, current) =>
        previous.version > current.version ? previous : current,
      );
      return mostRecent.swagger.path;
    }
  } catch {
    // Version not found or error occurred
  }

  return undefined;
}

/**
 * Get operations from all previous versions that also exist in current swagger
 * @param {string} targetSwaggerPath - Path to the current swagger file
 * @param {Swagger[]} availableSwaggers - Array of swagger objects to search within
 * @returns {Promise<Map<string, Operation[]>>} - Operations that exist in previous or current versions(but not same swagger)
 */
export async function getExistedVersionOperations(targetSwaggerPath, availableSwaggers) {
  /** @type {Map<string, Operation[]>} */
  let result = new Map();

  const targetSwagger = availableSwaggers.find((s) => s.path === targetSwaggerPath);
  if (!targetSwagger) {
    return result;
  }

  const fileName = await targetSwagger.getFileName();
  const currentVersion = await targetSwagger.getVersion();

  // Get operations from current swagger file
  const currentOperationsMap = await targetSwagger.getOperations();
  const currentOperations = Array.from(currentOperationsMap.values());

  // Load version info for all swaggers to enable filtering
  const swaggersWithVersions = await Promise.all(
    availableSwaggers.map(async (swagger) => ({
      swagger,
      version: await swagger.getVersion(),
      fileName: await swagger.getFileName(),
    })),
  );

  // Get all current and previous versions of the swaggers with different fileNames
  const previousVersionSwaggers = swaggersWithVersions
    .filter((item) => item.fileName !== fileName && item.version <= currentVersion)
    .sort((a, b) => a.version.localeCompare(b.version))
    .map((item) => item.swagger);

  // Collect operations from all previous versions that also exist in current version
  for (const previousSwagger of previousVersionSwaggers) {
    try {
      const previousOperationsMap = await previousSwagger.getOperations();
      const previousOperations = Array.from(previousOperationsMap.values());

      // Find operations that exist in both this previous version AND current version
      const matchingOperations = previousOperations.filter((operation) => {
        return currentOperations.some(
          (currentOp) =>
            currentOp.path === operation.path &&
            currentOp.id === operation.id &&
            currentOp.httpMethod === operation.httpMethod,
        );
      });
      result.set(previousSwagger.path, matchingOperations);
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
 * @returns {Promise<{preview?: string, stable?: string}>} - Paths to preceding versions
 */
export async function getPrecedingSwaggers(targetSwaggerPath, availableSwaggers) {
  return {
    preview: await getPrecedingSwaggerByType(
      targetSwaggerPath,
      availableSwaggers,
      API_VERSION_LIFECYCLE_STAGES.PREVIEW,
    ),
    stable: await getPrecedingSwaggerByType(
      targetSwaggerPath,
      availableSwaggers,
      API_VERSION_LIFECYCLE_STAGES.STABLE,
    ),
  };
}
