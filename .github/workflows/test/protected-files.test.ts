import { readFileSync } from "node:fs";
import { mkdir, mkdtemp, rename, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { runInNewContext } from "node:vm";
import { simpleGit } from "simple-git";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { isMap, isSeq, parseDocument } from "yaml";
import { getChangedFiles } from "../../shared/src/changed-files.ts";
import {
  checkProtectedFiles,
  publishProtectedFiles,
  readProtectedFilesDiff,
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
  context.eventName = "pull_request_target";
  context.actor = "azure-sdk";
  context.payload = { pull_request: { number: 1, user: { login: author } } };
  const core = createMockCore();
  return { core, context, run: () => checkProtectedFiles({ context, core }) };
}

function workflowScript(name: string): string {
  const workflow = parseDocument(
    readFileSync(new URL("../protected-files.yaml", import.meta.url), "utf8"),
  );
  const steps = workflow.getIn(["jobs", "protected-files", "steps"]);
  if (!isSeq(steps)) throw new Error("Expected workflow steps");
  const step = steps.items.find((item) => isMap(item) && item.get("name") === name);
  if (!isMap(step)) throw new Error(`Missing workflow step: ${name}`);
  const script = step.getIn(["with", "script"]);
  if (typeof script !== "string") throw new Error(`Missing script: ${name}`);
  return script;
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
      expect(result).toMatchObject({
        conclusion: "success",
        title: "Maintainer maintenance-only PR",
      });
      expect(result.summary).toContain("All other merge requirements still apply");
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

  it("passes a maintainer's specification-only PR without using the exemption", async () => {
    const { run } = setup("timotheeguerin");
    vi.mocked(getChangedFiles).mockResolvedValue(["specification/widgets/main.tsp"]);
    await expect(run()).resolves.toMatchObject({
      conclusion: "success",
      title: "No changes to protected files",
    });
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

  it("bounds check output for large PRs while reporting every protected path", async () => {
    const { core, run } = setup();
    core.error.mockImplementation(() => {});
    vi.mocked(getChangedFiles).mockResolvedValue(
      Array.from(
        { length: 1_000 },
        (_, index) => `eng/${index}/${"nested/".repeat(20)}config.json`,
      ),
    );
    const result = await run();
    expect(result.conclusion).toBe("failure");
    expect(Buffer.byteLength(result.summary)).toBeLessThan(65_535);
    expect(result.summary).toContain("additional protected paths");
    expect(core.error).toHaveBeenCalledTimes(1_000);
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

  it("includes deletions and both sides of renames using the shared diff reader", async () => {
    const { core, run } = setup();
    await run();
    expect(getChangedFiles).toHaveBeenCalledWith(
      expect.objectContaining({ gitOptions: ["--no-renames"] }),
    );
    expect(core.setFailed).not.toHaveBeenCalled();
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

  it("rejects non-PR events", async () => {
    const { context, run } = setup();
    context.eventName = "workflow_dispatch";
    await expect(run()).rejects.toThrow("Unsupported event for Protected Files");
    expect(getChangedFiles).not.toHaveBeenCalled();
  });

  it("rejects a missing PR author", async () => {
    const { context, run } = setup();
    context.payload = {};
    await expect(run()).rejects.toThrow("Protected Files requires a pull request author");
    expect(getChangedFiles).not.toHaveBeenCalled();
  });

  it("executes trusted policy and publishes one required head-SHA check", () => {
    const workflow = parseDocument(
      readFileSync(new URL("../protected-files.yaml", import.meta.url), "utf8"),
    );
    expect(workflow.errors).toEqual([]);
    const events = workflow.getIn(["on", "pull_request_target", "types"]);
    if (!isSeq(events)) throw new Error("Expected explicit PR event types");
    expect(events.toJSON()).toEqual(["opened", "synchronize", "reopened", "edited"]);
    expect(workflow.hasIn(["on", "pull_request"])).toBe(false);
    expect(workflow.hasIn(["on", "pull_request_target", "paths"])).toBe(false);
    const permissions = workflow.get("permissions");
    if (!isMap(permissions)) throw new Error("Expected explicit token permissions");
    expect(permissions.toJSON()).toEqual({
      contents: "read",
      "pull-requests": "read",
      checks: "write",
    });
    expect(workflow.getIn(["jobs", "protected-files", "name"])).not.toBe("Protected Files");
    expect(workflow.hasIn(["jobs", "protected-files", "if"])).toBe(false);
    expect(workflow.getIn(["concurrency", "cancel-in-progress"])).toBe(false);
    const steps = workflow.getIn(["jobs", "protected-files", "steps"]);
    if (!isSeq(steps)) throw new Error("Expected workflow steps");
    const start = steps.items[0];
    if (!isMap(start)) throw new Error("Expected a check creation step");
    expect(start.getIn(["with", "script"])).toContain('name: "Protected Files"');
    expect(start.getIn(["with", "script"])).toContain("head_sha: pr.head.sha");
    expect(start.getIn(["with", "script"])).toContain('status: "in_progress"');
    const exempt = steps.items.find((step) => isMap(step) && step.get("name") === "User allowed");
    if (!isMap(exempt)) throw new Error("Expected a trusted-author exemption step");
    expect(exempt.get("if")).toBe("${{ steps.start.outputs.user-allowed == 'true' }}");
    expect(exempt.getIn(["with", "script"])).toContain('conclusion: "success"');
    const artifactNames = steps.items
      .filter(
        (step) => isMap(step) && String(step.get("uses")).startsWith("actions/upload-artifact@"),
      )
      .map((step) => {
        if (!isMap(step)) throw new Error("Expected artifact upload step");
        return step.getIn(["with", "name"]);
      });
    expect(artifactNames).toEqual([
      "issue-number=${{ steps.start.outputs.issue-number }}",
      "head-sha=${{ steps.start.outputs.head-sha }}",
    ]);
    const checkout = steps.items.find(
      (step) => isMap(step) && String(step.get("uses")).startsWith("actions/checkout@"),
    );
    if (!isMap(checkout)) throw new Error("Expected a checkout step");
    expect(checkout.getIn(["with", "ref"])).toBe("${{ steps.start.outputs.base-sha }}");
    expect(checkout.getIn(["with", "persist-credentials"])).toBe(false);
    const check = steps.items.find(
      (step) => isMap(step) && step.get("name") === "Detect changes to protected files",
    );
    if (!isMap(check)) throw new Error("Expected a protected-files check step");
    expect(check.getIn(["with", "script"])).toContain(
      "await publishProtectedFiles({ github, context, core }",
    );
    const finalize = steps.items.at(-1);
    if (!isMap(finalize)) throw new Error("Expected a failure finalization step");
    expect(finalize.get("if")).toContain("always()");
    expect(finalize.get("if")).toContain("steps.evaluate.outputs.published != 'true'");
    expect(finalize.getIn(["with", "script"])).toContain('conclusion: "failure"');
  });
});

describe("Protected Files trusted diff", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("fetches the merge as data and verifies its parents before selecting the diff", async () => {
    const { fetch, raw } = mockMerge();
    await expect(
      readProtectedFilesDiff({
        pullNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
        token: "test-token",
      }),
    ).resolves.toEqual({ baseCommitish: BASE_SHA, headCommitish: MERGE_SHA });
    expect(fetch).toHaveBeenCalledWith([
      "--no-tags",
      "--filter=blob:none",
      "--depth=2",
      "origin",
      "refs/pull/42/merge",
    ]);
    expect(raw).toHaveBeenCalledExactlyOnceWith(["show", "--no-patch", "--format=%P", MERGE_SHA]);
    expect(simpleGit).toHaveBeenCalledWith({
      baseDir: undefined,
      config: [
        `http.extraheader=AUTHORIZATION: basic ${Buffer.from("x-access-token:test-token").toString("base64")}`,
      ],
    });
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

  it("reads a real fetched merge without modifying the trusted checkout", async () => {
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
      ).resolves.toEqual(["package.json"]);
      expect(await trusted.revparse(["HEAD"])).toBe(baseSha);
      expect(readFileSync(join(checkout, "package.json"), "utf8")).toBe('{"trusted": true}\n');
      expect(await trusted.raw(["status", "--porcelain"])).toBe("");
    } finally {
      await rm(directory, { recursive: true, force: true });
    }
  });

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

describe("Protected Files publishing", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(getChangedFiles).mockResolvedValue([]);
  });

  function setupPublisher(author = "timotheeguerin") {
    const { core, context } = setup(author);
    const github = createMockGithub();
    const update = vi.fn<typeof github.rest.checks.update>();
    Object.assign(github.rest.checks, { update });
    const pr = {
      number: 1,
      state: "open",
      user: { login: author },
      head: { sha: HEAD_SHA },
      base: { sha: BASE_SHA },
    };
    github.rest.pulls.get.mockResolvedValue({ data: pr });
    const inputs = {
      checkRunId: 123,
      headSha: HEAD_SHA,
      baseSha: BASE_SHA,
      token: "test-token",
    };
    return {
      core,
      context,
      github,
      update,
      pr,
      run: () => publishProtectedFiles({ github, context, core }, inputs),
    };
  }

  it("publishes a maintenance exemption after evaluating the pinned merge", async () => {
    const { core, update, run } = setupPublisher();
    mockMerge();
    vi.mocked(getChangedFiles).mockResolvedValue(["package.json"]);
    await run();
    expect(getChangedFiles).toHaveBeenCalledWith(
      expect.objectContaining({
        baseCommitish: BASE_SHA,
        headCommitish: MERGE_SHA,
        gitOptions: ["--no-renames"],
      }),
    );
    expect(update).toHaveBeenCalledWith(
      expect.objectContaining({
        check_run_id: 123,
        status: "completed",
        conclusion: "success",
      }),
    );
    expect(update.mock.calls[0]?.[0]?.output?.title).toBe("Maintainer maintenance-only PR");
    expect(core.setSecret).toHaveBeenCalledWith(
      Buffer.from("x-access-token:test-token").toString("base64"),
    );
    expect(core.summary.write).toHaveBeenCalledOnce();
    expect(core.setOutput).toHaveBeenCalledWith("published", "true");
  });

  it("publishes failure and the protected paths for a mixed PR", async () => {
    const { core, update, run } = setupPublisher();
    mockMerge();
    vi.mocked(getChangedFiles).mockResolvedValue(["package.json", "specification/a/main.tsp"]);
    await run();
    expect(update.mock.calls[0]?.[0]?.conclusion).toBe("failure");
    expect(update.mock.calls[0]?.[0]?.output?.summary).toContain("package.json");
    expect(core.setFailed).toHaveBeenCalledOnce();
    expect(core.setOutput).toHaveBeenCalledWith("published", "true");
  });

  it.each(["head", "base", "closed"])(
    "does not publish stale success after a %s change",
    async (change) => {
      const { github, update, pr, run } = setupPublisher();
      mockMerge();
      github.rest.pulls.get.mockResolvedValueOnce({ data: pr }).mockResolvedValueOnce({
        data: {
          ...pr,
          ...(change === "closed" ? { state: "closed" } : { [change]: { sha: "d".repeat(40) } }),
        },
      });
      await expect(run()).rejects.toThrow("PR changed during evaluation");
      expect(update).not.toHaveBeenCalled();
    },
  );

  it("rejects an already stale PR before fetching its merge", async () => {
    const { github, pr, run } = setupPublisher();
    github.rest.pulls.get.mockResolvedValue({ data: { ...pr, head: { sha: MERGE_SHA } } });
    await expect(run()).rejects.toThrow("PR changed during evaluation");
    expect(simpleGit).not.toHaveBeenCalled();
  });

  it("uses the current PR author instead of the webhook author or triggering actor", async () => {
    const { context, update, run } = setupPublisher("spec-author");
    context.payload = { pull_request: { number: 1, user: { login: "timotheeguerin" } } };
    mockMerge();
    vi.mocked(getChangedFiles).mockResolvedValue(["package.json"]);
    await run();
    expect(update).toHaveBeenCalledWith(expect.objectContaining({ conclusion: "failure" }));
  });

  it("propagates publication errors without marking the check published", async () => {
    const { core, update, run } = setupPublisher();
    mockMerge();
    update.mockRejectedValueOnce(new Error("Check publication failed"));
    await expect(run()).rejects.toThrow("Check publication failed");
    expect(core.setOutput).not.toHaveBeenCalledWith("published", "true");
  });
});

describe("Protected Files workflow publishing lifecycle", () => {
  function setupWorkflow(author = "spec-author") {
    const { context, core } = setup(author);
    context.serverUrl = "https://github.com";
    context.runId = 456;
    const github = createMockGithub();
    const create = vi.fn().mockResolvedValue({ data: { id: 123 } });
    const update = vi.fn();
    Object.assign(github.rest.checks, { create, update });
    const pr = {
      number: 1,
      state: "open",
      user: { login: author },
      head: { sha: HEAD_SHA },
      base: { sha: BASE_SHA },
    };
    github.rest.pulls.get.mockResolvedValue({ data: pr });
    async function run(name: string) {
      await runInNewContext(`(async () => { ${workflowScript(name)} })()`, {
        github,
        context,
        core,
        process: {
          env: { CHECK_RUN_ID: "123", HEAD_SHA, BASE_SHA },
        },
      });
    }
    return { github, core, create, update, pr, run };
  }

  it("creates the required check on the current PR head, not the target or merge SHA", async () => {
    const { core, create, run } = setupWorkflow();
    await run("Start required check");
    expect(create).toHaveBeenCalledWith(
      expect.objectContaining({
        name: "Protected Files",
        head_sha: HEAD_SHA,
        status: "in_progress",
        external_id: "protected-files:1",
      }),
    );
    expect(core.setOutput).toHaveBeenCalledWith("check-run-id", 123);
    expect(core.setOutput).toHaveBeenCalledWith("base-sha", BASE_SHA);
    expect(core.setOutput).toHaveBeenCalledWith("user-allowed", false);
  });

  it.each(["azure-sdk", "Azure-SDK", "azure-sdk-automation[bot]"])(
    "publishes the fast-path success for %s without git or dependencies",
    async (author) => {
      const { core, update, run } = setupWorkflow(author);
      await run("Start required check");
      expect(core.setOutput).toHaveBeenCalledWith("user-allowed", true);
      await run("User allowed");
      expect(update).toHaveBeenCalledWith(
        expect.objectContaining({
          check_run_id: 123,
          status: "completed",
          conclusion: "success",
        }),
      );
      expect(core.setOutput).toHaveBeenCalledWith("published", "true");
    },
  );

  it("does not publish automation success on a stale head", async () => {
    const { github, update, pr, run } = setupWorkflow("azure-sdk");
    github.rest.pulls.get.mockResolvedValue({ data: { ...pr, head: { sha: MERGE_SHA } } });
    await expect(run("User allowed")).rejects.toThrow("PR changed during evaluation");
    expect(update).not.toHaveBeenCalled();
  });

  it("finalizes an incomplete or failed setup as an explicit check failure", async () => {
    const { core, update, run } = setupWorkflow();
    await run("Fail incomplete evaluation");
    expect(update).toHaveBeenCalledWith(
      expect.objectContaining({
        check_run_id: 123,
        status: "completed",
        conclusion: "failure",
      }),
    );
    expect(core.setFailed).toHaveBeenCalledOnce();
  });

  it("refreshes the merge summary after Protected Files completes", () => {
    const workflow = parseDocument(
      readFileSync(new URL("../summarize-checks.yaml", import.meta.url), "utf8"),
    );
    const workflows = workflow.getIn(["on", "workflow_run", "workflows"]);
    if (!isSeq(workflows)) throw new Error("Expected summary workflow triggers");
    expect(workflows.toJSON()).toContain("Protected Files");
  });
});
