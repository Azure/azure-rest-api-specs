import { d } from "@azure-tools/specs-shared/testing";
import { execFile } from "node:child_process";
import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "pathe";
import { fileURLToPath } from "node:url";
import { promisify, stripVTControlCharacters } from "node:util";
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
  root = resolve(await realpath(await mkdtemp(join(tmpdir(), "tsv-cli-"))));
  vi.stubEnv("GITHUB_ACTIONS", "false");
  vi.stubEnv("DEBUG", "");
  vi.stubEnv("NO_COLOR", "1");
  vi.stubEnv("FORCE_COLOR", undefined);
  vi.stubEnv("GITHUB_STEP_SUMMARY", undefined);
});

afterEach(async () => {
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
});

it("shows the same help for --help and -h without a project or Git repository", async () => {
  const help = await run("--help");
  expect(await run("-h")).toEqual(help);
  expect(help.stderr).toBe("");
  for (const text of [
    "Validate Azure TypeSpec projects.",
    "pnpm tsv <folder> [context-json] [options]",
    "JSON context for rules and suppressions",
    "-v, --verbose",
    "--head <commit>",
    "--ignore-core-files",
    "--dry-run",
    "--git-clean",
    "--github-summary",
    "default: HEAD^",
    "default: HEAD)",
    "--all and --changed cannot be combined",
    "Options for --changed:",
    "Options for --all:",
    "Options for --all or --changed:",
    "one-based indices",
    "entire repository",
    "clean, disposable checkout",
    "ignored files are retained",
    "disables --git-clean",
    "pnpm tsv --changed --base=origin/main --head=HEAD --dry-run",
    "https://aka.ms/azsdk/specs/typespec-validation",
  ]) {
    expect(help.stdout.replace(/\s+/g, " ")).toContain(text);
  }
  expect(help.stdout).toMatch(/^\s+-h, --help\s+Show help and exit\.$/m);
  expect(help.stdout).toMatch(/^\s+--base <commit>\s+Base revision \(default: HEAD\^\)\.$/m);
  expect(help.stdout).toMatch(
    /^\s+--shard <index>\/<count>\s+Select a shard using one-based indices\./m,
  );
  expect(help.stdout).not.toMatch(/(?:^|\s)(?:--folder|--context|-f|-c)(?=[\s,=]|$)/);
});

it("requires an explicit project folder instead of resolving a missing argument to cwd", async () => {
  await writeFile(join(root, "tspconfig.yaml"), "");
  await expect(run()).rejects.toMatchObject({
    code: 1,
    stdout: "",
    stderr: "A project folder is required. Use --help for usage.\n",
  });
});

it("accepts backslash-separated relative project paths on every platform", async () => {
  const project = "specification/service/data-plane/Project";
  await addProject(project);
  await writeFile(
    join(root, "suppressions.yaml"),
    `- tool: TypeSpecValidation\n  paths: [${project}]\n  reason: normalized path fixture\n`,
  );
  const result = await run("specification\\service\\data-plane\\Project");
  expect(result.stdout).toContain("Suppressed: normalized path fixture");
  expect(result.stderr).toBe("");
});

it.each([
  ["--verbose"],
  ["--all"],
  ["--changed"],
  ["--all", "--changed"],
  ["--git-clean"],
  ["--dry-run"],
  ["--github-summary"],
  ["--shard=invalid"],
  ["--base=missing-ref"],
  ["missing-project", "{invalid-json"],
])("shows help before validation for %j", async (...args) => {
  const { stdout, stderr } = await run(...args, "--help");
  expect(stdout).toBe((await run("--help")).stdout);
  expect(stderr).toBe("");
});

it("does not clean files when help is requested with --git-clean", async () => {
  const sentinel = join(root, "local.txt");
  await writeFile(sentinel, "keep");

  const { stdout, stderr } = await run("--all", "--git-clean", "--help");
  expect(stdout).toContain("Usage:");
  expect(stdout).not.toMatch(/Checking \d+ TypeSpec folders|Running TypeSpecValidation on folder:/);
  expect(stderr).toBe("");
  expect(await readFile(sentinel, "utf8")).toBe("keep");
});

it.each(["--folder", "-f", "--context", "-c"])("rejects the unused option %s", async (option) => {
  await expect(run(option, "unused")).rejects.toMatchObject({
    code: 1,
    stdout: "",
    stderr: expect.stringContaining(`Unknown option '${option}'`) as unknown,
  });
});

it.each([
  { args: ["--unknown"], error: "ERR_PARSE_ARGS_UNKNOWN_OPTION" },
  { args: ["--help", "--unknown"], error: "ERR_PARSE_ARGS_UNKNOWN_OPTION" },
  { args: ["--base"], error: "ERR_PARSE_ARGS_INVALID_OPTION_VALUE" },
  { args: ["--help", "--base"], error: "ERR_PARSE_ARGS_INVALID_OPTION_VALUE" },
])("preserves parser errors for $args", async ({ args, error }) => {
  await expect(run(...args)).rejects.toMatchObject({
    code: 1,
    stdout: "",
    stderr: expect.stringContaining(error) as unknown,
  });
});

it("treats --help after the option terminator as a positional folder", async () => {
  await expect(run("--", "--help")).rejects.toMatchObject({
    code: 1,
    stdout: expect.stringContaining("/--help does not exist") as unknown,
    stderr: "",
  });
});

it.each(["single", "all", "changed"])(
  "makes Git tracing opt-in without hiding %s validation failures",
  async (mode) => {
    const project = "specification/service/Project";
    await addProject(project);
    await initGit();
    await commit("Base");
    await writeFile(join(root, project, "tspconfig.yaml"), "# changed");
    await commit("Head");
    const args = mode === "single" ? [project] : [`--${mode}`];
    await expect(run(...args)).rejects.toMatchObject({
      code: 1,
      stdout: expect.not.stringContaining("Executing rule:") as unknown,
      stderr: expect.stringContaining(
        'error tsv/folder-structure: Project must use "folder structure v2"',
      ) as unknown,
    });
    await expect(run(...args, "--verbose")).rejects.toMatchObject({
      code: 1,
      stdout: expect.stringContaining("\u00d7 FolderStructure") as unknown,
      stderr: expect.stringContaining("simple-git") as unknown,
    });
  },
);

it("keeps changed-file inventories behind --verbose and supports -v", async () => {
  await addProject("specification/service/Project");
  await initGit();
  await commit("Base");
  await writeFile(join(root, "specification/service/Project/tspconfig.yaml"), "# changed");
  await commit("Head");
  const quiet = await run("--changed", "--dry-run");
  expect(quiet.stdout).not.toContain("Changed Files:");
  expect(quiet.stderr).toBe("");
  const verbose = await run("--changed", "--dry-run", "-v");
  expect(verbose.stdout).toContain("Changed Files:");
  expect(verbose.stderr).toContain("simple-git");
});

it("respects explicit DEBUG selections without --verbose", async () => {
  vi.stubEnv("DEBUG", "simple-git");
  await addProject("specification/service/Project");
  await initGit();
  const { stderr } = await run("--all", "--dry-run");
  expect(stderr).toContain("simple-git");
});

it.each([
  {
    config: "emit: []\nemit: []\n",
    diagnostic: "tspconfig.yaml:2:1 - error tsv/invalid-yaml:",
    color: false,
  },
  {
    config: "emit: false\n",
    diagnostic: "tspconfig.yaml - error tsv/invalid-config: emit:",
    color: false,
  },
  { config: "emit: []\n", diagnostic: "tspconfig.yaml - error tsv/emit-autorest:", color: false },
  { config: "emit: []\n", diagnostic: "tspconfig.yaml - error tsv/emit-autorest:", color: true },
])(
  "renders the pilot diagnostic once (color=$color): $diagnostic",
  async ({ config, diagnostic, color }) => {
    if (color) {
      vi.stubEnv("NO_COLOR", undefined);
      vi.stubEnv("FORCE_COLOR", "1");
    }
    const project = "specification/service/data-plane/Project";
    await addProject(project);
    await initGit();
    await writeFile(join(root, "package.json"), '{"private":true}');
    await writeFile(join(root, project, "main.tsp"), "");
    await mkdir(join(root, project, "examples"));
    await writeFile(join(root, project, "tspconfig.yaml"), config);
    try {
      await run(project);
      expect.fail("Expected validation to fail");
    } catch (error) {
      expect(error).toMatchObject({ code: 1 });
      if (!(error instanceof Error) || !("stdout" in error) || !("stderr" in error)) throw error;
      const stderr = String(error.stderr);
      expect(stripVTControlCharacters(stderr).split(diagnostic)).toHaveLength(2);
      expect(stderr.includes("\x1b[31merror\x1b[39m")).toBe(color);
      expect(stderr).not.toContain("\n    at ");
      expect(stripVTControlCharacters(String(error.stdout))).toBe(
        "\n2 passed | 1 failed | 9 not run\n",
      );
      expect(String(error.stdout)).not.toMatch(
        /Executing rule:|config files:|imports:|Expected npm prefix:/,
      );
      expect(String(error.stdout)).not.toContain("mainTspExists:");
      expect(String(error.stdout)).not.toContain("Executing rule: ServiceYaml");
    }
  },
);

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
    stderr: expect.stringContaining(d`
      TypeSpec Validation failed for some folder to fix run and address any errors:
       > pnpm install
       > pnpm tsv custom/a
      For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation
    `) as unknown,
  });
});

it("emits a failure annotation inside its project group and a final reproduction summary", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await addProject("custom/a");
  await addProject("custom/b");
  await simpleGit(root).init();
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidation\n  paths: [custom/b]\n  reason: later project\n",
  );

  await expect(run("--all", "custom")).rejects.toMatchObject({
    code: 1,
    stdout: expect.stringContaining(
      "::error::TypeSpec Validation failed for project custom/a run the following command locally to validate.%0A" +
        " > pnpm install%0A > pnpm tsv custom/a%0A" +
        "For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation\n" +
        "::endgroup::\n::group::pass custom/b",
    ) as unknown,
    stderr: expect.stringContaining(d`
      TypeSpec Validation failed for some folder to fix run and address any errors:
       > pnpm install
       > pnpm tsv custom/a
      For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation
    `) as unknown,
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
  expect(stdout).toContain(d`
    Checking 2 TypeSpec folders:
    specification/a
    specification/b
  `);
  const groups = [...stdout.matchAll(/::group::([^\n]+)\n([\s\S]*?)::endgroup::/g)];
  expect(groups.map((group) => group[1])).toEqual(["pass specification/a", "pass specification/b"]);
  for (const group of groups) {
    expect(group[2]).not.toContain("Running TypeSpecValidation on folder:");
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

it("requires --all and the GitHub summary environment for --github-summary", async () => {
  await expect(run("--github-summary", "project")).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining("--github-summary requires --all") as unknown,
  });
  await expect(run("--all", "--github-summary")).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining(
      "--github-summary requires the GITHUB_STEP_SUMMARY environment variable",
    ) as unknown,
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
      "Usage: tsv --all [folder] [--shard=<index>/<count>] [--github-summary] [--git-clean] [--dry-run]",
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
    stderr: expect.stringContaining(d`
      TypeSpec Validation failed for some folder to fix run and address any errors:
       > pnpm install
       > pnpm tsv specification/service/a
      For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation
    `) as unknown,
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
  { args: ["--changed", "--github-summary"], error: "--github-summary requires --all" },
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
  { args: ["--all", "--diff-output=out.patch"], error: "--diff-output requires --git-clean" },
  { args: ["--changed", "project"], error: "Usage: tsv --changed" },
])("rejects invalid invocation $args", async ({ args, error }) => {
  await expect(run(...args)).rejects.toMatchObject({
    code: 1,
    stderr: expect.stringContaining(error) as unknown,
  });
});
