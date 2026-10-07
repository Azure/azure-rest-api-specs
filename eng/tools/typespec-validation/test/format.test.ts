import { ConsoleLogger, defaultLogger } from "@azure-tools/specs-shared/logger";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { FormatRule } from "../src/rules/format.ts";
import { formatTypeSpec } from "../src/typespec-compiler.ts";
import { gitDiffTopSpecFolder } from "../src/utils.ts";
import { diagnosticDetails } from "./diagnostics.ts";

const mockFolder = "specification/foo/Foo";
vi.mock("../src/typespec-compiler.ts", () => ({
  formatTypeSpec: vi.fn(),
}));
vi.mock("../src/utils.ts", () => ({
  gitDiffTopSpecFolder: vi.fn(),
}));

beforeEach(() => {
  vi.resetAllMocks();
  vi.mocked(formatTypeSpec).mockResolvedValue([null, "", ""]);
  vi.mocked(gitDiffTopSpecFolder).mockResolvedValue({ success: true, files: [] });
});

describe("FormatRule", () => {
  it("formats TypeSpec and tspconfig.yaml in one pass and checks files afterward", async () => {
    const logger = new ConsoleLogger(true);
    const result = await new FormatRule().execute(mockFolder, logger);
    expect(formatTypeSpec).toHaveBeenCalledExactlyOnceWith(mockFolder, [
      "../**/*.tsp",
      "tspconfig.yaml",
    ]);
    expect(gitDiffTopSpecFolder).toHaveBeenCalledExactlyOnceWith(mockFolder, logger);
    expect(result).toEqual({ success: true });
  });

  it("preserves native formatter diagnostics without repeating Error.message", async () => {
    vi.mocked(formatTypeSpec).mockResolvedValueOnce([
      new Error("TypeSpec formatting failed"),
      "native diagnostic\n",
      "",
    ]);
    const result = await new FormatRule().execute(mockFolder, defaultLogger);
    expect(result.success).toBe(false);
    expect(result.diagnostics).toMatchObject([
      {
        severity: "error",
        code: "format",
      },
    ]);
    expect(diagnosticDetails(result.diagnostics?.[0])).toBe("native diagnostic");
    expect(formatTypeSpec).toHaveBeenCalledTimes(1);
    expect(gitDiffTopSpecFolder).not.toHaveBeenCalled();
  });

  it("reports affected paths, their diff and a fix command", async () => {
    const diff = "diff --git a/tspconfig.yaml b/tspconfig.yaml\n-old\n+new\n";
    vi.mocked(gitDiffTopSpecFolder).mockResolvedValue({
      success: false,
      files: ["specification/foo/Foo/tspconfig.yaml", "specification/foo/Shared/main.tsp"],
      diff,
    });
    const result = await new FormatRule().execute(mockFolder, defaultLogger);
    expect(result).toMatchObject({
      success: false,
      diagnostics: [
        {
          code: "format-changed",
          path: mockFolder,
          help: expect.stringContaining(
            'pnpm exec tsp format "../**/*.tsp" tspconfig.yaml',
          ) as unknown,
        },
      ],
    });
    expect(diagnosticDetails(result.diagnostics?.[0])).toBe(
      `  specification/foo/Foo/tspconfig.yaml\n  specification/foo/Shared/main.tsp\n\n${diff}`,
    );
  });

  it("preserves unexpected successful output even when formatting also changes files", async () => {
    vi.mocked(formatTypeSpec).mockResolvedValueOnce([null, "Formatter warning\n", ""]);
    vi.mocked(gitDiffTopSpecFolder).mockResolvedValue({
      success: false,
      files: ["main.tsp"],
      diff: "-old\n+new\n",
    });
    const result = await new FormatRule().execute(mockFolder, defaultLogger);
    expect(result.success).toBe(false);
    expect(result.diagnostics?.map((diagnostic) => diagnostic.code)).toEqual([
      "format-output",
      "format-changed",
    ]);
    expect(diagnosticDetails(result.diagnostics?.[0])).toBe("Formatter warning");
    expect(diagnosticDetails(result.diagnostics?.[1])).toBe("  main.tsp\n\n-old\n+new\n");
  });
});
