/**
 * Dedents a template literal for readable multiline test expectations.
 * Removes one leading newline and a trailing newline followed by spaces, then
 * strips the first line's indentation from every line that shares that prefix.
 * Interpolated values are included before dedenting; null and undefined become empty strings.
 */
export function d(strings: TemplateStringsArray, ...values: unknown[]): string {
  const text = strings
    // oxlint-disable-next-line typescript/no-base-to-string -- Template substitutions use normal string coercion.
    .reduce((result, part, index) => result + part + String(values[index] ?? ""), "")
    .replace(/^\n|\n[ ]*$/g, "");
  const indent = text.match(/^[ \t]+/)?.[0] ?? "";

  return text
    .split("\n")
    .map((line) => (line.startsWith(indent) ? line.slice(indent.length) : line))
    .join("\n");
}
