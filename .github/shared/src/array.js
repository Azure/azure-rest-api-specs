// @ts-check

/**
 * @template T, U
 * @param {T[]} array
 * @param {(value: T, index: number, array: T[]) => Promise<U>} callbackfn
 * @returns {Promise<U[]>}
 */
export async function mapAsync(array, callbackfn) {
  return Promise.all(array.map(callbackfn));
}
