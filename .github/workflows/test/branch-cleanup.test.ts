import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { load } from "js-yaml";
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
  ["user/old", 1096, true],
  ["user/recent", 1095, false],
])("uses the age cutoff for %s", (name, days, stale) => {
  expect(isStale(branch(name, days), NOW)).toBe(stale);
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
      "trunk",
      "main",
      "develop",
      "typespec-next",
      "RPSaaSMaster",
      "dev-old",
      "dev/old",
      "release-old",
      "release/old",
      "feature/old",
      "feature-old",
      "published/old",
      "archive/old",
      "hotfix/old",
      "protected",
      "pr-head",
      "pr-base",
      "changed",
    ]);
    const git = vi.fn().mockResolvedValue(0);
    await cleanupBranches(args, dryRun, git, NOW);
    expect(args.github.graphql.mock.calls[1][1]).toMatchObject({ cursor: "next" });
    expect(args.core.info).toHaveBeenCalledWith(
      `${dryRun ? "Dry run" : "Cleanup"}: 2 stale branches`,
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
        "https://github.com/owner/repo.git",
        ":refs/heads/copilot/old",
        ":refs/heads/user/old",
      ]);
    }
  },
);

it("does not delete when inventory fails", async () => {
  const args = setup(["copilot/old"]);
  args.github.graphql.mockReset().mockRejectedValue(new Error("API unavailable"));
  const git = vi.fn();
  await expect(cleanupBranches(args, false, git, NOW)).rejects.toThrow("API unavailable");
  expect(git).not.toHaveBeenCalled();
});

it("stops subsequent batches on a failed push", async () => {
  const args = setup(Array.from({ length: 51 }, (_, i) => `copilot/${i}`));
  const git = vi.fn().mockRejectedValue(new Error("stale info"));
  await expect(cleanupBranches(args, false, git, NOW)).rejects.toThrow("stale info");
  expect(git).toHaveBeenCalledTimes(1);
});

it("defaults manual runs to dry run", async () => {
  const yaml = await readFile(join(import.meta.dirname, "../branch-cleanup.yaml"), "utf8");
  expect(load(yaml)).toMatchObject({
    on: { workflow_dispatch: { inputs: { "dry-run": { type: "boolean", default: true } } } },
  });
  expect(yaml).toContain("github.event_name == 'workflow_dispatch' && inputs.dry-run");
});
