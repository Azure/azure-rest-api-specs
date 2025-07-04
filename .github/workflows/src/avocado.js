// @ts-check

import { readFile } from "fs/promises";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function generateJobSummary({ core }) {
  const avocadoOutputPath = process.env.AVOCADO_OUTPUT_FILE;

  if (!avocadoOutputPath) {
    throw new Error("Env var AVOCADO_OUTPUT_FILE must be set");
  }

  const avocadoOutput = await readFile(avocadoOutputPath, { encoding: "utf-8" });

  core.summary.addCodeBlock(avocadoOutput);
  core.summary.write();
}
