/**
 * Remove a label from an issue/PR, ignoring 404 (label not present).
 */
export async function removeLabelIfPresent(
  github: import("../github.ts").WorkflowArguments["github"],
  owner: string,
  repo: string,
  issueNumber: number,
  label: string,
) {
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
