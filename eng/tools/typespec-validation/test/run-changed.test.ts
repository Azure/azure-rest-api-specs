import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { d } from "@azure-tools/specs-shared/testing";
import { ChildProcess, spawn } from "node:child_process";
import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "pathe";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { findChangedProjects } from "../src/find-projects.ts";
import { runChanged } from "../src/run-projects.ts";

vi.mock("../src/find-projects.ts", async (importOriginal) => ({
  ...(await importOriginal()),
  findChangedProjects: vi.fn(),
}));
vi.mock("node:child_process", async (importOriginal) => ({
  ...(await importOriginal()),
  spawn: vi.fn(),
}));

let root: string;
let project: string;

beforeEach(async () => {
  root = resolve(await realpath(await mkdtemp(join(tmpdir(), "tsv-changed-"))));
  project = join(root, "specification/service/Project");
  await mkdir(project, { recursive: true });
  await writeFile(join(project, "tspconfig.yaml"), "");
  await simpleGit(root).init();
  vi.stubEnv("GITHUB_ACTIONS", "false");
  vi.spyOn(console, "log").mockImplementation(() => {});
  vi.spyOn(console, "error").mockImplementation(() => {});
  vi.mocked(findChangedProjects)
    .mockReset()
    .mockResolvedValue({
      projects: [project],
      checkingAllSpecs: false,
    });
  vi.mocked(spawn)
    .mockReset()
    .mockImplementation(() => {
      const child = new ChildProcess();
      queueMicrotask(() => child.emit("close", 0, null));
      return child;
    });
});

afterEach(async () => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
});

it("uses the repository root and passes the default revisions to each project", async () => {
  await expect(runChanged(project)).resolves.toBe(true);
  expect(findChangedProjects).toHaveBeenCalledWith(root, {
    baseCommitish: "HEAD^",
    headCommitish: "HEAD",
    ignoreCoreFiles: undefined,
    logger: expect.any(ConsoleLogger) as unknown,
  });
  expect(vi.mocked(spawn).mock.calls[0][1]).toEqual([
    expect.stringMatching(/[/\\]cmd[/\\]tsv\.js$/),
    project,
    '{"checkingAllSpecs":false,"baseCommitish":"HEAD^","headCommitish":"HEAD"}',
  ]);
  expect(vi.mocked(findChangedProjects).mock.calls[0][1].logger.isDebug()).toBe(false);
});

it("passes explicit revisions and the core-file policy without losing context", async () => {
  await expect(
    runChanged(root, {
      baseCommitish: "origin/main",
      headCommitish: "feature",
      ignoreCoreFiles: true,
    }),
  ).resolves.toBe(true);
  expect(findChangedProjects).toHaveBeenCalledWith(root, {
    baseCommitish: "origin/main",
    headCommitish: "feature",
    ignoreCoreFiles: true,
    logger: expect.any(ConsoleLogger) as unknown,
  });
  expect(vi.mocked(spawn).mock.calls[0][1]?.[2]).toBe(
    '{"checkingAllSpecs":false,"baseCommitish":"origin/main","headCommitish":"feature"}',
  );
});

it("forwards verbose logging without adding presentation options to suppression context", async () => {
  await expect(runChanged(root, { verbose: true })).resolves.toBe(true);
  expect(findChangedProjects).toHaveBeenCalledWith(
    root,
    expect.objectContaining({
      logger: expect.objectContaining({ isDebug: expect.any(Function) as unknown }) as unknown,
    }),
  );
  expect(vi.mocked(findChangedProjects).mock.calls[0][1].logger.isDebug()).toBe(true);
  expect(vi.mocked(spawn).mock.calls[0][1]).toEqual([
    expect.stringMatching(/[/\\]cmd[/\\]tsv\.js$/),
    project,
    '{"checkingAllSpecs":false,"baseCommitish":"HEAD^","headCommitish":"HEAD"}',
    "--verbose",
  ]);
});

it("does not honor all-spec suppressions for scoped changed projects", async () => {
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidationAll\n  paths: [specification/**]\n  reason: all only\n",
  );
  await expect(runChanged(root)).resolves.toBe(true);
  expect(spawn).toHaveBeenCalledOnce();
});

it("honors all-spec suppressions, including commit context, after a core-file fallback", async () => {
  vi.mocked(findChangedProjects).mockResolvedValue({
    projects: [project],
    checkingAllSpecs: true,
  });
  await writeFile(
    join(root, "suppressions.yaml"),
    `- tool: TypeSpecValidationAll
  paths: [specification/**]
  if: checkingAllSpecs && baseCommitish === "HEAD^" && headCommitish === "HEAD"
  reason: all only
`,
  );
  await expect(runChanged(root)).resolves.toBe(true);
  expect(spawn).not.toHaveBeenCalled();
  expect(console.log).toHaveBeenCalledWith("Suppressed: all only");
});

it("sets all-spec context on child processes after a core-file fallback", async () => {
  vi.mocked(findChangedProjects).mockResolvedValue({
    projects: [project],
    checkingAllSpecs: true,
  });
  await expect(runChanged(root)).resolves.toBe(true);
  expect(vi.mocked(spawn).mock.calls[0][1]?.[2]).toBe(
    '{"checkingAllSpecs":true,"baseCommitish":"HEAD^","headCommitish":"HEAD"}',
  );
});

it.each([false, true])(
  "handles empty selections with checkingAllSpecs=%s",
  async (checkingAllSpecs) => {
    vi.mocked(findChangedProjects).mockResolvedValue({ projects: [], checkingAllSpecs });
    await expect(runChanged(root)).resolves.toBe(!checkingAllSpecs);
    expect(spawn).not.toHaveBeenCalled();
    if (checkingAllSpecs) {
      expect(console.error).toHaveBeenCalledWith(
        "TypeSpec Validation - All did not validate any specs",
      );
    } else {
      expect(console.log).toHaveBeenCalledWith("No impacted TypeSpec projects found");
    }
  },
);

it("dry runs list project context but do not validate or clean a dirty checkout", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  const untracked = join(root, "local.txt");
  await writeFile(untracked, "keep");
  await expect(runChanged(root, { dryRun: true, gitClean: true })).resolves.toBe(true);
  expect(spawn).not.toHaveBeenCalled();
  expect(await readFile(untracked, "utf8")).toBe("keep");
  expect(console.log).toHaveBeenLastCalledWith(
    'Dry run: would validate specification/service/Project with context {"checkingAllSpecs":false,"baseCommitish":"HEAD^","headCommitish":"HEAD"}',
  );
});

it.each(["false", "true"])(
  "continues after a failed changed project and reports failures with GITHUB_ACTIONS=%s",
  async (githubActions) => {
    vi.stubEnv("GITHUB_ACTIONS", githubActions);
    const other = join(root, "specification/other/Project");
    await mkdir(other, { recursive: true });
    vi.mocked(findChangedProjects).mockResolvedValue({
      projects: [project, other],
      checkingAllSpecs: false,
    });
    vi.mocked(spawn).mockImplementationOnce(() => {
      const child = new ChildProcess();
      queueMicrotask(() => child.emit("close", 1, null));
      return child;
    });
    await expect(runChanged(root)).resolves.toBe(false);
    expect(spawn).toHaveBeenCalledTimes(2);
    expect(console.error).toHaveBeenLastCalledWith(d`
      TypeSpec Validation failed for some folder to fix run and address any errors:
       > pnpm install
       > pnpm tsv specification/service/Project
      For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation
    `);
    if (githubActions === "true") {
      expect(console.log).toHaveBeenCalledWith(
        "::error::TypeSpec Validation failed for project specification/service/Project run the following command locally to validate.%0A" +
          " > pnpm install%0A > pnpm tsv specification/service/Project%0A" +
          "For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation",
      );
    } else {
      expect(console.log).not.toHaveBeenCalledWith(expect.stringMatching(/^::error::/));
    }
  },
);
