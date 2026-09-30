import { createHash } from "node:crypto";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { escapeMarkdown } from "../../shared/src/markdown.ts";
import type { GitHubScriptArgs } from "./github.ts";

export const BATCH_SIZE = 5;
export const STATE_BRANCH = "automation/backlog-triage";
const STATE_PATH = "state.json";
const REVISIT_MS = 90 * 24 * 60 * 60 * 1000;
const RETRY_MS = 24 * 60 * 60 * 1000;
const FEEDBACK_LABEL = "needs-author-feedback";
const EXCLUDED_LABELS = [FEEDBACK_LABEL, "no-recent-activity", "skip-backlog-triage"];
const ACTIONS = [
  "resolved",
  "obsolete",
  "duplicate",
  "needs_author_feedback",
  "keep_open",
  "blocked",
] as const;
type Action = (typeof ACTIONS)[number];
export interface Selection {
  number: number;
  updatedAt: string;
}
interface StateEntry {
  updatedAt: string;
  reviewedAt: string;
  action: Action;
}
interface State {
  version: 1;
  issues: Record<string, StateEntry>;
}
export interface Decision {
  number: number;
  action: Action;
  confidence: "high" | "medium" | "low";
  rationale: string;
  evidence: string[];
  question?: string;
  duplicateOf?: number;
}
type Issue = Awaited<ReturnType<GitHubScriptArgs["github"]["rest"]["issues"]["get"]>>["data"];

function record(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function isAction(value: unknown): value is Action {
  return typeof value === "string" && ACTIONS.some((action) => action === value);
}

function isClosure(action: Action): boolean {
  return ["resolved", "obsolete", "duplicate"].includes(action);
}

function timestamp(value: unknown): value is string {
  return typeof value === "string" && Number.isFinite(Date.parse(value));
}

function text(value: unknown, max = 2000): value is string {
  return typeof value === "string" && value.trim().length > 0 && value.length <= max;
}

function status(error: unknown): number | undefined {
  return record(error) && typeof error.status === "number" ? error.status : undefined;
}

export function parseState(value: unknown): State {
  if (!record(value) || value.version !== 1 || !record(value.issues)) {
    throw new Error("Invalid backlog triage state");
  }
  const issues: State["issues"] = {};
  for (const [number, entry] of Object.entries(value.issues)) {
    if (
      !/^[1-9]\d*$/.test(number) ||
      !Number.isSafeInteger(Number(number)) ||
      !record(entry) ||
      !timestamp(entry.updatedAt) ||
      !timestamp(entry.reviewedAt) ||
      !isAction(entry.action)
    ) {
      throw new Error(`Invalid backlog triage state entry: ${number}`);
    }
    issues[number] = {
      updatedAt: entry.updatedAt,
      reviewedAt: entry.reviewedAt,
      action: entry.action,
    };
  }
  return { version: 1, issues };
}

async function loadState({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<{ state: State; sha: string | undefined }> {
  try {
    await github.rest.repos.getBranch({ ...context.repo, branch: STATE_BRANCH });
  } catch (error) {
    if (status(error) !== 404) throw error;
    core.info("No backlog triage state branch yet; starting with the oldest open issues.");
    return { state: { version: 1, issues: {} } satisfies State, sha: undefined };
  }
  const { data } = await github.rest.repos.getContent({
    ...context.repo,
    ref: STATE_BRANCH,
    path: STATE_PATH,
  });
  if (Array.isArray(data) || data.type !== "file" || data.encoding !== "base64") {
    throw new Error("Backlog triage state must be a base64-encoded JSON file");
  }
  return {
    state: parseState(JSON.parse(Buffer.from(data.content, "base64").toString("utf8"))),
    sha: data.sha,
  };
}

async function saveState(args: GitHubScriptArgs, state: State, sha: string | undefined) {
  const { github, context } = args;
  const content = `${JSON.stringify(state, null, 2)}\n`;
  if (Buffer.byteLength(content) > 900_000) throw new Error("Backlog triage state exceeds 900 KB");
  if (!sha) {
    const { data: tree } = await github.rest.git.createTree({
      ...context.repo,
      tree: [{ path: STATE_PATH, mode: "100644", type: "blob", content }],
    });
    const { data: commit } = await github.rest.git.createCommit({
      ...context.repo,
      message: "Initialize backlog triage progress",
      tree: tree.sha,
      parents: [],
    });
    await github.rest.git.createRef({
      ...context.repo,
      ref: `refs/heads/${STATE_BRANCH}`,
      sha: commit.sha,
    });
  } else {
    await github.rest.repos.createOrUpdateFileContents({
      ...context.repo,
      branch: STATE_BRANCH,
      path: STATE_PATH,
      message: "Record backlog triage progress",
      content: Buffer.from(content).toString("base64"),
      sha,
    });
  }
}

function excluded(issue: Issue): boolean {
  return (
    issue.state !== "open" ||
    Boolean(issue.pull_request) ||
    issue.locked ||
    issue.labels.some((label) =>
      EXCLUDED_LABELS.includes(typeof label === "string" ? label : (label.name ?? "")),
    )
  );
}

export async function selectBacklogIssues(
  args: GitHubScriptArgs,
  requestedIssue = "",
  now = new Date(),
): Promise<Selection[]> {
  const { github, context, core } = args;
  const { state } = await loadState(args);
  const selected: Selection[] = [];
  const consider = (issue: Issue) => {
    const prior = state.issues[issue.number];
    if (
      excluded(issue) ||
      selected.some((item) => item.number === issue.number) ||
      (prior && isClosure(prior.action))
    )
      return;
    if (
      !requestedIssue &&
      prior?.updatedAt === issue.updated_at &&
      now.getTime() - Date.parse(prior.reviewedAt) <
        (prior.action === "blocked" ? RETRY_MS : REVISIT_MS)
    ) {
      return;
    }
    selected.push({ number: issue.number, updatedAt: issue.updated_at });
  };
  if (requestedIssue) {
    if (!/^[1-9]\d*$/.test(requestedIssue) || !Number.isSafeInteger(Number(requestedIssue))) {
      throw new Error("issue_number must be a positive safe integer");
    }
    consider(
      (await github.rest.issues.get({ ...context.repo, issue_number: Number(requestedIssue) }))
        .data,
    );
  } else {
    for (let page = 1; selected.length < BATCH_SIZE; page++) {
      const { data } = await github.rest.issues.listForRepo({
        ...context.repo,
        state: "open",
        sort: "created",
        direction: "asc",
        per_page: PER_PAGE_MAX,
        page,
      });
      for (const issue of data) {
        consider(issue);
        if (selected.length === BATCH_SIZE) break;
      }
      if (data.length < PER_PAGE_MAX) break;
    }
  }
  core.setOutput("selection", JSON.stringify(selected));
  core.setOutput("has_issues", selected.length > 0 ? "true" : "false");
  core.setOutput("source_sha", context.sha);
  core.info(
    `Selected ${selected.length} oldest eligible issue(s): ${selected.map((i) => i.number).join(", ")}`,
  );
  return selected;
}

export function parseSelection(value: unknown): Selection[] {
  if (!Array.isArray(value) || value.length < 1 || value.length > BATCH_SIZE) {
    throw new Error("Expected one to five selected issues");
  }
  const result = value.map((item): Selection => {
    if (
      !record(item) ||
      typeof item.number !== "number" ||
      !Number.isSafeInteger(item.number) ||
      item.number < 1 ||
      !timestamp(item.updatedAt)
    ) {
      throw new Error("Invalid selected issue");
    }
    return { number: item.number, updatedAt: item.updatedAt };
  });
  if (new Set(result.map((item) => item.number)).size !== result.length) {
    throw new Error("Duplicate selected issue");
  }
  return result;
}

export function parseDecisions(output: unknown, selection: Selection[]): Decision[] {
  if (!record(output) || !Array.isArray(output.items)) throw new Error("Invalid safe output");
  const calls = output.items.filter((item) => record(item) && item.type === "apply_backlog_triage");
  if (calls.length !== 1 || !record(calls[0]) || typeof calls[0].decisions !== "string") {
    throw new Error("Expected exactly one apply_backlog_triage call");
  }
  const decisions: unknown = JSON.parse(calls[0].decisions);
  if (!Array.isArray(decisions) || decisions.length !== selection.length) {
    throw new Error("Every selected issue must have exactly one decision");
  }
  const seen = new Set<number>();
  return decisions.map((item): Decision => {
    if (
      !record(item) ||
      typeof item.number !== "number" ||
      !selection.some((issue) => issue.number === item.number) ||
      seen.has(item.number) ||
      !isAction(item.action) ||
      !["high", "medium", "low"].includes(String(item.confidence)) ||
      !text(item.rationale) ||
      !Array.isArray(item.evidence) ||
      item.evidence.length > 8
    ) {
      throw new Error("Invalid or out-of-batch triage decision");
    }
    const evidence = item.evidence.map((url: unknown) => {
      if (!text(url, 2000)) throw new Error("Invalid evidence URL");
      const parsed = new URL(url);
      if (parsed.protocol !== "https:" || parsed.username || parsed.password) {
        throw new Error("Evidence must be a public HTTPS URL without credentials");
      }
      return parsed.href.replaceAll("<", "%3C").replaceAll(">", "%3E");
    });
    if (isClosure(item.action) && (item.confidence !== "high" || !evidence.length)) {
      throw new Error("Closing an issue requires high confidence and evidence");
    }
    if (item.action === "needs_author_feedback" && !text(item.question, 1000)) {
      throw new Error("Author feedback requires a specific question");
    }
    if (
      item.action === "duplicate" &&
      (typeof item.duplicateOf !== "number" ||
        !Number.isSafeInteger(item.duplicateOf) ||
        item.duplicateOf < 1 ||
        item.duplicateOf === item.number)
    ) {
      throw new Error("A duplicate requires a different canonical issue number");
    }
    seen.add(item.number);
    return {
      number: item.number,
      action: item.action,
      confidence: item.confidence as Decision["confidence"],
      rationale: item.rationale,
      evidence,
      ...(item.action === "needs_author_feedback" ? { question: String(item.question) } : {}),
      ...(item.action === "duplicate" ? { duplicateOf: Number(item.duplicateOf) } : {}),
    };
  });
}

export async function applyBacklogTriage(
  args: GitHubScriptArgs,
  selection: Selection[],
  output: unknown,
  staged: boolean,
  now = new Date(),
) {
  const decisions = parseDecisions(output, selection);
  const { github, context, core } = args;
  let { state, sha } = await loadState(args);
  for (const decision of decisions) {
    const issueParams = { ...context.repo, issue_number: decision.number };
    const { data: issue } = await github.rest.issues.get(issueParams);
    const selected = selection.find((item) => item.number === decision.number)!;
    if (excluded(issue) || issue.updated_at !== selected.updatedAt) {
      core.warning(
        `Skipping ${issue.html_url}: changed or became ineligible during investigation.`,
      );
      continue;
    }
    const comments = await github.paginate(github.rest.issues.listComments, {
      ...issueParams,
      per_page: PER_PAGE_MAX,
    });
    const ownComments = comments.filter(
      (comment) =>
        comment.user?.login === "github-actions[bot]" &&
        comment.body?.includes("<!-- backlog-triage:"),
    );
    const events = await github.paginate(github.rest.issues.listEvents, {
      ...issueParams,
      per_page: PER_PAGE_MAX,
    });
    if (
      (state.issues[issue.number] && isClosure(state.issues[issue.number].action)) ||
      events.some(
        (event) =>
          event.event === "reopened" &&
          ownComments.some(
            (comment) =>
              comment.body?.includes("<!-- backlog-triage:close:") &&
              event.created_at >= comment.created_at,
          ),
      )
    ) {
      core.warning(`Leaving reopened issue ${issue.html_url} for human review.`);
      continue;
    }
    if (decision.duplicateOf !== undefined) {
      const { data: canonical } = await github.rest.issues.get({
        ...context.repo,
        issue_number: decision.duplicateOf,
      });
      if (canonical.pull_request || canonical.state !== "open") {
        throw new Error("Duplicate target must be an open issue in this repository");
      }
    }
    const result = `${decision.action}: ${escapeMarkdown(decision.rationale)}`;
    core.info(`${staged ? "Preview" : "Triage"} ${issue.html_url}: ${result}`);
    if (staged) {
      await core.summary
        .addRaw(`\n- [${decision.number}](${issue.html_url}) **Preview:** ${result}\n`)
        .write();
      continue;
    }
    const { data: fresh } = await github.rest.issues.get(issueParams);
    if (excluded(fresh) || fresh.updated_at !== selected.updatedAt) {
      core.warning(`Skipping ${issue.html_url}: changed while checking the decision.`);
      continue;
    }
    if (decision.action === "blocked") {
      core.warning(`Retrying ${issue.html_url} after 24 hours: ${decision.rationale}`);
    } else if (decision.action !== "keep_open") {
      if (decision.action === "needs_author_feedback") {
        await github.rest.issues.getLabel({ ...context.repo, name: FEEDBACK_LABEL });
      }
      const canonical = decision.duplicateOf
        ? `\n\nTracked in https://github.com/${context.repo.owner}/${context.repo.repo}/issues/${decision.duplicateOf}.`
        : "";
      const content = [
        "_Automated backlog triage._",
        escapeMarkdown(decision.rationale) + canonical,
        ...(decision.evidence.length
          ? [`Evidence:\n${decision.evidence.map((url) => `- <${url}>`).join("\n")}`]
          : []),
        decision.action === "needs_author_feedback"
          ? `${escapeMarkdown(decision.question!)}\n\nPlease reply here. We are marking this needs-author-feedback; the repository's existing reminder and inactivity-closure policy applies.`
          : "Closing this issue based on the evidence above. If this still affects you, please reopen it with the affected API version and any remaining symptoms. If you cannot reopen it, please comment here or open a new issue linking this one.",
      ].join("\n\n");
      const hash = createHash("sha256").update(content).digest("hex").slice(0, 16);
      const marker = `<!-- backlog-triage:${isClosure(decision.action) ? "close" : "feedback"}:${hash} -->`;
      if (!ownComments.some((comment) => comment.body?.includes(marker))) {
        await github.rest.issues.createComment({ ...issueParams, body: `${content}\n\n${marker}` });
      }
      if (decision.action === "needs_author_feedback") {
        await github.rest.issues.addLabels({ ...issueParams, labels: [FEEDBACK_LABEL] });
      } else {
        await github.rest.issues.update({
          ...issueParams,
          state: "closed",
          state_reason: decision.action === "resolved" ? "completed" : "not_planned",
        });
      }
    }
    state.issues[issue.number] = {
      updatedAt: selected.updatedAt,
      reviewedAt: now.toISOString(),
      action: decision.action,
    };
    await saveState(args, state, sha);
    ({ state, sha } = await loadState(args));
    await core.summary
      .addRaw(
        `\n- [${decision.number}](${issue.html_url}) **${decision.action === "blocked" ? "Retry scheduled" : "Applied"}:** ${result}\n`,
      )
      .write();
  }
}
