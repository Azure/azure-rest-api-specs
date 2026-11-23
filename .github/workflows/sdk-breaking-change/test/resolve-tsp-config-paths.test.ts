import { mkdirSync, writeFileSync } from "node:fs";
import { rm } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, describe, expect, it, vi } from "vitest";
import { resolveChangedTypeSpecConfigPathsFromPullRequest } from "../src/resolve-tsp-config-paths.ts";
import { createMockContext, createMockCore, createMockGithub } from "../../test/mocks.ts";

const temporaryDirectories: string[] = [];

function createRepository(): string {
  const repositoryPath = join(import.meta.dirname, `repo-${crypto.randomUUID()}`);
  temporaryDirectories.push(repositoryPath);
  mkdirSync(join(repositoryPath, "specification", "service", "Widget.Service", "new"), {
    recursive: true,
  });
  writeFileSync(
    join(repositoryPath, "specification", "service", "Widget.Service", "tspconfig.yaml"),
    "emit: []\n",
  );
  return repositoryPath;
}

afterEach(async () => {
  await Promise.all(temporaryDirectories.splice(0).map((path) => rm(path, { recursive: true })));
});

describe("resolveChangedTypeSpecConfigPathsFromPullRequest", () => {
  it("reads all pull request files and sets the config path output", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    const localSpecRepoPath = createRepository();
    const listFiles = vi.fn().mockResolvedValue({
      data: [
        {
          filename: "specification/service/Widget.Service/new/main.tsp",
          previous_filename: "specification/service/Widget.Service/main.tsp",
        },
      ],
    });
    Object.assign(github.rest.pulls, { listFiles });
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "a".repeat(40) } } });

    await expect(
      resolveChangedTypeSpecConfigPathsFromPullRequest({
        github,
        context,
        core,
        pullNumber: 42,
        expectedHeadSha: "a".repeat(40),
        localSpecRepoPath,
      }),
    ).resolves.toEqual(["specification/service/Widget.Service/tspconfig.yaml"]);
    expect(listFiles).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      pull_number: 42,
      per_page: 100,
    });
    expect(core.setOutput).toHaveBeenCalledWith(
      "tsp-config-paths",
      '["specification/service/Widget.Service/tspconfig.yaml"]',
    );
  });

  it("rejects a PR updated between the lightweight gate and project discovery", async () => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "b".repeat(40) } } });

    await expect(
      resolveChangedTypeSpecConfigPathsFromPullRequest({
        github,
        context: createMockContext(),
        core: createMockCore(),
        pullNumber: 42,
        expectedHeadSha: "a".repeat(40),
        localSpecRepoPath: createRepository(),
      }),
    ).rejects.toThrow("Pull request head changed");
    expect(github.rest.pulls.listFiles).not.toHaveBeenCalled();
  });
});
