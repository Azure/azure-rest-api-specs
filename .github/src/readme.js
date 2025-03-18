// @ts-check

import { marked } from "marked";
import yaml from "yaml";
import { ILogger } from "./logger.js";

/**
 * @param {string} markdown
 * @param {Object} [options]
 * @param {ILogger} [options.logger]
 * @returns {Promise<Set<string>>} All input files for all tags
 */
export async function getInputFiles(markdown, options = {}) {
  const { logger } = options;

  const tokens = marked.lexer(markdown);

  const yamlBlocks = tokens
    .filter((token) => token.type === "code")
    .map((token) => /** @type import("marked").Tokens.Code */ (token))
    // Include default block and tagged blocks (```yaml $(tag) == 'package-2021-11-01')
    .filter((token) => token.lang?.toLowerCase().startsWith("yaml"));

  const inputFiles = yamlBlocks.flatMap((block) => {
    const tag =
      block.lang?.match(/yaml \$\(tag\) == '([^']*)'/)?.[1] || "default";

    const obj = yaml.parse(block.text);
    const blockFiles = /** @type string[] */ (obj["input-file"] || []);

    logger?.info(`Input files for tag '${tag}': ${JSON.stringify(blockFiles)}`);

    return blockFiles;
  });

  return new Set(inputFiles);
}
