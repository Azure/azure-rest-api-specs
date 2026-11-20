import { isFullGitSha } from "../../shared/src/git.ts";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { extractInputs, getWorkflowRunArtifactInputs } from "../src/context.ts";
import type { Context, Core, GitHub, GitHubScriptArgs, WebhookEvent } from "./github.ts";
import { ArmAutoSignoffLabel } from "./arm-auto-signoff/arm-auto-signoff-labels.ts";

export default async function updateLabels({ github, context, core }: GitHubScriptArgs) {
  const { owner, repo, head_sha, issue_number, run_id } =
    context.eventName === "workflow_dispatch"
      ? await getUniversalSourceRunInputs(github, context, core)
      : await extractInputs(github, context, core);
  await updateLabelsImpl({ owner, repo, head_sha, issue_number, run_id, github, core });
}

/**
 * Reads the PR and head SHA for a dispatched run from its `source_run_id`. Only a Universal
 * signoff run is accepted, never pull_request code or an arbitrary workflow.
 */
async function getUniversalSourceRunInputs(github: GitHub, context: Context, core: Core) {
  const runId = Number(
    (context.payload as WebhookEvent<"workflow-dispatch">).inputs?.source_run_id,
  );
  if (!Number.isSafeInteger(runId) || runId <= 0) {
    throw new Error("Update Labels dispatch requires a positive source run ID");
  }
  const { owner, repo } = context.repo;
  const { data: run } = await github.rest.actions.getWorkflowRun({ owner, repo, run_id: runId });
  // A pull_request run can execute a PR-modified copy of this file, so its artifacts are untrusted.
  if (
    run.path !== ".github/workflows/arm-universal-auto-signoff.yaml" ||
    !["workflow_dispatch", "workflow_run", "pull_request_target"].includes(run.event)
  ) {
    throw new Error("Update Labels dispatch source must be a Universal signoff run");
  }
  const { headSha, issueNumber } = await getWorkflowRunArtifactInputs({
    github,
    core,
    owner,
    repo,
    runId,
  });
  return { owner, repo, head_sha: headSha, issue_number: issueNumber, run_id: runId };
}

export async function updateLabelsImpl({
  owner,
  repo,
  head_sha,
  issue_number,
  run_id,
  github,
  core,
}: {
  owner: string;
  repo: string;
  head_sha: string;
  issue_number: number;
  run_id: number;
  github: GitHub;
  core: Core;
}) {
  if (isFullGitSha(head_sha)) {
    core.setOutput("head_sha", head_sha);
  } else {
    core.info(`head_sha is not a valid full git SHA: '${head_sha}'`);
  }

  if (Number.isInteger(issue_number) && issue_number > 0) {
    core.setOutput("issue_number", issue_number);
  } else {
    core.info(`issue_number must be a positive integer: ${issue_number}`);
  }

  if (!run_id) {
    // TODO: List all artifacts of all workflows associated with issue_number
    throw new Error("Required input 'run_id' not found in env or context");
  }

  // List artifacts from a single run_id
  core.info(`listWorkflowRunArtifacts(${owner}, ${repo}, ${run_id})`);
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner: owner,
    repo: repo,
    run_id: run_id,
    per_page: PER_PAGE_MAX,
  });

  const artifactNames: string[] = artifacts.map((a) => a.name);

  core.info(`artifactNames: ${JSON.stringify(artifactNames)}`);

  const labelsToAdd: string[] = [];

  const labelsToRemove: string[] = [];

  for (const artifactName of artifactNames) {
    // If artifactName has format "label-name=true|false", add or remove the label
    // Else, if artifactName has format "label-name=other-string", throw an error
    // Else, if artifactName does not start with "label-", ignore it
    const firstEquals = artifactName.indexOf("=");
    if (firstEquals !== -1) {
      const key = artifactName.substring(0, firstEquals);
      const value = artifactName.substring(firstEquals + 1);

      if (key.startsWith("label-")) {
        const name = key.substring("label-".length);

        if (!name) {
          throw new Error(`Invalid value for label name: '${name}'`);
        }

        if (value === "true") {
          labelsToAdd.push(name);
        } else if (value === "false") {
          labelsToRemove.push(name);
        } else {
          throw new Error(
            `Invalid value for label '${name}': ${value}.  Expected "true" or "false".`,
          );
        }
      }
    }
  }

  core.info(`labelsToAdd: ${JSON.stringify(labelsToAdd)}`);
  core.info(`labelsToRemove: ${JSON.stringify(labelsToRemove)}`);

  if ((labelsToAdd.length > 0 || labelsToRemove.length > 0) && Number.isNaN(issue_number)) {
    throw new Error(
      `Invalid value for 'issue_number':${issue_number}. Expected an 'issue-number' artifact created by the workflow run.`,
    );
  }

  const pullRequestUrl = `https://github.com/${owner}/${repo}/pull/${issue_number}`;
  core.info(`pull request url: ${pullRequestUrl}`);

  if (labelsToAdd.length > 0) {
    await github.rest.issues.addLabels({
      owner: owner,
      repo: repo,
      issue_number: issue_number,
      labels: labelsToAdd,
    });
  }

  if (labelsToRemove.length > 0) {
    // Remove ARMSignedOff before its auto-signoff markers. If a later removal fails, a lone marker
    // is harmless, whereas a lone ARMSignedOff would look like a human approval.
    labelsToRemove.sort(
      (a, b) =>
        Number(b === ArmAutoSignoffLabel.ArmSignedOff) -
        Number(a === ArmAutoSignoffLabel.ArmSignedOff),
    );
    // Must loop over labelsToRemove ourselves, since GitHub doesn't expose a REST API to remove in bulk.
    for (const name of labelsToRemove) {
      try {
        await github.rest.issues.removeLabel({
          owner: owner,
          repo: repo,
          issue_number: issue_number,
          name: name,
        });
      } catch (error) {
        if (error instanceof Error && "status" in error && error.status === 404) {
          core.info(`Ignoring error: ${error.status} - ${error.message}`);
        } else {
          throw error;
        }
      }
    }
  }
}
