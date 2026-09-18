import { readFile } from "fs/promises";
import { marked } from "marked";
import { dirname, normalize, relative } from "path";
import { inspect } from "util";
import * as z from "zod";
import { mapAsync } from "./array.ts";
import { resolvePairCached } from "./path.ts";
import { SpecModelError } from "./spec-model-error.ts";
import { embedError } from "./spec-model.ts";
import { Tag } from "./tag.ts";
import { parseYaml } from "./yaml.ts";

export type ErrorJSON = import("./spec-model.ts").ErrorJSON;

export type SpecModel = import("./spec-model.ts").SpecModel;

export type ToJSONOptions = import("./spec-model.ts").ToJSONOptions;

export type TagJSON = import("./tag.ts").TagJSON;

export interface ReadmeJSON {
  path: string;
  globalConfig: Record<string, unknown>;
  tags: (TagJSON | ErrorJSON)[];
}

/**
 * Regex to match tag names in readme.md yaml code blocks
 */
export const TagMatchRegex = /yaml.*\$\(tag\) ?== ?(["'])(.*?)\1/;

// Example: "foo.json"
const jsonFileSchema = z.string().regex(/\.json$/i);

// Examples:
// {}
// {"input-file": "foo.json"}
// {"input-file": ["foo.json", "bar.json"]}
const inputFileSchema = z.object({
  "input-file": z
    // May be undefined, a single json filename, or an array of json filenames
    .optional(z.union([jsonFileSchema, z.array(jsonFileSchema)]))
    // Normalize single string to array of string.  Don't change 'undefined'.
    .transform((value) => (typeof value === "string" ? [value] : value)),
});

export class Readme {
  /**
   * Content of `readme.md`, either loaded from `#path` or passed in via `options`.
   *
   * Reset to `undefined` after `#data` is loaded to save memory.
   */
  #content: string | undefined;

  #data: { globalConfig: Record<string, unknown>; tags: Map<string, Tag> } | undefined;

  #logger: import("./logger.ts").ILogger | undefined;

  /**
   * absolute path
   */
  #path: string;

  /**
   * SpecModel that contains this Readme
   */
  #specModel: SpecModel | undefined;

  /**
   * @param path Used for content, unless options.content is specified
   */
  constructor(
    path: string,
    options: {
      content?: string;
      logger?: import("./logger.ts").ILogger;
      specModel?: SpecModel;
    } = {},
  ) {
    const { content, logger, specModel } = options;

    this.#path = resolvePairCached(specModel?.folder ?? "", path);

    this.#content = content;
    this.#logger = logger;
    this.#specModel = specModel;
  }

  static #normalizeSwaggerPath(
    swaggerPath: string,
    logger?: import("./logger.ts").ILogger,
  ): string {
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

      const yamlBlocks: import("marked").Tokens.Code[] = tokens
        .filter((token) => token.type === "code")
        .map((token) => token as import("marked").Tokens.Code)
        // Include default block and tagged blocks (```yaml $(tag) == 'package-2021-11-01')
        .filter((token) => token.lang?.toLowerCase().startsWith("yaml"));

      const globalConfigYamlBlocks = yamlBlocks.filter((token) => token.lang === "yaml");

      const globalConfig = globalConfigYamlBlocks.reduce(
        (obj, token) => Object.assign(obj, parseYaml(token.text, { schema: "failsafe" })),
        {},
      );

      const tags: Map<string, Tag> = new Map();
      for (const block of yamlBlocks) {
        const tagName = block.lang?.match(TagMatchRegex)?.[2] || "default";

        if (tagName === "default" || tagName === "all-api-versions") {
          // Skip yaml blocks where this is no tag or tag is all-api-versions
          continue;
        }

        const obj = parseYaml(block.text, { schema: "failsafe" });

        if (!obj) {
          this.#logger?.debug(`No YAML object found for tag ${tagName} in ${this.#path}`);
          continue;
        }

        let parsedObj;
        try {
          parsedObj = inputFileSchema.parse(obj);
        } catch (error) {
          /* v8 ignore else -- defensive rethrow */
          if (error instanceof z.ZodError) {
            throw new SpecModelError(
              `Unable to parse input-file YAML for tag ${tagName} in ${this.#path}`,
              {
                source: this.#path,
                readme: this.#path,
                tag: tagName,
                cause: error,
              },
            );
          } else {
            throw error;
          }
        }

        if (!parsedObj["input-file"]) {
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

        const inputFilePaths = parsedObj["input-file"];

        const swaggerPathsResolved = inputFilePaths
          .map((p) => Readme.#normalizeSwaggerPath(p))
          .map((p) => resolvePairCached(dirname(this.#path), p));

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

  async getGlobalConfig(): Promise<Record<string, unknown>> {
    return (await this.#getData()).globalConfig;
  }

  async getTags(): Promise<Map<string, Tag>> {
    return (await this.#getData()).tags;
  }

  /**
   * @returns absolute path
   */
  get path(): string {
    return this.#path;
  }

  /**
   * @returns SpecModel that contains this Readme
   */
  get specModel(): SpecModel | undefined {
    return this.#specModel;
  }

  async toJSONAsync(options: ToJSONOptions = {}): Promise<ReadmeJSON | ErrorJSON> {
    const { relativePaths } = options;

    return await embedError(async () => {
      const tags = await mapAsync(
        [...(await this.getTags()).values()].sort((a, b) => a.name.localeCompare(b.name)),
        async (t) => await t.toJSONAsync(options),
      );

      return {
        path:
          relativePaths && this.#specModel
            ? relative(this.#specModel.folder, this.#path)
            : this.#path,
        globalConfig: await this.getGlobalConfig(),
        tags,
      };
    }, options);
  }

  toString(): string {
    return `Readme(${this.#path}, {logger: ${inspect(this.#logger)}})`;
  }
}
