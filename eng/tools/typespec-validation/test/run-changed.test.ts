import { ChildProcess, spawn } from "node:child_process";
import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
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
  root = await realpath(await mkdtemp(join(tmpdir(), "tsv-changed-")));
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
  });
  expect(vi.mocked(spawn).mock.calls[0][1]).toEqual([
    expect.stringMatching(/[/\\]cmd[/\\]tsv\.js$/),
    project,
    '{"checkingAllSpecs":false,"baseCommitish":"HEAD^","headCommitish":"HEAD"}',
  ]);
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
  });
  expect(vi.mocked(spawn).mock.calls[0][1]?.[2]).toBe(
    '{"checkingAllSpecs":false,"baseCommitish":"origin/main","headCommitish":"feature"}',
  );
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
  expect(console.log).toHaveBeenCalledWith(
    'Dry run: would validate specification/service/Project with context {"checkingAllSpecs":false,"baseCommitish":"HEAD^","headCommitish":"HEAD"}',
  );
  expect(console.log).toHaveBeenLastCalledWith("::endgroup::");
});

it("continues after a failed changed project and returns failure", async () => {
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
  expect(console.error).toHaveBeenCalledWith(
    "TypeSpec Validation failed for:\nspecification/service/Project",
  );
});
