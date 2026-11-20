import { mkdir, mkdtemp, rename, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { simpleGit } from "simple-git";
import { beforeEach, describe, expect, it, vi } from "vitest";
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
      vi.mocked(getChangedFiles).mockResolvedValue([
        "package.json",
        "specification/widgets/main.tsp",
      ]);
      await run();
      expect(core.error).toHaveBeenCalledWith(
        expect.stringContaining("Remove this change from your PR."),
        { file: "package.json" },
      );
      expect(core.setFailed).toHaveBeenCalledOnce();
    },
  );

  it("passes maintenance-only changes without an author exemption", async () => {
    const { core, run } = setup("external-contributor");
    vi.mocked(getChangedFiles).mockResolvedValue([
      "package.json",
      ".github/workflows/protected-files.yaml",
    ]);
    const result = await run();
    expect(result.conclusion).toBe("success");
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(result.summary).toContain("CODEOWNERS");
    expect(result.summary).toContain("package.json");
    expect(result.summary).toContain(".github/workflows/protected-files.yaml");
  });

  it("warns about synchronized files without blocking maintenance-only changes", async () => {
    const { core, run } = setup();
    const files = ["eng/common/script.ps1", ".github/skills/azsdk-common-example/SKILL.md"];
    vi.mocked(getChangedFiles).mockResolvedValue(files);
    const result = await run();
    expect(result.conclusion).toBe("success");
    expect(core.setFailed).not.toHaveBeenCalled();
    for (const file of files) {
      expect(core.warning).toHaveBeenCalledWith(
        expect.stringContaining("Make source changes in that repository"),
        { file },
      );
    }
  });

  it("recognizes specification scope case-insensitively", async () => {
    const { core, run } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue([
      "package.json",
      "SPECIFICATION/widgets/main.tsp",
    ]);
    await run();
    expect(core.setFailed).toHaveBeenCalledOnce();
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
  ])("fails for protected path %s in a specification PR", async (file) => {
    const { core, run } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue([file, "specification/widgets/main.tsp"]);
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
    vi.mocked(getChangedFiles).mockResolvedValue([file, "specification/widgets/main.tsp"]);
    await run();
    expect(core.error).toHaveBeenCalledWith(
      `File '${file}' is synced from Azure/azure-sdk-tools. Remove this change from your PR and make the change in Azure/azure-sdk-tools instead.`,
      { file },
    );
  });

  it("does not classify similarly named directories as synced", async () => {
    const { core, run } = setup();
    vi.mocked(getChangedFiles).mockResolvedValue([
      "eng/common-other/script.ps1",
      "specification/widgets/main.tsp",
    ]);
    await run();
    expect(core.error).toHaveBeenCalledWith(
      expect.stringContaining("outside the scope of a specification contribution"),
      { file: "eng/common-other/script.ps1" },
    );
  });

  it.each([
    { from: ".github/workflows/test.yaml", to: undefined, mixed: false },
    {
      from: ".github/workflows/test.yaml",
      to: "specification/widgets/test.yaml",
      mixed: true,
    },
    {
      from: "specification/widgets/test.yaml",
      to: ".github/workflows/test.yaml",
      mixed: true,
    },
    { from: "specification/widgets/test.yaml", to: undefined, mixed: true },
  ])("detects contribution scope in a real diff: $from -> $to", async ({ from, to, mixed }) => {
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
      const { core, run } = setup();
      const result = await run();
      const protectedPath = [from, to].find((file) => file?.startsWith(".github/"));
      if (mixed) {
        expect(result.conclusion).toBe("failure");
        expect(core.error).toHaveBeenCalledWith(expect.any(String), { file: "package.json" });
        if (protectedPath) {
          expect(core.error).toHaveBeenCalledWith(expect.any(String), { file: protectedPath });
        }
        expect(core.setFailed).toHaveBeenCalledOnce();
      } else {
        expect(result.conclusion).toBe("success");
        expect(result.summary).toContain(from);
        expect(core.error).not.toHaveBeenCalled();
        expect(core.setFailed).not.toHaveBeenCalled();
      }
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

  it("ignores specification changes introduced only by the base branch", async () => {
    const directory = await mkdtemp(join(tmpdir(), "protected-files-merge-"));
    try {
      const git = simpleGit(directory);
      await git.init(false, ["--initial-branch=main"]);
      await git.addConfig("user.name", "Test");
      await git.addConfig("user.email", "test@example.com");
      await git.addConfig("commit.gpgsign", "false");
      await writeFile(join(directory, "package.json"), "{}\n");
      await git.add(["--all"]);
      await git.commit("Base");
      await git.checkoutLocalBranch("change");
      await writeFile(join(directory, "package.json"), '{"updated": true}\n');
      await git.add(["--all"]);
      await git.commit("Maintenance change");
      await git.checkout("main");
      await mkdir(join(directory, "specification/widgets"), { recursive: true });
      await writeFile(join(directory, "specification/widgets/spec.json"), "{}\n");
      await git.add(["--all"]);
      await git.commit("Unrelated specification change");
      await git.merge(["--no-ff", "change", "-m", "PR merge"]);

      const actual = await vi.importActual<typeof import("../../shared/src/changed-files.ts")>(
        "../../shared/src/changed-files.ts",
      );
      vi.mocked(getChangedFiles).mockImplementationOnce((options) =>
        actual.getChangedFiles({ ...options, cwd: directory }),
      );
      const { core, run } = setup();
      const result = await run();
      expect(result.conclusion).toBe("success");
      expect(result.summary).toContain("package.json");
      expect(core.setFailed).not.toHaveBeenCalled();
    } finally {
      await rm(directory, { recursive: true, force: true });
    }
  });
});
