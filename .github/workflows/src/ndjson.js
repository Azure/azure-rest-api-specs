// Functions for processing newline-delimited JSON (aka "ndjson")
// Cannot round-trip "undefined", but neither can JSON.parse()/JSON.stringify()

/**
 * @param {string} text
 * @returns {any[]}
 */
export function parse(text) {
  return (
    text
      .split("\n")
      // Skip empty lines, since JSON.parse("") throws "unexpected end of JSON input"
      .filter((line) => line.trim() !== "")
      .map((line) => JSON.parse(line))
  );
}

/**
 * @param {any[]} values
 * @returns {string}
 */
export function stringify(values) {
  // stringify(undefined) returns "undefined", which is ignored in string[].join()
  return values.map((v) => JSON.stringify(v)).join("\n");
}
