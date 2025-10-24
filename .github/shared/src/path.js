// @ts-check

import { basename, dirname, resolve } from "path";

/**
 *
 * @param {string} path
 * @param {string} segment
 * @returns {boolean} True if path contains the named segment (file or folder)
 */
export function includesSegment(path, segment) {
  return untilSegment(path, segment) !== "";
}

/**
 * @param {string} path
 * @param {string} segment
 * @returns {string} Portion of the resolved path up to (but not including) the first occurrence of the named segment (file or folder)
 */
export function untilSegment(path, segment) {
  let current = resolve(path);

  while (true) {
    const parent = dirname(current);

    if (basename(current) === segment) {
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
