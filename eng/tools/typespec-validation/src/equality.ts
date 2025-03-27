// @ts-check

// Copied from ./github/src/equality.js
// TODO: Use shared source package once completed

export function setEquals(set1: Set<any>, set2: Set<any>): boolean {
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
