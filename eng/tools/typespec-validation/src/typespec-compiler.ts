import {
  compile,
  formatDiagnostic,
  NodeHost,
  resolveCompilerOptions,
  type CompilerHost,
  type Diagnostic,
} from "@typespec/compiler";
import { relative, resolve } from "pathe";
import { verbatim } from "./diagnostic-content.ts";
import { failure, warning, type RuleResult } from "./rule-result.ts";

export interface CompileResult extends RuleResult {
  /** Files written by emitters, relative to the working directory. */
  emittedFiles: string[];
}

export async function compileTypeSpec(
  entrypoint: string,
  options: { noEmit?: boolean } = {},
): Promise<CompileResult> {
  const cwd = process.cwd();
  const emittedFiles: string[] = [];
  const logs: string[] = [];
  const host: CompilerHost = {
    ...NodeHost,
    logSink: { log: (log) => logs.push(`${log.level}: ${log.message}`) },
    writeFile: async (path, content) => {
      emittedFiles.push(relative(cwd, path));
      return NodeHost.writeFile(path, content);
    },
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
  const program = await compile(host, resolve(entrypoint), { ...compilerOptions, ...options });
  return {
    ...compilerResult("compile", !program.hasError(), program.diagnostics, logs),
    emittedFiles,
  };
}

export async function formatTypeSpec(folder: string): Promise<RuleResult> {
  // TODO: Replace the private import once the compiler exports formatFiles.
  const { formatFiles } = (await import(
    new URL(
      "./dist/src/core/formatter-fs.js",
      import.meta.resolve("@typespec/compiler/package.json"),
    ).href
  )) as {
    formatFiles: (
      patterns: string[],
      options: { exclude?: string[] },
    ) => Promise<{ errored: [string, Diagnostic][] }>;
  };
  const { errored } = await formatFiles(
    [resolve(folder, "../**/*.tsp"), resolve(folder, "tspconfig.yaml")],
    { exclude: [resolve(folder, "../**/node_modules")] },
  );
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
