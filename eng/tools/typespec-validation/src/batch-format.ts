import { globFiles } from "@azure-tools/specs-shared/glob";
import type { ILogger } from "@azure-tools/specs-shared/logger";
import { readFile } from "node:fs/promises";
import { createRequire } from "node:module";
import { pathToFileURL } from "node:url";
import { isDeepStrictEqual } from "node:util";
import { resolve } from "pathe";
import type { Options } from "prettier";
import * as z from "zod";
import { filePath, indent, lines, verbatim } from "./diagnostic-content.ts";
import type { Diagnostic, RuleResult } from "./rule-result.ts";

export const batchFormatRequest = "tsv-format";
export const batchFormatEnvironment = "TSV_BATCH_FORMAT";

export interface BatchFormatResponse {
  type: "tsv-format-result";
  result: RuleResult;
}

interface CachedFile {
  source: string;
  options: Options | null;
  diagnostic?: Diagnostic;
  needsFormat: boolean;
}

async function loadFormatter(compilerPath: string) {
  const compilerModule: unknown = await import(pathToFileURL(compilerPath).href);
  const compiler = z
    .object({
      formatTypeSpec: z.custom<typeof import("@typespec/compiler").formatTypeSpec>(
        (value) => typeof value === "function",
      ),
    })
    .parse(compilerModule);
  const prettierModule: unknown = await import(
    pathToFileURL(createRequire(compilerPath).resolve("prettier")).href
  );
  const { default: prettier } = z
    .object({
      default: z.object({
        resolveConfig: z.custom<typeof import("prettier").resolveConfig>(
          (value) => typeof value === "function",
        ),
        clearConfigCache: z.custom<typeof import("prettier").clearConfigCache>(
          (value) => typeof value === "function",
        ),
        format: z.custom<typeof import("prettier").format>((value) => typeof value === "function"),
      }),
    })
    .parse(prettierModule);
  return { compiler, prettier };
}

export class BatchFormatter {
  readonly #formatters = new Map<string, ReturnType<typeof loadFormatter>>();
  readonly #files = new Map<string, CachedFile>();

  async check(folder: string, logger: Pick<ILogger, "debug">): Promise<RuleResult> {
    const require = createRequire(pathToFileURL(resolve(folder, "__resolve__.js")));
    const compilerPath = require.resolve("@typespec/compiler");
    let formatter = this.#formatters.get(compilerPath);
    if (!formatter) {
      formatter = loadFormatter(compilerPath);
      this.#formatters.set(compilerPath, formatter);
    }
    const { compiler, prettier } = await formatter;
    await prettier.clearConfigCache();
    const files = await globFiles(["../**/*.tsp", "tspconfig.yaml"], {
      cwd: folder,
      exclude: ["**/node_modules", "**/node_modules/**"],
    });
    const diagnostics: Diagnostic[] = [];
    const needsFormat: string[] = [];
    let checked = 0;
    let reused = 0;

    for (const file of files) {
      const path = resolve(folder, file);
      const [source, options] = await Promise.all([
        readFile(path, "utf8"),
        prettier.resolveConfig(path),
      ]);
      const key = `${compilerPath}\0${path}`;
      let cached = this.#files.get(key);
      if (cached?.source === source && isDeepStrictEqual(cached.options, options)) {
        reused++;
      } else {
        checked++;
        cached = { source, options, needsFormat: false };
        try {
          const formatted = path.endsWith(".tsp")
            ? await compiler.formatTypeSpec(source, options ?? {})
            : await prettier.format(source, { ...options, parser: "yaml", plugins: [] });
          cached.needsFormat = formatted !== source;
        } catch (error) {
          if (!(error instanceof Error) || !("loc" in error)) throw error;
          cached.diagnostic = {
            severity: "error",
            code: "format",
            message: "TypeSpec formatting failed.",
            path,
            details: verbatim(`error format-failed: ${error.message}`),
          };
        }
        this.#files.set(key, cached);
      }
      if (cached.diagnostic) diagnostics.push(cached.diagnostic);
      if (cached.needsFormat) needsFormat.push(path);
    }

    logger.debug(`Formatting: ${checked} checked, ${reused} reused`);
    if (needsFormat.length > 0) {
      diagnostics.push({
        severity: "error",
        code: "format-changed",
        path: folder,
        message: "Files need formatting:",
        details: indent(lines(needsFormat.map(filePath))),
        help: 'Run `pnpm exec tsp format "../**/*.tsp" tspconfig.yaml` from the project folder and include the changes.',
      });
    }
    return { success: diagnostics.length === 0, ...(diagnostics.length ? { diagnostics } : {}) };
  }
}

export function requestBatchFormat(): Promise<RuleResult> {
  if (!process.send || !process.connected) {
    throw new Error("Batch formatting requires a connection to the TSV parent process.");
  }
  return new Promise((resolve, reject) => {
    const cleanup = () => {
      process.off("message", onMessage);
      process.off("disconnect", onDisconnect);
    };
    const onMessage = (message: BatchFormatResponse) => {
      if (message.type !== "tsv-format-result") return;
      cleanup();
      resolve(message.result);
    };
    const onDisconnect = () => {
      cleanup();
      reject(new Error("TSV parent disconnected before formatting completed."));
    };
    process.on("message", onMessage);
    process.once("disconnect", onDisconnect);
    process.send?.(batchFormatRequest, (error) => {
      if (error) {
        cleanup();
        reject(error);
      }
    });
  });
}
