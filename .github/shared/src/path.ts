import { basename, dirname, resolve } from "path";

import { KeyedCache, KeyedPairCache } from "./cache.ts";

const resolveCache: KeyedCache<string, string> = new KeyedCache();

const resolvePairCache: KeyedPairCache<string, string, string> = new KeyedPairCache();

/**
 * @param path Absolute or relative path
 * @param segment File or folder
 * @returns True if resolved path contains segment
 * @example
 * includesSegment("stable/2025-01-01/examples/foo.json", "examples")
 * // -> true
 */
export function includesSegment(path: string, segment: string): boolean {
  return untilLastSegment(path, segment) !== "";
}

/**
 * Wraps `path.resolve(path)` with a cache to improve performance
 */
export function resolveCached(path: string): string {
  return resolveCache.getOrCreate(path, () => resolve(path));
}

/**
 * Wraps `path.resolve(from, to)` with a cache to improve performance
 */
export function resolvePairCached(from: string, to: string): string {
  return resolvePairCache.getOrCreate(from, to, () => resolve(from, to));
}

/**
 * @param path Absolute or relative path
 * @param segment File or folder
 * @returns Portion of resolved path up to (and including) the last occurrence of segment
 * @example
 * untilLastSegment("stable/2025-01-01/examples/foo.json", "examples")
 * // -> "{cwd}/stable/2025-01-01/examples"
 */
export function untilLastSegment(path: string, segment: string): string {
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
 * @param path Absolute or relative path
 * @param segment File or folder
 * @returns Portion of resolved path up to (and including) the last segment with the specified parent
 * @example
 * untilLastSegmentWithParent("specification/foo/data-plane/stable/2025-01-01/foo.json", "specification")
 * // -> "{cwd}/specification/foo"
 */
export function untilLastSegmentWithParent(path: string, segment: string): string {
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
