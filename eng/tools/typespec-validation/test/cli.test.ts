import { execFile } from "node:child_process";
import { mkdir, mkdtemp, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { promisify } from "node:util";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it } from "vitest";

const execFileAsync = promisify(execFile);
const cli = fileURLToPath(new URL("../cmd/tsv.js", import.meta.url));

let root: string;

async function addProject(path: string) {
  const folder = join(root, path);
  await mkdir(folder, { recursive: true });
  await writeFile(join(folder, "tspconfig.yaml"), "");
}

function run(...args: string[]) {
  return execFileAsync(process.execPath, [cli, ...args], { cwd: root });
}

beforeEach(async () => {
  root = await realpath(await mkdtemp(join(tmpdir(), "tsv-cli-")));
});

afterEach(async () => {
  await rm(root, { recursive: true, force: true });
});

it("defaults --all to specification and passes all-spec context to children and suppressions", async () => {
  await addProject("specification/a");
  await addProject("specification/b");
  await writeFile(
    join(root, "suppressions.yaml"),
    `- tool: TypeSpecValidationAll
  paths: [specification/a]
  if: checkingAllSpecs === true
  reason: skipped by all
- tool: TypeSpecValidation
  paths: [specification/b]
  if: checkingAllSpecs === true
  reason: skipped by project
`,
  );

  const { stdout } = await run("--all");
  expect(stdout).toContain("Checking 2 TypeSpec folders:");
  expect(stdout).toContain("Suppressed: skipped by all");
  expect(stdout).toContain("Suppressed: skipped by project");
});

it("uses an explicit root, exits nonzero on failure, and still runs later projects", async () => {
  await addProject("custom/a");
  await addProject("custom/b");
  await simpleGit(root).init();
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidation\n  paths: [custom/b]\n  reason: later project\n",
  );

  await expect(run("--all", "custom")).rejects.toMatchObject({
    code: 1,
    stdout: expect.stringContaining("Suppressed: later project") as unknown,
    stderr: expect.stringContaining(
      `TypeSpec Validation failed for:\n${join(root, "custom/a")}`,
    ) as unknown,
  });
});

it("preserves single-project validation and its positional context", async () => {
  await addProject("project");
  await writeFile(
    join(root, "suppressions.yaml"),
    `- tool: TypeSpecValidation
  paths: [project]
  if: !checkingAllSpecs && customValue === true
  reason: single project
`,
  );

  const { stdout } = await run("project", '{"customValue":true}');
  expect(stdout).toContain("Suppressed: single project");
});

it("exits nonzero when --all finds no projects", async () => {
  await mkdir(join(root, "specification"));
  await expect(run("--all")).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining("No TypeSpec projects found") as unknown,
  });
});

it("requires --all for --git-clean", async () => {
  await expect(run("--git-clean", "project")).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining("--git-clean requires --all") as unknown,
  });
});

it("refuses --git-clean when the checkout has untracked files", async () => {
  await addProject("specification/a");
  await simpleGit(root)
    .init()
    .addConfig("user.name", "Test")
    .addConfig("user.email", "test@example.com")
    .addConfig("commit.gpgsign", "false")
    .add(".")
    .commit("Fixture");
  await writeFile(join(root, "local.txt"), "local edits");

  await expect(run("--all", "--git-clean")).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining("--git-clean requires a clean checkout") as unknown,
  });
});

it("rejects extra positional arguments to --all", async () => {
  await expect(run("--all", "specification", "extra")).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining("Usage: tsv --all [folder] [--git-clean]") as unknown,
  });
});
