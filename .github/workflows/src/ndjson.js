// @ts-check

// Functions for processing newline-delimited JSON (aka "ndjson")

/**
 * @param {string} text
 * @returns {any[]}
 */
export function parse(text) {
  return text
    .split("\n")
    .filter((line) => line.trim() !== "")
    .map((line) => JSON.parse(line));
}

/**
 * @param {any[]} values
 * @returns {string}
 */
export function stringify(values) {
  return values.map((v) => JSON.stringify(v)).join("\n");
}
