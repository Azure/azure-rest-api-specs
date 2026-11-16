export async function filterAsync<T>(
  array: T[],
  asyncPredicate: (item: T, index: number, array: T[]) => Promise<boolean>,
): Promise<T[]> {
  const results = await mapAsync(array, asyncPredicate);
  return array.filter((_, i) => results[i]);
}

export async function flatMapAsync<T, U>(
  array: T[],
  asyncMapper: (item: T, index: number, array: T[]) => Promise<U[]>,
): Promise<U[]> {
  const mapped = await mapAsync(array, asyncMapper);
  return mapped.flat();
}

/**
 * Returns true if `array` includes no elements from `values`
 */
export async function mapAsync<T, U>(
  array: T[],
  asyncMapper: (item: T, index: number, array: T[]) => Promise<U>,
): Promise<U[]> {
  return Promise.all(array.map(asyncMapper));
}

/**
 * Returns true if `array` includes every element from `values`
 */
export function includesEvery<T>(array: T[], values: T[]): boolean {
  return values.every((value) => array.includes(value));
}

export function includesNone<T>(array: T[], values: T[]): boolean {
  return values.every((value) => !array.includes(value));
}
