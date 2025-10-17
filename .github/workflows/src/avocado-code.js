// @ts-check

import { readFile } from "fs/promises";
import {
  generateMarkdownTable,
  MessageLevel,
  MessageRecordSchema,
  MessageType,
} from "./message.js";
import { parse } from "./ndjson.js";

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

  const messages = parse(content).map((obj) => MessageRecordSchema.parse(obj));

  if (messages.length === 0) {
    // Should never happen, but if it does, just log the error and return.
    core.notice(`No messages in '${avocadoOutputFile}'`);
    return;
  } else if (
    messages.length === 1 &&
    messages[0].type === MessageType.Raw &&
    messages[0].level === MessageLevel.Info &&
    messages[0].message.toLowerCase() === "success"
  ) {
    // Special-case marker message for success
    core.summary.addRaw("Success");
  } else {
    core.summary.addRaw(generateMarkdownTable(messages));
  }

  core.summary.write();
  core.setOutput("summary", process.env.GITHUB_STEP_SUMMARY);
}
