/**
 * Verify namespace approval status and set check result.
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function statusCheck({ github, context, core }) {
  const { data: pr } = await github.rest.pulls.get({
    owner: context.repo.owner,
    repo: context.repo.repo,
    pull_number: /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (context.payload)
      .pull_request.number,
  });
  /** @type {string[]} */
  const labels = pr.labels.map((l) => l.name ?? "");

  if (!labels.includes("namespace-review-required")) {
    core.info("No namespace review required, passing");
    return;
  }

  const pendingLabels = labels.filter((l) => l.endsWith("-namespace-pending"));
  if (pendingLabels.length > 0) {
    core.setFailed(
      `Namespace approval pending for: ${pendingLabels.map((l) => l.replace("-namespace-pending", "")).join(", ")}`,
    );
  } else if (labels.includes("namespace-approved")) {
    core.info("All namespaces approved - merge allowed");
  }
}
