import { beforeEach, describe, expect, it, vi } from "vitest";
import { FormatRule } from "../src/rules/format.ts";
import { gitDiffTopSpecFolder, runNodeBin } from "../src/utils.ts";
import { mockFolder } from "./mocks.ts";

vi.mock("../src/utils.ts", () => ({
  runNodeBin: vi.fn(),
  gitDiffTopSpecFolder: vi.fn(),
}));

beforeEach(() => {
  vi.resetAllMocks();
  vi.mocked(runNodeBin).mockResolvedValue([null, "", ""]);
  vi.mocked(gitDiffTopSpecFolder).mockResolvedValue({
    success: true,
    stdOutput: "git output",
    errorOutput: undefined,
  });
});

describe("FormatRule", () => {
  it("formats TypeSpec and tspconfig.yaml directly in one command before checking for changes", async () => {
    vi.mocked(runNodeBin).mockResolvedValueOnce([null, "tsp output\n", "tsp warning\n"]);

    const result = await new FormatRule().execute(mockFolder);

    expect(runNodeBin).toHaveBeenCalledWith(
      "@typespec/compiler",
      ["tsp", "format", "../**/*.tsp", "tspconfig.yaml"],
      mockFolder,
    );
    expect(runNodeBin).toHaveBeenCalledTimes(1);
    expect(gitDiffTopSpecFolder).toHaveBeenCalledWith(mockFolder);
    expect(result).toEqual({
      success: true,
      stdOutput: "tsp output\ngit output",
      errorOutput: "tsp warning\n",
    });
  });

  it("reports formatter failures without checking for changes", async () => {
    vi.mocked(runNodeBin).mockResolvedValueOnce([
      new Error("tsp failure\n"),
      "tsp output\n",
      "tsp stderr\n",
    ]);

    const result = await new FormatRule().execute(mockFolder);

    expect(result).toEqual({
      success: false,
      stdOutput: "tsp output\n",
      errorOutput: "tsp failure\ntsp stderr\n",
    });
    expect(runNodeBin).toHaveBeenCalledTimes(1);
    expect(gitDiffTopSpecFolder).not.toHaveBeenCalled();
  });

  it("reports changed files and a single TypeSpec fix command", async () => {
    vi.mocked(gitDiffTopSpecFolder).mockResolvedValue({
      success: false,
      stdOutput: "git output",
      errorOutput: "changed tspconfig.yaml",
    });

    const result = await new FormatRule().execute(mockFolder);

    expect(result.success).toBe(false);
    expect(result.stdOutput).toBe("git output");
    expect(result.errorOutput).toContain("changed tspconfig.yaml");
    expect(result.errorOutput).toContain('pnpm exec tsp format "../**/*.tsp" tspconfig.yaml');
    expect(result.errorOutput).not.toContain("oxfmt");
  });
});
