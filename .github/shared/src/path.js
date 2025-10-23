// @ts-check

import { basename, dirname, resolve } from "path";

/**
 *
 * @param {string} path
 * @param {string} folder
 * @returns {boolean} True if path contains the named folder
 */
export function includesFolder(path, folder) {
  let current = resolve(path);

  while (true) {
    const parent = dirname(current);

    if (basename(current) === folder) {
      // Found the target folder
      return true;
    } else if (parent === current) {
      // Reached the filesystem root (folder not found)
      return false;
    } else {
      current = parent;
    }
  }
}

/**
 * @param {string} path
 * @param {string} folder
 * @returns {string} Portion of the resolved path up to (but not including) the first occurrence of the named folder
 */
export function untilFolder(path, folder) {
  let current = resolve(path);

  while (true) {
    const parent = dirname(current);

    if (basename(current) === folder) {
      // Found the target folder.  Return everything before it.
      return parent;
    } else if (parent === current) {
      // Reached the filesystem root (folder not found).  Return empty string.
      return "";
    } else {
      // Keep walking upward
      current = parent;
    }
  }
}
