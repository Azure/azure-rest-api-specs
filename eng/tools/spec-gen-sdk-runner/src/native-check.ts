import type { CommandResult, ExecutionReport } from "./types.ts";

export type NativeCheckSignal = "validation" | "breaking-present" | "breaking-absent";

export function parseNativeCheckSignal(value: string): NativeCheckSignal | undefined {
  if (!value) return undefined;
  if (value === "validation" || value === "breaking-present" || value === "breaking-absent") {
    return value;
  }
  throw new Error(`Unknown native SDK check signal: ${value}`);
}

export function completeBreakingChangeSignal(
  reports: (ExecutionReport | undefined)[],
  signals: (boolean | undefined)[],
  statusCode: number,
): boolean | undefined {
  if (
    statusCode !== 0 ||
    reports.length === 0 ||
    reports.length !== signals.length ||
    reports.some((report) => report?.executionResult !== "succeeded" || !report.packages.length) ||
    signals.some((signal) => signal === undefined)
  ) {
    return undefined;
  }
  return signals.some((signal) => signal === true);
}

export function nativeCheckExitCode(signal: NativeCheckSignal, result: CommandResult): number {
  const evidence = result.nativeCheck;
  if (!evidence) return 1;
  if (signal === "validation") {
    if (!evidence.required) return 0;
    return result.statusCode === 0 &&
      (result.executionResult === "succeeded" || result.executionResult === "warning")
      ? 0
      : 1;
  }
  return evidence.breakingChange === (signal === "breaking-present") ? 0 : 1;
}
