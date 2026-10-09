import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { parse } from "yaml";
import { expect, it, vi } from "vitest";
import { cleanupBranches, isStale } from "../src/branch-cleanup.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const NOW = Date.parse("2026-09-30T00:00:00Z");
const SHA = "a".repeat(40);
const branch = (name: string, days = 1500) => ({
  name,
  target: { oid: SHA, committedDate: new Date(NOW - days * 86400000).toISOString() },
});

it.each([
  ["copilot/old", 91, true],
  ["copilot/recent", 90, false],
  ["copilot-not-a-prefix", 91, false],
  ["user/old", 731, true],
  ["user/recent", 730, false],
  ["dev-old", 731, true],
  ["dev-recent", 730, false],
  ["dev/old", 731, true],
  ["dev/recent", 730, false],
])("uses the age cutoff for %s", (name, days, stale) => {
  expect(isStale(branch(name, days), NOW)).toBe(stale);
});

it("allows independent manual cutoffs", () => {
  const retention = { copilotDays: 30, otherDays: 365 };
  expect(isStale(branch("copilot/old", 31), NOW, retention)).toBe(true);
  expect(isStale(branch("copilot/recent", 30), NOW, retention)).toBe(false);
  expect(isStale(branch("user/old", 366), NOW, retention)).toBe(true);
  expect(isStale(branch("user/recent", 365), NOW, retention)).toBe(false);
});

it("rejects unknown commit dates", () => {
  expect(() =>
    isStale({ ...branch("user/old"), target: { oid: SHA, committedDate: "bad" } }, NOW),
  ).toThrow("Invalid commit date");
});

function setup(names: string[]) {
  const github = Object.assign(createMockGithub(), { graphql: vi.fn() });
  Object.assign(github.rest.repos, {
    get: vi.fn().mockResolvedValue({
      data: { default_branch: "trunk", clone_url: "https://github.com/owner/repo.git" },
    }),
    listBranches: vi.fn().mockResolvedValue({
      data: names.map((name) => ({
        name,
        commit: { sha: name === "changed" ? "b".repeat(40) : SHA },
        protected: name === "protected",
      })),
    }),
  });
  Object.assign(github.rest.pulls, {
    list: vi
      .fn()
      .mockResolvedValue({ data: [{ head: { ref: "pr-head" }, base: { ref: "pr-base" } }] }),
  });
  const refs = (items: string[], endCursor: string | null) => ({
    repository: {
      refs: {
        nodes: items.map((name) => branch(name)),
        pageInfo: { hasNextPage: endCursor !== null, endCursor },
      },
    },
  });
  github.graphql
    .mockResolvedValueOnce(refs(names.slice(0, 1), "next"))
    .mockResolvedValueOnce(refs(names.slice(1), null));
  const core = createMockCore();
  core.info.mockImplementation(() => {});
  return { github, core, context: createMockContext() };
}

it.each([true, false])(
  "preserves protected, long-lived, open-PR and changed branches (dry run %s)",
  async (dryRun) => {
    const args = setup([
      "copilot/old",
      "user/old",
      "dev-old",
      "dev/old",
      "published/old",
      "trunk",
      "main",
      "develop",
      "typespec-next",
      "RPSaaSMaster",
      "release-old",
      "release/old",
      "feature/old",
      "feature-old",
      "archive/old",
      "hotfix/old",
      "protected",
      "pr-head",
      "pr-base",
      "changed",
    ]);
    const git = vi.fn().mockResolvedValue(0);
    await cleanupBranches(args, dryRun, git, undefined, NOW);
    expect(args.github.graphql.mock.calls[1][1]).toMatchObject({ cursor: "next" });
    expect(args.core.info).toHaveBeenCalledWith(
      `${dryRun ? "Dry run" : "Cleanup"}: 5 stale branches`,
    );
    if (dryRun) {
      expect(git).not.toHaveBeenCalled();
    } else {
      expect(git).toHaveBeenCalledExactlyOnceWith([
        "push",
        "--atomic",
        "--no-follow-tags",
        `--force-with-lease=refs/heads/copilot/old:${SHA}`,
        `--force-with-lease=refs/heads/user/old:${SHA}`,
        `--force-with-lease=refs/heads/dev-old:${SHA}`,
        `--force-with-lease=refs/heads/dev/old:${SHA}`,
        `--force-with-lease=refs/heads/published/old:${SHA}`,
        "https://github.com/owner/repo.git",
        ":refs/heads/copilot/old",
        ":refs/heads/user/old",
        ":refs/heads/dev-old",
        ":refs/heads/dev/old",
        ":refs/heads/published/old",
      ]);
    }
  },
);

it("does not delete when inventory fails", async () => {
  const args = setup(["copilot/old"]);
  args.github.graphql.mockReset().mockRejectedValue(new Error("API unavailable"));
  const git = vi.fn();
  await expect(cleanupBranches(args, false, git, undefined, NOW)).rejects.toThrow(
    "API unavailable",
  );
  expect(git).not.toHaveBeenCalled();
});

it("stops subsequent batches on a failed push", async () => {
  const args = setup(Array.from({ length: 51 }, (_, i) => `copilot/${i}`));
  const git = vi.fn().mockRejectedValue(new Error("stale info"));
  await expect(cleanupBranches(args, false, git, undefined, NOW)).rejects.toThrow("stale info");
  expect(git).toHaveBeenCalledTimes(1);
});

it("applies manual cutoffs during cleanup", async () => {
  const args = setup(["copilot/old", "user/old"]);
  const git = vi.fn();
  await cleanupBranches(args, true, git, { copilotDays: 2000, otherDays: 1000 }, NOW);
  expect(args.core.info).toHaveBeenCalledWith("Dry run: 1 stale branches");
  expect(args.core.info).toHaveBeenCalledWith(`user/old ${SHA}`);
  expect(git).not.toHaveBeenCalled();
});

it.each([0, -1, 1.5, NaN, Infinity, Number.MAX_SAFE_INTEGER + 1])(
  "rejects invalid retention %s before querying or deleting",
  async (days) => {
    const args = setup(["copilot/old"]);
    const git = vi.fn();
    for (const retention of [
      { copilotDays: days, otherDays: 730 },
      { copilotDays: 90, otherDays: days },
    ]) {
      await expect(cleanupBranches(args, false, git, retention, NOW)).rejects.toThrow(
        "must be a positive whole number of days",
      );
    }
    expect(args.github.rest.repos.get).not.toHaveBeenCalled();
    expect(git).not.toHaveBeenCalled();
  },
);

it("defaults manual runs to dry run with separate retention inputs", async () => {
  const yaml = await readFile(join(import.meta.dirname, "../branch-cleanup.yaml"), "utf8");
  expect(parse(yaml)).toMatchObject({
    on: {
      workflow_dispatch: {
        inputs: {
          "dry-run": { type: "boolean", default: true },
          "copilot-days": { type: "number", default: 90 },
          "other-days": { type: "number", default: 730 },
        },
      },
    },
  });
  expect(yaml).toContain("github.event_name == 'workflow_dispatch' && inputs.dry-run");
  expect(yaml).toContain('Number(context.payload.inputs["copilot-days"])');
  expect(yaml).toContain('Number(context.payload.inputs["other-days"])');
});
