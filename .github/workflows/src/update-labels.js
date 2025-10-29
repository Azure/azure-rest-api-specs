// @ts-check

import { isFullGitSha } from "../../shared/src/git.js";
import { PER_PAGE_MAX } from "../../shared/src/github.js";
import { extractInputs } from "../src/context.js";

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
export default async function updateLabels({ github, context, core }) {
  const { owner, repo, head_sha, issue_number, run_id } = await extractInputs(
    github,
    context,
    core,
  );
  await updateLabelsImpl({ owner, repo, head_sha, issue_number, run_id, github, core });
}

/**
 * @param {Object} params
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {string} params.head_sha
 * @param {number} params.issue_number
 * @param {number} params.run_id
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} params.github
 * @param {typeof import("@actions/core")} params.core
 */
export async function updateLabelsImpl({
  owner,
  repo,
  head_sha,
  issue_number,
  run_id,
  github,
  core,
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

  /** @type {string[]} */
  let artifactNames = [];

  if (run_id) {
    // List artifacts from a single run_id
    core.info(`listWorkflowRunArtifacts(${owner}, ${repo}, ${run_id})`);
    const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
      owner: owner,
      repo: repo,
      run_id: run_id,
      per_page: PER_PAGE_MAX,
    });

    artifactNames = artifacts.map((a) => a.name);
  } else {
    // TODO: List all artifacts of all workflows associated with issue_number
    throw new Error("Required input 'run_id' not found in env or context");
  }

  core.info(`artifactNames: ${JSON.stringify(artifactNames)}`);

  /** @type {string[]} */
  const labelsToAdd = [];

  /** @type {string[]} */
  const labelsToRemove = [];

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
