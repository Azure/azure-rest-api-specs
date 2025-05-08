// @ts-check

/**
 * @template T
 * @param {T[]} array
 * @param {(item: T, index: number, array: T[]) => Promise<boolean>} asyncPredicate
 * @returns {Promise<T[]>}
 */
export async function filterAsync(array, asyncPredicate) {
  const results = await mapAsync(array, asyncPredicate);
  return array.filter((_, i) => results[i]);
}

/**
 * @template T,U
 * @param {T[]} array
 * @param {(item: T, index: number, array: T[]) => Promise<U[]>} asyncMapper
 * @returns {Promise<U[]>}
 */
export async function flatMapAsync(array, asyncMapper) {
  const mapped = await mapAsync(array, asyncMapper);
  return mapped.flat();
}

/**
 * @template T,U
 * @param {T[]} array
 * @param {(item: T, index: number, array: T[]) => Promise<U>} asyncMapper
 * @returns {Promise<U[]>}
 */
export async function mapAsync(array, asyncMapper) {
  return Promise.all(array.map(asyncMapper));
}
