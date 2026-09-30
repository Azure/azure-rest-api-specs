import type { ILogger } from "@azure-tools/specs-shared/logger";
import { isAbsolute, relative, win32 } from "node:path";
import { stripVTControlCharacters } from "node:util";
import pc from "picocolors";
import { DiagnosticError, type Diagnostic } from "./rule-result.ts";

export function supportsColor(env = process.env, isTTY = process.stderr.isTTY): boolean {
  if (env.NO_COLOR !== undefined || env.FORCE_COLOR === "0") return false;
  if (env.FORCE_COLOR !== undefined) return true;
  return (Boolean(isTTY) && env.TERM !== "dumb") || env.GITHUB_ACTIONS === "true";
}

export function formatDiagnostic(
  diagnostic: Diagnostic,
  { color = supportsColor(), cwd = process.cwd() }: { color?: boolean; cwd?: string } = {},
): string {
  const c = pc.createColors(color);
  const level = diagnostic.severity === "error" ? c.red("error") : c.yellow("warning");
  let location = "";
  if (diagnostic.path) {
    const file = diagnostic.path;
    const displayPath =
      /^[A-Za-z]:[\\/]/.test(file) && /^[A-Za-z]:[\\/]/.test(cwd)
        ? win32.relative(cwd, file)
        : isAbsolute(file)
          ? relative(cwd, file)
          : file;
    location = c.cyan(displayPath.replaceAll("\\", "/") || ".");
    if (diagnostic.location) {
      location += `:${c.yellow(String(diagnostic.location.line))}:${c.yellow(String(diagnostic.location.column))}`;
    }
  }
  const lines = [
    `${location ? `${location} - ` : ""}${level} ${c.dim(`tsv/${diagnostic.code}`)}: ${diagnostic.message.trimEnd()}`,
  ];
  if (diagnostic.path && diagnostic.location?.text !== undefined) {
    const { line, column, text } = diagnostic.location;
    const source = text.split(/\r?\n/)[line - 1];
    if (source !== undefined && column >= 1 && column <= source.length + 1) {
      lines.push(
        `  ${line} | ${source}`,
        `  ${" ".repeat(String(line).length)} | ${source.slice(0, column - 1).replace(/[^\t]/g, " ")}${c.red("^")}`,
      );
    }
  }
  if (diagnostic.help) lines.push(`  ${c.dim("help:")} ${diagnostic.help}`);
  if (diagnostic.url) lines.push(`  ${c.dim("docs:")} ${diagnostic.url}`);
  const output = lines.join("\n");
  return color ? output : stripVTControlCharacters(output);
}

export function reportDiagnostics(diagnostics: readonly Diagnostic[], logger: ILogger): void {
  const seen = new Set<string>();
  const urls = new Set<string>();
  for (const diagnostic of diagnostics) {
    const key = formatDiagnostic(diagnostic, { color: false });
    if (seen.has(key)) continue;
    seen.add(key);
    const url = diagnostic.url;
    const message = formatDiagnostic({
      ...diagnostic,
      url: url && urls.has(url) ? undefined : url,
    });
    if (url) urls.add(url);
    if (diagnostic.severity === "error") logger.error(message);
    else logger.warning(message);
  }
}

export function exceptionDiagnostic(error: unknown, path?: string): Diagnostic {
  if (error instanceof DiagnosticError) return error.diagnostic;
  return {
    severity: "error",
    code: "rule-execution",
    message: error instanceof Error ? error.message : String(error),
    path,
    help: "Re-run with --verbose for execution details.",
  };
}
