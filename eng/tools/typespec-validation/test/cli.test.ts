import { execFile } from "node:child_process";
import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { promisify } from "node:util";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";

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

async function initGit() {
  return simpleGit(root)
    .init()
    .addConfig("user.name", "Test")
    .addConfig("user.email", "test@example.com")
    .addConfig("commit.gpgsign", "false");
}

async function commit(message: string) {
  await simpleGit(root).add("-A").commit(message);
  return (await simpleGit(root).revparse("HEAD")).trim();
}

beforeEach(async () => {
  root = await realpath(await mkdtemp(join(tmpdir(), "tsv-cli-")));
  vi.stubEnv("GITHUB_ACTIONS", "false");
});

afterEach(async () => {
  vi.unstubAllEnvs();
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
    stderr: expect.stringContaining("TypeSpec Validation failed for:\ncustom/a") as unknown,
  });
});

it("wraps child output in repository-relative GitHub Actions groups", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await addProject("specification/a");
  await addProject("specification/b");
  await simpleGit(root).init();
  await writeFile(
    join(root, "suppressions.yaml"),
    `- tool: TypeSpecValidation
  paths: [specification/a, specification/b]
  reason: fixture
`,
  );

  const { stdout } = await run("--all", join(root, "specification"));
  expect(stdout).toContain("Checking 2 TypeSpec folders:\nspecification/a\nspecification/b");
  const groups = [...stdout.matchAll(/::group::([^\n]+)\n([\s\S]*?)::endgroup::/g)];
  expect(groups.map((group) => group[1])).toEqual([
    "Validating specification/a",
    "Validating specification/b",
  ]);
  for (const group of groups) {
    expect(group[2]).toContain("Running TypeSpecValidation on folder:");
    expect(group[2]).toContain("Suppressed: fixture");
  }
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

it("requires a batch mode for --git-clean", async () => {
  await expect(run("--git-clean", "project")).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining(
      "--git-clean and --dry-run require --all or --changed",
    ) as unknown,
  });
});

it("requires --all for --shard", async () => {
  await expect(run("--shard=1/2", "project")).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining("--shard requires --all") as unknown,
  });
});

it.each(["1", "0/2", "3/2"])("exits nonzero for invalid --shard=%s", async (shard) => {
  await addProject("specification/a");
  await expect(run("--all", `--shard=${shard}`)).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining("Invalid --shard") as unknown,
  });
});

it("runs only the selected shard under an explicit root", async () => {
  await addProject("custom/a");
  await addProject("custom/b");
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidation\n  paths: [custom/b]\n  reason: selected project\n",
  );

  const { stdout } = await run("--all", "--shard", "2/2", "custom");
  expect(stdout).toContain("Shard 2/2: 1 of 2 TypeSpec projects");
  expect(stdout).toContain("Suppressed: selected project");
  expect(stdout).not.toContain(join(root, "custom/a"));
});

it("exits nonzero rather than creating empty shards", async () => {
  await addProject("specification/a");
  await expect(run("--all", "--shard=1/2")).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining("Shard count (2) exceeds") as unknown,
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
    stderr: expect.stringContaining(
      "Usage: tsv --all [folder] [--shard=<index>/<count>] [--git-clean] [--dry-run]",
    ) as unknown,
  });
});

it("validates only changed projects and forwards commit context with cleanup enabled", async () => {
  await addProject("specification/service/a");
  await addProject("specification/other/b");
  await writeFile(
    join(root, "suppressions.yaml"),
    `- tool: TypeSpecValidationAll
  paths: [specification/**]
  reason: must not suppress scoped runs
- tool: TypeSpecValidation
  paths: [specification/service/a]
  if: !checkingAllSpecs && baseCommitish === "HEAD^" && headCommitish === "HEAD"
  reason: changed project context
`,
  );
  await initGit();
  await commit("Base");
  await writeFile(join(root, "specification/service/a/tspconfig.yaml"), "# changed");
  await commit("Head");

  const { stdout } = await run("--changed", "--git-clean");
  expect(stdout).toContain("Checking 1 TypeSpec folders:\nspecification/service/a");
  expect(stdout).toContain("Suppressed: changed project context");
  expect(stdout).not.toContain("must not suppress scoped runs");
  expect(stdout).not.toContain("Validating specification/other/b");
  expect((await simpleGit(root).status()).isClean()).toBe(true);
});

it("can ignore a core-file fallback while retaining scoped spec changes", async () => {
  await addProject("specification/service/a");
  await addProject("specification/other/b");
  await writeFile(
    join(root, "suppressions.yaml"),
    `- tool: TypeSpecValidation
  paths: [specification/**]
  if: typeof baseCommitish === "string" && typeof headCommitish === "string"
  reason: valid context
`,
  );
  await initGit();
  await commit("Base");
  await writeFile(join(root, ".gitattributes"), "*.tsp text\n");
  await writeFile(join(root, "specification/service/a/tspconfig.yaml"), "# changed");
  await commit("Head");

  const all = await run("--changed");
  expect(all.stdout).toContain("Found changes to core eng or root files so checking all specs.");
  expect(all.stdout).toContain("Checking 2 TypeSpec folders:");
  expect(all.stdout.match(/Suppressed: valid context/g)).toHaveLength(2);
  const scoped = await run("--changed", "--ignore-core-files");
  expect(scoped.stdout).toContain("Checking 1 TypeSpec folders:\nspecification/service/a");
  expect(scoped.stdout).not.toContain("Validating specification/other/b");
});

it("honors explicit revisions and dry runs without modifying local files", async () => {
  await addProject("specification/service/a");
  await addProject("specification/other/b");
  await initGit();
  const base = await commit("Base");
  await writeFile(join(root, "specification/service/a/tspconfig.yaml"), "# first");
  const head = await commit("First change");
  await writeFile(join(root, "specification/other/b/tspconfig.yaml"), "# second");
  await commit("Second change");
  const untracked = join(root, "local.txt");
  await writeFile(untracked, "keep");

  const { stdout } = await run(
    "--changed",
    `--base=${base}`,
    `--head=${head}`,
    "--dry-run",
    "--git-clean",
  );
  expect(stdout).toContain("Checking 1 TypeSpec folders:\nspecification/service/a");
  expect(stdout).toContain(`"baseCommitish":"${base}","headCommitish":"${head}"`);
  expect(stdout).not.toContain("Running TypeSpecValidation on folder:");
  expect(await readFile(untracked, "utf8")).toBe("keep");
});

it("succeeds when committed changes do not affect any projects", async () => {
  await addProject("specification/service/a");
  await initGit();
  await commit("Base");
  await writeFile(join(root, "README.md"), "docs only");
  await commit("Docs");

  const { stdout } = await run("--changed");
  expect(stdout).toContain("No impacted TypeSpec projects found");
  expect(stdout).not.toContain("Running TypeSpecValidation on folder:");
});

it("includes services with changed non-ASCII filenames without changing Git configuration", async () => {
  await addProject("specification/service/a");
  await initGit();
  await simpleGit(root).addConfig("core.quotepath", "true");
  await commit("Base");
  await writeFile(join(root, "specification/service/a/caf\u00e9.json"), "{}");
  await commit("Example");

  const { stdout } = await run("--changed", "--dry-run");
  expect(stdout).toContain("Checking 1 TypeSpec folders:\nspecification/service/a");
  expect((await simpleGit(root).getConfig("core.quotepath")).value).toBe("true");
});

it("fails instead of treating an invalid base as an empty selection", async () => {
  await addProject("specification/service/a");
  await initGit();
  await commit("Base");

  await expect(run("--changed", "--base=missing-ref")).rejects.toMatchObject({ code: 1 });
});

it("returns a failure exit code and still validates later impacted projects", async () => {
  await addProject("specification/service/a");
  await addProject("specification/service/b");
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidation\n  paths: [specification/service/b]\n  reason: later project\n",
  );
  await initGit();
  await commit("Base");
  await writeFile(join(root, "specification/service/a/tspconfig.yaml"), "# changed");
  await writeFile(join(root, "specification/service/b/tspconfig.yaml"), "# changed");
  await commit("Head");

  await expect(run("--changed")).rejects.toMatchObject({
    code: 1,
    stdout: expect.stringContaining("Suppressed: later project") as unknown,
    stderr: expect.stringContaining(
      "TypeSpec Validation failed for:\nspecification/service/a",
    ) as unknown,
  });
});

it("supports --dry-run with --all", async () => {
  await addProject("specification/service/a");
  const { stdout } = await run("--all", "--dry-run");
  expect(stdout).toContain(
    'Dry run: would validate specification/service/a with context {"checkingAllSpecs":true}',
  );
  expect(stdout).not.toContain("Running TypeSpecValidation on folder:");
});

it.each([
  { args: ["--all", "--changed"], error: "--all and --changed cannot be combined" },
  { args: ["--changed", "--shard=1/2"], error: "--shard requires --all" },
  {
    args: ["--all", "--base=HEAD"],
    error: "--base, --head and --ignore-core-files require --changed",
  },
  {
    args: ["--head=HEAD", "project"],
    error: "--base, --head and --ignore-core-files require --changed",
  },
  {
    args: ["--ignore-core-files"],
    error: "--base, --head and --ignore-core-files require --changed",
  },
  { args: ["--dry-run"], error: "--git-clean and --dry-run require --all or --changed" },
  { args: ["--changed", "project"], error: "Usage: tsv --changed" },
])("rejects invalid invocation $args", async ({ args, error }) => {
  await expect(run(...args)).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining(error) as unknown,
  });
});
