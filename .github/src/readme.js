// @ts-check

import { marked } from "marked";
import yaml from "yaml";

/**
 * @param {string} markdown
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<Set<string>>} All input files for all tags
 */
export async function getInputFiles(markdown, core) {
  const tokens = marked.lexer(markdown);

  const yamlBlocks = tokens
    .filter((token) => token.type === "code")
    .map((token) => /** @type import("marked").Tokens.Code */ (token))
    // Include default block and tagged blocks (```yaml $(tag) == 'package-2021-11-01')
    .filter((token) => token.lang?.toLowerCase().startsWith("yaml"));

  const inputFiles = yamlBlocks.flatMap((block) => {
    const obj = yaml.parse(block.text);
    return /** @type string[] */ (obj["input-file"] || []);
  });

  return new Set(inputFiles);
}
