import { writeFile } from "node:fs/promises";
import { join } from "node:path";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { getChangedFiles } from "../../shared/src/changed-files.ts";
import { writeLintdiffChangedFiles } from "../src/lintdiff-changed-files.ts";
import { requireWorkflowLocks } from "../src/require-workflow-locks.ts";
import { sdkSuppressionsContext } from "../src/sdk-suppressions-context.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

vi.mock("../../shared/src/changed-files.ts", () => ({ getChangedFiles: vi.fn() }));
vi.mock("node:fs/promises", () => ({ writeFile: vi.fn() }));

beforeEach(() => vi.clearAllMocks());

describe("compiled workflow lock enforcement", () => {
  const source = ".github/workflows/example.md";
  const lock = ".github/workflows/example.lock.yml";

  it.each([
    ["added", "added", false],
    ["modified", "modified", false],
    ["removed", "removed", false],
    ["modified", undefined, true],
    ["added", "removed", true],
    ["removed", "modified", true],
  ])("checks %s source with %s lock", async (status, lockStatus, fails) => {
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    context.payload = { pull_request: { number: 42 } };
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [
        { filename: source, status },
        ...(lockStatus ? [{ filename: lock, status: lockStatus }] : []),
        { filename: "documentation/unrelated.md", status: "modified" },
      ],
    });
    await requireWorkflowLocks({ github, context, core });
    expect(github.rest.pulls.listFiles).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      pull_number: 42,
      per_page: 100,
    });
    expect(core.setFailed).toHaveBeenCalledTimes(fails ? 1 : 0);
    if (fails) expect(core.setFailed).toHaveBeenCalledWith(expect.stringContaining(source));
  });

  it("rejects a missing PR context", async () => {
    await expect(
      requireWorkflowLocks({
        github: createMockGithub(),
        context: createMockContext(),
        core: createMockCore(),
      }),
    ).rejects.toThrow("context of a pull request");
  });
});

describe("SDK suppression context", () => {
  it("publishes label names as an array", () => {
    const context = createMockContext();
    const core = createMockCore();
    context.payload = {
      pull_request: { number: 42, labels: [{ name: "first" }, { name: 'quoted "label"' }] },
    };
    sdkSuppressionsContext({ context, core });
    expect(core.setOutput).toHaveBeenCalledWith("prLabels", ["first", 'quoted "label"']);
  });

  it("rejects a missing PR", () => {
    expect(() =>
      sdkSuppressionsContext({
        context: createMockContext(),
        core: createMockCore(),
      }),
    ).toThrow("context of a pull request");
  });
});

describe("LintDiff changed file output", () => {
  it.each([
    { files: [] },
    { files: ["specification/one.json", "specification/space in name.tsp"] },
  ])("writes $files from the after checkout to the working directory", async ({ files }) => {
    vi.mocked(getChangedFiles).mockResolvedValue(files);
    await writeLintdiffChangedFiles();
    expect(getChangedFiles).toHaveBeenCalledWith({ cwd: "after", paths: ["specification"] });
    expect(writeFile).toHaveBeenCalledWith(
      join(process.cwd(), "changed-files.txt"),
      files.join("\n"),
      "utf8",
    );
  });
});
