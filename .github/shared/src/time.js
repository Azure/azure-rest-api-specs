// @ts-check

/**
 * @typedef {Object} DurationType
 * @property {number} Second - 1 second in milliseconds
 * @property {number} Minute - 1 minute in milliseconds
 * @property {number} Hour   - 1 hour in milliseconds
 * @property {number} Day    - 1 day in milliseconds
 * @property {number} Week   - 1 week in milliseconds
 */

/**
 * Common time duration constants in milliseconds.
 *
 * @readonly
 * @type {DurationType}
 */
export const Duration = Object.freeze({
  Second: 1000,
  Minute: 60 * 1000,
  Hour: 60 * 60 * 1000,
  Day: 24 * 60 * 60 * 1000,
  Week: 7 * 24 * 60 * 60 * 1000,
});

/**
 * Add milliseconds to a date.
 * @param {Date} date
 * @param {number} ms
 * @returns {Date}
 */
export function add(date, ms) {
  return new Date(date.getTime() + ms);
}

/**
 * Subtract milliseconds from a date.
 * @param {Date} date
 * @param {number} ms
 * @returns {Date}
 */
export function subtract(date, ms) {
  return new Date(date.getTime() - ms);
}
