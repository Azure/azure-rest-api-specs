import type * as Compiler from "@typespec/compiler";
import { glob, readFile } from "node:fs/promises";
import { findPackageJSON } from "node:module";
import { dirname, join, relative, resolve } from "node:path";
import { pathToFileURL } from "node:url";
import { z } from "zod";
import type { CommandOutput } from "./command-output.ts";
import { supportsColor } from "./diagnostics.ts";

type FormatFileResult =
  | { kind: "formatted" | "already-formatted" | "ignored" }
  | { kind: "error"; diagnostic: Compiler.Diagnostic };

interface CompilerModules {
  api: typeof Compiler;
  formatFile: (filename: string) => Promise<FormatFileResult>;
}

const exportsSchema = z.object({
  exports: z.object({
    ".": z.union([z.string(), z.object({ import: z.string() }), z.object({ default: z.string() })]),
  }),
});

let modules: Promise<CompilerModules> | undefined;

/**
 * Load the TypeSpec compiler installed for the current working directory, matching the compiler
 * that `tsp` would have run. Loaded once per process so libraries are only imported once.
 */
export function loadCompiler(cwd = process.cwd()): Promise<CompilerModules> {
  return (modules ??= (async () => {
    const packageJsonPath = findPackageJSON(
      "@typespec/compiler",
      pathToFileURL(resolve(cwd, "__resolve__.mjs")),
    );
    if (!packageJsonPath) {
      throw new Error('Cannot find package.json for "@typespec/compiler".');
    }
    const root = dirname(packageJsonPath);
    const main = exportsSchema.parse(JSON.parse(await readFile(packageJsonPath, "utf8"))).exports[
      "."
    ];
    const api = (await import(
      pathToFileURL(
        join(root, typeof main === "string" ? main : "import" in main ? main.import : main.default),
      ).href
    )) as typeof Compiler;
    // `formatFiles`/`formatFile` are not exported publicly; this is the same code `tsp format` runs.
    const formatter = (await import(
      pathToFileURL(join(root, "dist/src/core/formatter-fs.js")).href
    )) as { formatFile: CompilerModules["formatFile"] };
    return { api, formatFile: formatter.formatFile };
  })());
}

export interface CompileResult {
  output: CommandOutput;
  /** Files written by emitters, relative to the working directory (like `tsp compile --list-files`). */
  emittedFiles: string[];
}

/** Compile an entrypoint in-process, equivalent to `tsp compile --warn-as-error <entrypoint>`. */
export async function compileTypeSpec(
  entrypoint: string,
  options: { noEmit?: boolean } = {},
): Promise<CompileResult> {
  const { api } = await loadCompiler();
  const pretty = supportsColor();
  const cwd = process.cwd();
  const logs: string[] = [];
  const emittedFiles: string[] = [];
  const format = (diagnostics: readonly Compiler.Diagnostic[]) =>
    diagnostics.map((d) => api.formatDiagnostic(d, { pretty })).join("\n");
  const host: Compiler.CompilerHost = {
    ...api.NodeHost,
    logSink: {
      log: (log) => logs.push(`${log.level}: ${log.message}`),
    },
    writeFile: async (path, content) => {
      emittedFiles.push(relative(cwd, path));
      return api.NodeHost.writeFile(path, content);
    },
  };

  try {
    const [compilerOptions, configDiagnostics] = await api.resolveCompilerOptions(host, {
      cwd,
      entrypoint: resolve(entrypoint),
      env: process.env,
    });
    if (configDiagnostics.length > 0) {
      return {
        output: [new Error("Invalid TypeSpec configuration"), format(configDiagnostics), ""],
        emittedFiles,
      };
    }
    const program = await api.compile(host, resolve(entrypoint), {
      ...compilerOptions,
      warningAsError: true,
      ...(options.noEmit ? { noEmit: true } : {}),
    });
    const stdout = [format(program.diagnostics), ...logs].filter(Boolean).join("\n");
    return {
      output: [program.hasError() ? new Error("TypeSpec compilation failed") : null, stdout, ""],
      emittedFiles,
    };
  } catch (error) {
    const err = error instanceof Error ? error : new Error(String(error));
    return { output: [err, logs.join("\n"), err.stack ?? err.message], emittedFiles };
  }
}

/** Format TypeSpec files in-process, equivalent to `tsp format <patterns>` run from `folder`. */
export async function formatTypeSpec(folder: string, patterns: string[]): Promise<CommandOutput> {
  const { api, formatFile } = await loadCompiler();
  const errors: Compiler.Diagnostic[] = [];
  try {
    for await (const entry of glob(patterns, {
      cwd: folder,
      withFileTypes: true,
      exclude: ["**/node_modules"],
    })) {
      if (!entry.isFile()) continue;
      const result = await formatFile(resolve(folder, entry.parentPath, entry.name));
      if (result.kind === "error") errors.push(result.diagnostic);
    }
  } catch (error) {
    const err = error instanceof Error ? error : new Error(String(error));
    return [err, "", err.stack ?? err.message];
  }
  if (errors.length === 0) return [null, "", ""];
  const pretty = supportsColor();
  return [
    new Error("TypeSpec formatting failed"),
    errors.map((d) => api.formatDiagnostic(d, { pretty })).join("\n"),
    "",
  ];
}
