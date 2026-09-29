export interface Diagnostic {
  readonly severity: "error" | "warning";
  readonly code: string;
  readonly message: string;
  readonly path?: string;
  readonly location?: { line: number; column: number; text?: string };
  readonly help?: string;
  readonly url?: string;
}

export interface RuleResult {
  readonly success: boolean;
  readonly diagnostics?: Diagnostic[];
  readonly skipped?: string;
  readonly suppressed?: string;
  /** Legacy output for unmigrated rules; new rule findings belong in diagnostics. */
  readonly stdOutput?: string;
  readonly errorOutput?: string;
}

export class DiagnosticError extends Error {
  readonly diagnostic: Diagnostic;

  constructor(diagnostic: Diagnostic, cause: unknown) {
    super(diagnostic.message, { cause });
    this.diagnostic = diagnostic;
  }
}

export function failure(
  code: string,
  message: string,
  details: Omit<Diagnostic, "code" | "message" | "severity"> = {},
): RuleResult {
  return { success: false, diagnostics: [{ severity: "error", code, message, ...details }] };
}

export function warning(
  code: string,
  message: string,
  details: Omit<Diagnostic, "code" | "message" | "severity"> = {},
): RuleResult {
  return { success: true, diagnostics: [{ severity: "warning", code, message, ...details }] };
}
