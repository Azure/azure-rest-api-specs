import { isExecError } from "@azure-tools/specs-shared/exec";
import {
  compile,
  formatDiagnostic,
  NodeHost,
  resolveCompilerOptions,
  type CompilerHost,
  type Diagnostic,
} from "@typespec/compiler";
import { execFile } from "node:child_process";
import { readFile } from "node:fs/promises";
import { promisify } from "node:util";
import { relative, resolve } from "pathe";
import { simpleGit } from "simple-git";
import { filePath, indent, lines, verbatim } from "./diagnostic-content.ts";
import { failure, warning, type RuleResult } from "./rule-result.ts";

export interface CompileResult extends RuleResult {
  /** Files written by emitters, relative to the working directory. */
  emittedFiles: string[];
  /** Files whose final emitted contents differ from the checkout, excluding ignored outputs. */
  changedFiles?: string[];
}

let cachedHost: CompilerHost | undefined;

/**
 * Share file reads, stats and directory listings across every later check-only compilation in
 * this process, so projects validated by the same worker don't re-read common libraries and specs.
 * Results, including missing files, are kept for the life of the process: only enable this while
 * nothing modifies the checkout. Fix-mode compilations always read through.
 */
export function enableCompilerFileCache(): void {
  const memoize = <T>(read: (path: string) => Promise<T>) => {
    const cache = new Map<string, Promise<T>>();
    return (path: string) => {
      let result = cache.get(path);
      if (!result) {
        result = read(path);
        // Rejections are cached too; callers that await the promise still observe them.
        result.catch(() => {});
        cache.set(path, result);
      }
      return result;
    };
  };
  cachedHost ??= {
    ...NodeHost,
    readFile: memoize((path) => NodeHost.readFile(path)),
    readUrl: memoize((url) => NodeHost.readUrl(url)),
    stat: memoize((path) => NodeHost.stat(path)),
    realpath: memoize((path) => NodeHost.realpath(path)),
    readDir: memoize((path) => NodeHost.readDir(path)),
  };
}

export async function compileTypeSpec(
  entrypoint: string,
  options: { noEmit?: boolean; fix?: boolean } = {},
): Promise<CompileResult> {
  const { fix = false, ...overrides } = options;
  const cwd = process.cwd();
  const emittedFiles: string[] = [];
  const changedFiles = new Set<string>();
  const logs: string[] = [];
  const host: CompilerHost = {
    ...((!fix && cachedHost) || NodeHost),
    logSink: { log: (log) => logs.push(`${log.level}: ${log.message}`) },
    writeFile: async (path, content) => {
      emittedFiles.push(relative(cwd, path));
      if (fix) return NodeHost.writeFile(path, content);
      let existing: string | undefined;
      try {
        existing = await readFile(path, "utf8");
      } catch (error) {
        if (!(error instanceof Error && "code" in error && error.code === "ENOENT")) throw error;
      }
      // Git normalizes text line endings under the repository's eol=lf policy.
      if (existing?.replace(/\r\n/g, "\n") === content.replace(/\r\n/g, "\n")) {
        changedFiles.delete(path);
      } else {
        changedFiles.add(path);
      }
    },
    ...(!fix
      ? {
          mkdirp: () => Promise.resolve(undefined),
          rm: () =>
            Promise.reject(
              new Error("Removing files is not supported during check-only validation"),
            ),
        }
      : {}),
  };
  const [compilerOptions, diagnostics] = await resolveCompilerOptions(host, {
    cwd,
    entrypoint: resolve(entrypoint),
    env: process.env,
    overrides: { warnAsError: true },
  });
  if (diagnostics.length > 0) {
    return { ...compilerResult("compile", false, diagnostics, logs), emittedFiles };
  }
  const program = await compile(host, resolve(entrypoint), { ...compilerOptions, ...overrides });
  return {
    ...compilerResult("compile", !program.hasError(), program.diagnostics, logs),
    emittedFiles,
    ...(!fix
      ? {
          changedFiles: (await excludeIgnoredFiles(program.projectRoot, [...changedFiles])).map(
            (path) => relative(cwd, path),
          ),
        }
      : {}),
  };
}

async function excludeIgnoredFiles(folder: string, files: string[]): Promise<string[]> {
  if (files.length === 0) return files;
  const git = simpleGit(folder);
  if (!(await git.checkIsRepo())) return files;
  const root = (await git.revparse("--show-toplevel")).trim();
  // Use NUL-delimited stdin for arbitrary paths and Windows command-line limits.
  const command = promisify(execFile)("git", ["check-ignore", "--stdin", "-z"], {
    cwd: root,
    env: { ...process.env, GIT_OPTIONAL_LOCKS: "0" },
    maxBuffer: 16 * 1024 * 1024,
  });
  command.child.stdin?.end(files.map((p) => relative(root, p)).join("\0") + "\0");
  try {
    const { stdout } = await command;
    const ignored = new Set(
      stdout
        .split("\0")
        .filter(Boolean)
        .map((path) => resolve(root, path)),
    );
    return files.filter((path) => !ignored.has(resolve(path)));
  } catch (error) {
    if (!isExecError(error) || error.code !== 1) throw error;
    return files;
  }
}

export async function formatTypeSpec(folder: string, fix = false): Promise<RuleResult> {
  // TODO: Replace the private import once the compiler exports its filesystem formatter APIs.
  const { formatFiles, checkFilesFormat } = (await import(
    new URL(
      "./dist/src/core/formatter-fs.js",
      import.meta.resolve("@typespec/compiler/package.json"),
    ).href
  )) as {
    formatFiles: (
      patterns: string[],
      options: { exclude?: string[] },
    ) => Promise<{ errored: [string, Diagnostic][] }>;
    checkFilesFormat: (
      patterns: string[],
      options: { exclude?: string[] },
    ) => Promise<{ errored: [string, Diagnostic][]; needsFormat: string[] }>;
  };
  const patterns = [resolve(folder, "../**/*.tsp"), resolve(folder, "tspconfig.yaml")];
  const options = { exclude: [resolve(folder, "../**/node_modules")] };
  const { errored, needsFormat = [] } = fix
    ? { ...(await formatFiles(patterns, options)), needsFormat: [] }
    : await checkFilesFormat(patterns, options);
  if (errored.length === 0 && needsFormat.length > 0) {
    return failure("format-changed", "Files need TypeSpec formatting:", {
      path: folder,
      details: indent(lines(needsFormat.map((path) => filePath(relative(process.cwd(), path))))),
      help: 'Run `pnpm exec tsp format "../**/*.tsp" tspconfig.yaml` from the project folder and include the changes.',
    });
  }
  return compilerResult(
    "format",
    errored.length === 0,
    errored.map(([, diagnostic]) => diagnostic),
  );
}

function compilerResult(
  command: "compile" | "format",
  success: boolean,
  diagnostics: readonly Diagnostic[],
  logs: string[] = [],
): RuleResult {
  const output = [
    ...diagnostics.map((diagnostic) => formatDiagnostic(diagnostic, { pretty: true })),
    ...logs,
  ].join("\n");
  const label = command === "compile" ? "TypeSpec compilation" : "TypeSpec formatting";
  if (!success) return failure(command, `${label} failed.`, { details: verbatim(output) });
  return output
    ? warning(`${command}-output`, `${label} reported additional output.`, {
        details: verbatim(output),
      })
    : { success: true };
}
