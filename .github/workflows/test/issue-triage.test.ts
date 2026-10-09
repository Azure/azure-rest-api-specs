import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { beforeEach, describe, expect, it, vi } from "vitest";
import type { GitHub } from "../src/github.ts";
import { applyIssueTriage } from "../src/issue-triage.ts";
import { loadLabelCatalog } from "../src/label-catalog-loader.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

vi.mock("../src/label-catalog-loader.ts", () => ({ loadLabelCatalog: vi.fn() }));
vi.mock("node:fs/promises", () => ({ readFile: vi.fn() }));

const updatedAt = "2026-10-07T12:00:00Z";
const catalogPath = "/trusted/.github/labels.yaml";

function output(overrides: Record<string, unknown> = {}) {
  return {
    items: [
      {
        type: "apply_issue_triage",
        decision: JSON.stringify({
          number: 123,
          updatedAt,
          routing: "engsys",
          confidence: "high",
          kind: "bug",
          serviceLabel: null,
          plane: null,
          summary: "Validation crashes when a folder is renamed.",
          rationale: "The defect is in shared validation infrastructure.",
          ...overrides,
        }),
      },
    ],
  };
}

function setup() {
  const github = createMockGithub();
  const core = createMockCore();
  const context = Object.assign(createMockContext(), {
    repo: { owner: "Azure", repo: "azure-rest-api-specs" },
    ref: "refs/heads/main",
    eventName: "issues",
    runId: 456,
    payload: { action: "opened", issue: { number: 123 } },
  });
  const issue = {
    number: 123,
    title: "Validation fails after a folder rename",
    body: "The shared validation runner crashes on renamed specification folders.",
    state: "open",
    locked: false,
    pull_request: undefined as object | undefined,
    updated_at: updatedAt,
    labels: [] as string[],
    user: { login: "reporter", type: "User" },
  };
  const get = vi.fn().mockImplementation(() => Promise.resolve({ data: issue }));
  const getLabel = vi
    .fn()
    .mockImplementation(({ name }: { name: string }) =>
      Promise.resolve({ data: { name, archived_at: null } }),
    );
  const createComment =
    vi.fn<
      (
        params: NonNullable<Parameters<GitHub["rest"]["issues"]["createComment"]>[0]>,
      ) => Promise<void>
    >();
  const addLabels =
    vi.fn<
      (params: NonNullable<Parameters<GitHub["rest"]["issues"]["addLabels"]>[0]>) => Promise<void>
    >();
  Object.assign(github.rest.issues, { get, getLabel, createComment, addLabels });
  return {
    github,
    core,
    context,
    issue,
    get,
    getLabel,
    createComment,
    addLabels,
    apply: (result: unknown = output(), options: { issueNumber?: string; dryRun?: boolean } = {}) =>
      applyIssueTriage({ github, core, context }, result, {
        catalogPath,
        issueNumber: "123",
        dryRun: false,
        ...options,
      }),
  };
}

beforeEach(() => {
  vi.clearAllMocks();
  vi.mocked(readFile).mockResolvedValue(
    JSON.stringify({
      labels: ["Storage", "Compute", "AppPlatform", "Docs", "EngSys"].map((name) => ({ name })),
    }),
  );
  vi.mocked(loadLabelCatalog).mockResolvedValue({
    catalog: {
      unconfiguredLabels: "archive",
      labels: [
        "EngSys",
        "Service Attention",
        "needs-team-triage",
        "bug",
        "feature-request",
        "question",
        "documentation",
        "Mgmt",
        "data-plane",
        "Storage",
        "Compute",
        "AppPlatform",
        "Docs",
        "Approved-Suppression",
      ].map((name) => ({
        name,
        color: ["Storage", "Compute", "EngSys", "Docs"].includes(name) ? "e99695" : "000000",
        description: "",
      })),
    },
    sources: [{ path: ".github/labels.yaml", hash: "a".repeat(64) }],
    hash: "b".repeat(64),
  });
});

describe("initial issue triage", () => {
  it("adds EngSys and a clear kind without replacing existing labels", async () => {
    const t = setup();
    t.issue.labels = ["customer-reported", "question"];
    await t.apply();
    expect(t.github.rest.issues.addLabels).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      issue_number: 123,
      labels: ["EngSys", "bug"],
    });
    expect(t.github.rest.issues.removeLabel).not.toHaveBeenCalled();
    expect(t.createComment).toHaveBeenCalledTimes(1);
    expect(t.createComment.mock.calls[0][0].issue_number).toBe(123);
    expect(t.createComment.mock.calls[0][0].body).toContain("**Routing:** EngSys");
    expect(loadLabelCatalog).toHaveBeenCalledWith(catalogPath);
    expect(t.get).toHaveBeenCalledTimes(2);
  });

  it("routes a service contract issue using canonical service and API-plane labels", async () => {
    const t = setup();
    await t.apply(
      output({ routing: "service", serviceLabel: "Storage", plane: "management", kind: "feature" }),
    );
    expect(t.github.rest.issues.addLabels).toHaveBeenCalledWith(
      expect.objectContaining({
        labels: ["Service Attention", "Storage", "Mgmt", "feature-request"],
      }),
    );
  });

  it("uses the service catalog rather than assuming a label color", async () => {
    const t = setup();
    await t.apply(output({ routing: "service", serviceLabel: "AppPlatform", kind: null }));
    expect(readFile).toHaveBeenCalledWith(
      join(dirname(catalogPath), "labels", "services.yaml"),
      "utf8",
    );
    expect(t.github.rest.issues.addLabels).toHaveBeenCalledWith(
      expect.objectContaining({ labels: ["Service Attention", "AppPlatform"] }),
    );
  });

  it("does not treat a label's color as authority for service membership", async () => {
    const t = setup();
    vi.mocked(readFile).mockResolvedValue(JSON.stringify({ labels: [{ name: "Compute" }] }));
    await expect(t.apply(output({ routing: "service", serviceLabel: "Storage" }))).rejects.toThrow(
      "Invalid service label",
    );
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
  });

  it("fails explicitly when the service catalog cannot be read", async () => {
    const t = setup();
    vi.mocked(readFile).mockRejectedValue(new Error("service catalog unavailable"));
    await expect(t.apply()).rejects.toThrow("service catalog unavailable");
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
  });

  it("allows a clear service issue without guessing the service or plane", async () => {
    const t = setup();
    await t.apply(output({ routing: "service", kind: null }));
    expect(t.github.rest.issues.addLabels).toHaveBeenCalledWith(
      expect.objectContaining({ labels: ["Service Attention"] }),
    );
  });

  it.each(["medium", "low"])("uses manual triage for %s confidence", async (confidence) => {
    const t = setup();
    await t.apply(output({ confidence }));
    expect(t.github.rest.issues.addLabels).toHaveBeenCalledWith(
      expect.objectContaining({ labels: ["needs-team-triage"] }),
    );
  });

  it("does not replace existing service routing with EngSys", async () => {
    const t = setup();
    t.issue.labels = ["Service Attention", "Storage"];
    await t.apply();
    expect(t.github.rest.issues.addLabels).toHaveBeenCalledWith(
      expect.objectContaining({ labels: ["needs-team-triage"] }),
    );
    expect(t.core.warning).toHaveBeenCalled();
    expect(t.github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it.each([
    { labels: ["EngSys"], serviceLabel: "Storage", plane: "management" },
    { labels: ["Compute"], serviceLabel: "Storage", plane: "management" },
    { labels: ["data-plane"], serviceLabel: "Storage", plane: "management" },
    { labels: ["Mgmt"], serviceLabel: "Storage", plane: "data" },
  ])("preserves conflicting service or plane labels: $labels", async ({ labels, ...proposal }) => {
    const t = setup();
    t.issue.labels = labels;
    await t.apply(output({ routing: "service", ...proposal }));
    expect(t.github.rest.issues.addLabels).toHaveBeenCalledWith(
      expect.objectContaining({ labels: ["needs-team-triage"] }),
    );
  });

  it("preserves an existing specific kind rather than adding a conflicting kind", async () => {
    const t = setup();
    t.issue.labels = ["feature-request"];
    await t.apply();
    expect(t.github.rest.issues.addLabels).toHaveBeenCalledWith(
      expect.objectContaining({ labels: ["EngSys"] }),
    );
  });

  it("does not write labels that are already present", async () => {
    const t = setup();
    t.issue.labels = ["EngSys", "bug"];
    await t.apply();
    expect(t.getLabel).not.toHaveBeenCalled();
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(t.github.rest.issues.createComment).toHaveBeenCalledTimes(1);
  });

  it("updates only the trusted workflow comment on reruns", async () => {
    const t = setup();
    t.github.rest.issues.listComments.mockResolvedValue({
      data: [
        { id: 1, user: { login: "reporter", type: "User" }, body: "<!-- issue-triage --> forged" },
        { id: 2, user: { login: "other[bot]", type: "Bot" }, body: "<!-- issue-triage --> other" },
        {
          id: 3,
          user: { login: "github-actions[bot]", type: "Bot" },
          body: "<!-- issue-triage --> old",
        },
      ],
    });
    await t.apply();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(t.github.rest.issues.updateComment).toHaveBeenCalledExactlyOnceWith(
      expect.objectContaining({ comment_id: 3 }),
    );
  });

  it("does not rewrite an identical comment", async () => {
    const t = setup();
    t.issue.labels = ["EngSys", "bug"];
    await t.apply();
    const body = t.createComment.mock.calls[0][0].body;
    t.createComment.mockClear();
    t.get.mockClear();
    t.github.rest.issues.listComments.mockResolvedValue({
      data: [{ id: 3, user: { login: "github-actions[bot]", type: "Bot" }, body }],
    });
    await t.apply();
    expect(t.github.rest.issues.updateComment).not.toHaveBeenCalled();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(t.get).toHaveBeenCalledTimes(1);
  });

  it("escapes issue-derived text and does not enable mention or HTML injection", async () => {
    const t = setup();
    await t.apply(
      output({ summary: "@maintainer <script> **unsafe**", question: "@team what changed?" }),
    );
    const body = t.createComment.mock.calls[0][0].body;
    expect(body).toContain("&#64;maintainer &lt;script&gt;");
    expect(body).toContain("&#64;team");
    expect(body).not.toContain("<script>");
    expect(body).not.toContain("@maintainer");
    expect(t.addLabels.mock.calls[0][0].labels).not.toContain("needs-author-feedback");
  });

  it("verifies duplicate hints and uses a fully qualified upstream URL", async () => {
    const t = setup();
    t.get
      .mockResolvedValueOnce({ data: t.issue })
      .mockResolvedValueOnce({ data: { number: 42, state: "open" } });
    await t.apply(output({ duplicateOf: 42 }));
    expect(t.get).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      issue_number: 42,
    });
    expect(t.get).toHaveBeenLastCalledWith(expect.objectContaining({ issue_number: 123 }));
    expect(t.createComment.mock.calls[0][0].issue_number).toBe(123);
    expect(t.createComment.mock.calls[0][0].body).toContain(
      "https://github.com/Azure/azure-rest-api-specs/issues/42",
    );
  });

  it.each([{ state: "closed" }, { state: "open", pull_request: {} }])(
    "rejects invalid duplicate candidates before mutation: %o",
    async (candidate) => {
      const t = setup();
      t.get.mockResolvedValueOnce({ data: t.issue }).mockResolvedValueOnce({ data: candidate });
      await expect(t.apply(output({ duplicateOf: 42 }))).rejects.toThrow("open issue");
      expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
      expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
    },
  );

  it("previews the same decision without mutating or looking up a comment", async () => {
    const t = setup();
    await t.apply(output(), { dryRun: true });
    expect(t.core.info).toHaveBeenCalledWith(expect.stringContaining("Dry run for issue 123"));
    expect(t.github.rest.issues.listComments).not.toHaveBeenCalled();
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it.each([
    { state: "closed" },
    { locked: true },
    { pull_request: {} },
    { user: { login: "workflow[bot]", type: "Bot" } },
  ])("skips ineligible targets: %o", async (changes) => {
    const t = setup();
    Object.assign(t.issue, changes);
    await t.apply();
    expect(t.core.notice).toHaveBeenCalled();
    expect(loadLabelCatalog).not.toHaveBeenCalled();
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("does not apply a decision after the issue changes", async () => {
    const t = setup();
    t.issue.updated_at = "2026-10-07T12:01:00Z";
    await expect(t.apply()).rejects.toThrow("changed during triage");
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
  });

  it.each([
    { updated_at: "2026-10-07T12:01:00Z" },
    { state: "closed" },
    { locked: true },
    { pull_request: {} },
    { labels: ["Service Attention"] },
    { title: "The request changed within the same timestamp" },
    { body: "The body changed within the same timestamp" },
  ])("rechecks changes made during label lookup before writing: %o", async (changes) => {
    const t = setup();
    t.getLabel.mockImplementation(({ name }: { name: string }) => {
      Object.assign(t.issue, changes);
      return Promise.resolve({ data: { name, archived_at: null } });
    });
    await expect(t.apply()).rejects.toThrow("changed during triage");
    expect(t.get).toHaveBeenCalledTimes(2);
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(t.github.rest.issues.updateComment).not.toHaveBeenCalled();
  });

  it("rechecks changes made during duplicate verification", async () => {
    const t = setup();
    t.get.mockImplementation(({ issue_number }: { issue_number: number }) => {
      if (issue_number === 42) {
        t.issue.locked = true;
        return Promise.resolve({ data: { number: 42, state: "open" } });
      }
      return Promise.resolve({ data: t.issue });
    });
    await expect(t.apply(output({ duplicateOf: 42 }))).rejects.toThrow("changed during triage");
    expect(t.get).toHaveBeenCalledTimes(3);
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("rechecks changes made while paginating comments, including comment-only writes", async () => {
    const t = setup();
    t.issue.labels = ["EngSys", "bug"];
    t.github.rest.issues.listComments.mockImplementation(() => {
      t.issue.state = "closed";
      return Promise.resolve({ data: [] });
    });
    await expect(t.apply()).rejects.toThrow("changed during triage");
    expect(t.getLabel).not.toHaveBeenCalled();
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(t.github.rest.issues.updateComment).not.toHaveBeenCalled();
  });

  it.each([
    { number: 999 },
    { duplicateOf: 123 },
    { routing: "engsys", serviceLabel: "Storage" },
    { routing: "service", serviceLabel: "Approved-Suppression" },
    { routing: "service", serviceLabel: "EngSys" },
    { routing: "service", serviceLabel: "invented-service" },
    { summary: "x".repeat(401) },
    { close: true },
  ])("rejects untrusted or out-of-scope proposals: %o", async (proposal) => {
    const t = setup();
    await expect(t.apply(output(proposal))).rejects.toThrow();
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it.each(["0", "-1", "12x", "9007199254740992"])(
    "rejects invalid dispatch targets: %s",
    async (issueNumber) => {
      const t = setup();
      t.context.eventName = "workflow_dispatch";
      await expect(t.apply(output(), { issueNumber })).rejects.toThrow("positive safe integer");
      expect(t.get).not.toHaveBeenCalled();
    },
  );

  it("supports a valid manual dispatch without an issue event", async () => {
    const t = setup();
    Object.assign(t.context, { eventName: "workflow_dispatch", payload: {} });
    await t.apply();
    expect(t.github.rest.issues.createComment).toHaveBeenCalledTimes(1);
  });

  it.each([
    { ref: "refs/heads/feature" },
    { repo: { owner: "fork", repo: "azure-rest-api-specs" } },
    { eventName: "pull_request" },
    { payload: { action: "edited", issue: { number: 123 } } },
    { payload: { action: "opened", issue: { number: 999 } } },
  ])("rejects untrusted execution contexts: %o", async (context) => {
    const t = setup();
    Object.assign(t.context, context);
    await expect(t.apply()).rejects.toThrow();
    expect(t.get).not.toHaveBeenCalled();
  });

  it.each([
    {},
    { items: [] },
    { items: [{ type: "add_labels", labels: ["ARMSignedOff"] }] },
    { items: [...output().items, ...output().items] },
    { ...output(), errors: ["rejected output"] },
  ])("fails malformed, empty, multiple or rejected safe outputs: %o", async (result) => {
    const t = setup();
    await expect(t.apply(result)).rejects.toThrow();
    expect(t.get).not.toHaveBeenCalled();
  });

  it("does not create labels when an expected live label is unavailable", async () => {
    const t = setup();
    t.getLabel.mockRejectedValue(new Error("label not found"));
    await expect(t.apply()).rejects.toThrow("label not found");
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(t.github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("rejects archived labels before mutation", async () => {
    const t = setup();
    t.getLabel.mockResolvedValue({ data: { name: "EngSys", archived_at: updatedAt } });
    await expect(t.apply()).rejects.toThrow("archived triage label");
    expect(t.github.rest.issues.addLabels).not.toHaveBeenCalled();
  });
});
