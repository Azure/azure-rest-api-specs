import { execFile } from "node:child_process";
import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "pathe";
import { fileURLToPath } from "node:url";
import { promisify, stripVTControlCharacters } from "node:util";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";

const exec = promisify(execFile);
const cli = fileURLToPath(new URL("../cmd/tsv.js", import.meta.url));
const project = "specification/service/data-plane/Project";
let root: string;

beforeEach(async () => {
  root = resolve(await realpath(await mkdtemp(join(tmpdir(), "tsv-command-cli-"))));
  await writeFile(join(root, ".gitattributes"), "* text=auto eol=lf\n");
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

it("prints only a final summary by default and compact rule statuses with --verbose", async () => {
  await compiler(`if (process.argv[2] === "compile") {
    console.log("TypeSpec compiler v1.16.0\\n\\nCompilation completed successfully.\\n");
    process.stderr.write("- Compiling...\\n\\u2714 Compiling\\n");
  } else {
    process.stderr.write("- Formatting\\n\\u2714 1 unchanged\\n");
  }`);
  const quiet = await run(project);
  expect(quiet.code).toBe(0);
  expect(quiet.stdout).toBe("8 passed | 1 skipped | 1 suppressed\n");
  expect(quiet.stderr).toBe("");
  const verbose = await run(project, "--verbose");
  expect(verbose.code).toBe(quiet.code);
  expect(verbose.stdout.match(/TypeSpec compiler v1.16.0/g)).toHaveLength(1);
  expect(verbose.stdout).toContain("Compilation completed successfully.");
  expect(verbose.stdout).toContain("1 unchanged");
  expect(
    verbose.stdout
      .trim()
      .split("\n")
      .filter((line) =>
        /^[\u2714\u00d7!-] (?:FolderStructure|NpmPrefix|EmitAutorest|ServiceYaml|FlavorAzure|LinterRuleset|ClientTspImport|Compile|Format|SdkTspConfigValidation|MultipleNewApiVersions|StaleApiVersionPin)\b/.test(
          line,
        ),
      ),
  ).toEqual([
    "\u2714 FolderStructure",
    "\u2714 NpmPrefix",
    "\u2714 EmitAutorest",
    "\u2714 ServiceYaml",
    "\u2714 FlavorAzure",
    "\u2714 LinterRuleset",
    "- ClientTspImport (skipped)",
    "\u2714 Compile",
    "\u2714 Format",
    "- SdkTspConfigValidation (suppressed)",
  ]);
  expect(verbose.stdout).toContain(
    "- SdkTspConfigValidation (suppressed)\n\n8 passed | 1 skipped | 1 suppressed",
  );
});

it.each([false, true])("compiles one entrypoint with main present=%s", async (mainExists) => {
  const folder = join(root, project);
  await writeFile(join(folder, "client.tsp"), "");
  if (mainExists) {
    await writeFile(join(folder, "main.tsp"), 'import "./client.tsp";\n');
  } else {
    await rm(join(folder, "main.tsp"));
  }
  await simpleGit(root).add(project).commit("Set entrypoints");

  const invocations = join(root, "compiler-invocations.jsonl");
  await writeFile(invocations, "");
  await compiler(`if (process.argv[2] === "compile") {
    require("node:fs").appendFileSync(
      ${JSON.stringify(invocations)},
      JSON.stringify(process.argv.slice(2)) + "\\n"
    );
  }`);

  const result = await run(project);

  expect(result.code).toBe(0);
  expect(result.stderr).toBe("");
  const args = (await readFile(invocations, "utf8"))
    .trim()
    .split("\n")
    .map((line): unknown => JSON.parse(line));
  expect(args).toEqual([
    mainExists
      ? ["compile", "--list-files", "--warn-as-error", resolve(folder)]
      : ["compile", "--no-emit", "--warn-as-error", join(folder, "client.tsp")],
  ]);
});

it("rejects a missing client import before running the compiler", async () => {
  await writeFile(join(root, project, "client.tsp"), "");
  await simpleGit(root).add(project).commit("Add client without import");
  await compiler('throw new Error("Compiler must not run");');

  const result = await run(project);

  expect(result.code).toBe(1);
  expect(result.stderr).toContain("error tsv/client-tsp-import:");
  expect(result.stderr).not.toContain("Compiler must not run");
  expect(result.stdout).not.toContain("Compiler must not run");
});

it.each([
  { command: "compile", color: false, verbose: false },
  { command: "compile", color: true, verbose: true },
  { command: "format", color: false, verbose: true },
  { command: "format", color: true, verbose: false },
])(
  "shows changed-file diffs once for $command with color=$color verbose=$verbose",
  async ({ command, color, verbose }) => {
    await simpleGit(root)
      .addConfig("color.diff.new", "green")
      .addConfig("core.autocrlf", "true")
      .addConfig("core.safecrlf", "warn");
    if (color) {
      vi.stubEnv("NO_COLOR", undefined);
      vi.stubEnv("FORCE_COLOR", "1");
    }
    const generatedFile = JSON.stringify(join(root, project, "generated.json"));
    await compiler(`if (process.argv[2] === "${command}") {
      require("node:fs").writeFileSync(${generatedFile}, "new content\\n");
    }`);

    const result = await run(project, ...(verbose ? ["--verbose"] : []));
    expect(result.code).toBe(1);
    const output = stripVTControlCharacters(result.stderr);
    const code = command === "compile" ? "generated-files-changed" : "format-changed";
    expect(output).toContain(`error tsv/${code}:`);
    expect(output).toContain(`\n  ${project}/generated.json\n\ndiff --git`);
    expect(output).toContain("\n+new content\n\n  help:");
    expect(output.match(/diff --git/g)).toHaveLength(1);
    expect(result.stdout).not.toContain("diff --git");
    expect(result.stderr.includes("\x1b[32m")).toBe(color);
  },
);

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
    expect(stripVTControlCharacters(result.stdout).includes("\u00d7 Compile")).toBe(verbose);
    expect(stripVTControlCharacters(result.stdout)).toContain(
      "6 passed | 1 failed | 1 skipped | 2 not run",
    );
    expect(stripVTControlCharacters(result.stdout)).not.toContain("\u2714 Format");
    if (!verbose) {
      expect(stripVTControlCharacters(result.stdout)).toBe(
        "\n6 passed | 1 failed | 1 skipped | 2 not run\n",
      );
    }
  },
);

it("retains per-project CI annotations and native diagnostics in batch mode", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await compiler(
    'console.log("main.tsp:1:1 - error test-code: native failure"); process.exitCode = 1;',
  );
  const result = await run("--all");
  expect(result.code).toBe(1);
  const groupStart = result.stdout.indexOf(`::group::fail ${project}`);
  const nativeDiagnostic = result.stdout.indexOf("native failure");
  const groupEnd = result.stdout.indexOf("::endgroup::", groupStart);
  expect(groupStart).toBeGreaterThanOrEqual(0);
  expect(nativeDiagnostic).toBeGreaterThan(groupStart);
  expect(groupEnd).toBeGreaterThan(nativeDiagnostic);
  expect(result.stdout).toContain(`::error::TypeSpec Validation failed for project ${project}`);
  expect(result.stdout.match(/native failure/g)).toHaveLength(1);
  expect(result.stderr).not.toContain("native failure");
});
