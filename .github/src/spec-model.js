// @ts-check

import { readdir } from "fs/promises";
import { readme } from "../src/changed-files.js";

import { dirname, join } from "path";
import { fileURLToPath } from "url";

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
      readmes.map((r) => [
        join(folder, r),
        { path: r, content: "", globalConfig: {}, tags: new Map() },
      ]),
    ),
  };
}
