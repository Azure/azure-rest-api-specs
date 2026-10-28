import { extractInputs } from "../context.js";

/**
 * Verify package name approval status and report as a commit status on the PR.
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

  if (!labels.includes("package-name-review-required")) {
    core.info("No package name review required, passing");
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: pr.head.sha,
      state: "success",
      context: "Package Name Approval",
      description: "No package name review required",
    });
    return;
  }

  const pendingLabels = labels.filter(
    (label) => label.startsWith("package-name-") && label.endsWith("-pending"),
  );
  if (pendingLabels.length > 0) {
    const pending = pendingLabels
      .map((l) => l.replace("package-name-", "").replace("-pending", ""))
      .join(", ");
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: pr.head.sha,
      state: "pending",
      context: "Package Name Approval",
      description: `Pending: ${pending}`,
    });
    core.info(`Package name approval pending for: ${pending}`);
  } else if (labels.includes("package-name-approved")) {
    core.info("All package names approved - merge allowed");
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: pr.head.sha,
      state: "success",
      context: "Package Name Approval",
      description: "All package names approved",
    });
  } else {
    core.warning("package-name-review-required is set but no pending or approved labels found");
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: pr.head.sha,
      state: "pending",
      context: "Package Name Approval",
      description: "Package name review in progress",
    });
  }
}
