import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { parseExistingComments } from "./comment.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

const MARKER = "<!-- target-branch -->";
const WRONG_BRANCH_MESSAGE =
  "## This PR targets a read-only branch\n\n" +
  "The `main` branch in `Azure/azure-rest-api-specs-pr` is a read-only mirror of " +
  "the public repository. PRs targeting it cannot be merged.\n\n" +
  "- For public API or repository tooling changes, open a PR against " +
  "[Azure/azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs)'s `main` branch. " +
  "Follow the [move PR guide](https://aka.ms/azsdk/move-pr).\n" +
  "- For private ARM API changes, edit this PR's base branch to `RPSaaSMaster`, " +
  "or your team's appropriate private development or release branch. " +
  "**Do not move private API specifications to the public repository.**\n\n" +
  "This check will update automatically when you change the base branch.";
const RESOLVED_MESSAGE =
  "## Target branch warning resolved\n\n" +
  "This PR no longer targets the read-only `main` branch in `Azure/azure-rest-api-specs-pr`.";

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

  const comments = await github.paginate(github.rest.issues.listComments, {
    owner,
    repo,
    issue_number: number,
    per_page: PER_PAGE_MAX,
  });
  const [commentId, oldBody] = parseExistingComments(
    comments.filter(
      (comment) => comment.user?.type === "Bot" && comment.user.login === "github-actions[bot]",
    ),
    MARKER,
  );

  // Fetch after comment pagination so queued runs report the latest head and base, not stale events.
  const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: number });
  if (pr.state !== "open") {
    core.info("Skipping target branch warning for a closed PR.");
    return;
  }
  const wrongBranch = pr.base.ref === "main";
  const summary = wrongBranch
    ? WRONG_BRANCH_MESSAGE
    : "This PR does not target the read-only `main` branch in `Azure/azure-rest-api-specs-pr`.";
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

  const body = `${wrongBranch ? WRONG_BRANCH_MESSAGE : RESOLVED_MESSAGE}\n${MARKER}`;
  if (commentId && oldBody !== body) {
    await github.rest.issues.updateComment({ owner, repo, comment_id: commentId, body });
  } else if (!commentId && wrongBranch) {
    await github.rest.issues.createComment({ owner, repo, issue_number: number, body });
  }
}
