// @ts-check

/**
 *
 * @param {Set<any>} set1
 * @param {Set<any>} set2
 * @returns {boolean} True if sets are the same size and have the same elements
 */
export function setEquals(set1, set2) {
  if (!(set1 instanceof Set) || !(set2 instanceof Set)) {
    return false;
  }

  if (set1.size !== set2.size) {
    return false;
  }

  // Should be O(N), since set lookup should be O(1)
  for (const item of set1) {
    if (!set2.has(item)) {
      return false;
    }
  }

  return true;
}
