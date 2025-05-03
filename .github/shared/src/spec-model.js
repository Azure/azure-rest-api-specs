// @ts-check

import { readdir } from "fs/promises";
import { resolve } from "path";
import { mapAsync } from "./array.js";
import { Readme } from "./readme.js";

/**
 * @typedef {Object} ToJSONOptions
 * @prop {boolean} [includeRefs]
 * @prop {boolean} [relativePaths]
 *
 * @typedef {import('./swagger.js').Swagger} Swagger
 * @typedef {import('./tag.js').Tag} Tag
 */

export class SpecModel {
  /** @type {string} absolute path */
  #folder;

  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {Set<Readme> | undefined} */
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
   * @param {string} swaggerPath
   * @returns {Promise<Map<Readme, Set<Tag>>>}
   */
  async getAffectedReadmeTags(swaggerPath) {
    const swaggerPathResolved = resolve(swaggerPath);

    /** @type {Map<Readme, Set<Tag>>} */
    const affectedReadmeTags = new Map();

    for (const readme of await this.getReadmes()) {
      for (const tag of await readme.getTags()) {
        for (const inputFile of tag.inputFiles) {
          if (inputFile.path === swaggerPathResolved) {
            /** @type {Set<Tag>} */
            const tags = affectedReadmeTags.get(readme) ?? new Set();
            tags.add(tag);
            affectedReadmeTags.set(readme, tags);

            // No need to check refs if the swagger file is directly referenced
            continue;
          }

          const refs = await inputFile.getRefs();
          if ([...refs].find((r) => r.path === swaggerPathResolved)) {
            /** @type {Set<Tag>} */
            const tags = affectedReadmeTags.get(readme) ?? new Set();
            tags.add(tag);
            affectedReadmeTags.set(readme, tags);
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
   * @returns {Promise<Set<Swagger>>}
   */
  async getAffectedSwaggers(swaggerPath) {
    const swaggerPathResolved = resolve(swaggerPath);

    // Use Map instead of Set, to ensure exactly one Swagger object per path is returned
    // SpecModel can include multiple Swagger objects pointing to the same path
    /** @type {Map<string, Swagger>} */
    const affectedSwaggers = new Map();

    for (const readme of await this.getReadmes()) {
      for (const tag of await readme.getTags()) {
        for (const swagger of tag.inputFiles) {
          // readme.md includes swaggerPath
          if (swagger.path === swaggerPathResolved) {
            affectedSwaggers.set(swagger.path, swagger);
          }

          const refs = await swagger.getRefs();

          // readme.md includes a.json
          //   a.json references swaggerPath
          const refToSwaggerPath = [...refs].find(
            (ref) => ref.path === swaggerPathResolved,
          );
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
          for (const ref of refs) {
            const refRefs = await ref.getRefs();
            const refRefToSwaggerPath = [...refRefs].find(
              (ref) => ref.path === swaggerPathResolved,
            );
            if (refRefToSwaggerPath) {
              // Add the Swagger object for swaggerPath
              affectedSwaggers.set(
                refRefToSwaggerPath.path,
                refRefToSwaggerPath,
              );

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
      throw new Error(
        `No affected swaggers found in specModel for ${swaggerPath}`,
      );
    }

    return new Set(affectedSwaggers.values());
  }

  /**
   * @returns {Promise<Set<Readme>>}
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

      this.#readmes = new Set(
        readmePaths.map(
          (p) => new Readme(p, { logger: this.#logger, specModel: this }),
        ),
      );
    }

    return this.#readmes;
  }

  /**
   * @param {ToJSONOptions} [options]
   * @returns {Promise<Object>}
   */
  async toJSONAsync(options) {
    const readmes = await mapAsync(
      [...(await this.getReadmes())].sort((a, b) =>
        a.path.localeCompare(b.path),
      ),
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
