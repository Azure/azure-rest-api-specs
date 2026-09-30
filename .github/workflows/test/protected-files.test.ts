import { readFileSync } from "node:fs";
import { mkdir, mkdtemp, rename, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { simpleGit } from "simple-git";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { isMap, isSeq, parseDocument } from "yaml";
import { getChangedFiles } from "../../shared/src/changed-files.ts";
import { checkProtectedFiles } from "../src/protected-files.ts";
import { createMockContext, createMockCore } from "./mocks.ts";

vi.mock("../../shared/src/changed-files.ts", () => ({ getChangedFiles: vi.fn() }));

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
    { from: ".github/workflows/test.yaml", to: undefined },
    { from: ".github/workflows/test.yaml", to: "specification/widgets/test.yaml" },
    { from: "specification/widgets/test.yaml", to: ".github/workflows/test.yaml" },
  ])("detects protected changes in a real diff: $from -> $to", async ({ from, to }) => {
    const directory = await mkdtemp(join(tmpdir(), "protected-files-"));
    try {
      const git = simpleGit(directory);
      await git.init();
      await git.addConfig("user.name", "Test");
      await git.addConfig("user.email", "test@example.com");
      await git.addConfig("commit.gpgsign", "false");
      await mkdir(dirname(join(directory, from)), { recursive: true });
      await writeFile(join(directory, from), "test content\n");
      await git.add(["--all"]);
      await git.commit("Initial file");
      if (to) {
        await mkdir(dirname(join(directory, to)), { recursive: true });
        await rename(join(directory, from), join(directory, to));
      } else {
        await rm(join(directory, from));
      }
      await git.add(["--all"]);
      await git.commit("Change file");

      const actual = await vi.importActual<typeof import("../../shared/src/changed-files.ts")>(
        "../../shared/src/changed-files.ts",
      );
      vi.mocked(getChangedFiles).mockImplementationOnce((options) =>
        actual.getChangedFiles({ ...options, cwd: directory }),
      );
      const { core, run } = setup();
      await run();
      expect(core.error).toHaveBeenCalledExactlyOnceWith(expect.any(String), {
        file: ".github/workflows/test.yaml",
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

  it("runs the required check on PR merge commits, including base-branch edits", () => {
    const workflow = parseDocument(
      readFileSync(new URL("../protected-files.yaml", import.meta.url), "utf8"),
    );
    expect(workflow.errors).toEqual([]);
    const events = workflow.getIn(["on", "pull_request", "types"]);
    if (!isSeq(events)) throw new Error("Expected explicit PR event types");
    expect(events.toJSON()).toEqual(["opened", "synchronize", "reopened", "edited"]);
    expect(workflow.hasIn(["on", "pull_request", "paths"])).toBe(false);
    const permissions = workflow.get("permissions");
    if (!isMap(permissions)) throw new Error("Expected explicit token permissions");
    expect(permissions.toJSON()).toEqual({ contents: "read" });
    expect(workflow.getIn(["jobs", "protected-files", "name"])).toBe("Protected Files");
    expect(workflow.hasIn(["jobs", "protected-files", "if"])).toBe(false);
    const steps = workflow.getIn(["jobs", "protected-files", "steps"]);
    if (!isSeq(steps)) throw new Error("Expected workflow steps");
    const checkout = steps.items.find(
      (step) => isMap(step) && String(step.get("uses")).startsWith("actions/checkout@"),
    );
    if (!isMap(checkout)) throw new Error("Expected a checkout step");
    expect(checkout.getIn(["with", "fetch-depth"])).toBe(2);
    expect(checkout.hasIn(["with", "ref"])).toBe(false);
    const check = steps.items.find(
      (step) => isMap(step) && step.get("name") === "Detect changes to protected files",
    );
    if (!isMap(check)) throw new Error("Expected a protected-files check step");
    expect(check.getIn(["with", "script"])).toContain(
      "await checkProtectedFiles({ context, core })",
    );
  });
});
