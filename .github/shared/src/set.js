// @ts-check

/**
 * @template T
 * @param {Set<T>} a
 * @param {Set<T>} b
 * @returns {Set<T>}
 */
export function intersect(a, b) {
  // Since set lookup is O(1), iterate over the smaller set for better perf: O(small) vs O(large)
  const [small, large] = a.size < b.size ? [a, b] : [b, a];
  return new Set([...small].filter((value) => large.has(value)));
}
