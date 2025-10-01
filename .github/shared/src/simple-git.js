import { resolve } from "path";
import { simpleGit } from "simple-git";

/**
 *
 * @param {string} inputPath
 * @returns {Promise<string>}
 */
export async function getRootFolder(inputPath) {
  // expecting users to handle the case where inputPath is not a git repo
  const gitRoot = await simpleGit(inputPath).revparse("--show-toplevel");
  return resolve(gitRoot.trim());
}

/**
 *
 * @param {string} inputPath
 * @returns {Promise<string>}
 */
export async function getBranchName(inputPath) {
  // expecting users to handle the case where inputPath is not a git repo
  const branchName = await simpleGit(inputPath).revparse(["--abbrev-ref", "HEAD"]);
  return branchName.trim();
}

/**
 *
 * @param {string} inputPath
 * @returns {Promise<string>}
 */
export async function getSha(inputPath) {
  // expecting users to handle the case where inputPath is not a git repo
  const sha = await simpleGit(inputPath).revparse(["HEAD"]);
  return sha.trim();
}
