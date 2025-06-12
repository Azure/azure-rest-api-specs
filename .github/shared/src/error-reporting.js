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
