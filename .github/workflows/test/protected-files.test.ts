import { readFileSync } from "node:fs";
import { mkdir, mkdtemp, rename, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { simpleGit } from "simple-git";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { getChangedFiles } from "../../shared/src/changed-files.ts";
import {
  checkProtectedFiles,
  readProtectedFilesDiff,
  runProtectedFiles,
} from "../src/protected-files.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

vi.mock("../../shared/src/changed-files.ts", () => ({ getChangedFiles: vi.fn() }));
vi.mock("simple-git", async (importOriginal) => {
  const actual = await importOriginal<typeof import("simple-git")>();
  return { ...actual, simpleGit: vi.fn(actual.simpleGit) };
});

const BASE_SHA = "a".repeat(40);
const HEAD_SHA = "b".repeat(40);
const MERGE_SHA = "c".repeat(40);

function mockMerge() {
  const git = simpleGit();
  const fetch = vi.spyOn(git, "fetch").mockResolvedValue({
    raw: "",
    remote: "origin",
    branches: [],
    tags: [],
    updated: [],
    deleted: [],
  });
  const revparse = vi.spyOn(git, "revparse").mockResolvedValue(MERGE_SHA);
  const raw = vi.spyOn(git, "raw").mockResolvedValue(`${BASE_SHA} ${HEAD_SHA}\n`);
  vi.mocked(simpleGit).mockReturnValueOnce(git);
  return { fetch, revparse, raw };
}

function setup(author = "spec-author") {
  const context = createMockContext();
  context.eventName = "pull_request";
  context.actor = "azure-sdk";
  context.payload = { pull_request: { number: 1, user: { login: author } } };
  const core = createMockCore();
  return { core, context, run: () => checkProtectedFiles({ context, core }) };
}

describe("Protected Files", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(getChangedFiles).mockResolvedValue([]);
  });

  it.each(["azure-sdk", "azure-sdk-automation[bot]", "Azure-SDK"])(
    "passes for trusted PR author %s without reading changed files",
    async (author) => {
      const { core, context, run } = setup(author);
      context.actor = "spec-author";
      await run();
      expect(core.info).toHaveBeenCalledWith(
        `Account '${author}' is allowed to update protected files`,
      );
      expect(getChangedFiles).not.toHaveBeenCalled();
      expect(core.setFailed).not.toHaveBeenCalled();
    },
  );

  it.each(["spec-author", "dependabot[bot]", "azure-sdk-other"])(
    "does not exempt author %s when a trusted account triggers the run",
    async (author) => {
      const { core, run } = setup(author);
      vi.mocked(getChangedFiles).mockResolvedValue(["package.json"]);
      await run();
      expect(core.error).toHaveBeenCalledWith(
        expect.stringContaining("Remove this change from your PR."),
        { file: "package.json" },
      );
      expect(core.setFailed).toHaveBeenCalledOnce();
    },
  );

  it.each(["timotheeguerin", "TimotheeGuerin", "xirzec"])(
    "passes protected maintenance-only changes authored by %s",
    async (author) => {
      const { core, run } = setup(author);
      vi.mocked(getChangedFiles).mockResolvedValue([
        "package.json",
        ".github/workflows/protected-files.yaml",
        "eng/common/script.ps1",
      ]);
      const result = await run();
      expect(result.conclusion).toBe("success");
      expect(core.error).not.toHaveBeenCalled();
      expect(core.setFailed).not.toHaveBeenCalled();
      expect(getChangedFiles).toHaveBeenCalledOnce();
    },
  );

  it.each([
    "specification/widgets/main.tsp",
    "SPECIFICATION/widgets/main.tsp",
    "specification/.hidden/config.json",
    "specification",
  ])("does not exempt a maintainer's mixed PR containing %s", async (file) => {
    const { core, run } = setup("timotheeguerin");
    vi.mocked(getChangedFiles).mockResolvedValue([file, "package.json"]);
    await expect(run()).resolves.toMatchObject({ conclusion: "failure" });
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it("passes a maintainer's specification-only PR", async () => {
    const { run } = setup("timotheeguerin");
    vi.mocked(getChangedFiles).mockResolvedValue(["specification/widgets/main.tsp"]);
    await expect(run()).resolves.toMatchObject({ conclusion: "success" });
  });

  it("does not exempt a non-maintainer when a maintainer reruns their PR", async () => {
    const { core, context, run } = setup();
    context.actor = "timotheeguerin";
    vi.mocked(getChangedFiles).mockResolvedValue(["eng/tool.ts"]);
    await run();
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it("does not authorize roster or policy changes proposed by an ordinary author", async () => {
    const { run } = setup("new-maintainer");
    vi.mocked(getChangedFiles).mockResolvedValue([".github/workflows/src/protected-files.ts"]);
    await expect(run()).resolves.toMatchObject({ conclusion: "failure" });
  });

  it.each([
    ".gitignore",
    "cspell.json",
    "cspell.yaml",
    "package.json",
    "pnpm-lock.yaml",
    "pnpm-workspace.yaml",
    ".github/workflows/protected-files.yaml",
    ".github/azsdk-common-config.yml",
    ".vscode/settings.json",
    "eng/tools/example/package.json",
    "eng/scripts/ChangedFiles-Functions.ps1",
    ".github/CODEOWNERS.backup",
    ".github/CODEOWNERS\n",
    ".github/workflows/nested/.github/CODEOWNERS",
    "eng/nested/.github/skills/custom/SKILL.md",
    ".github/skills/azsdk-common-example/SKILL.md",
    ".github/skills/azsdk-common-example",
    "PACKAGE.JSON",
    ".GITHUB/WORKFLOWS/test.yaml",
    ".github/workflows/with spaces.yaml",
    ".github/.hidden/config.yaml",
    ".github/workflows/.hidden.yaml",
    ".vscode/.hidden",
    "eng/.hidden/nested/config.json",
    ".github/skills",
  ])("fails for protected path %s", async (file) => {
    const { core, run } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue([file]);
    await run();
    expect(core.error).toHaveBeenCalledWith(expect.any(String), { file });
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it.each(
    [
      [],
      ["specification/widgets/main.tsp"],
      [".github/CODEOWNERS"],
      [".github/skills/custom/SKILL.md"],
      [".github/skills/custom/nested/file.ts"],
      [".github/skills/custom"],
      [".github/skills/.custom/.hidden"],
      [".github/skills/custom/.hidden/config.json"],
      [".github/skills/custom/azsdk-common-example/SKILL.md"],
      [".github/skills/azsdk-custom/SKILL.md"],
      [".GITHUB/codeowners", ".GITHUB/SKILLS/CUSTOM/skill.md"],
      ["documentation/ci-fix.md", "README.md", "specification/widgets/package.json"],
    ].map((files) => ({ files })),
  )("passes for unprotected changes $files", async ({ files }) => {
    const { core, run } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue(files);
    await run();
    expect(core.error).not.toHaveBeenCalled();
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith("No changes to protected files.");
  });

  it("reports only protected files in a mixed PR", async () => {
    const { core, run } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue([
      ".github/CODEOWNERS",
      "specification/widgets/main.tsp",
      ".github/skills/custom/SKILL.md",
      ".github/workflows/test.yaml",
      "pnpm-lock.yaml",
    ]);
    await run();
    expect(core.error).toHaveBeenCalledTimes(2);
    expect(core.error).toHaveBeenNthCalledWith(1, expect.any(String), {
      file: ".github/workflows/test.yaml",
    });
    expect(core.error).toHaveBeenNthCalledWith(2, expect.any(String), {
      file: "pnpm-lock.yaml",
    });
    expect(core.setFailed).toHaveBeenCalledWith(
      "Remove changes to protected files from your specification PR. See https://aka.ms/ci-fix#protected-files.",
    );
  });

  it.each([
    "eng/common/script.ps1",
    "eng/common",
    ".github/skills/azsdk-common-example/SKILL.md",
    ".github/skills/azsdk-common-example",
    ".github/skills/azsdk-common-example/.hidden/config.json",
    ".GITHUB/SKILLS/AZSDK-COMMON-EXAMPLE/SKILL.md",
    "eng/common/.hidden",
  ])("directs synced changes in %s to their source repository", async (file) => {
    const { core, run } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue([file]);
    await run();
    expect(core.error).toHaveBeenCalledWith(
      `File '${file}' is synced from Azure/azure-sdk-tools. Remove this change from your PR and make the change in Azure/azure-sdk-tools instead.`,
      { file },
    );
  });

  it("does not classify similarly named directories as synced", async () => {
    const { core, run } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue(["eng/common-other/script.ps1"]);
    await run();
    expect(core.error).toHaveBeenCalledWith(
      expect.stringContaining("outside the scope of a specification contribution"),
      { file: "eng/common-other/script.ps1" },
    );
  });

  it.each([
    { from: ".github/workflows/test.yaml", to: undefined, author: "spec-author" },
    {
      from: ".github/workflows/test.yaml",
      to: "specification/widgets/test.yaml",
      author: "timotheeguerin",
    },
    {
      from: "specification/widgets/test.yaml",
      to: ".github/workflows/test.yaml",
      author: "timotheeguerin",
    },
    { from: "specification/widgets/test.yaml", to: undefined, author: "timotheeguerin" },
  ])("detects protected changes in a real diff: $from -> $to", async ({ from, to, author }) => {
    const directory = await mkdtemp(join(tmpdir(), "protected-files-"));
    try {
      const git = simpleGit(directory);
      await git.init();
      await git.addConfig("user.name", "Test");
      await git.addConfig("user.email", "test@example.com");
      await git.addConfig("commit.gpgsign", "false");
      await mkdir(dirname(join(directory, from)), { recursive: true });
      await writeFile(join(directory, from), "test content\n");
      await writeFile(join(directory, "package.json"), "{}\n");
      await git.add(["--all"]);
      await git.commit("Initial file");
      if (to) {
        await mkdir(dirname(join(directory, to)), { recursive: true });
        await rename(join(directory, from), join(directory, to));
      } else {
        await rm(join(directory, from));
      }
      await writeFile(join(directory, "package.json"), '{"updated": true}\n');
      await git.add(["--all"]);
      await git.commit("Change file");

      const actual = await vi.importActual<typeof import("../../shared/src/changed-files.ts")>(
        "../../shared/src/changed-files.ts",
      );
      vi.mocked(getChangedFiles).mockImplementationOnce((options) =>
        actual.getChangedFiles({ ...options, cwd: directory }),
      );
      const { core, run } = setup(author);
      await run();
      expect(core.error).toHaveBeenCalledWith(expect.any(String), {
        file: "package.json",
      });
      const protectedPath = [from, to].find((file) => file?.startsWith(".github/"));
      if (protectedPath) {
        expect(core.error).toHaveBeenCalledWith(expect.any(String), { file: protectedPath });
      }
      expect(core.setFailed).toHaveBeenCalledOnce();
    } finally {
      await rm(directory, { recursive: true, force: true });
    }
  });

  it("propagates diff errors instead of passing", async () => {
    const { core, run } = setup();
    const error = new Error("Unable to read the merge parent");
    vi.mocked(getChangedFiles).mockRejectedValueOnce(error);
    await expect(run()).rejects.toThrow(error);
    expect(core.info).not.toHaveBeenCalledWith("No changes to protected files.");
  });

  it.each(["pull_request_target", "workflow_dispatch"])("rejects event %s", async (eventName) => {
    const { context, run } = setup();
    context.eventName = eventName;
    await expect(run()).rejects.toThrow("Unsupported event for Protected Files");
    expect(getChangedFiles).not.toHaveBeenCalled();
  });

  it("rejects a missing PR author", async () => {
    const { context, run } = setup();
    context.payload = {};
    await expect(run()).rejects.toThrow("Protected Files requires a pull request author");
    expect(getChangedFiles).not.toHaveBeenCalled();
  });
});

describe("Protected Files trusted diff", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it.each([`${HEAD_SHA} ${BASE_SHA}`, BASE_SHA, `${BASE_SHA} ${HEAD_SHA} ${MERGE_SHA}`])(
    "rejects mismatched or incomplete merge parents %s",
    async (parents) => {
      mockMerge().raw.mockResolvedValueOnce(parents);
      await expect(
        readProtectedFilesDiff({
          pullNumber: 42,
          headSha: HEAD_SHA,
          baseSha: BASE_SHA,
          token: "test-token",
        }),
      ).rejects.toThrow("PR merge does not match");
    },
  );

  it("propagates an unavailable merge ref", async () => {
    mockMerge().fetch.mockRejectedValueOnce(new Error("Merge ref unavailable"));
    await expect(
      readProtectedFilesDiff({
        pullNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
        token: "test-token",
      }),
    ).rejects.toThrow("Merge ref unavailable");
  });

  it.each([false, true])(
    "reads a merge without modifying the checkout (autocrlf: %s)",
    async (autocrlf) => {
      const directory = await mkdtemp(join(tmpdir(), "protected-files-merge-"));
      const origin = join(directory, "origin");
      const checkout = join(directory, "checkout");
      try {
        await mkdir(origin);
        const git = simpleGit(origin);
        await git.init(false, ["--initial-branch=main"]);
        await git.addConfig("user.name", "Test");
        await git.addConfig("user.email", "test@example.com");
        await git.addConfig("commit.gpgsign", "false");
        await writeFile(join(origin, "package.json"), '{"trusted": true}\n');
        await git.add(["--all"]);
        await git.commit("Trusted base");
        await git.checkoutLocalBranch("change");
        await writeFile(join(origin, "package.json"), '{"trusted": false}\n');
        await mkdir(join(origin, "specification/widgets"), { recursive: true });
        await writeFile(join(origin, "specification/widgets/spec.json"), "{}\n");
        await git.add(["--all"]);
        await git.commit("Untrusted PR");
        const headSha = await git.revparse(["HEAD"]);
        await git.checkout("main");
        await writeFile(join(origin, "base-only.txt"), "unrelated base change\n");
        await git.add(["--all"]);
        await git.commit("Updated target");
        const baseSha = await git.revparse(["HEAD"]);
        await git.merge(["--no-ff", "change", "-m", "PR merge"]);
        const mergeSha = await git.revparse(["HEAD"]);
        await git.raw(["update-ref", "refs/pull/1/merge", mergeSha]);

        await simpleGit().clone(origin, checkout, ["--no-checkout"]);
        const trusted = simpleGit(checkout);
        await trusted.addConfig("core.autocrlf", String(autocrlf));
        await trusted.checkout(baseSha);
        const diff = await readProtectedFilesDiff({
          cwd: checkout,
          pullNumber: 1,
          headSha,
          baseSha,
          token: "test-token",
        });
        expect(diff).toEqual({ baseCommitish: baseSha, headCommitish: mergeSha });
        const actual = await vi.importActual<typeof import("../../shared/src/changed-files.ts")>(
          "../../shared/src/changed-files.ts",
        );
        await expect(
          actual.getChangedFiles({ ...diff, cwd: checkout, gitOptions: ["--no-renames"] }),
        ).resolves.toEqual(["package.json", "specification/widgets/spec.json"]);

        const { context, core } = setup("timotheeguerin");
        const github = createMockGithub();
        const pr = {
          number: 1,
          state: "open",
          user: { login: "timotheeguerin" },
          head: { sha: headSha },
          base: { sha: baseSha },
        };
        context.payload = { pull_request: pr };
        github.rest.pulls.get.mockResolvedValue({ data: pr });
        vi.mocked(simpleGit).mockReturnValueOnce(trusted);
        vi.mocked(getChangedFiles).mockImplementationOnce((options) =>
          actual.getChangedFiles({ ...options, cwd: checkout }),
        );
        await expect(
          runProtectedFiles({ github, context, core }, "test-token"),
        ).resolves.toMatchObject({ conclusion: "failure" });
        expect(core.setFailed).toHaveBeenCalledOnce();
        expect(await trusted.revparse(["HEAD"])).toBe(baseSha);
        expect(JSON.parse(readFileSync(join(checkout, "package.json"), "utf8"))).toEqual({
          trusted: true,
        });
        expect(await trusted.raw(["status", "--porcelain"])).toBe("");
      } finally {
        await rm(directory, { recursive: true, force: true });
      }
    },
  );

  it.each([
    { pullNumber: 0, headSha: HEAD_SHA, token: "test-token" },
    { pullNumber: 42, headSha: "--untrusted-option", token: "test-token" },
    { pullNumber: 42, headSha: HEAD_SHA, token: "" },
  ])("rejects invalid metadata before git operations: $pullNumber / $headSha", async (input) => {
    await expect(readProtectedFilesDiff({ ...input, baseSha: BASE_SHA })).rejects.toThrow(
      "Protected Files requires",
    );
    expect(simpleGit).not.toHaveBeenCalled();
  });
});

describe("Protected Files read-only evaluation", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(getChangedFiles).mockResolvedValue([]);
  });

  function setupEvaluation(author = "timotheeguerin") {
    const { core, context } = setup(author);
    const github = createMockGithub();
    const denied = () => Promise.reject(new Error("Read-only token cannot write checks"));
    Object.assign(github.rest.checks, { create: vi.fn(denied), update: vi.fn(denied) });
    github.rest.repos.createCommitStatus.mockRejectedValue(new Error("Read-only token"));
    const pr = {
      number: 1,
      state: "open",
      user: { login: author },
      head: { sha: HEAD_SHA },
      base: { sha: BASE_SHA },
    };
    github.rest.pulls.get.mockResolvedValue({ data: pr });
    context.payload = { pull_request: pr };
    return {
      core,
      context,
      github,
      pr,
      run: () => runProtectedFiles({ github, context, core }, "test-token"),
    };
  }

  it("allows a maintainer's maintenance-only PR with a read-only API client", async () => {
    const { core, run } = setupEvaluation();
    mockMerge();
    vi.mocked(getChangedFiles).mockResolvedValue(["package.json"]);
    await expect(run()).resolves.toMatchObject({ conclusion: "success" });
    expect(core.setFailed).not.toHaveBeenCalled();
  });

  it("fails a mixed PR and identifies its protected changes", async () => {
    const { core, run } = setupEvaluation();
    mockMerge();
    vi.mocked(getChangedFiles).mockResolvedValue(["package.json", "specification/a/main.tsp"]);
    await expect(run()).resolves.toMatchObject({ conclusion: "failure" });
    expect(core.error).toHaveBeenCalledWith(expect.any(String), { file: "package.json" });
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it.each(["head", "base", "closed"])(
    "rejects the evaluation when the PR's %s changes",
    async (change) => {
      const { github, pr, run } = setupEvaluation();
      mockMerge();
      github.rest.pulls.get.mockResolvedValueOnce({ data: pr }).mockResolvedValueOnce({
        data: {
          ...pr,
          ...(change === "closed" ? { state: "closed" } : { [change]: { sha: "d".repeat(40) } }),
        },
      });
      await expect(run()).rejects.toThrow("PR changed during evaluation");
    },
  );

  it("rejects an already stale PR before fetching its merge", async () => {
    const { github, pr, run } = setupEvaluation();
    github.rest.pulls.get.mockResolvedValue({ data: { ...pr, head: { sha: MERGE_SHA } } });
    await expect(run()).rejects.toThrow("PR changed during evaluation");
    expect(simpleGit).not.toHaveBeenCalled();
  });

  it("uses the current PR author instead of the webhook author or triggering actor", async () => {
    const { context, core, pr, run } = setupEvaluation("spec-author");
    context.payload = { pull_request: { ...pr, user: { login: "timotheeguerin" } } };
    mockMerge();
    vi.mocked(getChangedFiles).mockResolvedValue(["package.json"]);
    await expect(run()).resolves.toMatchObject({ conclusion: "failure" });
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it("propagates API errors rather than granting an exemption", async () => {
    const { github, run } = setupEvaluation();
    github.rest.pulls.get.mockRejectedValueOnce(new Error("PR lookup failed"));
    await expect(run()).rejects.toThrow("PR lookup failed");
  });
});
