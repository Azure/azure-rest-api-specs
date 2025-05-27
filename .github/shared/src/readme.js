// @ts-check

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { marked } from "marked";
import { dirname, normalize, relative, resolve } from "path";
import { mapAsync } from "./array.js";
import { Tag } from "./tag.js";

/**
 * @typedef {import('./spec-model.js').SpecModel} SpecModel
 * @typedef {import('./spec-model.js').ToJSONOptions} ToJSONOptions
 */

export class Readme {
  /**
   * Content of `readme.md`, either loaded from `#path` or passed in via `options`.
   *
   * Reset to `undefined` after `#data` is loaded to save memory.
   *
   * @type {string | undefined}
   */
  #content;

  /** @type {{globalConfig: Object, tags: Map<string, Tag>} | undefined} */
  #data;

  /** @type {import('./logger.js').ILogger | undefined} */
  #logger;

  /**
   * absolute path
   * @type {string}
   * */
  #path;

  /**
   * SpecModel that contains this Readme
   * @type {SpecModel | undefined}
   */
  #specModel;

  /**
   * @param {string} path Used for content, unless options.content is specified
   * @param {Object} [options]
   * @param {string} [options.content] If specified, is used instead of reading path from disk
   * @param {import('./logger.js').ILogger} [options.logger]
   * @param {SpecModel} [options.specModel]
   */
  constructor(path, options) {
    this.#path = resolve(options?.specModel?.folder ?? "", path);

    this.#content = options?.content;
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
      // Only read file if #content is exactly undefined, to allow setting #content to empty string
      // to simulate an empty file
      if (this.#content === undefined) {
        this.#content = await readFile(this.#path, {
          encoding: "utf8",
        });
      }

      const tokens = marked.lexer(this.#content);

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

      /** @type {Map<string, Tag>} */
      const tags = new Map();
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
        const existingTag = tags.get(tagName);
        if ((existingTag?.inputFiles?.size ?? 0) > 0) {
          // The tag already exists and has a swagger file. This is an error as
          // there should only be one definition of input-files per tag.
          const message = `Multiple input-file definitions for tag ${tagName} in ${this.#path}`;
          this.#logger?.error(message);
          throw new Error(message);
        }

        // It's possible for input-file to be a string or an array
        const inputFilePaths = Array.isArray(obj["input-file"])
          ? obj["input-file"]
          : [obj["input-file"]];

        const swaggerPathsResolved = inputFilePaths
          .map((p) => Readme.#normalizeSwaggerPath(p))
          .map((p) => resolve(dirname(this.#path), p));

        const tag = new Tag(tagName, swaggerPathsResolved, {
          logger: this.#logger,
          readme: this,
        });

        tags.set(tag.name, tag);
      }

      this.#data = { globalConfig, tags };

      // Clear #content to save memory, since it's no longer needed after #data is loaded
      this.#content = undefined;
    }

    return this.#data;
  }

  /**
   * @returns {Promise<Object>}
   */
  async getGlobalConfig() {
    return (await this.#getData()).globalConfig;
  }

  /**
   * @returns {Promise<Map<string, Tag>>}
   */
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
   * @returns {SpecModel | undefined} SpecModel that contains this Readme
   */
  get specModel() {
    return this.#specModel;
  }

  /**
   * @param {ToJSONOptions} [options]
   * @returns {Promise<Object>}
   */
  async toJSONAsync(options) {
    const tags = await mapAsync(
      [...(await this.getTags()).values()].sort((a, b) =>
        a.name.localeCompare(b.name),
      ),
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
