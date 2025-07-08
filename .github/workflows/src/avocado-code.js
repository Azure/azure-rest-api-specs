// @ts-check

import { readFile } from "fs/promises";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function generateJobSummary({ core }) {
  let content = "";

  const avocadoOutput = process.env.AVOCADO_OUTPUT;
  core.info(`avocadoOutput: ${avocadoOutput}`);
  if (avocadoOutput) {
    content = await readFileIfExists(avocadoOutput, core);
  }

  const avocadoLog = process.env.AVOCADO_LOG;
  core.info(`avocadoLog: ${avocadoLog}`);
  if (!content && avocadoLog) {
    content = await readFileIfExists(avocadoLog, core);

    // Remove lines starting with "##vso"
    content = content.replace(/^##vso.*(?:\r?\n)?/gm, "");
  }

  if (!content) {
    content = `Unable to read file '${avocadoOutput}' or '${avocadoLog}'`;
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
