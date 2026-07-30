/**
 * Remove a label from an issue/PR, ignoring 404 (label not present).
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} github
 * @param {string} owner
 * @param {string} repo
 * @param {number} issueNumber
 * @param {string} label
 */
export async function removeLabelIfPresent(github, owner, repo, issueNumber, label) {
  try {
    await github.rest.issues.removeLabel({
      owner,
      repo,
      issue_number: issueNumber,
      name: label,
    });
  } catch (error) {
    if (error instanceof Error && "status" in error && error.status === 404) {
      return;
    }
    throw error;
  }
}
