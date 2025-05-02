// @ts-check

import $RefParser from "@apidevtools/json-schema-ref-parser";
import { readdir, readFile } from "fs/promises";
import * as yaml from "js-yaml";
import { marked } from "marked";
import { dirname, join, normalize, relative, resolve } from "path";
import { simpleGit } from "simple-git";
import { mapAsync } from "./array.js";
import { example, readme } from "./changed-files.js";
import { resolveCheckAccess } from "./fs.js";

export class SpecModel2 {
  /** @type {string} absolute path */
  #folder;

  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {Set<Readme2> | undefined} */
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
   * @returns {Promise<Set<Readme2>>}
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
        readmePaths.map((p) => new Readme2(p, { logger: this.#logger })),
      );
    }

    return this.#readmes;
  }

  /**
   * @returns {string}
   */
  toString() {
    return `SpecModel2(${this.#folder}, {logger: ${this.#logger}})`;
  }
}

export class Readme2 {
  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {{globalConfig: Object, tags: Set<Tag2>} | undefined} */
  #data;

  /** @type {string} absolute path */
  #path;

  /**
   * @param {string} path
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   */
  constructor(path, options) {
    this.#path = resolveCheckAccess(path);
    this.#logger = options?.logger;
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

      /** @type {Set<Tag2>} */
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

        /** @type {Set<Swagger2>} */
        const inputFiles = new Set();

        // It's possible for input-file to be a string or an array
        const inputFilePaths = Array.isArray(obj["input-file"])
          ? obj["input-file"]
          : [obj["input-file"]];
        for (const swaggerPath of inputFilePaths) {
          const swaggerPathNormalized = normalizeSwaggerPath(swaggerPath);
          const swaggerPathResolved = resolve(
            dirname(this.#path),
            swaggerPathNormalized,
          );
          const swagger = new Swagger2(swaggerPathResolved, {
            logger: this.#logger,
          });
          inputFiles.add(swagger);
        }

        const tag = new Tag2(tagName, inputFiles, { logger: this.#logger });

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
   * @returns {string}
   */
  toString() {
    return `Readme2(${this.#path}, {logger: ${this.#logger}})`;
  }
}

export class Tag2 {
  /** @type {Set<Swagger2>} */
  #inputFiles;

  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {string} */
  #name;

  /**
   * @param {string} name
   * @param {Set<Swagger2>} inputFiles
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   */
  constructor(name, inputFiles, options) {
    this.#name = name;
    this.#inputFiles = inputFiles;
    this.#logger = options?.logger;
  }

  /**
   * @returns {Set<Swagger2>}
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

  toString() {
    return `Tag2(${this.#name}, ${this.#inputFiles}, {logger: ${this.#logger}})`;
  }
}

export class Swagger2 {
  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {string} absolute path */
  #path;

  /**
   * @param {string} path
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   */
  constructor(path, options) {
    this.#path = resolveCheckAccess(path);
    this.#logger = options?.logger;
  }

  /**
   * @returns {string} absolute path
   */
  get path() {
    return this.#path;
  }

  toString() {
    return `Swagger2(${this.#path}, {logger: ${this.#logger}})`;
  }
}

/**
 * @typedef {Object} SpecModel
 * @prop {string} repoRoot
 * @prop {string} folder
 * @prop {Object<string, Readme>} readmes
 */

/**
 * @typedef {Object} Readme
 * @prop {Object} globalConfig
 * @prop {Object<string, Tag>} tags
 */

/**
 * @typedef {Object} Tag
 * @prop {Object<string, Swagger>} inputFiles
 */

/**
 * @typedef {Object} Swagger
 * @prop {Object<string, string[]>} refs
 */

/**
 * @param {string} folder
 * @param {Object} [options]
 * @param {import('./logger.js').ILogger} [options.logger]
 * @returns {Promise<SpecModel>} All input files for all tags
 */
export async function getSpecModel(folder, options = {}) {
  const { logger } = options;

  const repoRoot = await simpleGit(folder).revparse("--show-toplevel");
  const folderRelative = relative(repoRoot, folder);

  logger?.debug(
    `getSpecModel: ${folder}, repoRoot: ${repoRoot}, folderRelative: ${folderRelative}, options: ${JSON.stringify(options)}`,
  );

  const filesRelative = await readdir(folder, {
    recursive: true,
  });
  const readmesRelative = filesRelative.filter(readme);
  logger?.debug(`Found ${readmesRelative.length} readme files`);

  return {
    repoRoot,
    folder: folderRelative,
    readmes: Object.fromEntries(
      await mapAsync(readmesRelative, async (readmeRelative) => {
        return [
          readmeRelative,
          await getReadme(readmeRelative, repoRoot, folderRelative, logger),
        ];
      }),
    ),
  };
}

/**
 * @param {string} readmePath
 * @param {string} repoRoot
 * @param {string} folderRelative
 * @param {import('./logger.js').ILogger} [logger]
 * @returns {Promise<Readme>}
 */
async function getReadme(readmePath, repoRoot, folderRelative, logger) {
  logger?.debug(`getReadme(${readmePath}, ${repoRoot}, ${folderRelative})`);

  const content = await readFile(join(repoRoot, folderRelative, readmePath), {
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

  /** @type {Object<string, Tag>} */
  const tags = {};
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
      logger?.debug(`No yaml object found for tag ${tagName} in ${readmePath}`);
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
    if (
      tags[tagName]?.inputFiles &&
      Object.entries(tags[tagName]?.inputFiles).length > 0
    ) {
      // The tag already exists and has a swagger file. This is an error as
      // there should only be one definition of input-files per tag.
      const message = `Multiple input-file definitions for tag ${tagName} in ${readmePath}`;
      logger?.error(message);
      throw new Error(message);
    }

    /** @type Tag */
    const tag = { inputFiles: {} };

    // It's possible for input-file to be a string or an array
    const inputFiles = Array.isArray(obj["input-file"])
      ? obj["input-file"]
      : [obj["input-file"]];
    for (const swaggerPath of inputFiles) {
      const swaggerPathNormalized = normalizeSwaggerPath(swaggerPath);
      const swagger = await getSwagger(
        swaggerPathNormalized,
        repoRoot,
        folderRelative,
        dirname(readmePath),
        logger,
      );
      tag.inputFiles[swaggerPathNormalized] = swagger;
    }

    tags[tagName] = tag;
  }

  const readme = {
    globalConfig,
    tags,
  };

  return readme;
}

/**
 * @param {string} swaggerPath
 * @param {import('./logger.js').ILogger} [logger]
 * @returns {string}
 */
function normalizeSwaggerPath(swaggerPath, logger) {
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

/**
 * @param {string} swaggerPath
 * @param {string} repoRoot
 * @param {string} folderRelative
 * @param {string} readmeFolderRelative
 * @param {import('./logger.js').ILogger} [logger]
 * @returns {Promise<Swagger>}
 */
async function getSwagger(
  swaggerPath,
  repoRoot,
  folderRelative,
  readmeFolderRelative,
  logger,
) {
  logger?.debug(
    `getSwagger(${swaggerPath}, ${repoRoot}, ${folderRelative}, ${readmeFolderRelative})`,
  );

  return {
    refs: await getExternalFileRefs(
      swaggerPath,
      repoRoot,
      folderRelative,
      readmeFolderRelative,
    ),
  };
}

/**
 * Reads all levels of external file references in a swagger file and returns a
 * map where the key is the referenced swagger file and the value is a set of
 * all references that the file depends on, including transitive dependencies.
 * @param {string} swaggerPath,
 * @param {string} repoRoot
 * @param {string} folderRelative
 * @param {string} readmeFolderRelative
 * @returns {Promise<Object<string, string[]>>}
 */
async function getExternalFileRefs(
  swaggerPath,
  repoRoot,
  folderRelative,
  readmeFolderRelative,
) {
  const initialSwagger = swaggerPath;
  const visited = new Set();
  const toVisit = new Set([initialSwagger]);

  /** @type {Object<string, Set<string>>} */
  const externalFileRefs = {};

  while (toVisit.size > 0) {
    const currentSwagger = /** @type {string} */ (
      toVisit.values().next().value
    );

    toVisit.delete(currentSwagger);
    visited.add(currentSwagger);

    const currentSchema = await $RefParser.resolve(
      join(repoRoot, folderRelative, readmeFolderRelative, currentSwagger),
      { resolve: { http: false } },
    );
    const currentRefs = currentSchema
      .paths("file")
      .map((p) =>
        relative(join(repoRoot, folderRelative, readmeFolderRelative), p),
      )
      .filter((p) => !visited.has(p) && !example(p));

    // Add the ref to the dependency map for the current path
    if (currentSwagger !== initialSwagger) {
      if (
        !externalFileRefs[relative(dirname(initialSwagger), currentSwagger)]
      ) {
        externalFileRefs[relative(dirname(initialSwagger), currentSwagger)] =
          new Set();
      }
    }

    for (const ref of currentRefs) {
      if (currentSwagger !== initialSwagger) {
        externalFileRefs[relative(dirname(initialSwagger), currentSwagger)].add(
          relative(dirname(currentSwagger), ref),
        );
      }

      if (!visited.has(ref)) {
        toVisit.add(ref);
      }
    }
  }

  return Object.fromEntries(
    Object.entries(externalFileRefs).map((e) => [e[0], Array.from(e[1])]),
  );
}

/**
 * Given a swagger file, return the readme files and tags that reference that
 * swagger file.
 * @param {string} swaggerFile
 * @param {SpecModel} specModel
 * @returns {Object<string, string[]>}
 */
export function getAffectedReadmeTags(swaggerFile, specModel) {
  const swaggerFileResolved = resolve(swaggerFile);

  /** @type Object<string, Set<string>> */
  const affectedReadmes = {};

  for (const [readmePath, readme] of Object.entries(specModel.readmes)) {
    const readmePathResolved = resolve(
      specModel.repoRoot,
      specModel.folder,
      readmePath,
    );
    const readmePathRelative = relative(specModel.repoRoot, readmePathResolved);

    for (const [tagName, tag] of Object.entries(readme.tags)) {
      for (const [inputFile, swagger] of Object.entries(tag.inputFiles)) {
        const inputFileResolved = resolve(
          dirname(readmePathResolved),
          inputFile,
        );
        if (inputFileResolved === swaggerFileResolved) {
          if (!affectedReadmes[readmePathRelative]) {
            affectedReadmes[readmePathRelative] = new Set();
          }
          affectedReadmes[readmePathRelative].add(tagName);
          // No need to check refs if the swagger file is directly referenced
          continue;
        }

        // Because refs contains the full set of transitive dependencies, only
        // check if the swagger file is in the map keys.
        if (
          Object.keys(swagger.refs)
            .map((ref) => resolve(dirname(inputFileResolved), ref))
            .includes(swaggerFileResolved)
        ) {
          if (!affectedReadmes[readmePathRelative]) {
            affectedReadmes[readmePathRelative] = new Set();
          }
          affectedReadmes[readmePathRelative].add(tagName);
        }
      }
    }
  }
  return Object.fromEntries(
    Object.entries(affectedReadmes).map((e) => [e[0], Array.from(e[1])]),
  );
}

/**
 * Given a swagger file, return the swagger files that are affected by the
 * changes in the given swagger file.
 * @param {string} swaggerFile
 * @param {SpecModel} specModel
 * @returns {string[]}
 */
export function getAffectedSwaggers(swaggerFile, specModel) {
  const swaggerFileResolved = resolve(swaggerFile);
  const swaggerFileRelative = relative(specModel.repoRoot, swaggerFileResolved);

  /** @type {Set<string>} */
  const affectedSwaggers = new Set();

  for (const [readmePath, readme] of Object.entries(specModel.readmes)) {
    const readmePathResolved = resolve(
      specModel.repoRoot,
      specModel.folder,
      readmePath,
    );

    for (const [, tag] of Object.entries(readme.tags)) {
      for (const [inputFile, swagger] of Object.entries(tag.inputFiles)) {
        const inputFileResolved = resolve(
          dirname(readmePathResolved),
          inputFile,
        );
        const inputFileRelative = relative(
          specModel.repoRoot,
          inputFileResolved,
        );

        // The readme.md file directly references the given swaggerFile
        if (inputFileResolved === swaggerFileResolved) {
          affectedSwaggers.add(swaggerFileRelative);
        }

        // Some swagger file has a ref to the given swaggerFile.
        if (
          Object.keys(swagger.refs)
            .map((ref) => resolve(dirname(inputFileResolved), ref))
            .includes(swaggerFileResolved)
        ) {
          affectedSwaggers.add(swaggerFileRelative);
          affectedSwaggers.add(inputFileRelative);
        }

        // Check the swagger file's refs and add any which depend on the given
        // swaggerFile.
        // For example "->" means "depends on", given:
        // Tag 1 directly references a with a relationship of:
        // a -> b -> c
        // If c is changed, then a and b are affected, but since b is not
        // directly referenced in the readme, it can only be discovered by
        // evaluating a's dependencies.
        for (const [ref, dependsOn] of Object.entries(swagger.refs)) {
          const refResolved = resolve(dirname(inputFileResolved), ref);
          const refRelative = relative(specModel.repoRoot, refResolved);
          if (
            dependsOn
              .map((dep) => resolve(dirname(refResolved), dep))
              .includes(swaggerFileResolved)
          ) {
            affectedSwaggers.add(swaggerFileRelative);
            affectedSwaggers.add(refRelative);
          }
        }
      }
    }
  }

  // The swagger file supplied does not exist in the given specModel
  if (affectedSwaggers.size === 0) {
    throw new Error(
      `No affected swaggers found in specModel for ${swaggerFile}`,
    );
  }

  return Array.from(affectedSwaggers);
}
