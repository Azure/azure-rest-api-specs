import { execFile } from "node:child_process";
import { mkdir, mkdtemp, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { promisify, stripVTControlCharacters } from "node:util";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";

const exec = promisify(execFile);
const cli = fileURLToPath(new URL("../cmd/tsv.js", import.meta.url));
const project = "specification/service/data-plane/Project";
let root: string;

beforeEach(async () => {
  root = await realpath(await mkdtemp(join(tmpdir(), "tsv-command-cli-")));
  vi.stubEnv("DEBUG", "");
  vi.stubEnv("GITHUB_ACTIONS", "false");
  vi.stubEnv("NO_COLOR", "1");
  vi.stubEnv("FORCE_COLOR", undefined);
  await mkdir(join(root, project, "examples"), { recursive: true });
  await writeFile(join(root, "package.json"), '{"name":"fixture","private":true}');
  await writeFile(join(root, project, "main.tsp"), "");
  await writeFile(join(root, project, "service.yaml"), "versions: []\n");
  await writeFile(
    join(root, project, "tspconfig.yaml"),
    "emit:\n  - '@azure-tools/typespec-autorest'\nlinter:\n  extends:\n    - '@azure-tools/typespec-azure-rulesets/data-plane'\n",
  );
  // Isolate command reporting from SDK configuration checks; use real suppression handling.
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidation\n  paths: [specification/service/data-plane/Project/tspconfig.yaml]\n  rules: [SdkTspConfigValidation]\n  reason: command fixture\n",
  );
  await mkdir(join(root, "node_modules/@typespec/compiler"), { recursive: true });
  await writeFile(
    join(root, "node_modules/@typespec/compiler/package.json"),
    '{"name":"@typespec/compiler","bin":{"tsp":"cli.cjs"}}',
  );
  await simpleGit(root)
    .init()
    .addConfig("user.name", "Test")
    .addConfig("user.email", "test@example.com")
    .addConfig("commit.gpgsign", "false")
    .add(".")
    .commit("Fixture");
});

afterEach(async () => {
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
});

async function compiler(source: string) {
  await writeFile(join(root, "node_modules/@typespec/compiler/cli.cjs"), source);
}

async function run(...args: string[]): Promise<{ code: number; stdout: string; stderr: string }> {
  try {
    const { stdout, stderr } = await exec(process.execPath, [cli, ...args], { cwd: root });
    return { code: 0, stdout, stderr };
  } catch (error) {
    if (
      !(error instanceof Error) ||
      !("stdout" in error) ||
      !("stderr" in error) ||
      !("code" in error) ||
      typeof error.stdout !== "string" ||
      typeof error.stderr !== "string" ||
      typeof error.code !== "number"
    )
      throw error;
    return { code: error.code, stdout: error.stdout, stderr: error.stderr };
  }
}

it("prints rule statuses and a summary, with compiler details restored by --verbose", async () => {
  await compiler(`if (process.argv[2] === "compile") {
    console.log("TypeSpec compiler v1.16.0\\n\\nCompilation completed successfully.\\n");
    process.stderr.write("- Compiling...\\n\\u2714 Compiling\\n");
  } else {
    process.stderr.write("- Formatting\\n\\u2714 1 unchanged\\n");
  }`);
  const quiet = await run(project);
  expect(quiet.code).toBe(0);
  expect(quiet.stdout.trim().split("\n").slice(1)).toEqual([
    "PASS FolderStructure",
    "PASS NpmPrefix",
    "PASS EmitAutorest",
    "PASS ServiceYaml",
    "PASS FlavorAzure",
    "PASS LinterRuleset",
    "SKIP ClientTspImport",
    "PASS Compile",
    "PASS Format",
    "SUPPRESSED SdkTspConfigValidation",
    "SKIP MultipleNewApiVersions",
    "SKIP StaleApiVersionPin",
    "Rules: 8 passed | 3 skipped | 1 suppressed",
  ]);
  expect(quiet.stdout).toContain("Running TypeSpecValidation on folder:");
  expect(quiet.stderr).toBe("");
  const verbose = await run(project, "--verbose");
  expect(verbose.code).toBe(quiet.code);
  expect(verbose.stdout.match(/TypeSpec compiler v1.16.0/g)).toHaveLength(1);
  expect(verbose.stdout).toContain("Compilation completed successfully.");
  expect(verbose.stdout).toContain("1 unchanged");
});

it.each([
  { color: false, verbose: false },
  { color: true, verbose: false },
  { color: false, verbose: true },
])(
  "shows failing native stdout and stderr once with color=$color verbose=$verbose",
  async ({ color, verbose }) => {
    if (color) {
      vi.stubEnv("NO_COLOR", undefined);
      vi.stubEnv("FORCE_COLOR", "1");
    }
    await compiler(`const message = "main.tsp:3:1 - error test-code: native stdout failure\\n> 3 | invalid\\n    | ^";
    console.log(process.env.FORCE_COLOR === "1" ? "\\x1b[31m" + message + "\\x1b[0m" : message);
    process.stderr.write("native stderr detail\\n");
    process.exitCode = 1;`);
    const result = await run(project, ...(verbose ? ["--verbose"] : []));
    expect(result.code).toBe(1);
    expect(result.stderr.match(/native stdout failure/g)).toHaveLength(1);
    expect(result.stderr.match(/native stderr detail/g)).toHaveLength(1);
    expect(result.stdout).not.toContain("native stdout failure");
    expect(result.stdout).not.toContain("native stderr detail");
    expect(result.stderr.includes("\x1b")).toBe(color);
    expect(stripVTControlCharacters(result.stderr)).toContain(
      "error tsv/compile: TypeSpec compilation failed (exit code 1).",
    );
    expect(result.stderr).toContain("> 3 | invalid");
    expect(stripVTControlCharacters(result.stdout)).toContain("FAIL Compile");
    expect(stripVTControlCharacters(result.stdout)).toContain(
      "Rules: 6 passed | 1 failed | 1 skipped | 4 not run",
    );
    expect(stripVTControlCharacters(result.stdout)).not.toContain("PASS Format");
  },
);

it("retains per-project CI annotations and native diagnostics in batch mode", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await compiler(
    'console.log("main.tsp:1:1 - error test-code: native failure"); process.exitCode = 1;',
  );
  const result = await run("--all");
  expect(result.code).toBe(1);
  expect(result.stdout).toContain(`::group::Validating ${project}`);
  expect(result.stdout).toContain(`::error::TypeSpec Validation failed for project ${project}`);
  expect(result.stdout).toContain("::endgroup::");
  expect(result.stderr.match(/native failure/g)).toHaveLength(1);
});
