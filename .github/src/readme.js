// @ts-check

/**
 * @param {string} markdown
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<Set<string>>} All input files for all tags
 */
export async function getInputFiles(markdown, core) {
  // TODO: Replace with calls to "marked" and "yaml" libraries
  // Hacky implementation to pass test
  const lines = markdown.split("\n");
  const inputFileLines = lines.filter(
    (l) => l.startsWith("  - ") && l.trimEnd().toLowerCase().endsWith(".json"),
  );
  const inputFiles = inputFileLines.map((l) => l.substring(4));

  return new Set(inputFiles);
}
