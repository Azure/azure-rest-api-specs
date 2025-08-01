// @ts-check

import { resolve, sep } from "path";

/**
 *
 * @param {string} path
 * @param {string} folder
 * @returns {boolean} True if path contains the named folder
 */
export function includesFolder(path, folder) {
  return resolve(path).split(sep).includes(folder);
}
