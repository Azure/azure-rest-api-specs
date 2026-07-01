import { extractInputs } from "../context.js";

/**
 * Verify namespace approval status and report as a commit status on the PR.
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
  const labels = pr.labels.map((/** @type {{ name?: string }} */ label) => label.name ?? "");

  if (!labels.includes("namespace-review-required")) {
    core.info("No namespace review required, passing");
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: pr.head.sha,
      state: "success",
      context: "Namespace Approval",
      description: "No namespace review required",
    });
    return;
  }

  const pendingLabels = labels.filter((label) => label.endsWith("-namespace-pending"));
  if (pendingLabels.length > 0) {
    const pending = pendingLabels.map((l) => l.replace("-namespace-pending", "")).join(", ");
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: pr.head.sha,
      state: "pending",
      context: "Namespace Approval",
      description: `Pending: ${pending}`,
    });
    core.info(`Namespace approval pending for: ${pending}`);
  } else if (labels.includes("namespace-approved")) {
    core.info("All namespaces approved - merge allowed");
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: pr.head.sha,
      state: "success",
      context: "Namespace Approval",
      description: "All namespaces approved",
    });
  } else {
    core.warning("namespace-review-required is set but no pending or approved labels found");
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: pr.head.sha,
      state: "pending",
      context: "Namespace Approval",
      description: "Namespace review in progress",
    });
  }
}
