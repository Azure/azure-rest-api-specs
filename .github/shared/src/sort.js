// @ts-check

/**
 * Returns a comparator that compares values by a date string in ascending order.
 * null, undefined, and non-parseable strings are treated as the oldest date.
 *
 * @template T
 * @param {(item: T) => string | null | undefined} getDate
 * @returns {(a: T, b: T) => number}
 */
export function byDate(getDate) {
  return (a, b) => {
    // Map null and undefined to "", since Date.parse() requires a defined string
    const stringA = getDate(a) ?? "";
    const stringB = getDate(b) ?? "";

    // Date.parse() returns NaN for "", and any string that can't be parsed as a date
    const parsedA = Date.parse(stringA);
    const parsedB = Date.parse(stringB);

    // Map NaN to -Infinifty, so it's treated as the oldest date
    const timeA = Number.isNaN(parsedA) ? -Infinity : parsedA;
    const timeB = Number.isNaN(parsedB) ? -Infinity : parsedB;

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
