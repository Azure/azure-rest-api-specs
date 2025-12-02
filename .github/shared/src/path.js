import { basename, dirname, resolve } from "path";

/**
 *
 * @param {string} path Absolute or relative path
 * @param {string} segment File or folder
 * @returns {boolean} True if resolved path contains segment
 *
 * @example
 * includesSegment("stable/2025-01-01/examples/foo.json", "examples")
 * // -> true
 */
export function includesSegment(path, segment) {
  return untilLastSegment(path, segment) !== "";
}

/**
 * @param {string} path Absolute or relative path
 * @param {string} segment File or folder
 * @returns {string} Portion of resolved path up to (and including) the last occurrence of segment
 *
 * @example
 * untilLastSegment("stable/2025-01-01/examples/foo.json", "examples")
 * // -> "{cwd}/stable/2025-01-01/examples"
 */
export function untilLastSegment(path, segment) {
  let current = resolve(path);

  while (true) {
    const parent = dirname(current);

    if (basename(current) === segment) {
      // Found the target folder.  Return it.
      return current;
    } else if (parent === current) {
      // Reached the filesystem root (folder not found).  Return empty string.
      return "";
    } else {
      // Keep walking upward
      current = parent;
    }
  }
}

/**
 * @param {string} path Absolute or relative path
 * @param {string} segment File or folder
 * @returns {string} Portion of resolved path up to (and including) the last segment with the specified parent
 *
 * @example
 * untilLastParentSegment("stable/2025-01-01/examples/foo.json", "examples")
 * // -> "{cwd}/stable/2025-01-01"
 */
export function untilLastSegmentWithParent(path, segment) {
  let current = resolve(path);

  while (true) {
    const parent = dirname(current);

    if (basename(parent) === segment) {
      // Found the target parent.  Return current;
      return current;
    } else if (parent === current) {
      // Reached the filesystem root (folder not found).  Return empty string.
      return "";
    } else {
      // Keep walking upward
      current = parent;
    }
  }
}
