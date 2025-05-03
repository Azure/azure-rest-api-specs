// @ts-check

import $RefParser from "@apidevtools/json-schema-ref-parser";
import { readdir, readFile } from "fs/promises";
import * as yaml from "js-yaml";
import { marked } from "marked";
import { dirname, normalize, relative, resolve } from "path";
import { mapAsync } from "./array.js";
import { resolveCheckAccess } from "./fs.js";

/**
 * @typedef {Object} ToJSONOptions
 * @prop {boolean} [includeRefs]
 * @prop {boolean} [relativePaths]
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
    this.#folder = resolveCheckAccess(folder);
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
    const swaggerPathResolved = resolveCheckAccess(swaggerPath);

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
    const swaggerPathResolved = resolveCheckAccess(swaggerPath);

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
        readmePaths.map((p) => new Readme(this, p, { logger: this.#logger })),
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
    return `SpecModel(${this.#folder}, {logger: ${this.#logger}})`;
  }
}

export class Readme {
  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {{globalConfig: Object, tags: Set<Tag>} | undefined} */
  #data;

  /** @type {string} absolute path */
  #path;

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
   * @param {string} swaggerPath
   * @param {import('./logger.js').ILogger} [logger]
   * @returns {string}
   */
  static #normalizeSwaggerPath(swaggerPath, logger) {
    let swaggerPathNormalized = swaggerPath;
    // Ignore uses of "$(this-folder)" in the swagger path. It refers to the
    // current folder anyway and can be substituted with "."
    if (swaggerPath.includes("$(this-folder)")) {
      swaggerPathNormalized = swaggerPath.replaceAll("$(this-folder)", ".");
    }

    // Some swagger paths contain backslashes. These should be normalized when
    // encountered though the expected format for input-files is forward slashes.
    if (swaggerPathNormalized.includes("\\")) {
      logger?.info(
        `Found backslash (\\) in swagger path ${swaggerPath}. Replacing with forward slash (/)`,
      );
      swaggerPathNormalized = swaggerPathNormalized.replaceAll("\\", "/");
    }

    return normalize(swaggerPathNormalized);
  }

  async #getData() {
    if (!this.#data) {
      const content = await readFile(this.#path, {
        encoding: "utf8",
      });

      const tokens = marked.lexer(content);

      /** @type import("marked").Tokens.Code[] */
      const yamlBlocks = tokens
        .filter((token) => token.type === "code")
        .map((token) => /** @type import("marked").Tokens.Code */ (token))
        // Include default block and tagged blocks (```yaml $(tag) == 'package-2021-11-01')
        .filter((token) => token.lang?.toLowerCase().startsWith("yaml"));

      const globalConfigYamlBlocks = yamlBlocks.filter(
        (token) => token.lang === "yaml",
      );

      const globalConfig = globalConfigYamlBlocks.reduce(
        (obj, token) =>
          Object.assign(
            obj,
            yaml.load(token.text, { schema: yaml.FAILSAFE_SCHEMA }),
          ),
        {},
      );

      /** @type {Set<Tag>} */
      const tags = new Set();
      for (const block of yamlBlocks) {
        const tagName =
          block.lang?.match(/yaml.*\$\(tag\) ?== ?'([^']*)'/)?.[1] || "default";

        if (tagName === "default" || tagName === "all-api-versions") {
          // Skip yaml blocks where this is no tag or tag is all-api-versions
          continue;
        }

        const obj = /** @type {any} */ (
          yaml.load(block.text, { schema: yaml.FAILSAFE_SCHEMA })
        );

        if (!obj) {
          this.#logger?.debug(
            `No yaml object found for tag ${tagName} in ${this.#path}`,
          );
          continue;
        }

        if (!obj["input-file"]) {
          // The yaml block does not contain an input-file key
          continue;
        }

        // This heuristic assumes that a previous definition of the tag with no
        // swaggers means that the previous definition did not have an input-file
        // key. It's possible that the previous defintion had an `input-file: []`
        // or something like it.
        const existingTag = [...tags].find((t) => t.name == tagName);
        if ((existingTag?.inputFiles?.size ?? 0) > 0) {
          // The tag already exists and has a swagger file. This is an error as
          // there should only be one definition of input-files per tag.
          const message = `Multiple input-file definitions for tag ${tagName} in ${this.#path}`;
          this.#logger?.error(message);
          throw new Error(message);
        }

        /** @type {Set<Swagger>} */
        const inputFiles = new Set();

        // It's possible for input-file to be a string or an array
        const inputFilePaths = Array.isArray(obj["input-file"])
          ? obj["input-file"]
          : [obj["input-file"]];
        for (const swaggerPath of inputFilePaths) {
          const swaggerPathNormalized =
            Readme.#normalizeSwaggerPath(swaggerPath);
          const swaggerPathResolved = resolve(
            dirname(this.#path),
            swaggerPathNormalized,
          );
          const swagger = new Swagger(this.#specModel, swaggerPathResolved, {
            logger: this.#logger,
          });
          inputFiles.add(swagger);
        }

        const tag = new Tag(tagName, inputFiles, { logger: this.#logger });

        tags.add(tag);
      }

      this.#data = { globalConfig, tags };
    }

    return this.#data;
  }

  /**
   * @returns {Promise<Object>}
   */
  async getGlobalConfig() {
    return (await this.#getData()).globalConfig;
  }

  async getTags() {
    return (await this.#getData()).tags;
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
    const tags = await mapAsync(
      [...(await this.getTags())].sort((a, b) => a.name.localeCompare(b.name)),
      async (t) => await t.toJSONAsync(options),
    );

    return {
      path: options?.relativePaths
        ? relative(this.#specModel.folder, this.#path)
        : this.#path,
      globalConfig: await this.getGlobalConfig(),
      tags,
    };
  }

  /**
   * @returns {string}
   */
  toString() {
    return `Readme
    (${this.#path}, {logger: ${this.#logger}})`;
  }
}

export class Tag {
  /** @type {Set<Swagger>} */
  #inputFiles;

  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {string} */
  #name;

  /**
   * @param {string} name
   * @param {Set<Swagger>} inputFiles
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   */
  constructor(name, inputFiles, options) {
    this.#name = name;
    this.#inputFiles = inputFiles;
    this.#logger = options?.logger;
  }

  /**
   * @returns {Set<Swagger>}
   */
  get inputFiles() {
    return this.#inputFiles;
  }

  /**
   * @returns {string}
   */
  get name() {
    return this.#name;
  }

  /**
   * @param {ToJSONOptions} [options]
   * @returns {Promise<Object>}
   */
  async toJSONAsync(options) {
    return {
      name: this.#name,
      inputFiles: await mapAsync(
        [...this.#inputFiles].sort(),
        async (s) => await s.toJSONAsync(options),
      ),
    };
  }

  toString() {
    return `Tag(${this.#name}, ${this.#inputFiles}, {logger: ${this.#logger}})`;
  }
}

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

/**
 * @param {string} [file]
 * @returns {boolean}
 */
function readme(file) {
  // Filename "readme.md" with any case is a valid README file
  return typeof file === "string" && file.toLowerCase().endsWith("readme.md");
}
