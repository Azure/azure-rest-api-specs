// @ts-check

import { readFile } from "fs/promises";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function generateJobSummary({ core }) {
  let content = "";

  const avocadoOutputFile = process.env.AVOCADO_OUTPUT_FILE;
  core.info(`avocadoOutputFile: ${avocadoOutputFile}`);
  if (avocadoOutputFile) {
    content = await readFileIfExists(avocadoOutputFile, core);
  }

  const avocadoLogFile = process.env.AVOCADO_LOG_FILE;
  core.info(`avocadoLogFile: ${avocadoLogFile}`);
  if (!content && avocadoLogFile) {
    content = await readFileIfExists(avocadoLogFile, core);
  }

  if (!content) {
    content = `Unable to read file '${avocadoOutputFile}' or '${avocadoLogFile}'`;
  }

  core.summary.addCodeBlock(content);
  core.summary.write();

  core.setOutput("summary", process.env.GITHUB_STEP_SUMMARY);
}

async function readFileIfExists(file, core) {
  let content = "";

  try {
    content = await readFile(file, { encoding: "utf-8" });
  } catch (error) {
    if (error.code === "ENOENT") {
      core.info(`File '${file}' does not exist`);
    } else {
      throw error;
    }
  }

  return content;
}
