import fs from "node:fs";
import path from "node:path";
import { pathToFileURL } from "node:url";

/** @type {string | undefined} */
let resolvedEntryPath;
/** @type {string | undefined} */
let resolvedEntryUrl;

/**
 * @typedef {string | boolean | string[] | undefined} CliArgumentValue
 * @typedef {{
 *   defaults?: Record<string, CliArgumentValue>,
 *   booleans?: string[],
 *   arrays?: string[],
 *   required?: string[]
 * }} ParseArgsOptions
 */

/**
 * @param {string[]} argv
 * @param {ParseArgsOptions} [options]
 * @returns {Record<string, CliArgumentValue> & {_?: string[]}}
 */
export function parseArgs(argv, options = {}) {
  /** @type {Record<string, CliArgumentValue> & {_?: string[]}} */
  const result = { ...options.defaults };
  for (let index = 0; index < argv.length; index += 1) {
    const token = argv[index];
    if (!token.startsWith("--")) {
      const positional = result._ ?? [];
      positional.push(token);
      result._ = positional;
      continue;
    }
    const [rawName, inlineValue] = token.slice(2).split("=", 2);
    const name = rawName.replaceAll("-", "_");
    if (options.booleans?.includes(rawName)) {
      result[name] = inlineValue === undefined ? true : inlineValue !== "false";
      continue;
    }
    const value = inlineValue ?? argv[++index];
    if (value === undefined || value.startsWith("--")) {
      throw new Error(`Missing value for --${rawName}.`);
    }
    if (options.arrays?.includes(rawName)) {
      const values = Array.isArray(result[name]) ? result[name] : [];
      values.push(value);
      result[name] = values;
    } else {
      result[name] = value;
    }
  }
  for (const required of options.required ?? []) {
    if (result[required.replaceAll("-", "_")] === undefined) {
      throw new Error(`Missing required argument --${required}.`);
    }
  }
  return result;
}

/**
 * @param {string} file
 * @returns {unknown}
 */
export function readJson(file) {
  return /** @type {unknown} */ (JSON.parse(fs.readFileSync(file, "utf8")));
}

/**
 * @param {unknown} value
 * @returns {value is Record<string, unknown>}
 */
export function isRecord(value) {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

/**
 * @param {string} file
 * @returns {Record<string, unknown>}
 */
export function readJsonObject(file) {
  const value = readJson(file);
  if (!isRecord(value)) {
    throw new TypeError(`Expected a JSON object in ${file}.`);
  }
  return value;
}

/**
 * @param {string} file
 * @param {unknown} value
 */
export function writeJson(file, value) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, `${JSON.stringify(value, null, 2)}\n`);
}

/**
 * @param {string} metaUrl
 * @returns {boolean}
 */
export function isMain(metaUrl) {
  if (!process.argv[1]) return false;
  const entryPath = path.resolve(process.argv[1]);
  if (metaUrl === pathToFileURL(entryPath).href) return true;
  // Node resolves linked entrypoints, while argv retains the junction/symlink path.
  if (resolvedEntryPath !== entryPath) {
    resolvedEntryPath = entryPath;
    resolvedEntryUrl = fs.existsSync(entryPath)
      ? pathToFileURL(fs.realpathSync(entryPath)).href
      : undefined;
  }
  return metaUrl === resolvedEntryUrl;
}

/**
 * @param {() => void | Promise<void>} action
 * @returns {Promise<void>}
 */
export async function runMain(action) {
  try {
    await action();
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    process.exitCode = 1;
  }
}
