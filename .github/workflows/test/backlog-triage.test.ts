import { readFileSync } from "node:fs";
import { describe, expect, it, vi } from "vitest";
import { isMap, isSeq, parseDocument } from "yaml";
import {
  applyBacklogTriage,
  parseDecisions,
  parseSelection,
  parseState,
  selectBacklogIssues,
  STATE_BRANCH,
  type Decision,
} from "../src/backlog-triage.ts";
import {
  createMockContext,
  createMockCore,
  createMockGithub,
  createMockRequestError,
} from "./mocks.ts";

const now = new Date("2026-09-30T02:00:00Z");
const updatedAt = "2026-01-01T00:00:00Z";
function issue(number: number) {
  return {
    number,
    state: "open",
    locked: false,
    created_at: `2017-01-${String(number).padStart(2, "0")}T00:00:00Z`,
    updated_at: updatedAt,
    html_url: `https://github.com/Azure/azure-rest-api-specs/issues/${number}`,
    labels: [] as string[],
  };
}
const selected = [{ number: 1, updatedAt }];
function decision(overrides: Partial<Decision> = {}): Decision {
  return {
    number: 1,
    action: "resolved",
    confidence: "high",
    rationale: "The reported version and current consumer contain the merged fix.",
    evidence: ["https://github.com/Azure/azure-rest-api-specs/pull/123"],
    ...overrides,
  };
}
function output(decisions: Decision[] = [decision()]) {
  return { items: [{ type: "apply_backlog_triage", decisions: JSON.stringify(decisions) }] };
}

function setup(initialState?: unknown) {
  const github = createMockGithub();
  const context = createMockContext();
  Object.assign(context, {
    repo: { owner: "Azure", repo: "azure-rest-api-specs" },
    sha: "a".repeat(40),
  });
  const core = createMockCore();
  let stored = initialState;
  let pendingState = "";
  const issues = new Map([
    [1, issue(1)],
    [2, issue(2)],
  ]);
  const comments: { user: { login: string }; body: string; created_at: string }[] = [];
  const get = vi.fn(({ issue_number }: { issue_number: number }) =>
    Promise.resolve({
      data: issues.get(issue_number),
    }),
  );
  const listForRepo = vi.fn().mockResolvedValue({ data: [...issues.values()] });
  const update = vi.fn(({ issue_number, state }: { issue_number: number; state: string }) => {
    Object.assign(issues.get(issue_number)!, { state, updated_at: now.toISOString() });
    return Promise.resolve({ data: issues.get(issue_number) });
  });
  const getLabel = vi.fn().mockResolvedValue({ data: { name: "needs-author-feedback" } });
  Object.assign(github.rest.issues, { get, listForRepo, update, getLabel });
  github.rest.issues.createComment.mockImplementation(({ body }: { body: string }) => {
    comments.push({ user: { login: "github-actions[bot]" }, body, created_at: now.toISOString() });
    return Promise.resolve({ data: comments.at(-1) });
  });
  github.rest.issues.listComments.mockImplementation(() => Promise.resolve({ data: comments }));

  const getBranch = vi.fn(() => {
    if (stored === undefined) return Promise.reject(createMockRequestError(404));
    return Promise.resolve({ data: { name: STATE_BRANCH } });
  });
  const getContent = vi.fn(() =>
    Promise.resolve({
      data: {
        type: "file",
        encoding: "base64",
        content: Buffer.from(JSON.stringify(stored)).toString("base64"),
        sha: "state-sha",
      },
    }),
  );
  const save = vi.fn(({ content }: { content: string }) => {
    stored = JSON.parse(Buffer.from(content, "base64").toString("utf8"));
    return Promise.resolve({});
  });
  Object.assign(github.rest.repos, { getBranch, getContent, createOrUpdateFileContents: save });
  const createTree = vi.fn(({ tree }: { tree: { content: string }[] }) => {
    pendingState = tree[0].content;
    return Promise.resolve({ data: { sha: "tree-sha" } });
  });
  const createCommit = vi.fn().mockResolvedValue({ data: { sha: "commit-sha" } });
  const createRef = vi.fn(() => {
    stored = JSON.parse(pendingState);
    return Promise.resolve({});
  });
  Object.assign(github.rest, { git: { createTree, createCommit, createRef } });
  const args = { github, context, core };
  return {
    args,
    github,
    core,
    issues,
    comments,
    get,
    listForRepo,
    update,
    getLabel,
    getBranch,
    getContent,
    save,
    createRef,
    state: () => stored,
    apply: (results = output(), staged = false) =>
      applyBacklogTriage(args, selected, results, staged, now),
  };
}

describe("backlog triage selection", () => {
  it("selects oldest open issues across pages, excluding PRs and waiting/opt-out issues", async () => {
    const t = setup();
    t.listForRepo
      .mockResolvedValueOnce({
        data: Array.from({ length: 100 }, (_, i) => ({ ...issue(i + 1), pull_request: {} })),
      })
      .mockResolvedValueOnce({
        data: [
          { ...issue(101), labels: ["needs-author-feedback"] },
          { ...issue(102), labels: [{ name: "skip-backlog-triage" }] },
          { ...issue(103), locked: true },
          { ...issue(104), labels: ["no-recent-activity"] },
          ...Array.from({ length: 7 }, (_, i) => issue(i + 105)),
        ],
      });
    expect(await selectBacklogIssues(t.args, "", now)).toEqual(
      [105, 106, 107, 108, 109].map((number) => ({ number, updatedAt })),
    );
    expect(t.listForRepo).toHaveBeenCalledWith(
      expect.objectContaining({
        page: 2,
        per_page: 100,
        sort: "created",
        direction: "asc",
        state: "open",
      }),
    );
  });

  it("moves past unchanged reviewed issues but revisits changed conversations", async () => {
    const t = setup({
      version: 1,
      issues: { 1: { updatedAt, reviewedAt: now.toISOString(), action: "keep_open" } },
    });

    expect(await selectBacklogIssues(t.args, "", now)).toEqual([{ number: 2, updatedAt }]);
    t.issues.get(1)!.updated_at = now.toISOString();
    expect(await selectBacklogIssues(t.args, "", now)).toHaveLength(2);
  });

  it("does not count duplicate issues when the paginated backlog changes", async () => {
    const t = setup();
    t.listForRepo
      .mockResolvedValueOnce({
        data: [
          ...Array.from({ length: 99 }, (_, i) => ({ ...issue(i + 10), pull_request: {} })),
          issue(1),
        ],
      })
      .mockResolvedValueOnce({ data: [issue(1), issue(2)] });
    expect(await selectBacklogIssues(t.args, "", now)).toEqual([
      { number: 1, updatedAt },
      { number: 2, updatedAt },
    ]);
  });

  it("revisits unchanged keep-open issues after 90 days, and blocked issues after one day", async () => {
    const t = setup({
      version: 1,
      issues: {
        1: { updatedAt, reviewedAt: "2026-06-01T00:00:00Z", action: "keep_open" },
        2: { updatedAt, reviewedAt: "2026-09-29T00:00:00Z", action: "blocked" },
      },
    });
    expect(await selectBacklogIssues(t.args, "", now)).toHaveLength(2);
  });

  it("does not automatically reclose a previously closed issue that was reopened", async () => {
    const t = setup({
      version: 1,
      issues: { 1: { updatedAt, reviewedAt: "2020-01-01T00:00:00Z", action: "resolved" } },
    });
    expect(await selectBacklogIssues(t.args, "1", now)).toEqual([]);
  });

  it("manual selection can revisit kept issues but cannot target a PR or an invalid number", async () => {
    const t = setup({
      version: 1,
      issues: { 1: { updatedAt, reviewedAt: now.toISOString(), action: "keep_open" } },
    });
    expect(await selectBacklogIssues(t.args, "1", now)).toEqual(selected);
    Object.assign(t.issues.get(1)!, { pull_request: {} });
    expect(await selectBacklogIssues(t.args, "1", now)).toEqual([]);
    await expect(selectBacklogIssues(t.args, "1; echo bad", now)).rejects.toThrow(
      "positive safe integer",
    );
  });

  it("does not reset progress on permission, corruption, or missing-state-file errors", async () => {
    const t = setup({ version: 1, issues: {} });
    t.getBranch.mockRejectedValueOnce(createMockRequestError(403));
    await expect(selectBacklogIssues(t.args)).rejects.toThrow("403");
    t.getContent.mockRejectedValueOnce(createMockRequestError(404));
    await expect(selectBacklogIssues(t.args)).rejects.toThrow("404");
    expect(() => parseState({ version: 2, issues: {} })).toThrow("Invalid backlog");
    expect(() => parseState({ version: 1, issues: { 1: { action: "resolved" } } })).toThrow(
      "entry",
    );
  });
});

describe("backlog triage output boundary", () => {
  it("rejects oversized/duplicate selections and out-of-batch or incomplete decisions", () => {
    expect(() => parseSelection(Array(6).fill(selected[0]))).toThrow();
    expect(() => parseSelection([selected[0], selected[0]])).toThrow("Duplicate");
    expect(() => parseDecisions(output([decision({ number: 2 })]), selected)).toThrow(
      "out-of-batch",
    );
    expect(() => parseDecisions(output([]), selected)).toThrow("Every selected");
    expect(() =>
      parseDecisions({ items: [...output().items, ...output().items] }, selected),
    ).toThrow("exactly one");
  });

  it("requires high-confidence closure evidence, concrete questions, and valid duplicate targets", () => {
    for (const bad of [
      decision({ confidence: "medium" }),
      decision({ evidence: [] }),
      decision({ evidence: ["http://example.com"] }),
      decision({ action: "needs_author_feedback" }),
      decision({ action: "duplicate", duplicateOf: 1 }),
    ]) {
      expect(() => parseDecisions(output([bad]), selected)).toThrow();
    }
  });

  it("dry-runs all actions without creating comments, labels, closures, or state", async () => {
    const t = setup();
    await t.apply(output(), true);
    expect(t.core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining("Preview"));
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(t.update).not.toHaveBeenCalled();
    expect(t.createRef).not.toHaveBeenCalled();
    expect(t.save).not.toHaveBeenCalled();
  });

  it.each(["resolved", "obsolete", "duplicate"] as const)(
    "closes %s with evidence and a reopening invitation, then saves progress",
    async (action) => {
      const t = setup();
      await t.apply(
        output([decision({ action, ...(action === "duplicate" ? { duplicateOf: 2 } : {}) })]),
      );
      expect(t.comments[0].body).toContain("please reopen");
      expect(t.update).toHaveBeenCalledWith(
        expect.objectContaining({
          issue_number: 1,
          state: "closed",
          state_reason: action === "resolved" ? "completed" : "not_planned",
        }),
      );
      expect(t.createRef).toHaveBeenCalledWith(
        expect.objectContaining({
          ref: `refs/heads/${STATE_BRANCH}`,
        }),
      );
      expect(parseState(t.state()).issues["1"].action).toBe(action);
    },
  );

  it("asks the specific question and adds author-feedback without replacing service labels", async () => {
    const t = setup();
    await t.apply(
      output([
        decision({
          action: "needs_author_feedback",
          question: "Does this reproduce with API version 2026-01-01?",
        }),
      ]),
    );
    expect(t.comments[0].body).toContain("API version 2026-01-01");
    expect(t.github.rest.issues.addLabels).toHaveBeenCalledWith(
      expect.objectContaining({
        labels: ["needs-author-feedback"],
      }),
    );
    expect(t.update).not.toHaveBeenCalled();
    expect(t.github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("fails before asking a question when the feedback label is unavailable", async () => {
    const t = setup();
    t.getLabel.mockRejectedValueOnce(createMockRequestError(404));
    await expect(
      t.apply(
        output([
          decision({
            action: "needs_author_feedback",
            question: "Which API version is affected?",
          }),
        ]),
      ),
    ).rejects.toThrow("404");
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(t.createRef).not.toHaveBeenCalled();
  });

  it.each(["keep_open", "blocked"] as const)(
    "records %s without noisy public comments",
    async (action) => {
      const t = setup();
      await t.apply(output([decision({ action, confidence: "medium", evidence: [] })]));
      expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
      expect(t.update).not.toHaveBeenCalled();
      expect(parseState(t.state()).issues["1"].action).toBe(action);
    },
  );

  it("skips newly changed, closed, labeled, or locked issues without advancing progress", async () => {
    for (const change of [
      { updated_at: now.toISOString() },
      { state: "closed" },
      { labels: ["needs-author-feedback"] },
      { locked: true },
    ]) {
      const t = setup();
      Object.assign(t.issues.get(1)!, change);
      await t.apply();
      expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
      expect(t.createRef).not.toHaveBeenCalled();
      expect(t.core.warning).toHaveBeenCalled();
    }
  });

  it("rechecks activity after reading comments and timeline, before posting", async () => {
    const t = setup();
    t.get
      .mockResolvedValueOnce({ data: issue(1) })
      .mockResolvedValueOnce({ data: { ...issue(1), updated_at: now.toISOString() } });
    await t.apply();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(t.createRef).not.toHaveBeenCalled();
  });

  it("protects a reopened issue even if the previous state write failed", async () => {
    const t = setup();
    t.comments.push({
      user: { login: "github-actions[bot]" },
      body: "<!-- backlog-triage:close:old -->",
      created_at: "2020-01-01T00:00:00Z",
    });
    t.github.rest.issues.listEvents.mockResolvedValueOnce({
      data: [{ event: "reopened", created_at: "2020-01-02T00:00:00Z" }],
    });
    await t.apply();
    expect(t.update).not.toHaveBeenCalled();
    expect(t.createRef).not.toHaveBeenCalled();
  });

  it("does not advance progress after an API failure and does not duplicate a retry comment", async () => {
    const t = setup();
    t.update.mockRejectedValueOnce(createMockRequestError(502));
    await expect(t.apply()).rejects.toThrow("502");
    expect(t.createRef).not.toHaveBeenCalled();
    await t.apply();
    expect(t.github.rest.issues.createComment).toHaveBeenCalledTimes(1);
    expect(t.update).toHaveBeenCalledTimes(2);
  });

  it("rejects a canonical PR or closed duplicate target before writing", async () => {
    const t = setup();
    t.issues.get(2)!.state = "closed";
    await expect(
      t.apply(output([decision({ action: "duplicate", duplicateOf: 2 })])),
    ).rejects.toThrow("open issue");
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("neutralizes untrusted mentions and markup in public comments", async () => {
    const t = setup();
    await t.apply(output([decision({ rationale: "@someone <script>text</script>" })]));
    const body = t.comments[0].body;
    expect(body).toContain("&#64;someone &lt;script&gt;");
    expect(body).not.toContain("<script>");
  });
});

describe("backlog triage workflow", () => {
  it("isolates writes to the trusted bounded applier and defaults manual runs to previews", () => {
    const content = readFileSync(new URL("../backlog-triage.md", import.meta.url), "utf8");
    const match = /^---\n([\s\S]*?)\n---/.exec(content);
    const doc = parseDocument(match![1]);
    expect(doc.errors).toEqual([]);
    expect(doc.getIn(["permissions", "issues"])).toBe("read");
    expect(doc.getIn(["permissions", "contents"])).toBe("read");
    expect(doc.getIn(["on", "workflow_dispatch", "inputs", "dry_run", "default"])).toBe(true);
    expect(doc.hasIn(["on", "issues"])).toBe(false);
    expect(doc.hasIn(["on", "issue_comment"])).toBe(false);
    expect(doc.getIn(["concurrency", "cancel-in-progress"])).toBe(false);
    expect(doc.hasIn(["safe-outputs", "close-issue"])).toBe(false);
    expect(doc.hasIn(["safe-outputs", "add-labels"])).toBe(false);
    expect(doc.getIn(["safe-outputs", "staged"])).toBe(
      "${{ github.event_name == 'workflow_dispatch' && inputs.dry_run }}",
    );
    expect(
      doc.getIn(["safe-outputs", "jobs", "apply-backlog-triage", "permissions", "issues"]),
    ).toBe("write");
  });

  it("compiles trusted batch transport and gates the write job on successful detection", () => {
    const doc = parseDocument(
      readFileSync(new URL("../backlog-triage.lock.yml", import.meta.url), "utf8"),
    );
    expect(doc.errors).toEqual([]);
    expect(doc.getIn(["jobs", "agent", "permissions", "issues"])).toBe("read");
    const preSteps = doc.getIn(["jobs", "pre_activation", "steps"]);
    const applySteps = doc.getIn(["jobs", "apply_backlog_triage", "steps"]);
    if (!isSeq(preSteps) || !isSeq(applySteps)) throw new Error("Missing compiled steps");
    const upload = preSteps.items.find(
      (step) => isMap(step) && step.get("name") === "Preserve trusted issue selection",
    );
    const download = applySteps.items.find(
      (step) => isMap(step) && step.get("name") === "Download trusted issue selection",
    );
    if (!isMap(upload) || !isMap(download)) throw new Error("Missing trusted batch transport");
    expect(upload.getIn(["with", "name"])).toBe("backlog-triage-selection");
    expect(download.getIn(["with", "name"])).toBe("backlog-triage-selection");
    expect(doc.getIn(["jobs", "apply_backlog_triage", "if"])).toContain(
      "needs.detection.result == 'success'",
    );
    expect(doc.getIn(["jobs", "apply_backlog_triage", "if"])).toContain(
      "needs.agent.result == 'success'",
    );
    const apply = applySteps.items.find(
      (step) => isMap(step) && step.get("name") === "Apply bounded triage decisions",
    );
    if (!isMap(apply)) throw new Error("Missing applier");
    expect(apply.getIn(["env", "TRIAGE_SELECTION_PATH"])).toBe(
      "${{ runner.temp }}/backlog-triage-selection/backlog-triage-selection.json",
    );
    expect(apply.getIn(["with", "script"])).toContain("process.env.GH_AW_SAFE_OUTPUTS_STAGED");
  });
});
