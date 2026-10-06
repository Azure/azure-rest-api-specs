import { readFile } from "node:fs/promises";
import { getWorkflowRunArtifactInputs } from "../context.ts";
import type { GitHub, GitHubScriptArgs } from "../github.ts";
import { parseSemanticReviewResult, type SemanticReviewResult } from "./arm-semantic-review.ts";

export async function validateSemanticReviewResult({
  owner,
  repo,
  result,
  github,
}: {
  owner: string;
  repo: string;
  result: SemanticReviewResult;
  github: GitHub;
}): Promise<void> {
  const { data: pullRequest } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: result.issueNumber,
  });
  if (pullRequest.state !== "open" || pullRequest.head.sha !== result.headSha) {
    throw new Error("The reviewed pull request head is no longer current");
  }
}

function encodeSemanticReviewReceipt(result: SemanticReviewResult): string {
  return [
    result.runAttempt,
    result.issueNumber,
    result.headSha,
    result.reviewScope,
    result.completion,
    result.blockingCount,
  ].join(".");
}

/* v8 ignore start */
export default async function validateArmSemanticReview({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<{
  artifactValue: string;
}> {
  const outputPath = process.env.GH_AW_AGENT_OUTPUT;
  if (!outputPath) {
    throw new Error("GH_AW_AGENT_OUTPUT is unavailable");
  }

  const runAttemptText = process.env.GITHUB_RUN_ATTEMPT;
  if (!runAttemptText || !/^[1-9]\d*$/.test(runAttemptText)) {
    throw new Error(`Invalid workflow run attempt: '${runAttemptText ?? ""}'`);
  }

  const runAttempt = Number(runAttemptText);
  const { headSha, issueNumber } = await getWorkflowRunArtifactInputs({
    github,
    core,
    ...context.repo,
    runId: context.runId,
  });
  const agentOutput = JSON.parse(await readFile(outputPath, "utf8")) as unknown;
  const result = parseSemanticReviewResult(agentOutput, {
    headSha,
    issueNumber,
    runAttempt,
  });
  await validateSemanticReviewResult({
    ...context.repo,
    result,
    github,
  });
  return {
    artifactValue: encodeSemanticReviewReceipt(result),
  };
}
/* v8 ignore stop */
