import { execFile } from "node:child_process";
import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
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

interface CompilerFixture {
  compile?: string;
  format?: string;
  resolveCompilerOptions?: string;
  formatDiagnostic?: string;
}

async function compiler(fixture: CompilerFixture = {}) {
  const compilerRoot = join(root, "node_modules/@typespec/compiler");
  await writeFile(
    join(compilerRoot, "index.js"),
    `import fs from "node:fs";

export const NodeHost = {
  writeFile: async (path, content) => fs.promises.writeFile(path, content),
};

export async function resolveCompilerOptions(host, args) {
  ${fixture.resolveCompilerOptions ?? "return [{}, []];"}
}

export async function compile(host, entrypoint, options) {
  ${fixture.compile ?? "return { diagnostics: [], hasError() { return false; } };"}
}

export function formatDiagnostic(diagnostic, options) {
  ${fixture.formatDiagnostic ?? "const message = typeof diagnostic === 'string' ? diagnostic : diagnostic.message ?? String(diagnostic);\n  return options?.pretty ? `\\x1b[31m${message}\\x1b[0m` : message;"}
}
`,
  );
  await writeFile(
    join(compilerRoot, "dist/src/core/formatter-fs.js"),
    `import fs from "node:fs";

export async function formatFile(filename) {
  ${fixture.format ?? "return { kind: 'already-formatted' };"}
}
`,
  );
}

beforeEach(async () => {
  root = await realpath(await mkdtemp(join(tmpdir(), "tsv-command-cli-")));
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
  await mkdir(join(root, "node_modules/@typespec/compiler/dist/src/core"), { recursive: true });
  await writeFile(
    join(root, "node_modules/@typespec/compiler/package.json"),
    JSON.stringify({
      name: "@typespec/compiler",
      type: "module",
      exports: { ".": "./index.js" },
    }),
  );
  await compiler();
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
  expect(quiet.code).toBe(0);
  expect(quiet.stdout).toBe("8 passed | 3 skipped | 1 suppressed\n");
  expect(quiet.stderr).toBe("");
  const verbose = await run(project, "--verbose");
  expect(verbose.code).toBe(quiet.code);
  expect(verbose.stdout).not.toContain("TypeSpec compiler v");
  expect(verbose.stdout).not.toContain("Compilation completed successfully.");
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
    "- MultipleNewApiVersions (skipped)",
    "- StaleApiVersionPin (skipped)",
  ]);
  expect(verbose.stdout).toContain(
    "- StaleApiVersionPin (skipped)\n\n8 passed | 3 skipped | 1 suppressed",
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
  await compiler({
    compile: `fs.appendFileSync(
      ${JSON.stringify(invocations)},
      JSON.stringify({ entrypoint, options }) + "\\n"
    );
    return { diagnostics: [], hasError() { return false; } };`,
  });

  const result = await run(project);

  expect(result.code).toBe(0);
  expect(result.stderr).toBe("");
  const args = (await readFile(invocations, "utf8"))
    .trim()
    .split("\n")
    .map(
      (line): { entrypoint: string; options: Record<string, unknown> } =>
        JSON.parse(line) as { entrypoint: string; options: Record<string, unknown> },
    );
  expect(args).toEqual([
    mainExists
      ? {
          entrypoint: join(folder, "main.tsp"),
          options: { warningAsError: true },
        }
      : {
          entrypoint: join(folder, "client.tsp"),
          options: { warningAsError: true, noEmit: true },
        },
  ]);
});

it("rejects a missing client import before running the compiler", async () => {
  await writeFile(join(root, project, "client.tsp"), "");
  await simpleGit(root).add(project).commit("Add client without import");
  await compiler({ compile: 'throw new Error("Compiler must not run");' });

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
    const generatedFile = JSON.stringify(join(root, project, "generated.txt"));
    await compiler(
      command === "compile"
        ? {
            compile: `await host.writeFile(${generatedFile}, "new content\\n");
    return { diagnostics: [], hasError() { return false; } };`,
          }
        : {
            format: `fs.writeFileSync(${generatedFile}, "new content\\n");
  return { kind: "formatted" };`,
          },
    );

    const result = await run(project, ...(verbose ? ["--verbose"] : []));
    expect(result.code).toBe(1);
    const output = stripVTControlCharacters(result.stderr);
    const code = command === "compile" ? "generated-files-changed" : "format-changed";
    expect(output).toContain(`error tsv/${code}:`);
    expect(output).toContain(`\n  ${project}/generated.txt\n\ndiff --git`);
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
  "shows failing compiler diagnostics once with color=$color verbose=$verbose",
  async ({ color, verbose }) => {
    if (color) {
      vi.stubEnv("NO_COLOR", undefined);
      vi.stubEnv("FORCE_COLOR", "1");
    }
    await compiler({
      compile: `const message = "main.tsp:3:1 - error test-code: compiler failure\\n> 3 | invalid\\n    | ^";
    return { diagnostics: [{ message }], hasError() { return true; } };`,
    });
    const result = await run(project, ...(verbose ? ["--verbose"] : []));
    expect(result.code).toBe(1);
    expect(result.stderr.match(/compiler failure/g)).toHaveLength(1);
    expect(result.stdout).not.toContain("compiler failure");
    expect(result.stderr.includes("\x1b")).toBe(color);
    expect(stripVTControlCharacters(result.stderr)).toContain(
      "error tsv/compile: TypeSpec compilation failed.",
    );
    expect(result.stderr).toContain("> 3 | invalid");
    expect(stripVTControlCharacters(result.stdout).includes("\u00d7 Compile")).toBe(verbose);
    expect(stripVTControlCharacters(result.stdout)).toContain(
      "6 passed | 1 failed | 1 skipped | 4 not run",
    );
    expect(stripVTControlCharacters(result.stdout)).not.toContain("\u2714 Format");
    if (!verbose) {
      expect(stripVTControlCharacters(result.stdout)).toBe(
        "\n6 passed | 1 failed | 1 skipped | 4 not run\n",
      );
    }
  },
);

it("retains per-project CI annotations and compiler diagnostics in batch mode", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await compiler({
    compile: `return {
      diagnostics: [{ message: "main.tsp:1:1 - error test-code: compiler failure" }],
      hasError() { return true; },
    };`,
  });
  const result = await run("--all");
  expect(result.code).toBe(1);
  const groupStart = result.stdout.indexOf(`::group::fail ${project}`);
  const nativeDiagnostic = result.stdout.indexOf("compiler failure");
  const groupEnd = result.stdout.indexOf("::endgroup::", groupStart);
  expect(groupStart).toBeGreaterThanOrEqual(0);
  expect(nativeDiagnostic).toBeGreaterThan(groupStart);
  expect(groupEnd).toBeGreaterThan(nativeDiagnostic);
  expect(result.stdout).toContain(`::error::TypeSpec Validation failed for project ${project}`);
  expect(result.stdout.match(/compiler failure/g)).toHaveLength(1);
  expect(result.stderr).not.toContain("compiler failure");
});
