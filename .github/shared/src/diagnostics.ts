import type { ILogger } from "./logger.ts";
import { stripVTControlCharacters } from "node:util";
import pc from "picocolors";
import { filePath, renderDiagnosticContent } from "./diagnostic-content.ts";
import { DiagnosticError, type Diagnostic } from "./rule-result.ts";

export function supportsColor(env = process.env, isTTY = process.stderr.isTTY): boolean {
  if (env.NO_COLOR !== undefined || env.FORCE_COLOR === "0") return false;
  if (env.FORCE_COLOR !== undefined) return true;
  return (Boolean(isTTY) && env.TERM !== "dumb") || env.GITHUB_ACTIONS === "true";
}

export type RuleStatus = "PASS" | "FAIL" | "WARN" | "SKIP" | "SUPPRESSED";
export type RuleCounts = Record<RuleStatus, number>;

export function formatRuleStatus(
  name: string,
  status: RuleStatus,
  color = supportsColor(process.env, process.stdout.isTTY),
): string {
  const c = pc.createColors(color);
  const label =
    status === "FAIL"
      ? c.red("\u00d7")
      : status === "WARN"
        ? c.yellow("!")
        : status === "PASS"
          ? c.green("\u2714")
          : c.dim("-");
  const detail =
    status === "SKIP"
      ? " (skipped)"
      : status === "SUPPRESSED"
        ? " (suppressed)"
        : status === "WARN"
          ? " (warnings)"
          : "";
  return `${label} ${name}${detail}`;
}

export function formatRuleSummary(
  counts: RuleCounts,
  notRun: number,
  color = supportsColor(process.env, process.stdout.isTTY),
): string {
  const c = pc.createColors(color);
  const parts: string[] = [];
  if (counts.PASS) parts.push(c.green(`${counts.PASS} passed`));
  if (counts.FAIL) parts.push(c.bold(c.red(`${counts.FAIL} failed`)));
  if (counts.WARN) parts.push(c.yellow(`${counts.WARN} with warnings`));
  if (counts.SKIP) parts.push(c.gray(`${counts.SKIP} skipped`));
  if (counts.SUPPRESSED) parts.push(c.gray(`${counts.SUPPRESSED} suppressed`));
  if (notRun) parts.push(c.gray(`${notRun} not run`));
  return parts.join(c.dim(" | ")) || c.gray("0 run");
}

export function formatDiagnostic(
  diagnostic: Diagnostic,
  prefix: string,
  { color = supportsColor(), cwd = process.cwd() }: { color?: boolean; cwd?: string } = {},
): string {
  const c = pc.createColors(color);
  const level = diagnostic.severity === "error" ? c.red("error") : c.yellow("warning");
  let location = "";
  if (diagnostic.path) {
    location = renderDiagnosticContent(filePath(diagnostic.path), { color, cwd });
    if (diagnostic.location) {
      location += `:${c.yellow(String(diagnostic.location.line))}:${c.yellow(String(diagnostic.location.column))}`;
    }
  }
  const lines = [
    `${location ? `${location} - ` : ""}${level} ${c.dim(`${prefix}/${diagnostic.code}`)}: ${diagnostic.message.trimEnd()}`,
  ];
  if (diagnostic.details !== undefined) {
    const details = renderDiagnosticContent(diagnostic.details, { color, cwd });
    if (details) lines.push(details);
  }
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

export function reportDiagnostics(
  diagnostics: readonly Diagnostic[],
  logger: ILogger,
  prefix: string,
): void {
  const seen = new Set<string>();
  const urls = new Set<string>();
  for (const diagnostic of diagnostics) {
    const key = formatDiagnostic(diagnostic, prefix, { color: false });
    if (seen.has(key)) continue;
    seen.add(key);
    const url = diagnostic.url;
    const message = formatDiagnostic(
      { ...diagnostic, url: url && urls.has(url) ? undefined : url },
      prefix,
    );
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
