import { mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { load } from "js-yaml";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { execFile } from "../../shared/src/exec.ts";
import {
  applyCleanup,
  classifyBranch,
  deleteBranchBatch,
  planCleanup,
  type Branch,
  type Protection,
} from "../src/branch-cleanup.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

vi.mock("../../shared/src/exec.ts", () => ({ execFile: vi.fn() }));

const NOW = new Date("2026-09-30T12:00:00Z");
const SHA = "a".repeat(40);
const NEW_SHA = "b".repeat(40);
const PROTECTION: Protection = { defaultBranch: "main", rules: [] };

function branch(name = "copilot/stale", date = "2022-01-01T00:00:00Z"): Branch {
  return {
    name,
    target: { oid: SHA, committedDate: date },
    branchProtectionRule: null,
    openPullRequests: { totalCount: 0 },
    associatedPullRequests: { nodes: [] },
  };
}

function page<T>(nodes: T[], cursor: string | null = null) {
  return { nodes, pageInfo: { hasNextPage: cursor !== null, endCursor: cursor } };
}

function mocks() {
  const github = Object.assign(createMockGithub(), {
    graphql: vi.fn(),
    request: vi.fn(),
  });
  const getRepository = vi.fn().mockResolvedValue({ data: { default_branch: "main" } });
  Object.assign(github.rest.repos, { get: getRepository });
  const rulesets = vi.spyOn(github, "paginate").mockResolvedValue([]);
  const context = Object.assign(createMockContext(), { serverUrl: "https://github.com" });
  const core = createMockCore();
  core.info.mockImplementation(() => {});
  core.debug.mockImplementation(() => {});
  return { github, context, core, rulesets, getRepository };
}

describe("branch retention", () => {
  it.each([
    ["copilot/stale", "2026-07-02T11:59:59Z", "eligible", "90 days"],
    ["copilot/stale", "2026-07-02T12:00:00Z", "recent-activity", "90 days"],
    ["copilot/stale", "2026-09-01T00:00:00Z", "recent-activity", "90 days"],
    ["user/stale", "2023-09-30T11:59:59Z", "eligible", "3 years"],
    ["user/stale", "2023-09-30T12:00:00Z", "recent-activity", "3 years"],
    ["user/stale", "2024-01-01T00:00:00Z", "recent-activity", "3 years"],
    ["copilot-not-a-namespace", "2026-01-01T00:00:00Z", "recent-activity", "3 years"],
    ["sync-eng/old", "2022-01-01T00:00:00Z", "eligible", "3 years"],
  ])("%s at %s is %s", (name, date, reason, retention) => {
    expect(classifyBranch(branch(name, date), PROTECTION, new Set(), NOW)).toMatchObject({
      reason,
      retention,
      sha: SHA,
    });
  });

  it("uses calendar years and clamps leap day", () => {
    const now = new Date("2028-02-29T12:00:00Z");
    expect(
      classifyBranch(branch("user/old", "2025-02-28T11:59:59Z"), PROTECTION, new Set(), now).reason,
    ).toBe("eligible");
    expect(
      classifyBranch(branch("user/old", "2025-02-28T12:00:00Z"), PROTECTION, new Set(), now).reason,
    ).toBe("recent-activity");
  });

  it.each([
    "main",
    "master",
    "develop",
    "typespec-next",
    "RPSaas",
    "RPSaaSMaster",
    "RPSaaSCanary",
    "ARMCoreRPDev",
    "gh-pages",
    "dev-old",
    "dev/old",
    "release-old/nested",
    "release/old",
    "feature-old",
    "feature/old",
    "published/old",
    "archive/old",
    "hotfix/old",
  ])("preserves %s regardless of age", (name) => {
    expect(classifyBranch(branch(name), PROTECTION, new Set(), NOW).reason).toBe("preserved");
  });

  it("preserves a renamed default branch", () => {
    expect(
      classifyBranch(branch("trunk"), { ...PROTECTION, defaultBranch: "trunk" }, new Set(), NOW)
        .reason,
    ).toBe("preserved");
  });

  it("preserves classic protection and active ruleset patterns, including slashes", () => {
    const protectedBranch = branch();
    protectedBranch.branchProtectionRule = { pattern: "copilot/*" };
    expect(classifyBranch(protectedBranch, PROTECTION, new Set(), NOW).reason).toBe("protected");
    const protection = {
      ...PROTECTION,
      rules: [{ include: ["refs/heads/team-*/**/*"], exclude: ["refs/heads/team-a/obsolete"] }],
    };
    expect(classifyBranch(branch("team-a/keep/nested"), protection, new Set(), NOW).reason).toBe(
      "protected",
    );
    expect(classifyBranch(branch("team-a/obsolete"), protection, new Set(), NOW).reason).toBe(
      "eligible",
    );
    expect(
      classifyBranch(
        branch(),
        { ...PROTECTION, rules: [{ include: ["~ALL"], exclude: [] }] },
        new Set(),
        NOW,
      ).reason,
    ).toBe("protected");
  });

  it("does not apply default-branch rules to unrelated branches", () => {
    expect(
      classifyBranch(
        branch(),
        { ...PROTECTION, rules: [{ include: ["~DEFAULT_BRANCH"], exclude: [] }] },
        new Set(),
        NOW,
      ).reason,
    ).toBe("eligible");
  });

  it.each(["refs/heads/@(a|b)", "refs/heads/{a,b}", "refs/heads/a\\b"])(
    "fails closed on ambiguous glob syntax: %s",
    (pattern) => {
      expect(() =>
        classifyBranch(
          branch(),
          { ...PROTECTION, rules: [{ include: [pattern], exclude: [] }] },
          new Set(),
          NOW,
        ),
      ).toThrow("Cannot safely evaluate");
    },
  );

  it("preserves open PR sources and targets, including drafts", () => {
    const source = branch();
    source.openPullRequests.totalCount = 1;
    expect(classifyBranch(source, PROTECTION, new Set(), NOW).reason).toBe("open-pr");
    expect(classifyBranch(branch(), PROTECTION, new Set(["copilot/stale"]), NOW).reason).toBe(
      "open-pr",
    );
  });

  it("uses the latest closed PR activity as well as the tip commit", () => {
    const candidate = branch();
    candidate.associatedPullRequests.nodes = [{ updatedAt: "2026-09-29T00:00:00Z" }];
    expect(classifyBranch(candidate, PROTECTION, new Set(), NOW).reason).toBe("recent-activity");
    candidate.associatedPullRequests.nodes = [{ updatedAt: "2026-01-01T00:00:00Z" }];
    expect(classifyBranch(candidate, PROTECTION, new Set(), NOW).reason).toBe("eligible");
  });

  it("rejects malformed dates and SHAs instead of treating them as old", () => {
    expect(() =>
      classifyBranch(branch("copilot/old", "invalid"), PROTECTION, new Set(), NOW),
    ).toThrow("Invalid activity timestamp");
    const invalid = branch();
    invalid.target.oid = "invalid";
    expect(() => classifyBranch(invalid, PROTECTION, new Set(), NOW)).toThrow();
  });
});

describe("cleanup orchestration", () => {
  let directory: string;

  beforeEach(async () => {
    directory = await mkdtemp(join(tmpdir(), "branch-cleanup-test-"));
    vi.mocked(execFile).mockReset().mockResolvedValue({ stdout: "", stderr: "" });
  });
  afterEach(async () => {
    await rm(directory, { recursive: true, force: true });
    vi.restoreAllMocks();
  });

  async function plan(args: ReturnType<typeof mocks>, branches = [branch()]) {
    args.github.graphql
      .mockResolvedValueOnce({ repository: { refs: page(branches) } })
      .mockResolvedValueOnce({ repository: { pullRequests: page([]) } });
    return planCleanup(args, directory, NOW);
  }

  it("paginates branches and open PR targets, writing a read-only plan", async () => {
    const args = mocks();
    args.github.graphql
      .mockResolvedValueOnce({ repository: { refs: page([branch()], "branches-next") } })
      .mockResolvedValueOnce({ repository: { refs: page([branch("user/base")]) } })
      .mockResolvedValueOnce({ repository: { pullRequests: page([], "prs-next") } })
      .mockResolvedValueOnce({
        repository: { pullRequests: page([{ baseRefName: "user/base" }]) },
      });
    const result = await planCleanup(args, directory, NOW);
    expect(result.branches.map((b) => b.reason)).toEqual(["eligible", "open-pr"]);
    expect(args.github.graphql.mock.calls[1][1]).toMatchObject({ cursor: "branches-next" });
    expect(args.github.graphql.mock.calls[3][1]).toMatchObject({ cursor: "prs-next" });
    expect(args.rulesets).toHaveBeenCalledWith(
      "GET /repos/{owner}/{repo}/rulesets",
      expect.objectContaining({ includes_parents: true, per_page: 100 }),
    );
    expect(JSON.parse(await readFile(join(directory, "plan.json"), "utf8"))).toEqual(result);
    expect(execFile).not.toHaveBeenCalled();
  });

  it("fails closed on API errors or incomplete pagination", async () => {
    const args = mocks();
    args.rulesets.mockRejectedValueOnce(new Error("Forbidden"));
    await expect(plan(args)).rejects.toThrow("Forbidden");
    args.github.graphql.mockReset().mockResolvedValue({
      repository: {
        refs: { nodes: [], pageInfo: { hasNextPage: true, endCursor: null } },
      },
    });
    await expect(planCleanup(args, directory, NOW)).rejects.toThrow("invalid pagination cursor");
    expect(execFile).not.toHaveBeenCalled();
  });

  it("loads active inherited branch rulesets and rejects missing conditions", async () => {
    const args = mocks();
    args.rulesets.mockResolvedValue([
      { id: 1, target: "branch", enforcement: "active" },
      { id: 2, target: "tag", enforcement: "active" },
      { id: 3, target: "branch", enforcement: "disabled" },
    ]);
    args.github.request.mockResolvedValue({
      data: {
        enforcement: "active",
        conditions: { ref_name: { include: ["refs/heads/copilot/*"], exclude: [] } },
      },
    });
    expect((await plan(args)).branches[0].reason).toBe("protected");
    expect(args.github.request).toHaveBeenCalledTimes(1);
    args.github.request.mockResolvedValue({ data: { id: 1, enforcement: "active" } });
    await expect(plan(args)).rejects.toThrow("Cannot determine branch targets");
    expect(execFile).not.toHaveBeenCalled();
  });

  it("rechecks eligibility and deletes only unchanged eligible branches", async () => {
    const args = mocks();
    const branches = [
      branch("copilot/delete"),
      branch("copilot/changed"),
      branch("copilot/open-head"),
      branch("copilot/open-base"),
      branch("copilot/recent-pr"),
      branch("copilot/protected"),
      branch("copilot/gone"),
    ];
    await plan(args, branches);
    const source = branch("copilot/open-head");
    source.openPullRequests.totalCount = 1;
    const recent = branch("copilot/recent-pr");
    recent.associatedPullRequests.nodes = [{ updatedAt: NOW.toISOString() }];
    const protectedBranch = branch("copilot/protected");
    protectedBranch.branchProtectionRule = { pattern: "copilot/protected" };
    args.github.graphql.mockResolvedValueOnce({
      repository: {
        branch0: branches[0],
        branch1: { ...branches[1], target: { ...branches[1].target, oid: NEW_SHA } },
        branch2: source,
        branch3: branches[3],
        branch4: recent,
        branch5: protectedBranch,
        branch6: null,
        ...Object.fromEntries(
          branches.map((_, i) => [`base${i}`, { totalCount: i === 3 ? 1 : 0 }]),
        ),
      },
    });
    await applyCleanup(args, directory, NOW);
    expect(execFile).toHaveBeenCalledTimes(2);
    expect(vi.mocked(execFile).mock.calls[0][1]).toEqual([
      "push",
      "--atomic",
      "--porcelain",
      "--no-follow-tags",
      `--force-with-lease=refs/heads/copilot/delete:${SHA}`,
      "https://github.com/owner/repo.git",
      ":refs/heads/copilot/delete",
    ]);
    expect(JSON.parse(await readFile(join(directory, "results.json"), "utf8"))).toMatchObject([
      { outcome: "deleted" },
      { outcome: "kept-tip-changed" },
      { outcome: "kept-open-pr" },
      { outcome: "kept-open-pr" },
      { outcome: "kept-recent-activity" },
      { outcome: "kept-protected" },
      { outcome: "already-deleted" },
    ]);
  });

  it("rechecks rulesets and the default branch before deletion", async () => {
    const args = mocks();
    await plan(args);
    args.getRepository.mockResolvedValue({ data: { default_branch: "copilot/stale" } });
    args.github.graphql.mockResolvedValueOnce({
      repository: { branch0: branch(), base0: { totalCount: 0 } },
    });
    await applyCleanup(args, directory, NOW);
    expect(execFile).not.toHaveBeenCalled();
    expect(JSON.parse(await readFile(join(directory, "results.json"), "utf8"))).toMatchObject([
      { outcome: "kept-preserved" },
    ]);
  });

  it("keeps a branch covered by a newly added ruleset", async () => {
    const args = mocks();
    await plan(args);
    args.rulesets.mockResolvedValue([{ id: 1, target: "branch", enforcement: "active" }]);
    args.github.request.mockResolvedValue({
      data: {
        enforcement: "active",
        conditions: { ref_name: { include: ["~ALL"], exclude: [] } },
      },
    });
    args.github.graphql.mockResolvedValueOnce({
      repository: { branch0: branch(), base0: { totalCount: 0 } },
    });
    await applyCleanup(args, directory, NOW);
    expect(execFile).not.toHaveBeenCalled();
    expect(JSON.parse(await readFile(join(directory, "results.json"), "utf8"))).toMatchObject([
      { outcome: "kept-protected" },
    ]);
  });

  it("rechecks each batch and persists earlier deletions if a later batch fails", async () => {
    const args = mocks();
    const branches = Array.from({ length: 51 }, (_, i) => branch(`copilot/old-${i}`));
    await plan(args, branches);
    args.github.graphql
      .mockResolvedValueOnce({
        repository: Object.fromEntries(
          branches.slice(0, 50).flatMap<[string, Branch | { totalCount: number }]>((b, i) => [
            [`branch${i}`, b],
            [`base${i}`, { totalCount: 0 }],
          ]),
        ),
      })
      .mockRejectedValueOnce(new Error("recheck failed"));
    await expect(applyCleanup(args, directory, NOW)).rejects.toThrow("recheck failed");
    expect(execFile).toHaveBeenCalledTimes(2);
    expect(
      vi.mocked(execFile).mock.calls[0][1]?.filter((arg) => arg.startsWith(":refs/heads/")),
    ).toHaveLength(50);
    expect(JSON.parse(await readFile(join(directory, "results.json"), "utf8"))).toMatchObject([
      ...Array.from({ length: 50 }, () => ({ outcome: "deleted" })),
      { outcome: "pending" },
    ]);
  });

  it("stops on recheck errors without deleting and records unresolved candidates", async () => {
    const args = mocks();
    await plan(args);
    args.github.graphql.mockRejectedValueOnce(new Error("Rate limited"));
    await expect(applyCleanup(args, directory, NOW)).rejects.toThrow("Rate limited");
    expect(execFile).not.toHaveBeenCalled();
    expect(JSON.parse(await readFile(join(directory, "results.json"), "utf8"))).toMatchObject([
      { outcome: "pending" },
    ]);
  });

  it.each(["push-failure", "verification-failure"])("reports %s explicitly", async (failure) => {
    const args = mocks();
    await plan(args);
    args.github.graphql.mockResolvedValueOnce({
      repository: { branch0: branch(), base0: { totalCount: 0 } },
    });
    if (failure === "push-failure") {
      vi.mocked(execFile).mockRejectedValueOnce(new Error("stale info"));
    } else {
      vi.mocked(execFile)
        .mockResolvedValueOnce({ stdout: "", stderr: "" })
        .mockResolvedValueOnce({ stdout: `${SHA}\trefs/heads/copilot/stale\n`, stderr: "" });
    }
    await expect(applyCleanup(args, directory, NOW)).rejects.toThrow();
    expect(JSON.parse(await readFile(join(directory, "results.json"), "utf8"))).toMatchObject([
      { outcome: "unconfirmed" },
    ]);
  });

  it("rejects plans for another repository, old plans, and future plans", async () => {
    const args = mocks();
    const original = await plan(args);
    for (const overrides of [
      { repository: "other/repo" },
      { createdAt: "2026-09-01T00:00:00Z" },
      { createdAt: "2026-10-01T00:00:00Z" },
    ]) {
      await writeFile(join(directory, "plan.json"), JSON.stringify({ ...original, ...overrides }));
      await expect(applyCleanup(args, directory, NOW)).rejects.toThrow();
    }
    expect(execFile).not.toHaveBeenCalled();
  });

  it("does not push when there are no eligible branches", async () => {
    const args = mocks();
    await plan(args, [branch("main")]);
    await applyCleanup(args, directory, NOW);
    expect(execFile).not.toHaveBeenCalled();
    expect(JSON.parse(await readFile(join(directory, "results.json"), "utf8"))).toEqual([]);
  });

  it("uses actual Git leases and atomic deletion to protect changed tips", async () => {
    const actual = await vi.importActual<typeof import("../../shared/src/exec.ts")>(
      "../../shared/src/exec.ts",
    );
    vi.mocked(execFile).mockImplementation(actual.execFile);
    const remote = join(directory, "remote.git");
    const writer = join(directory, "writer");
    const git = async (...args: string[]) => actual.execFile("git", args);
    await git("init", "--quiet", "--bare", remote);
    await git("init", "--quiet", "-b", "main", writer);
    const commit = async () => {
      await git(
        "-C",
        writer,
        "-c",
        "user.name=Test",
        "-c",
        "user.email=test@example.com",
        "commit",
        "--quiet",
        "--allow-empty",
        "--no-gpg-sign",
        "-m",
        "test",
      );
      return (await git("-C", writer, "rev-parse", "HEAD")).stdout.trim();
    };
    const oldSha = await commit();
    await git("-C", writer, "push", "--quiet", remote, "HEAD:main", "HEAD:one", "HEAD:two");
    const newSha = await commit();
    await git("-C", writer, "push", "--quiet", remote, "HEAD:two");
    const core = createMockCore();
    core.debug.mockImplementation(() => {});
    const candidates = [
      { branch: "one", sha: oldSha },
      { branch: "two", sha: oldSha },
    ];
    await expect(deleteBranchBatch(candidates, remote, core)).rejects.toThrow();
    expect((await git("ls-remote", "--heads", remote, "one", "two")).stdout).toContain(
      "refs/heads/one",
    );
    await deleteBranchBatch(
      [
        { branch: "one", sha: oldSha },
        { branch: "two", sha: newSha },
      ],
      remote,
      core,
    );
    expect((await git("ls-remote", "--heads", remote)).stdout.trim()).toBe(
      `${oldSha}\trefs/heads/main`,
    );
  });
});

it("schedules live cleanup but defaults manual runs to dry run and saves the plan first", async () => {
  const yaml = await readFile(join(import.meta.dirname, "../branch-cleanup.yaml"), "utf8");
  expect(load(yaml)).toMatchObject({
    on: {
      schedule: [{ cron: "23 5 * * 1" }],
      workflow_dispatch: { inputs: { "dry-run": { type: "boolean", default: true } } },
    },
    permissions: { contents: "write", "pull-requests": "read" },
    concurrency: { "cancel-in-progress": false },
  });
  expect(yaml).toContain("github.repository == 'Azure/azure-rest-api-specs'");
  expect(yaml).toContain(
    "github.ref == format('refs/heads/{0}', github.event.repository.default_branch)",
  );
  expect(yaml).toContain("if: github.event_name == 'schedule' || !inputs.dry-run");
  expect(yaml.indexOf("Save branch names and SHAs")).toBeLessThan(
    yaml.indexOf("Delete eligible branches"),
  );
});
