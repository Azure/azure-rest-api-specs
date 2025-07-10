// @ts-check

import { readFile } from "fs/promises";
import { inspect } from "util";
import { MessageRecordSchema } from "./message.js";

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
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
    core.info(`readfile(${avocadoOutputFile})`);
    content = await readFile(avocadoOutputFile, { encoding: "utf-8" });
    core.info(`content:\n${content}`);
  } catch (error) {
    // If we can't read the file, the previous step must have failed catastrophically.
    // generateJobSummary() should never fail, so just log the error and return
    core.info(`Error reading '${avocadoOutputFile}': ${error}`);
    return;
  }

  // TODO
  // 1. Parse content to an array of MessageRecord (copied from alps)
  // 2. Generate markdown table from objects

  const messages = content
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line.trim() !== "")
    .map((line) => JSON.parse(line))
    .map((obj) => MessageRecordSchema.parse(obj));

  core.summary.addCodeBlock(inspect(messages));

  core.summary.write();
  core.setOutput("summary", process.env.GITHUB_STEP_SUMMARY);
}
