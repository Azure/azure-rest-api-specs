// @ts-check

import { readFile } from "fs/promises";
import { inspect } from "util";
import { MessageLevel, MessageRecordSchema, MessageType } from "./message.js";

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

  const messages = content
    .split("\n")
    .filter((line) => line.trim() !== "")
    .map((line) => JSON.parse(line))
    .map((obj) => MessageRecordSchema.parse(obj));

  if (
    messages.length === 1 &&
    messages[0].type === MessageType.Raw &&
    messages[0].level === MessageLevel.Info &&
    messages[0].message.toLowerCase() === "success"
  ) {
    // Special-case marker message for success
    core.summary.addRaw("Success");
  } else {
    // Render all "Raw" and "Result" messages in a table
    core.summary.addCodeBlock(inspect(messages));
  }

  core.summary.write();
  core.setOutput("summary", process.env.GITHUB_STEP_SUMMARY);
}
