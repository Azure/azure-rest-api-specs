import { inlineCode, link, renderMarkdownDoc, section } from "../../shared/src/markdown.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

const WRONG_BRANCH_MESSAGE = renderMarkdownDoc(
  section(
    "This PR targets a read-only branch",
    `The ${inlineCode("main")} branch in ${inlineCode("Azure/azure-rest-api-specs-pr")} cannot accept PRs. ` +
      `Retarget private ARM changes to ${inlineCode("RPSaaSMaster")} or your team's private branch. ` +
      `For public API or tooling changes, follow the ${link("move PR guide", "https://aka.ms/azsdk/move-pr")}. ` +
      "**Do not move private API specifications to the public repository.**",
  ),
  2,
);

/** Reports private-main PRs on the current head and resolves the warning after retargeting. */
export async function checkTargetBranch({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<void> {
  const { owner, repo } = context.repo;
  if (owner.toLowerCase() !== "azure" || repo.toLowerCase() !== "azure-rest-api-specs-pr") {
    core.info("Target branch warnings only apply to Azure/azure-rest-api-specs-pr.");
    return;
  }
  if (context.eventName !== "pull_request_target") {
    throw new Error("Target branch requires a pull_request_target event");
  }
  const payload = context.payload as WebhookEvent<"pull-request">;
  const number = payload.pull_request?.number;
  if (!number) {
    throw new Error("Target branch requires a pull request number");
  }

  // Queued runs must report the current head and base, not stale event payloads.
  const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: number });
  if (pr.state !== "open") {
    core.info("Skipping target branch warning for a closed PR.");
    return;
  }
  const wrongBranch = pr.base.ref === "main";
  const summary = wrongBranch
    ? WRONG_BRANCH_MESSAGE
    : `This PR does not target the read-only ${inlineCode("main")} branch in ${inlineCode("Azure/azure-rest-api-specs-pr")}.`;
  await core.summary.addRaw(summary).write();
  await github.rest.checks.create({
    owner,
    repo,
    name: "Target branch",
    head_sha: pr.head.sha,
    external_id: `target-branch:${number}`,
    status: "completed",
    conclusion: wrongBranch ? "failure" : "success",
    output: {
      title: wrongBranch
        ? "Change the PR's target branch: main is read-only"
        : "Not targeting read-only main",
      summary,
    },
  });
}
