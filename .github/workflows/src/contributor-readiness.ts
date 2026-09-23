import type { AsyncFunctionArguments } from "@actions/github-script";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import {
  escapeMarkdown,
  inlineCode,
  link,
  renderMarkdownDoc,
  section,
  table,
  type MarkdownDoc,
} from "../../shared/src/markdown.ts";
import { parseExistingComments } from "./comment.ts";
import type { Core, WebhookEvent } from "./github.ts";

const COMMAND = "/azsdk check-access";
const MARKER = "<!-- contributor-readiness -->";
const CHECK_NAME = "Contributor readiness";
const ONBOARDING = "https://aka.ms/azsdk/access";

type GitHub = AsyncFunctionArguments["github"];
type Inputs = Pick<AsyncFunctionArguments, "github" | "context" | "core">;
type PullRequest = Awaited<ReturnType<GitHub["rest"]["pulls"]["get"]>>["data"];
type Account = { id: number; login: string; type: string };
type Participant = Account & { roles: Set<string> };
export type ReadinessFinding = { subject: string; message: string; unknown?: boolean };

/** Extracts an HTTP status from an API error, leaving unrelated errors unclassified. */
function status(error: unknown): number | undefined {
  return error instanceof Error && "status" in error && typeof error.status === "number"
    ? error.status
    : undefined;
}

/** Identifies bots and GitHub's web-flow committer, which do not require human onboarding. */
function isAutomation(account: Account): boolean {
  return account.type === "Bot" || (account.id === 19864447 && account.login === "web-flow");
}

/** Resolves a trigger to its PR; ignored commands and unmatched review runs return null. */
export async function resolveReadinessPullRequest(inputs: Inputs): Promise<number | null> {
  const { context } = inputs;
  if (context.eventName === "pull_request_target") {
    return (context.payload as WebhookEvent<"pull-request">).pull_request.number;
  }
  if (context.eventName === "issue_comment") {
    const { issue, comment, sender } = context.payload as WebhookEvent<"issue-comment", "created">;
    return issue.pull_request && comment.body.trim() === COMMAND && !isAutomation(sender)
      ? issue.number
      : null;
  }
  if (context.eventName !== "workflow_run") throw new Error("Unsupported readiness trigger");
  return resolveReviewWorkflowPullRequest(inputs);
}

/**
 * Resolves a review notification from GitHub's run metadata, never fork-supplied artifacts.
 * Rejects unexpected workflows and incomplete or ambiguous PR associations.
 */
async function resolveReviewWorkflowPullRequest({
  github,
  context,
  core,
}: Inputs): Promise<number | null> {
  const payload = context.payload as WebhookEvent<"workflow-run", "completed">;
  const { data: run } = await github.rest.actions.getWorkflowRun({
    ...context.repo,
    run_id: payload.workflow_run.id,
  });
  if (
    run.repository.id !== payload.repository.id ||
    run.event !== "pull_request_review" ||
    run.path !== ".github/workflows/contributor-readiness-review.yaml"
  ) {
    throw new Error("Unexpected contributor readiness review workflow");
  }
  let numbers = (run.pull_requests ?? [])
    .filter((pr) => pr.base.repo.id === payload.repository.id)
    .map((pr) => pr.number);
  if (numbers.length === 0) {
    const { data } = await github.rest.search.issuesAndPullRequests({
      q: `repo:${context.repo.owner}/${context.repo.repo} is:pr is:open sha:${run.head_sha}`,
      per_page: PER_PAGE_MAX,
    });
    if (data.incomplete_results || data.total_count > data.items.length) {
      throw new Error("Incomplete PR lookup for review workflow; use /azsdk check-access");
    }
    numbers = data.items.map((pr) => pr.number);
  }
  const candidates: number[] = [];
  for (const number of new Set(numbers)) {
    const { data: pr } = await github.rest.pulls.get({ ...context.repo, pull_number: number });
    if (pr.state === "open" && pr.base.repo.id === payload.repository.id) candidates.push(number);
  }
  if (candidates.length > 1) {
    throw new Error(
      "Review workflow matches multiple PRs; use /azsdk check-access on the intended PR",
    );
  }
  if (!candidates.length) core.info("No open PR found for the review workflow.");
  return candidates[0] ?? null;
}

/**
 * Collects unique PR, commit and submitted-review accounts with their roles.
 * Appends unknown findings when identities or commit coverage cannot be resolved.
 */
export async function collectReadinessParticipants(
  github: GitHub,
  owner: string,
  repo: string,
  pr: PullRequest,
  findings: ReadinessFinding[],
): Promise<Participant[]> {
  const participants = new Map<number, Participant>();
  /** Adds a role to a resolvable account; returns false for missing or malformed identities. */
  function add(account: Account | Record<string, never> | null, role: string): boolean {
    if (
      !account ||
      typeof account.id !== "number" ||
      typeof account.login !== "string" ||
      typeof account.type !== "string"
    )
      return false;
    const participant = participants.get(account.id) ?? {
      id: account.id,
      login: account.login,
      type: account.type,
      roles: new Set<string>(),
    };
    participant.roles.add(role);
    participants.set(account.id, participant);
    return true;
  }
  if (!add(pr.user, "PR author")) {
    findings.push({
      subject: "PR author",
      unknown: true,
      message: "GitHub account unavailable.",
    });
  }
  const commits = await github.paginate(github.rest.pulls.listCommits, {
    owner,
    repo,
    pull_number: pr.number,
    per_page: PER_PAGE_MAX,
  });
  if (commits.length !== pr.commits) {
    findings.push({
      subject: "Commit coverage",
      unknown: true,
      message: `Only ${commits.length} of ${pr.commits} commits checked (GitHub limit: 250).`,
    });
  }
  for (const commit of commits) {
    const author = add(commit.author, "commit author");
    const committer = add(commit.committer, "committer");
    if (!author || !committer)
      findings.push({
        subject: `Commit ${commit.sha.slice(0, 12)}`,
        unknown: true,
        message: "Author/committer account unavailable; check the commit email.",
      });
  }
  const reviews = await github.paginate(github.rest.pulls.listReviews, {
    owner,
    repo,
    pull_number: pr.number,
    per_page: PER_PAGE_MAX,
  });
  for (const review of reviews) {
    if (review.state === "PENDING") continue;
    if (!add(review.user, "submitted reviewer"))
      findings.push({
        subject: `Review ${review.id}`,
        unknown: true,
        message: "Reviewer account unavailable.",
      });
  }
  return [...participants.values()].sort((a, b) => a.login.localeCompare(b.login));
}

/** Checks membership visibility; false means not public, not necessarily absent membership. */
async function publicMembership(github: GitHub, org: string, username: string): Promise<boolean> {
  try {
    await github.rest.orgs.checkPublicMembershipForUser({ org, username });
    return true;
  } catch (error) {
    if (status(error) === 404) return false;
    throw error;
  }
}

/** Checks effective repository write capability, including maintain/admin and custom grants. */
async function writeAccess(github: GitHub, owner: string, repo: string, username: string) {
  const { data } = await github.rest.repos.getCollaboratorPermissionLevel({
    owner,
    repo,
    username,
  });
  return (
    ["write", "maintain", "admin"].includes(data.permission) ||
    data.user?.permissions?.push === true
  );
}

/** Logs denied/unavailable lookups as unknown evidence; propagates other API failures. */
async function observe<T>(
  core: Core,
  findings: ReadinessFinding[],
  subject: string,
  operation: () => Promise<T>,
  unavailable = "Could not verify access; retry or ask a maintainer.",
): Promise<T | undefined> {
  try {
    return await operation();
  } catch (error) {
    // A denied lookup is not evidence that the participant lacks permission.
    if (![403, 404].includes(status(error) ?? 0)) throw error;
    core.warning(`${subject}: ${unavailable} GitHub returned ${status(error)}.`);
    findings.push({
      subject,
      unknown: true,
      message: unavailable,
    });
    return undefined;
  }
}

/** Appends public-membership and effective-access findings for human participants. */
export async function evaluateReadinessParticipants(
  github: GitHub,
  core: Core,
  owner: string,
  repo: string,
  participants: Participant[],
  findings: ReadinessFinding[],
): Promise<void> {
  for (const participant of participants) {
    if (isAutomation(participant)) continue;
    for (const org of ["Microsoft", "Azure"]) {
      const visible = await observe(
        core,
        findings,
        participant.login,
        () => publicMembership(github, org, participant.login),
        `Could not verify ${org} membership.`,
      );
      if (visible === false)
        findings.push({
          subject: participant.login,
          message: `${org} membership not public.`,
        });
    }
    const write = await observe(
      core,
      findings,
      participant.login,
      () => writeAccess(github, owner, repo, participant.login),
      "Could not verify repository access.",
    );
    if (write === false)
      findings.push({
        subject: participant.login,
        message: participant.roles.has("submitted reviewer")
          ? "No write access; approval cannot satisfy required reviews."
          : "No write access; fork contributions are still allowed.",
      });
  }
}

/** Builds a concise advisory report with only affected users and a setup/refresh link. */
export function renderReadiness(participants: Participant[], findings: ReadinessFinding[]): string {
  return renderMarkdownDoc(
    section(
      "Contributor readiness (advisory)",
      findings.length
        ? [
            renderReadinessFindings(participants, findings),
            `Internal contributors: ${link("setup / renew access", ONBOARDING)}. Recheck: ${inlineCode(COMMAND)}.`,
            "Advisory only; GitHub review rules still apply.",
          ]
        : "✅ No contributor-readiness issues found.",
    ),
    2,
  );
}

/** Groups findings into escaped, linked user rows; yellow means unknown, not confirmed failure. */
function renderReadinessFindings(
  participants: Participant[],
  findings: ReadinessFinding[],
): MarkdownDoc {
  const users = new Set(participants.map((participant) => participant.login));
  const groups = new Map<string, { messages: Set<string>; unknown: boolean }>();
  for (const finding of findings) {
    const group = groups.get(finding.subject) ?? { messages: new Set<string>(), unknown: true };
    group.messages.add(finding.message);
    group.unknown &&= finding.unknown === true;
    groups.set(finding.subject, group);
  }
  const entries = [...groups].sort(
    ([a, left], [b, right]) => Number(left.unknown) - Number(right.unknown) || a.localeCompare(b),
  );
  return [
    table([
      ["User / area", "Issue"],
      ...entries.slice(0, 100).map(([subject, group]) => {
        const label = escapeMarkdown(subject);
        const user = users.has(subject)
          ? link(label, `https://github.com/${encodeURIComponent(subject)}`)
          : label;
        return [
          `${group.unknown ? "🟡" : "🔴"} **${user}**`,
          [...group.messages].map(escapeMarkdown).join("<br>"),
        ];
      }),
    ]),
    entries.length > 100 ? `${entries.length - 100} more entries not shown.` : undefined,
  ];
}

/**
 * Evaluates an open PR, authorizes manual refreshes, and publishes the advisory report.
 * Unexpected lookup failures are rethrown after publishing the available incomplete evidence.
 */
export async function checkContributorReadiness(inputs: Inputs, number: number): Promise<void> {
  if (!Number.isSafeInteger(number) || number <= 0) throw new Error("Invalid PR number");
  const { github, context, core } = inputs;
  const { owner, repo } = context.repo;
  const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: number });
  if (pr.state !== "open") {
    core.info("Skipping contributor readiness for a closed PR.");
    return;
  }
  const findings: ReadinessFinding[] = [];
  let participants: Participant[] = [];
  let failure: Error | undefined;
  // A command must be authorized before it can publish or refresh the report.
  if (context.eventName === "issue_comment") {
    const authorizedParticipants = await collectAuthorizedRefreshParticipants(inputs, pr, findings);
    if (!authorizedParticipants) return;
    participants = authorizedParticipants;
  }
  try {
    if (context.eventName !== "issue_comment") {
      participants = await collectReadinessParticipants(github, owner, repo, pr, findings);
    }
    await evaluateReadinessParticipants(github, core, owner, repo, participants, findings);
  } catch (error) {
    failure = error instanceof Error ? error : new Error("GitHub lookup failed", { cause: error });
    core.error("Contributor readiness could not complete its GitHub lookups.");
    findings.push({
      subject: "Evaluation",
      unknown: true,
      message: "Could not complete checks; rerun or use the refresh command.",
    });
  }
  await publishReadinessReport(inputs, pr, participants, findings);
  if (failure) throw failure;
}

/** Returns participants for an authorized refresh, or undefined after logging a denied request. */
async function collectAuthorizedRefreshParticipants(
  { github, context, core }: Inputs,
  pr: PullRequest,
  findings: ReadinessFinding[],
): Promise<Participant[] | undefined> {
  const { owner, repo } = context.repo;
  const payload = context.payload as WebhookEvent<"issue-comment", "created">;
  if (
    payload.issue.number !== pr.number ||
    payload.comment.body.trim() !== COMMAND ||
    isAutomation(payload.sender)
  ) {
    throw new Error("Unexpected contributor readiness command");
  }
  const participants = await collectReadinessParticipants(github, owner, repo, pr, findings);
  const authorized =
    participants.some((person) => person.id === payload.sender.id) ||
    (await observe(core, [], "refresh authorization", () =>
      writeAccess(github, owner, repo, payload.sender.login),
    ));
  if (!authorized) {
    core.info("Ignoring refresh from a nonparticipant without verified write access.");
    return undefined;
  }
  return participants;
}

/** Verifies the PR head is still current, then publishes its check, comment and job summary. */
async function publishReadinessReport(
  { github, context, core }: Inputs,
  pr: PullRequest,
  participants: Participant[],
  findings: ReadinessFinding[],
): Promise<void> {
  const { owner, repo } = context.repo;
  const { data: latest } = await github.rest.pulls.get({ owner, repo, pull_number: pr.number });
  if (latest.state !== "open" || latest.head.sha !== pr.head.sha) {
    throw new Error("PR changed during evaluation; rerun contributor readiness");
  }
  const body = renderReadiness(participants, findings);
  await github.rest.checks.create({
    owner,
    repo,
    name: CHECK_NAME,
    head_sha: pr.head.sha,
    external_id: `contributor-readiness:${pr.number}`,
    status: "completed",
    conclusion: findings.length ? "neutral" : "success",
    output: {
      title: findings.some((finding) => finding.unknown)
        ? "Could not fully verify contributor readiness"
        : findings.length
          ? "Contributor readiness needs attention"
          : "No contributor-readiness issues found",
      summary: body,
    },
  });
  await updateReadinessComment(github, owner, repo, pr.number, body, findings.length > 0);
  await core.summary.addRaw(body).write();
}

/**
 * Updates only the Actions bot's marked comment, resolving it when findings disappear.
 * Creates a comment only for findings and leaves identical content untouched.
 */
async function updateReadinessComment(
  github: GitHub,
  owner: string,
  repo: string,
  number: number,
  body: string,
  hasFindings: boolean,
): Promise<void> {
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
  const commentBody = `${body}\n${MARKER}`;
  if (commentId && oldBody !== commentBody) {
    await github.rest.issues.updateComment({
      owner,
      repo,
      comment_id: commentId,
      body: commentBody,
    });
  } else if (!commentId && hasFindings) {
    await github.rest.issues.createComment({
      owner,
      repo,
      issue_number: number,
      body: commentBody,
    });
  }
}
