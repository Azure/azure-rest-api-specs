// @ts-check

/**
 * @template T, U
 * @param {T[]} array - The input array of type T.
 * @param {(item: T, index: number) => Promise<U>} callbackfn - Async function to apply to each item.
 * @returns {Promise<U[]>} A promise that resolves to an array of type U.
 */
export async function mapAsync(array, callbackfn) {
  return Promise.all(array.map(callbackfn));
}
