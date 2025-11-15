/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function dumpTriggerMetadata({ context, core }) {
  core.info(`Event name: ${context.eventName}`);
  core.info(`Action: ${context.payload.action}`);

  if (
    context.eventName === "workflow_run" &&
    context.payload.action === "completed" &&
    context.payload.workflow_run
  ) {
    const payload = /** @type {import("@octokit/webhooks-types").WorkflowRunCompletedEvent} */ (
      context.payload
    );

    const run = payload.workflow_run;
    core.info(`Triggering workflow: ${run.name}`);
    core.info(`Triggering workflow ID: ${run.id}`);
    core.info(`Triggering run ID: ${run.run_number}`);
    core.info(`Triggering event: ${run.event}`);
    core.info(`Triggering status: ${run.status}`);
    core.info(`Triggering conclusion: ${run.conclusion}`);
    core.info(`Triggering branch: ${run.head_branch}`);
    core.info(`Triggering SHA: ${run.head_sha}`);
    core.info(`Triggering actor: ${run.actor?.login || "unknown"}`);

    // Create clickable URL to the triggering workflow run
    const triggeringRunUrl = `https://github.com/${context.repo.owner}/${context.repo.repo}/actions/runs/${run.id}`;
    core.info(`🔗 Triggering workflow run URL: ${triggeringRunUrl}`);

    // If there's a pull request associated, show that too
    if (run.pull_requests && run.pull_requests.length > 0) {
      run.pull_requests.forEach((pr) => {
        const prUrl = `https://github.com/${context.repo.owner}/${context.repo.repo}/pull/${pr.number}`;
        core.info(`🔗 Associated PR: ${prUrl}`);
      });
    }
  } else if (context.eventName === "pull_request_target" && context.payload.pull_request) {
    const payload = /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (
      context.payload
    );

    const pr = payload.pull_request;
    core.info(`PR number: ${pr.number}`);
    core.info(`PR title: ${pr.title}`);
    core.info(`PR state: ${pr.state}`);
    core.info(`PR head SHA: ${pr.head.sha}`);
    core.info(`PR base branch: ${pr.base.ref}`);
    core.info(`🔗 PR URL: ${pr.html_url}`);
  }
}
