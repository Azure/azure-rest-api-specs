// @ts-check

import { readFile } from "fs/promises";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function generateJobSummary({ core }) {
  const avocadoLog = process.env.AVOCADO_LOG;
  core.info(`avocadoLog: ${avocadoLog}`);

  const avocadoOutput = process.env.AVOCADO_OUTPUT;
  core.info(`avocadoOutput: ${avocadoOutput}`);

  if (avocadoOutput) {
    const content = await readFileIfExists(avocadoOutput, core);

    // TODO: Replace with table similar to old check
    core.summary.addCodeBlock(content);
  } else if (avocadoLog) {
    const content = (await readFileIfExists(avocadoLog, core))
      // Remove lines starting with "##vso"
      .replace(/^##vso.*(?:\r?\n)?/gm, "");
    core.summary.addCodeBlock(content);
  } else {
    const content = `Unable to read file '${avocadoOutput}' or '${avocadoLog}'`;
    core.summary.addCodeBlock(content);
  }

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
