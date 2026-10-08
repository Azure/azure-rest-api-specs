import { mkdir, mkdtemp, rename, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { simpleGit } from "simple-git";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { getChangedFiles } from "../../shared/src/changed-files.ts";
import { execFile } from "../../shared/src/exec.ts";
import { checkProtectedFiles, runProtectedFiles } from "../src/protected-files.ts";
import { createMockContext, createMockCore } from "./mocks.ts";

vi.mock("../../shared/src/changed-files.ts", () => ({ getChangedFiles: vi.fn() }));
vi.mock("../../shared/src/exec.ts", () => ({ execFile: vi.fn() }));

function setup(author = "spec-author") {
  const context = createMockContext();
  context.eventName = "pull_request";
  context.payload = {
    pull_request: { number: 1, user: { login: author }, base: { sha: "base-sha" } },
  };
  const core = createMockCore();
  return { core, context, run: () => checkProtectedFiles({ context, core }) };
}

describe("Protected Files review guidance", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(getChangedFiles).mockResolvedValue([]);
    vi.mocked(execFile).mockResolvedValue({
      stdout: "* @maintainers\n/specification/\n/eng/ @tool-owner\n",
      stderr: "",
    });
  });

  it.each(["spec-author", "external-contributor", "azure-sdk", "azure-sdk-automation[bot]"])(
    "generates guidance for mixed changes by %s without blocking",
    async (author) => {
      const { core, run } = setup(author);
      vi.mocked(getChangedFiles).mockResolvedValue([
        "package.json",
        "eng/tools/example/src/index.ts",
        "specification/widgets/main.tsp",
      ]);
      const result = await run();
      expect(result.conclusion).toBe("success");
      expect(result.summary).toContain("package.json");
      expect(result.summary).toContain("@tool-owner");
      expect(result.summary).toContain("specification/widgets/main.tsp");
      expect(result.summary).toContain("does not mean approval has been granted");
      expect(core.setFailed).not.toHaveBeenCalled();
      expect(core.error).not.toHaveBeenCalled();
    },
  );

  it("reads ownership from the merge commit's base parent, not the PR's CODEOWNERS", async () => {
    const { run } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue([".github/CODEOWNERS"]);
    const result = await run();
    expect(execFile).toHaveBeenCalledWith(
      "git",
      ["show", "HEAD^:.github/CODEOWNERS"],
      expect.any(Object),
    );
    expect(result.summary).toContain("blob/base-sha/.github/CODEOWNERS");
    expect(result.summary).toContain("@maintainers");
  });

  it("reports an empty diff without claiming approval", async () => {
    const { run } = setup();
    const result = await run();
    expect(result.summary).toBe("No changed files to route for review.");
  });

  it.each(["diff", "CODEOWNERS"])("propagates %s errors instead of passing", async (source) => {
    const { core, run } = setup();
    const error = new Error(`Unable to read ${source}`);
    if (source === "diff") vi.mocked(getChangedFiles).mockRejectedValueOnce(error);
    else vi.mocked(execFile).mockRejectedValueOnce(error);
    await expect(run()).rejects.toThrow(error);
    expect(core.info).not.toHaveBeenCalled();
  });

  it("publishes successful guidance through the workflow entry point", async () => {
    const { context, core } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue(["eng/tools/example/index.ts"]);
    await runProtectedFiles({ context, core });
    expect(core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining("## Code-owner review guidance"),
    );
    expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining("@tool-owner"));
    expect(core.summary.write).toHaveBeenCalledOnce();
    expect(core.setFailed).not.toHaveBeenCalled();
  });

  it.each(["diff", "CODEOWNERS"])(
    "publishes actionable failure guidance without treating %s errors as missing approval",
    async (source) => {
      const { context, core } = setup();
      const error = new Error(`Unable to read ${source}`);
      if (source === "diff") vi.mocked(getChangedFiles).mockRejectedValueOnce(error);
      else vi.mocked(execFile).mockRejectedValueOnce(error);
      await expect(runProtectedFiles({ context, core })).rejects.toThrow(error);
      expect(core.error).toHaveBeenCalledWith(error);
      expect(core.setFailed).toHaveBeenCalledWith("Unable to generate code-owner review guidance");
      expect(core.summary.addRaw).toHaveBeenCalledWith(
        expect.stringContaining(`**Evaluation error:** \`Unable to read ${source}\``),
      );
      expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining("> [!CAUTION]"));
      expect(core.summary.addRaw).toHaveBeenCalledWith(
        expect.stringContaining("not a missing code-owner approval"),
      );
      expect(core.summary.addRaw).toHaveBeenCalledWith(
        expect.stringContaining("Rerun the failed job"),
      );
      expect(core.summary.write).toHaveBeenCalledOnce();
      expect(core.summary.addRaw).not.toHaveBeenCalledWith(
        expect.stringContaining("## Code-owner review guidance\n"),
      );
    },
  );

  it("keeps evaluation failed even when writing its error summary fails", async () => {
    const { context, core } = setup();
    vi.mocked(getChangedFiles).mockRejectedValueOnce(new Error("Unable to read diff"));
    core.summary.write.mockRejectedValueOnce(new Error("Summary file unavailable"));
    await expect(runProtectedFiles({ context, core })).rejects.toThrow("Summary file unavailable");
    expect(core.setFailed).toHaveBeenCalledWith("Unable to generate code-owner review guidance");
    expect(core.error).toHaveBeenCalledWith(
      expect.objectContaining({ message: "Unable to read diff" }),
    );
  });

  it("renders non-Error evaluation failures without losing the failure status", async () => {
    const { context, core } = setup();
    vi.mocked(getChangedFiles).mockRejectedValueOnce("Diff unavailable");
    await expect(runProtectedFiles({ context, core })).rejects.toBe("Diff unavailable");
    expect(core.setFailed).toHaveBeenCalledWith("Unable to generate code-owner review guidance");
    expect(core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining("**Evaluation error:** `Diff unavailable`"),
    );
  });

  it("rejects non-PR events", async () => {
    const { context, run } = setup();
    context.eventName = "workflow_dispatch";
    await expect(run()).rejects.toThrow("Unsupported event for Protected Files");
    expect(getChangedFiles).not.toHaveBeenCalled();
  });

  it("rejects missing PR identity", async () => {
    const { context, run } = setup();
    context.payload = {};
    await expect(run()).rejects.toThrow("Protected Files requires a pull request base SHA");
    expect(getChangedFiles).not.toHaveBeenCalled();
  });

  it.each([
    { from: "eng/tools/example/config.json", to: undefined },
    { from: "eng/tools/example/config.json", to: "specification/widgets/config.json" },
    { from: "specification/widgets/config.json", to: "eng/tools/example/config.json" },
  ])("routes real deletions and renames: $from -> $to", async ({ from, to }) => {
    const directory = await mkdtemp(join(tmpdir(), "codeowner-review-"));
    try {
      const git = simpleGit(directory);
      await git.init(false, ["--initial-branch=main"]);
      await git.addConfig("user.name", "Test");
      await git.addConfig("user.email", "test@example.com");
      await git.addConfig("commit.gpgsign", "false");
      await mkdir(join(directory, ".github"), { recursive: true });
      await mkdir(dirname(join(directory, from)), { recursive: true });
      await writeFile(join(directory, from), "test content\n");
      await writeFile(join(directory, ".github/CODEOWNERS"), "* @base-owner\n");
      await git.add(["--all"]);
      await git.commit("Base");
      const base = await git.revparse(["HEAD"]);
      await git.checkoutLocalBranch("change");
      if (to) {
        await mkdir(dirname(join(directory, to)), { recursive: true });
        await rename(join(directory, from), join(directory, to));
      } else {
        await rm(join(directory, from));
      }
      await writeFile(join(directory, ".github/CODEOWNERS"), "* @pr-owner\n");
      await git.add(["--all"]);
      await git.commit("Change files and ownership");
      await git.checkout("main");
      await mkdir(join(directory, "specification/unrelated"), { recursive: true });
      await writeFile(join(directory, "specification/unrelated/main.tsp"), "model Unrelated {}\n");
      await git.add(["--all"]);
      await git.commit("Unrelated base-branch change");
      await git.merge(["--no-ff", "change", "-m", "PR merge"]);

      const actualDiff = await vi.importActual<typeof import("../../shared/src/changed-files.ts")>(
        "../../shared/src/changed-files.ts",
      );
      const actualExec = await vi.importActual<typeof import("../../shared/src/exec.ts")>(
        "../../shared/src/exec.ts",
      );
      vi.mocked(getChangedFiles).mockImplementationOnce((options) =>
        actualDiff.getChangedFiles({ ...options, cwd: directory }),
      );
      vi.mocked(execFile).mockImplementationOnce((file, args, options) =>
        actualExec.execFile(file, args, { ...options, cwd: directory }),
      );
      const { context, core, run } = setup();
      context.payload = { pull_request: { number: 1, base: { sha: base } } };
      const result = await run();
      expect(result.summary).toContain(from);
      if (to) expect(result.summary).toContain(to);
      expect(result.summary).toContain("@base-owner");
      expect(result.summary).not.toContain("@pr-owner");
      expect(result.summary).not.toContain("specification/unrelated/main.tsp");
      expect(core.setFailed).not.toHaveBeenCalled();
    } finally {
      await rm(directory, { recursive: true, force: true });
    }
  });
});
