import { ConsoleLogger, defaultLogger } from "@azure-tools/specs-shared/logger";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { FormatRule } from "../src/rules/format.ts";
import { gitDiffTopSpecFolder, runNodeBin } from "../src/utils.ts";
import { diagnosticDetails } from "./diagnostics.ts";

const mockFolder = "specification/foo/Foo";
vi.mock("../src/utils.ts", () => ({
  runNodeBin: vi.fn(),
  gitDiffTopSpecFolder: vi.fn(),
}));

beforeEach(() => {
  vi.resetAllMocks();
  vi.mocked(runNodeBin).mockResolvedValue([null, "", ""]);
  vi.mocked(gitDiffTopSpecFolder).mockResolvedValue({ success: true, files: [] });
});

describe("FormatRule", () => {
  it("formats TypeSpec and tspconfig.yaml in one command and checks files afterward", async () => {
    vi.mocked(runNodeBin).mockResolvedValueOnce([null, "", "- Formatting\n\u2714 5 unchanged\n"]);
    const logger = new ConsoleLogger(true);
    const debug = vi.spyOn(logger, "debug").mockImplementation(() => {});
    const result = await new FormatRule().execute(mockFolder, logger);
    expect(runNodeBin).toHaveBeenCalledExactlyOnceWith(
      "@typespec/compiler",
      ["tsp", "format", "../**/*.tsp", "tspconfig.yaml"],
      logger,
      mockFolder,
    );
    expect(gitDiffTopSpecFolder).toHaveBeenCalledExactlyOnceWith(mockFolder, logger);
    expect(result).toEqual({ success: true });
    expect(debug).toHaveBeenCalledWith("- Formatting\n\u2714 5 unchanged");
  });

  it("preserves native formatter errors from both streams without repeating Error.message", async () => {
    vi.mocked(runNodeBin).mockResolvedValueOnce([
      new Error("Command failed: tsp\nnative stderr"),
      "native stdout\n",
      "native stderr\n",
    ]);
    const result = await new FormatRule().execute(mockFolder, defaultLogger);
    expect(result.success).toBe(false);
    expect(result.diagnostics).toMatchObject([
      {
        severity: "error",
        code: "format",
      },
    ]);
    expect(diagnosticDetails(result.diagnostics?.[0])).toBe("native stdout\nnative stderr");
    expect(runNodeBin).toHaveBeenCalledTimes(1);
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
    vi.mocked(runNodeBin).mockResolvedValueOnce([null, "Formatter warning\n", ""]);
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
