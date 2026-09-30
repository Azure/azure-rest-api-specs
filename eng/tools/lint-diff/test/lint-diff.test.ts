import { execa } from "execa";
import { resolve } from "node:path";
import { describe, expect, test } from "vitest";

describe("e2e", () => {
  test("reports missing required arguments", async () => {
    const output = await execa(
      process.execPath,
      [resolve(import.meta.dirname, "../cmd/lint-diff.js")],
      { reject: false },
    );

    expect(output.exitCode, `${output.stdout}\n${output.stderr}`).toBe(1);
    expect(output.stdout).toContain("--before must be a valid path");
    expect(output.stdout).toContain("--after must be a valid path");
    expect(output.stdout).toContain("--changed-files-path missing");
  });
});
