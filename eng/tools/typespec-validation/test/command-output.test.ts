import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { describe, expect, it, vi } from "vitest";
import { reportCommandOutput } from "../src/command-output.ts";
import { formatDiagnostic } from "../src/diagnostics.ts";
import { diagnosticDetails } from "./diagnostics.ts";

describe("command output", () => {
  it.each([
    [
      "compile",
      "TypeSpec compiler v1.16.0\n\n    specification/example.json\n    specification/service.yaml\n\nCompilation completed successfully.\n",
      "- Compiling...\n\u2714 Compiling\n- Running @azure-tools/typespec-autorest...\n\u2714 @azure-tools/typespec-autorest 20ms output\n",
    ],
    ["format", "", "- Formatting\n\u2714 1 formatted, 2 unchanged, 3 ignored\n"],
  ] as const)("keeps routine %s output debug-only", (command, stdout, stderr) => {
    const logger = new ConsoleLogger();
    const debug = vi.spyOn(logger, "debug");
    const result = reportCommandOutput(command, "TypeSpec", [null, stdout, stderr], logger);
    expect(result).toEqual({ success: true });
    expect(debug).toHaveBeenCalled();
  });

  it.each([
    ["stdout", ""],
    ["", "stderr"],
    ["stdout", "stderr"],
    ["same", "same"],
    ["", ""],
  ])(
    "preserves failing stdout=%j stderr=%j once even when Error.message embeds stderr",
    (stdout, stderr) => {
      const error = Object.assign(new Error(`Command failed\n${stderr}`), { code: 1 });
      const logger = new ConsoleLogger(true);
      const debug = vi.spyOn(logger, "debug").mockImplementation(() => {});
      const result = reportCommandOutput(
        "compile",
        "TypeSpec compilation",
        [error, stdout, stderr],
        logger,
      );

      expect(result.success).toBe(false);
      const output = [...new Set([stdout, stderr].filter(Boolean))].join("\n");
      expect(result.diagnostics?.[0]).toMatchObject({
        code: "compile",
        message: "TypeSpec compilation failed (exit code 1).",
      });
      expect(diagnosticDetails(result.diagnostics?.[0])).toBe((output || error.message).trimEnd());
      expect(debug.mock.calls.flat().join("\n")).not.toContain("Command failed");
      for (const text of [stdout, stderr].filter(Boolean)) {
        expect(debug.mock.calls.flat().join("\n")).not.toContain(text);
      }
    },
  );

  it("does not duplicate a native crash stack embedded in the command error message", () => {
    const output = "Internal compiler error!\n    at nativeCompiler (compiler.js:1:1)";
    const logger = new ConsoleLogger(true);
    const debug = vi.spyOn(logger, "debug").mockImplementation(() => {});
    const result = reportCommandOutput(
      "compile",
      "Compilation",
      [new Error(`Command failed\n${output}`), "", output],
      logger,
    );
    expect(diagnosticDetails(result.diagnostics?.[0])).toBe(output);
    expect(debug.mock.calls.flat().join("\n")).not.toContain("nativeCompiler");
  });

  it.each([
    { code: "ERR_CHILD_PROCESS_STDIO_MAXBUFFER", text: "ERR_CHILD_PROCESS_STDIO_MAXBUFFER" },
    { signal: "SIGTERM", text: "terminated by SIGTERM" },
  ])("keeps execution failure details alongside partial output: $text", ({ text, ...reason }) => {
    const result = reportCommandOutput(
      "compile",
      "Compilation",
      [Object.assign(new Error("failed"), reason), "partial diagnostic", ""],
      new ConsoleLogger(),
    );
    expect(result.diagnostics?.[0].message).toContain(text);
    expect(diagnosticDetails(result.diagnostics?.[0])).toBe("partial diagnostic");
  });

  it("preserves native diagnostic codes, source excerpts, related locations and colors", () => {
    const output =
      "\x1b[36mmain.tsp:5:2\x1b[39m - \x1b[31merror\x1b[39m invalid-ref: Unknown X\n> 5 | X\n    | ^\n  other.tsp:1:1 - declared here";
    const result = reportCommandOutput(
      "compile",
      "Compilation",
      [new Error("failed"), output, ""],
      new ConsoleLogger(),
    );
    const diagnostic = result.diagnostics![0];
    expect(formatDiagnostic(diagnostic, { color: true })).toContain(output);
    const plain = formatDiagnostic(diagnostic, { color: false });
    expect(plain).not.toContain("\x1b");
    expect(plain).toContain("error invalid-ref: Unknown X");
    expect(plain).toContain("other.tsp:1:1 - declared here");
  });

  it("retains full emitted-file paths even when a failed command wrote them before its diagnostic", () => {
    const output =
      "TypeSpec compiler v1.16.0\n    specification/generated.json\nmain.tsp:2:1 - warning compiler/rule: diagnostic";
    const result = reportCommandOutput(
      "compile",
      "Compilation",
      [Object.assign(new Error("failed"), { code: 1 }), output, ""],
      new ConsoleLogger(),
    );
    expect(result.success).toBe(false);
    expect(diagnosticDetails(result.diagnostics?.[0])).toBe(output);
  });

  it.each([
    [
      "compile",
      "Diagnostics were reported during compilation:\nwarning library/code: message\n  file.json\n",
      "",
    ],
    ["compile", "", "- Compiling...\nUnknown emitter message\n\u2714 Compiling\n"],
    ["compile", "No emitter was configured, no output was generated.", ""],
    ["format", "source.tsp:1:1 - warning code: message", ""],
    ["format", "", "\u26a0 1 ignored, 1 error"],
  ] as const)(
    "preserves unexpected successful %s output without guessing its diagnostic structure",
    (command, stdout, stderr) => {
      const logger = new ConsoleLogger(true);
      const debug = vi.spyOn(logger, "debug").mockImplementation(() => {});
      const result = reportCommandOutput(command, "Command", [null, stdout, stderr], logger);
      expect(result.success).toBe(true);
      expect(result.diagnostics?.[0]).toMatchObject({
        severity: "warning",
      });
      expect(diagnosticDetails(result.diagnostics?.[0])).toBe((stdout || stderr).trimEnd());
      expect(debug).not.toHaveBeenCalled();
    },
  );
});
