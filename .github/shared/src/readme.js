// @ts-check

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { marked } from "marked";
import { dirname, normalize, relative, resolve } from "path";
import { mapAsync } from "./array.js";
import { Swagger } from "./swagger.js";
import { Tag } from "./tag.js";

/**
 * @typedef {import('./spec-model.js').SpecModel} SpecModel
 * @typedef {import('./spec-model.js').ToJSONOptions} ToJSONOptions
 */

export class Readme {
  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /** @type {{globalConfig: Object, tags: Set<Tag>} | undefined} */
  #data;

  /** @type {string} absolute path */
  #path;

  /** @type {SpecModel | undefined} backpointer to owning SpecModel */
  #specModel;

  /**
   * @param {string} path
   * @param {Object} [options]
   * @param {import('./logger.js').ILogger} [options.logger]
   * @param {SpecModel} [options.specModel]
   */
  constructor(path, options) {
    this.#path = resolve(path);
    this.#logger = options?.logger;
    this.#specModel = options?.specModel;
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
      /* v8 ignore next */
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
          const swagger = new Swagger(swaggerPathResolved, {
            logger: this.#logger,
            specModel: this.#specModel,
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
      path:
        options?.relativePaths && this.#specModel
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
    return `Readme(${this.#path}, {logger: ${this.#logger}})`;
  }
}

/**
 * @param {string} markdown
 * @param {Object} [options]
 * @param {import('./logger.js').ILogger} [options.logger]
 * @returns {Promise<Set<string>>} All input files for all tags
 */
export async function getInputFiles(markdown, options = {}) {
  const { logger } = options;

  const tokens = marked.lexer(markdown);

  const yamlBlocks = tokens
    .filter((token) => token.type === "code")
    .map((token) => /** @type import("marked").Tokens.Code */ (token))
    // Include default block and tagged blocks (```yaml $(tag) == 'package-2021-11-01')
    .filter((token) => token.lang?.toLowerCase().startsWith("yaml"));

  const inputFiles = yamlBlocks.flatMap((block) => {
    const tag =
      block.lang?.match(/yaml \$\(tag\) == '([^']*)'/)?.[1] || "default";

    const obj = /** @type {any} */ (yaml.load(block.text));
    const blockFiles = /** @type string[] */ (obj["input-file"] || []);

    /* v8 ignore next */
    logger?.info(`Input files for tag '${tag}': ${JSON.stringify(blockFiles)}`);

    return blockFiles;
  });

  return new Set(inputFiles);
}
