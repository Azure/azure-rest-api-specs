// @ts-check

/**
 * Returns a comparator that compares values by a date string in ascending order.
 * "null" is treated as the oldest date.
 *
 * @template T
 * @param {(item: T) => string | null} getDate
 * @returns {(a: T, b: T) => number}
 */
export function byDate(getDate) {
  return (a, b) => {
    const stringA = getDate(a);
    const stringB = getDate(b);

    // Treat "null" dates as oldest
    const timeA = stringA == null ? -Infinity : Date.parse(stringA);
    const timeB = stringB == null ? -Infinity : Date.parse(stringB);

    // Sort ascending to match JS default
    return timeA - timeB;
  };
}

/**
 * Inverts a comparator function.
 *
 * @template T
 * @param {(a: T, b: T) => number} comparator
 * @returns {(a: T, b: T) => number}
 */
export function invert(comparator) {
  return (a, b) => -comparator(a, b);
}
