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

/**
 * @param {string} path
 * @param {string} folder
 * @returns {string} Portion of the resolved path up to (but not including) the first occurrence of the named folder
 */
export function untilFolder(path, folder) {
  // Example: /a/b/c.txt -> ["", "a", "b", "c"] (note leading empty string)
  const segments = resolve(path).split(sep);

  const index = segments.indexOf(folder);

  if (index === -1) {
    // If path doesn't contain the folder, return an empty string
    return "";
  } else {
    return segments.slice(0, index).join(sep);
  }
}
