// @ts-check

/**
 * @template T
 * @param {T[]} array - The array to filter.
 * @param {(item: T, index: number, array: T[]) => Promise<boolean>} asyncPredicate
 *   - An async function that returns true to keep the item.
 * @returns {Promise<T[]>} A promise that resolves to the filtered array.
 */
export async function filterAsync(array, asyncPredicate) {
  const filterResults = await Promise.all(array.map(asyncPredicate));
  return array.filter((_, index) => filterResults[index]);
}
