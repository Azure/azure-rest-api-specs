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
    // TODO: Remove lines starting with "##vso"
  }

  if (!content) {
    content = `Unable to read file '${avocadoOutputFile}' or '${avocadoLogFile}'`;
  }

  core.summary.addCodeBlock(content);
  core.summary.write();

  core.setOutput("summary", process.env.GITHUB_STEP_SUMMARY);
}

/**
 * @param {string} file
 * @param {typeof import("@actions/core")} core
 */
async function readFileIfExists(file, core) {
  let content = "";

  try {
    content = await readFile(file, { encoding: "utf-8" });
  } catch (error) {
    if (error instanceof Error && "code" in error && error.code === "ENOENT") {
      core.info(`File '${file}' does not exist`);
    } else {
      throw error;
    }
  }

  return content;
}
