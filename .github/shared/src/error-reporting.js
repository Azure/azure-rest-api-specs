// @ts-check
import * as fs from "fs";

/**
 * Set the summary of the github step summary for a job. This feature is intended for formatted markdown,
 * which can be used to display the results of a job in a more readable format.
 *
 * Format your results as a markdown table and go to town!
 * @param {string} content
 * @returns {void}
 */
export function setSummary(content) {
  if (!process.env.GITHUB_STEP_SUMMARY) {
    console.log("GITHUB_STEP_SUMMARY is not set. Skipping summary update.");
    return;
  }
  const summaryFile = process.env.GITHUB_STEP_SUMMARY;

  fs.writeFileSync(summaryFile, content);
}

/**
 * Set the output for a Github Actions step. The output is written to the GITHUB_OUTPUT environment variable.
 * This is used to pass data between steps in a workflow.
 *
 * To access this output later, leverage: ${{ steps.<step id>.outputs.<name> }}.
 *
 * This function is the equivalent of using `core.setOutput(name, value)` in a GitHub Action, without the package dependency.
 * @param {string} name - The name of the output variable.
 * @param {string} value - The value to set for the output variable.
 * @returns {void}
 */
export function setOutput(name, value) {
  if (!process.env.GITHUB_OUTPUT) {
    console.log(`GITHUB_OUTPUT is not set. Skipping ${name} update with value '${value}.'`);
    return;
  }

  if (process.env.GITHUB_OUTPUT) {
    fs.appendFileSync(process.env.GITHUB_OUTPUT, `${name}=${value}\n`);
  }
}

/**
 * This function is used to ask the github agent to annotate a file in a github PR with an error message.
 * @param {string} repoPath
 * @param {string} message
 * @param {number} line
 * @param {number} col
 * @returns {void}
 */
export function annotateFileError(repoPath, message, line, col) {
  const errorLine = `::error file=${repoPath},line=${line},col=${col}::${message}`;
  console.log(errorLine);
}
