/**
 * Convert a float [0,1] to a percentage string.
 * @param value - A number between 0 and 1.
 * @param decimals - How many decimal places to include. Default: 0
 */
export function toPercent(value: number, decimals: number = 0): string {
  return `${(value * 100).toFixed(decimals)}%`;
}
