// @ts-check

/**
 * @template T
 * @param {Set<T>} setA
 * @param {Set<T>} setB
 * @returns {Set<T>}
 */
export function intersect(setA, setB) {
  return new Set([...setA].filter((value) => setB.has(value)));
}
