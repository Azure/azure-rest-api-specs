// @ts-check

import { readFile } from "fs/promises";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function generateJobSummary({ core }) {
  const avocadoOutputFile = process.env.AVOCADO_OUTPUT_FILE;
  core.info(`avocadoOutputFile: ${avocadoOutputFile}`);

  if (!avocadoOutputFile) {
    throw new Error("Env var AVOCADO_OUTPUT_FILE must be set");
  }

  /** @type {string} */
  let content;

  try {
    content = await readFile(avocadoOutputFile, { encoding: "utf-8" });
  } catch {
    // If we can't read the file, the previous step must have failed catastrophically, so don't
    // even try to generate a summary.
    return;
  }

  // TODO: Replace with table similar to old check
  core.summary.addCodeBlock(content);

  core.summary.write();
  core.setOutput("summary", process.env.GITHUB_STEP_SUMMARY);
}
