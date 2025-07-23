/**
 * Checks an input branch name and determines if it should be considered a release branch.
 * @param {string} branchName
 * @returns {boolean}
 */
export function isReleaseBranch(branchName) {
  const branchRegex = [/main/, /RPSaaSMaster/, /release*/, /ARMCoreRPDev/];
  return branchRegex.some((b) => b.test(branchName));
}
