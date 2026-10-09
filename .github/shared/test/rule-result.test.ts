import { describe, expect, it } from "vitest";
import { exceptionDiagnostic } from "../src/diagnostics.ts";
import { DiagnosticError, failure, warning } from "../src/rule-result.ts";

describe("structured rule results", () => {
  it("keeps warnings non-failing and errors failing, including diagnostic details", () => {
    expect(failure("error", "Broken")).toEqual({
      success: false,
      diagnostics: [{ severity: "error", code: "error", message: "Broken" }],
    });
    expect(warning("warning", "Limited", { path: "file.yaml" })).toEqual({
      success: true,
      diagnostics: [
        { severity: "warning", code: "warning", message: "Limited", path: "file.yaml" },
      ],
    });
    expect(warning("warning", "Limited").success).toBe(true);
  });
  it("preserves typed diagnostics and reports unexpected values explicitly", () => {
    const diagnostic = failure("parse", "Bad YAML").diagnostics![0];
    const cause = new Error("Cause");
    const error = new DiagnosticError(diagnostic, cause);
    expect(error.cause).toBe(cause);
    expect(exceptionDiagnostic(error)).toBe(diagnostic);
    expect(exceptionDiagnostic(new Error("Failed"), "file")).toMatchObject({
      code: "rule-execution",
      message: "Failed",
      path: "file",
    });
    expect(exceptionDiagnostic("unknown")).toMatchObject({ message: "unknown" });
  });
});
