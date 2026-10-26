import { execFile } from "node:child_process";
import { mkdir, mkdtemp, realpath, rm, symlink, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "pathe";
import { fileURLToPath } from "node:url";
import { promisify, stripVTControlCharacters } from "node:util";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { compileTypeSpec, formatTypeSpec } from "../src/typespec-compiler.ts";

const exec = promisify(execFile);
const cli = fileURLToPath(new URL("../cmd/tsv.js", import.meta.url));
const project = "specification/service/data-plane/Project";
const tspConfig =
  'emit:\n  - "@azure-tools/typespec-autorest"\noptions:\n  "@azure-tools/typespec-autorest":\n    emitter-output-dir: "{project-root}/../stable/2026-01-01"\nlinter:\n  extends:\n    - "@azure-tools/typespec-azure-rulesets/data-plane"\n';
let root: string;

beforeEach(async () => {
  root = resolve(await realpath(await mkdtemp(join(tmpdir(), "tsv-command-cli-"))));
  await writeFile(join(root, ".gitattributes"), "* text=auto eol=lf\n");
  await writeFile(join(root, ".gitignore"), "node_modules\n");
  vi.stubEnv("DEBUG", "");
  vi.stubEnv("GITHUB_ACTIONS", "false");
  vi.stubEnv("NO_COLOR", "1");
  vi.stubEnv("FORCE_COLOR", undefined);
  await mkdir(join(root, project, "examples"), { recursive: true });
  await writeFile(join(root, "package.json"), '{"name":"fixture","private":true}');
  await writeFile(join(root, project, "main.tsp"), "");
  await writeFile(join(root, project, "service.yaml"), "versions: []\n");
  await writeFile(join(root, project, "tspconfig.yaml"), tspConfig);
  // Isolate compiler reporting from SDK configuration checks; use real suppression handling.
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidation\n  paths: [specification/service/data-plane/Project/tspconfig.yaml]\n  rules: [SdkTspConfigValidation]\n  reason: command fixture\n",
  );
  await symlink(
    fileURLToPath(new URL("../../../../node_modules", import.meta.url)),
    join(root, "node_modules"),
    "junction",
  );
  const compiled = await compileTypeSpec(join(root, project));
  expect(compiled.success, JSON.stringify(compiled.diagnostics)).toBe(true);
  expect((await formatTypeSpec(join(root, project))).success).toBe(true);
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
  const quiet = await run(project);
  expect(quiet.code, quiet.stderr).toBe(0);
  expect(quiet.stdout).toBe("8 passed | 1 skipped | 1 suppressed\n");
  expect(quiet.stderr).toBe("");
  const verbose = await run(project, "--verbose");
  expect(verbose.code).toBe(quiet.code);
  expect(verbose.stderr).toContain("simple-git");
  expect(
    verbose.stdout
      .trim()
      .split("\n")
      .filter((line) =>
        /^[\u2714\u00d7!-] (?:FolderStructure|NpmPrefix|EmitAutorest|ServiceYaml|FlavorAzure|LinterRuleset|ClientTspImport|Compile|Format|SdkTspConfigValidation)\b/.test(
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

it.each([false, true])("validates client projects with main present=%s", async (mainExists) => {
  const folder = join(root, project);
  await writeFile(join(folder, "client.tsp"), "");
  if (mainExists) {
    await writeFile(join(folder, "main.tsp"), 'import "./client.tsp";\n');
  } else {
    await rm(join(folder, "main.tsp"));
  }
  await simpleGit(root).add(project).commit("Set entrypoints");

  const result = await run(project);

  expect(result.code, result.stderr).toBe(0);
  expect(result.stderr).toBe("");
});

it("rejects a missing client import before compiling", async () => {
  await writeFile(join(root, project, "client.tsp"), "");
  await simpleGit(root).add(project).commit("Add client without import");

  const result = await run(project);

  expect(result.code).toBe(1);
  expect(result.stderr).toContain("error tsv/client-tsp-import:");
});

it.each([
  { command: "compile", color: false, verbose: false },
  { command: "format", color: true, verbose: true },
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
    const folder = join(root, project);
    if (command === "compile") {
      await writeFile(
        join(folder, "tspconfig.yaml"),
        tspConfig.replace("emit:\n", "emit:\n  - ./emitter.mjs\n"),
      );
      await writeFile(
        join(folder, "emitter.mjs"),
        `export async function $onEmit({ program }) {
  await program.host.writeFile(${JSON.stringify(join(folder, "generated.txt"))}, "new content\\n");
}
`,
      );
    } else {
      await writeFile(join(folder, "main.tsp"), "// Comment.   ");
    }
    await simpleGit(root).add(project).commit("Set changed-file fixture");

    const result = await run(project, ...(verbose ? ["--verbose"] : []));
    expect(result.code).toBe(1);
    const output = stripVTControlCharacters(result.stderr);
    const code = command === "compile" ? "generated-files-changed" : "format-changed";
    const file = command === "compile" ? "generated.txt" : "main.tsp";
    expect(output).toContain(`error tsv/${code}:`);
    expect(output).toContain(`\n  ${project}/${file}\n\ndiff --git`);
    expect(output).toContain(command === "compile" ? "\n+new content" : "\n+// Comment.");
    expect(output.match(/diff --git/g)).toHaveLength(1);
    expect(result.stdout).not.toContain("diff --git");
    expect(result.stderr.includes("\x1b[32m")).toBe(color);
  },
);

it.each([
  { color: false, verbose: false },
  { color: true, verbose: true },
])(
  "shows failing compiler diagnostics once with color=$color verbose=$verbose",
  async ({ color, verbose }) => {
    if (color) {
      vi.stubEnv("NO_COLOR", undefined);
      vi.stubEnv("FORCE_COLOR", "1");
    }
    await writeFile(join(root, project, "main.tsp"), "model Invalid { value: Unknown; }\n");
    const result = await run(project, ...(verbose ? ["--verbose"] : []));
    expect(result.code).toBe(1);
    expect(result.stderr.match(/invalid-ref/g)).toHaveLength(1);
    expect(result.stdout).not.toContain("invalid-ref");
    expect(result.stderr.includes("\x1b")).toBe(color);
    expect(stripVTControlCharacters(result.stderr)).toContain(
      "error tsv/compile: TypeSpec compilation failed.",
    );
    expect(stripVTControlCharacters(result.stderr)).toContain("main.tsp:1:");
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

it("retains per-project CI annotations and compiler diagnostics in batch mode", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await writeFile(join(root, project, "main.tsp"), "model Invalid { value: Unknown; }\n");
  const result = await run("--all");
  expect(result.code).toBe(1);
  const groupStart = result.stdout.indexOf(`::group::fail ${project}`);
  const nativeDiagnostic = result.stdout.indexOf("invalid-ref");
  const groupEnd = result.stdout.indexOf("::endgroup::", groupStart);
  expect(groupStart).toBeGreaterThanOrEqual(0);
  expect(nativeDiagnostic).toBeGreaterThan(groupStart);
  expect(groupEnd).toBeGreaterThan(nativeDiagnostic);
  expect(result.stdout).toContain(`::error::TypeSpec Validation failed for project ${project}`);
  expect(result.stdout.match(/invalid-ref/g)).toHaveLength(1);
  expect(result.stderr).not.toContain("invalid-ref");
});
