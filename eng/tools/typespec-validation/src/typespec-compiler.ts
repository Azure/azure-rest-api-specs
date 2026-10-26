import type * as Compiler from "@typespec/compiler";
import { createRequire } from "node:module";
import { pathToFileURL } from "node:url";
import { relative, resolve } from "pathe";
import { verbatim } from "./diagnostic-content.ts";
import { supportsColor } from "./diagnostics.ts";
import { failure, warning, type RuleResult } from "./rule-result.ts";

/** Load the compiler installed for the working directory, rather than TSV's own dependency. */
export function loadCompiler(cwd = process.cwd()): Promise<typeof Compiler> {
  const require = createRequire(resolve(cwd, "__resolve__.mjs"));
  return import(pathToFileURL(require.resolve("@typespec/compiler")).href);
}

export interface CompileResult extends RuleResult {
  /** Files written by emitters, relative to the working directory. */
  emittedFiles: string[];
}

export async function compileTypeSpec(
  entrypoint: string,
  options: { noEmit?: boolean } = {},
): Promise<CompileResult> {
  const api = await loadCompiler();
  const cwd = process.cwd();
  const emittedFiles: string[] = [];
  const logs: string[] = [];
  const host: Compiler.CompilerHost = {
    ...api.NodeHost,
    logSink: { log: (log) => logs.push(`${log.level}: ${log.message}`) },
    writeFile: async (path, content) => {
      emittedFiles.push(relative(cwd, path));
      return api.NodeHost.writeFile(path, content);
    },
  };
  const [compilerOptions, diagnostics] = await api.resolveCompilerOptions(host, {
    cwd,
    entrypoint: resolve(entrypoint),
    env: process.env,
    overrides: { warnAsError: true },
  });
  if (diagnostics.length > 0) {
    return { ...compilerResult(api, "compile", false, diagnostics, logs), emittedFiles };
  }
  const program = await api.compile(host, resolve(entrypoint), { ...compilerOptions, ...options });
  return {
    ...compilerResult(api, "compile", !program.hasError(), program.diagnostics, logs),
    emittedFiles,
  };
}

export async function formatTypeSpec(folder: string): Promise<RuleResult> {
  const api = await loadCompiler(folder);
  const require = createRequire(resolve(folder, "__resolve__.mjs"));
  // TODO: Replace the private import once the compiler exports formatFiles.
  const { formatFiles } = (await import(
    new URL(
      "./dist/src/core/formatter-fs.js",
      pathToFileURL(require.resolve("@typespec/compiler/package.json")),
    ).href
  )) as {
    formatFiles: (
      patterns: string[],
      options: { exclude?: string[] },
    ) => Promise<{ errored: [string, Compiler.Diagnostic][] }>;
  };
  const { errored } = await formatFiles(
    [resolve(folder, "../**/*.tsp"), resolve(folder, "tspconfig.yaml")],
    { exclude: [resolve(folder, "../**/node_modules")] },
  );
  return compilerResult(
    api,
    "format",
    errored.length === 0,
    errored.map(([, diagnostic]) => diagnostic),
  );
}

function compilerResult(
  api: typeof Compiler,
  command: "compile" | "format",
  success: boolean,
  diagnostics: readonly Compiler.Diagnostic[],
  logs: string[] = [],
): RuleResult {
  const output = [
    ...diagnostics.map((diagnostic) =>
      api.formatDiagnostic(diagnostic, { pretty: supportsColor() }),
    ),
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
