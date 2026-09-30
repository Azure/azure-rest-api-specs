import type { ILogger } from "@azure-tools/specs-shared/logger";
import { stripVTControlCharacters } from "node:util";
import { verbatim } from "./diagnostic-content.ts";
import { failure, warning, type RuleResult } from "./rule-result.ts";

export type CommandOutput = [Error | null, string, string];

/** Preserve failing or unexpected output intact; only known successful CLI output is verbose. */
export function reportCommandOutput(
  command: "compile" | "format",
  label: string,
  [error, stdout, stderr]: CommandOutput,
  logger: ILogger,
): RuleResult {
  const streams = [...new Set([stdout.trimEnd(), stderr.trimEnd()].filter((text) => text.trim()))];
  if (error) {
    const reason =
      "signal" in error && typeof error.signal === "string"
        ? ` (terminated by ${error.signal})`
        : "code" in error && (typeof error.code === "number" || typeof error.code === "string")
          ? ` (${typeof error.code === "number" ? "exit code " : ""}${error.code})`
          : "";
    // Node's execFile error message embeds stderr. Render the captured streams instead.
    const prefix = `${error.name}: ${error.message}`;
    const frames = error.stack?.startsWith(prefix)
      ? error.stack.slice(prefix.length).trimEnd()
      : undefined;
    if (frames) logger.debug(frames);
    return failure(command, `${label} failed${reason}.`, {
      details: verbatim((streams.join("\n") || error.message).trimEnd()),
    });
  }

  const unexpected: string[] = [];
  for (const stream of streams) {
    if (isRoutineOutput(command, stream)) logger.debug(stream);
    else unexpected.push(stream);
  }
  return unexpected.length
    ? warning(`${command}-output`, `${label} reported additional output.`, {
        details: verbatim(unexpected.join("\n")),
      })
    : { success: true };
}

function isRoutineOutput(command: "compile" | "format", output: string): boolean {
  return stripVTControlCharacters(output)
    .split(/\r?\n/)
    .every((line) => {
      const text = line.trim();
      if (!text) return true;
      if (command === "format") {
        return (
          text === "- Formatting" ||
          /^\u2714(?: \d+ (?:formatted|unchanged|ignored)(?:, \d+ (?:formatted|unchanged|ignored))*)?$/.test(
            text,
          )
        );
      }
      return (
        /^TypeSpec compiler v\d+\.\d+\.\d+(?:[-+][\w.-]+)?$/.test(text) ||
        text === "Compilation completed successfully." ||
        text === "- Compiling..." ||
        text === "\u2714 Compiling" ||
        /^- Running [@\w./-]+\.\.\.$/.test(text) ||
        /^\u2714 [@\w./-]+ \d+ms(?: .*)?$/.test(text) ||
        // --list-files prints each emitted path on an indented line.
        (/^ {4}\S.*[/\\][^/\\]+\.(?:json|yaml)$/.test(line) && !/ - (?:error|warning)\b/.test(line))
      );
    });
}
