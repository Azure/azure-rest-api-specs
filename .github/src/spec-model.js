// @ts-check
import { readFile, readdir } from "fs/promises";
import yaml from "js-yaml";
import { marked } from "marked";
import { dirname, join } from "path";
import { fileURLToPath } from "url";
import { readme } from "../src/changed-files.js";
import { mapAsync } from "./array.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

/**
 * @typedef {Object} SpecModel
 * @prop {Map<string, Readme>} readmes
 */

/**
 * @typedef {Object} Readme
 * @prop {string} path
 * @prop {string} content
 * @prop {Object} globalConfig
 * @prop {Map<string, Swagger[]>} tags
 */

/**
 * @typedef {Object} Swagger
 * @prop {string} path
 * @prop {string} content
 * @prop {Set<string>} refs
 */

/**
 * @param {string} folder
 * @param {Object} [options]
 * @param {import('./types.js').ILogger} [options.logger]
 * @returns {Promise<SpecModel>} All input files for all tags
 */
export async function getSpecModel(folder, options = {}) {
  console.log(options);

  const files = await readdir(join(__dirname, "..", "..", folder), {
    recursive: true,
  });
  const readmes = files.filter(readme);

  return {
    readmes: new Map(
      await mapAsync(readmes, async (r) => {
        return [join(folder, r), await getReadme(join(folder, r))];
      }),
    ),
  };
}

/**
 * @param {string} path
 * @returns {Promise<Readme>}
 */
async function getReadme(path) {
  // TODO: Do not assume location is with respect to repo root, could be reading
  // files from a different root location (e.g. "before" state of repo in
  // another folder).
  const content = await readFile(join(__dirname, "..", "..", path), {
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
    (obj, token) => Object.assign(obj, yaml.load(token.text)),
    {},
  );

  const tags = new Map();
  for (const block of yamlBlocks) {
    const tagName =
      block.lang?.match(/yaml \$\(tag\) == '([^']*)'/)?.[1] || "default";

    if (tagName === "default") {
      // Skip yaml blocks where this is no tag
      continue;
    }
    const obj = /** @type {any} */ (yaml.load(block.text));

    /** @type Swagger[] */
    const swaggers = [];
    for (const swaggerPath of obj["input-file"]) {
      const swagger = await getSwagger(join(dirname(path), swaggerPath));
      swaggers.push(swagger);
    }

    tags.set(tagName, swaggers);
  }

  const readme = {
    path,
    content,
    globalConfig,
    tags,
  };

  return readme;
}

/**
 * @param {string} path
 * @returns {Promise<Swagger>}
 */
async function getSwagger(path) {
  // TODO: Do not assume location is with respect to repo root, could be reading
  // files from a different root location (e.g. "before" state of repo in
  // another folder).
  const content = await readFile(join(__dirname, "..", "..", path), {
    encoding: "utf8",
  });

  return {
    path,
    content,
    refs: new Set(),
  };
}
