import { basename, dirname, resolve } from "path";
import { MemoryCache, MemoryCache2 } from "./memory-cache.js";

/** @type {MemoryCache<string, string>} */
const resolveCache = new MemoryCache();

/** @type {MemoryCache2<string, string, string>} */
const resolveCache2 = new MemoryCache2();

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
 * @param {string} path
 * @returns {string}
 */
export function resolveCached(path) {
  return resolveCache.getOrCreate(path, () => resolve(path));
}

/**
 * @param {string} from
 * @param {string} to
 * @returns {string}
 */
export function resolveCached2(from, to) {
  return resolveCache2.getOrCreate(from, to, () => resolve(from, to));
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
  // Shares code with `untilLastSegmentWithParent()`, but not worth refactoring yet

  let current = resolveCached(path);

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
 * untilLastSegmentWithParent("specification/foo/data-plane/stable/2025-01-01/foo.json", "specification")
 * // -> "{cwd}/specification/foo"
 */
export function untilLastSegmentWithParent(path, segment) {
  // Shares code with `untilLastSegment()`, but not worth refactoring yet

  let current = resolveCached(path);

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
