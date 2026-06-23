import { extractInputs } from "../context.js";

/**
 * Verify namespace approval status and set check result.
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function statusCheck({ github, context, core }) {
  const { owner, repo, issue_number } = await extractInputs(github, context, core);
  const { data: pr } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issue_number,
  });
  /** @type {string[]} */
  const labels = pr.labels.map((label) => label.name ?? "");

  if (!labels.includes("namespace-review-required")) {
    core.info("No namespace review required, passing");
    return;
  }

  const pendingLabels = labels.filter((label) => label.endsWith("-namespace-pending"));
  if (pendingLabels.length > 0) {
    core.setFailed(
      `Namespace approval pending for: ${pendingLabels.map((label) => label.replace("-namespace-pending", "")).join(", ")}`,
    );
  } else if (labels.includes("namespace-approved")) {
    core.info("All namespaces approved - merge allowed");
  }
}
