import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import {
  details,
  escapeMarkdown,
  inlineCode,
  link,
  renderMarkdownDoc,
  section,
  table,
  type MarkdownDoc,
} from "../../shared/src/markdown.ts";
import { parseExistingComments } from "./comment.ts";
import type { Core, GitHub, GitHubScriptArgs, WebhookEvent } from "./github.ts";

const COMMAND = "/azsdk check-access";
const MARKER = "<!-- contributor-readiness -->";
const CHECK_NAME = "Contributor readiness";
const ONBOARDING = "https://aka.ms/azsdk/access";
const ORGANIZATIONS = ["Azure"] as const;

type PullRequest = Awaited<ReturnType<GitHub["rest"]["pulls"]["get"]>>["data"];
type Account = { id: number; login: string; type: string };
type Participant = Account & { roles: Set<string> };
export type ReadinessFinding = {
  subject: string;
  message: string;
  impacts?: string[];
  unknown?: boolean;
  organization?: (typeof ORGANIZATIONS)[number];
};

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

type UnresolvedCommitIdentity = { shas: Set<string>; roles: Set<string> };

/** Groups an unresolved commit author/committer by its git email, falling back to the commit. */
function recordUnresolvedIdentity(
  identities: Map<string, UnresolvedCommitIdentity>,
  email: string | null | undefined,
  sha: string,
  role: string,
): void {
  const key = email ? `email:${email}` : `commit:${sha}`;
  const identity = identities.get(key) ?? { shas: new Set(), roles: new Set() };
  identity.shas.add(sha);
  identity.roles.add(role);
  identities.set(key, identity);
}

/** Resolves a trigger to its PR; ignored commands and unmatched notification runs return null. */
export async function resolveReadinessPullRequest(
  inputs: GitHubScriptArgs,
): Promise<number | null> {
  const { context } = inputs;
  if (context.eventName === "issue_comment") {
    const { issue, comment, sender } = context.payload as WebhookEvent<"issue-comment", "created">;
    return issue.pull_request && comment.body.trim() === COMMAND && !isAutomation(sender)
      ? issue.number
      : null;
  }
  if (context.eventName !== "workflow_run") throw new Error("Unsupported readiness trigger");
  return resolveNotificationPullRequest(inputs);
}

/**
 * Resolves a PR/review notification from GitHub's run metadata, never fork-supplied artifacts.
 * Rejects unexpected workflows and incomplete or ambiguous PR associations.
 */
async function resolveNotificationPullRequest({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<number | null> {
  const payload = context.payload as WebhookEvent<"workflow-run", "completed">;
  const { data: run } = await github.rest.actions.getWorkflowRun({
    ...context.repo,
    run_id: payload.workflow_run.id,
  });
  if (
    run.repository.id !== payload.repository.id ||
    !["pull_request", "pull_request_review"].includes(run.event) ||
    run.path !== ".github/workflows/contributor-readiness-notify.yaml"
  ) {
    throw new Error("Unexpected contributor readiness notification workflow");
  }
  let numbers = (run.pull_requests ?? [])
    .filter((pr) => pr.base.repo.id === payload.repository.id)
    .map((pr) => pr.number);
  if (numbers.length === 0) {
    const { data } = await github.rest.search.issuesAndPullRequests({
      q: `repo:${context.repo.owner}/${context.repo.repo} is:pr is:open ${run.head_sha}`,
      per_page: PER_PAGE_MAX,
      advanced_search: "true",
    });
    if (data.incomplete_results || data.total_count > data.items.length) {
      throw new Error("Incomplete PR lookup for notification workflow; use /azsdk check-access");
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
      "Notification workflow matches multiple PRs; use /azsdk check-access on the intended PR",
    );
  }
  if (!candidates.length) core.info("No open PR found for the notification workflow.");
  return candidates[0] ?? null;
}

/**
 * Collects unique PR, commit and approved-review accounts with their roles.
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
  // Commits sharing an unresolvable email (e.g. one contributor's unlinked work email
  // across several commits) are grouped into a single finding instead of one per commit.
  const unresolvedIdentities = new Map<string, UnresolvedCommitIdentity>();
  for (const commit of commits) {
    const author = add(commit.author, "commit author");
    const committer = add(commit.committer, "committer");
    if (!author)
      recordUnresolvedIdentity(
        unresolvedIdentities,
        commit.commit?.author?.email,
        commit.sha,
        "author",
      );
    if (!committer)
      recordUnresolvedIdentity(
        unresolvedIdentities,
        commit.commit?.committer?.email,
        commit.sha,
        "committer",
      );
  }
  for (const [key, identity] of unresolvedIdentities) {
    const shas = [...identity.shas].map((sha) => sha.slice(0, 12));
    const roleLabel =
      identity.roles.size > 1
        ? "Author/committer"
        : identity.roles.has("author")
          ? "Author"
          : "Committer";
    const email = key.startsWith("email:") ? key.slice("email:".length) : undefined;
    findings.push({
      subject: email ?? `Commit ${shas[0]}`,
      unknown: true,
      message: email
        ? `${roleLabel} account unavailable; add or verify this email on a GitHub account. Affects ${
            shas.length === 1 ? "1 commit" : `${shas.length} commits`
          }: ${shas.join(", ")}.`
        : "Author/committer account unavailable; check the commit email.",
    });
  }
  const reviews = await github.paginate(github.rest.pulls.listReviews, {
    owner,
    repo,
    pull_number: pr.number,
    per_page: PER_PAGE_MAX,
  });
  for (const review of reviews) {
    if (review.state !== "APPROVED") continue;
    if (!add(review.user, "approved reviewer"))
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

/** Checks GitHub's base permission; maintain and custom roles inherit a base permission. */
async function writeAccess(github: GitHub, owner: string, repo: string, username: string) {
  const { data } = await github.rest.repos.getCollaboratorPermissionLevel({
    owner,
    repo,
    username,
  });
  return data.permission === "write" || data.permission === "admin";
}

/** Logs denied/unavailable lookups as unknown evidence; propagates other API failures. */
async function observe<T>(
  core: Core,
  findings: ReadinessFinding[],
  subject: string,
  operation: () => Promise<T>,
  unavailable = "Could not verify access; retry or ask a maintainer.",
  organization?: ReadinessFinding["organization"],
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
      organization,
    });
    return undefined;
  }
}

/** Appends human access findings and returns contributors whose checks all passed. */
export async function evaluateReadinessParticipants(
  github: GitHub,
  core: Core,
  owner: string,
  repo: string,
  participants: Participant[],
  findings: ReadinessFinding[],
): Promise<Participant[]> {
  const verifiedParticipants: Participant[] = [];
  for (const participant of participants) {
    if (isAutomation(participant)) continue;
    let membershipVerified = true;
    for (const org of ORGANIZATIONS) {
      const visible = await observe(
        core,
        findings,
        participant.login,
        () => publicMembership(github, org, participant.login),
        `Could not verify ${org} membership.`,
        org,
      );
      membershipVerified &&= visible === true;
      if (visible === false)
        findings.push({
          subject: participant.login,
          message: `${org} membership not public.`,
          organization: org,
        });
    }
    const write = await observe(
      core,
      findings,
      participant.login,
      () => writeAccess(github, owner, repo, participant.login),
      "Could not verify repository access.",
    );
    if (write === false) {
      const impacts: string[] = [];
      if (participant.roles.has("PR author")) {
        impacts.push("PR author cannot add labels to this PR.");
      }
      if (participant.roles.has("approved reviewer"))
        impacts.push(
          "Reviewer approval does not count toward required reviews (GitHub's green approval check). This reviewer must set up or renew their access.",
        );
      findings.push({
        subject: participant.login,
        message: "No repository write access.",
        impacts,
      });
    }
    if (membershipVerified && write === true) verifiedParticipants.push(participant);
  }
  return verifiedParticipants;
}

/** Builds an advisory report with prominent findings and collapsed verified contributors. */
export function renderReadiness(
  participants: Participant[],
  findings: ReadinessFinding[],
  verifiedParticipants: Participant[] = [],
): string {
  return renderMarkdownDoc(
    section(
      "Contributor readiness: required access",
      findings.length
        ? [
            "> [!WARNING]\n> **The access issues below can prevent PR approvals from counting or PR authors from adding labels.**",
            renderReadinessFindings(participants, findings),
            `Internal contributors: ${link("setup / renew required access", ONBOARDING)}. Recheck: ${inlineCode(COMMAND)}.`,
            renderVerifiedContributors(verifiedParticipants),
            "Non-blocking report; external fork contributions are allowed. GitHub review rules still apply.",
          ]
        : "✅ No contributor-readiness issues found.",
    ),
    2,
  );
}

/** Renders confirmed passes separately from findings, with bounded output. */
function renderVerifiedContributors(participants: Participant[]): string | undefined {
  if (!participants.length) return undefined;
  return details(
    `Contributors with verified access (${participants.length})`,
    renderMarkdownDoc([
      "Public Azure membership and repository write access verified.",
      table([
        ["User", "Roles"],
        ...participants
          .slice(0, 100)
          .map((participant) => [
            link(
              escapeMarkdown(participant.login),
              `https://github.com/${encodeURIComponent(participant.login)}`,
            ),
            [...participant.roles].map(escapeMarkdown).join(", "),
          ]),
      ]),
      participants.length > 100
        ? `${participants.length - 100} more verified contributors not shown.`
        : undefined,
    ]),
  );
}

/** Groups findings into escaped, linked user rows; yellow means unknown, not confirmed failure. */
function renderReadinessFindings(
  participants: Participant[],
  findings: ReadinessFinding[],
): MarkdownDoc {
  const users = new Set(participants.map((participant) => participant.login));
  const groups = new Map<
    string,
    { messages: Set<string>; impacts: Set<string>; unknown: boolean }
  >();
  for (const finding of findings) {
    const group = groups.get(finding.subject) ?? {
      messages: new Set<string>(),
      impacts: new Set<string>(),
      unknown: true,
    };
    group.messages.add(renderFindingMessage(finding));
    for (const impact of finding.impacts ?? []) group.impacts.add(escapeMarkdown(impact));
    group.unknown &&= finding.unknown === true;
    groups.set(finding.subject, group);
  }
  const entries = [...groups].sort(
    ([a, left], [b, right]) => Number(left.unknown) - Number(right.unknown) || a.localeCompare(b),
  );
  return [
    table([
      ["User / area", "Access issue", "PR impact"],
      ...entries.slice(0, 100).map(([subject, group]) => {
        const label = escapeMarkdown(subject);
        const user = users.has(subject)
          ? link(label, `https://github.com/${encodeURIComponent(subject)}`)
          : label;
        return [
          `${group.unknown ? "🟡" : "🔴"} **${user}**`,
          [...group.messages].join("<br>"),
          group.impacts.size ? [...group.impacts].join("<br>") : "Not determined.",
        ];
      }),
    ]),
    entries.length > 100 ? `${entries.length - 100} more entries not shown.` : undefined,
  ];
}

/** Escapes finding text and links its organization to a People search for the affected user. */
function renderFindingMessage(finding: ReadinessFinding): string {
  const message = escapeMarkdown(finding.message);
  const org = finding.organization;
  if (!org) return message;
  const query = new URLSearchParams({ query: finding.subject }).toString();
  return message.replace(org, link(org, `https://github.com/orgs/${org}/people?${query}`));
}

/**
 * Evaluates an open PR touching specification/, authorizes refreshes, and publishes the report.
 * Unexpected lookup failures are rethrown after publishing the available incomplete evidence.
 */
export async function checkContributorReadiness(
  inputs: GitHubScriptArgs,
  number: number,
): Promise<void> {
  if (!Number.isSafeInteger(number) || number <= 0) throw new Error("Invalid PR number");
  const { github, context, core } = inputs;
  const { owner, repo } = context.repo;
  const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: number });
  if (pr.state !== "open") {
    core.info("Skipping contributor readiness for a closed PR.");
    return;
  }
  if (!(await changesSpecifications(github, owner, repo, pr))) {
    core.info("Skipping contributor readiness: no changes under specification/.");
    return;
  }
  const findings: ReadinessFinding[] = [];
  let participants: Participant[] = [];
  let verifiedParticipants: Participant[] = [];
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
    verifiedParticipants = await evaluateReadinessParticipants(
      github,
      core,
      owner,
      repo,
      participants,
      findings,
    );
  } catch (error) {
    failure = error instanceof Error ? error : new Error("GitHub lookup failed", { cause: error });
    core.error("Contributor readiness could not complete its GitHub lookups.");
    findings.push({
      subject: "Evaluation",
      unknown: true,
      message: "Could not complete checks; rerun or use the refresh command.",
    });
  }
  await publishReadinessReport(inputs, pr, participants, findings, verifiedParticipants);
  if (failure) throw failure;
}

/** Checks current PR files for spec changes, including renames, without guessing on truncated results. */
async function changesSpecifications(
  github: GitHub,
  owner: string,
  repo: string,
  pr: PullRequest,
): Promise<boolean> {
  const files = await github.paginate(github.rest.pulls.listFiles, {
    owner,
    repo,
    pull_number: pr.number,
    per_page: PER_PAGE_MAX,
  });
  if (
    files.some(
      (file) =>
        file.filename.startsWith("specification/") ||
        file.previous_filename?.startsWith("specification/"),
    )
  )
    return true;
  if (files.length < pr.changed_files) {
    throw new Error(
      "Cannot determine specification scope: GitHub returned an incomplete changed-file list",
    );
  }
  return false;
}

/** Returns participants for an authorized refresh, or undefined after logging a denied request. */
async function collectAuthorizedRefreshParticipants(
  { github, context, core }: GitHubScriptArgs,
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
  { github, context, core }: GitHubScriptArgs,
  pr: PullRequest,
  participants: Participant[],
  findings: ReadinessFinding[],
  verifiedParticipants: Participant[],
): Promise<void> {
  const { owner, repo } = context.repo;
  const { data: latest } = await github.rest.pulls.get({ owner, repo, pull_number: pr.number });
  if (latest.state !== "open" || latest.head.sha !== pr.head.sha) {
    throw new Error("PR changed during evaluation; rerun contributor readiness");
  }
  const body = renderReadiness(participants, findings, verifiedParticipants);
  await core.summary.addRaw(body).write();
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
