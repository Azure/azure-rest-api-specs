import { execa } from "execa";
import { join, resolve } from "pathe";
import { afterEach, describe, expect, it, vi } from "vitest";
import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { reportPrDiagnostics } from "../src/cli.ts";
import { createRepo } from "./repo.ts";

const script = resolve(import.meta.dirname, "../cmd/spec-pr-validation.js");
afterEach(() => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
});

describe("PR CLI", () => {
  it("shows help without a repository or comparison context", async () => {
    const result = await execa(process.execPath, [script, "--help"], { cwd: import.meta.dirname });
    expect(result.stdout).toContain("Spec PR Validation");
    expect(result.stdout).toContain("--base");
    expect(result.stdout).toMatch(/upstream\s+main/);
  });

  it("requires base instead of silently inspecting only the last commit", async () => {
    const result = await execa(process.execPath, [script], { reject: false });
    expect(result.exitCode).toBe(1);
    expect(result.stderr).toContain("--base is required");
  });

  it("defaults head, emits false for no applicable policies, and reports bad revisions", async () => {
    const { root } = await createRepo({}, { "eng/changed.ts": "" });
    const output = join(root, "output");
    const success = await execa(process.execPath, [script, "--base=HEAD^"], {
      cwd: root,
      env: { GITHUB_OUTPUT: output },
    });
    expect(success.stdout).toBe("No applicable spec PR policies.");
    const { readFile } = await import("node:fs/promises");
    expect(await readFile(output, "utf8")).toBe("brownfield=false\n");
    const failure = await execa(process.execPath, [script, "--base=missing"], {
      cwd: root,
      reject: false,
    });
    expect(failure.exitCode).toBe(1);
    expect(failure.stderr).toContain("spec-pr-validation/rule-execution");
  });

  it("escapes annotation data and paths without enabling verbose logging", () => {
    vi.stubEnv("GITHUB_ACTIONS", "true");
    vi.stubEnv("NO_COLOR", "1");
    const stdout = vi.spyOn(console, "log").mockImplementation(() => {});
    vi.spyOn(console, "warn").mockImplementation(() => {});
    reportPrDiagnostics(
      [
        {
          severity: "warning",
          code: "policy",
          message: "line%1\nline2",
          path: "C:/folder,a.json",
          location: { line: 2, column: 3 },
        },
      ],
      new ConsoleLogger(),
    );
    expect(stdout).toHaveBeenCalledExactlyOnceWith(
      "::warning file=C%3A/folder%2Ca.json,line=2,col=3::line%251%0Aline2",
    );
  });
});
