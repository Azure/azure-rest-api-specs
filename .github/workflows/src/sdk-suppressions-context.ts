import type { WorkflowArguments } from "./github.ts";

export function sdkSuppressionsContext({
  context,
  core,
}: Pick<WorkflowArguments, "context" | "core">) {
  const payload = context.payload as Partial<import("@octokit/webhooks-types").PullRequestEvent>;
  const pr = payload.pull_request;
  if (!pr) {
    throw new Error("This workflow must run in the context of a pull request.");
  }
  core.info(`This action trigger by ${context.eventName}`);
  core.setOutput(
    "prLabels",
    pr.labels.map((label) => label.name),
  );
}
