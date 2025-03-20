// @ts-check
import { readFileSync } from "fs";
import { readdir } from "fs/promises";
import { marked } from "marked";
import { dirname, join } from "path";
import { fileURLToPath } from "url";
import yaml from "yaml";
import { readme } from "../src/changed-files.js";

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
 * @prop {Map<string, Object>} tags
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
      readmes.map((r) => [join(folder, r), getReadme(join(folder, r))]),
    ),
  };
}

/**
 * @param {string} path
 * @returns {Readme}
 */
function getReadme(path) {
  const readmeText = readFileSync(join(__dirname, "..", "..", path), {
    encoding: "utf8",
  });

  const tokens = marked.lexer(readmeText);

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
    (obj, token) => Object.assign(obj, yaml.parse(token.text)),
    {},
  );

  //     const tag =
  //       block.lang?.match(/yaml \$\(tag\) == '([^']*)'/)?.[1] || "default";

  const readme = {
    path,
    content: readmeText,
    globalConfig,
    tags: new Map(),
  };

  return readme;
}
