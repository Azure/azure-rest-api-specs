/**
 * Returns a comparator that compares values by a date string in ascending order.
 * Throws if the value returned by getDate() is null, undefined, or cannot be
 * parsed as a date.
 */
export function byDate<T>(getDate: (item: T) => string): (a: T, b: T) => number {
  return (a, b) => {
    // Sort ascending to match JS default
    return parseDate(getDate(a)) - parseDate(getDate(b));
  };
}

/**
 * Parses a string to a date, throwing if null, undefined, or cannot be parsed.
 */
function parseDate(s: string): number {
  // Date.parse() returns NaN for null, undefined, or strings that cannot be parsed.
  const parsed = Date.parse(s);

  if (Number.isNaN(parsed)) {
    throw new Error(`Unable to parse '${s}' to a valid date`);
  }

  return parsed;
}

/**
 * Inverts a comparator function.
 */
export function invert<T>(comparator: (a: T, b: T) => number): (a: T, b: T) => number {
  return (a, b) => -comparator(a, b);
}
