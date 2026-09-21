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
  it("formats TypeSpec and YAML directly from the project folder before checking for changes", async () => {
    vi.mocked(runNodeBin)
      .mockResolvedValueOnce([null, "tsp output\n", "tsp warning\n"])
      .mockResolvedValueOnce([null, "yaml output\n", "yaml warning\n"]);

    const result = await new FormatRule().execute(mockFolder);

    expect(runNodeBin).toHaveBeenNthCalledWith(
      1,
      "@typespec/compiler",
      ["tsp", "format", "../**/*.tsp"],
      mockFolder,
    );
    expect(runNodeBin).toHaveBeenNthCalledWith(
      2,
      "oxfmt",
      ["oxfmt", "--write", "tspconfig.yaml"],
      mockFolder,
    );
    expect(runNodeBin).toHaveBeenCalledTimes(2);
    expect(gitDiffTopSpecFolder).toHaveBeenCalledWith(mockFolder);
    expect(result).toEqual({
      success: true,
      stdOutput: "tsp output\nyaml output\ngit output",
      errorOutput: "tsp warning\nyaml warning\n",
    });
  });

  it.each(["TypeSpec", "YAML", "both"])("reports %s formatter failures", async (failure) => {
    vi.mocked(runNodeBin)
      .mockResolvedValueOnce([
        failure === "YAML" ? null : new Error("tsp failure\n"),
        "tsp output\n",
        "tsp stderr\n",
      ])
      .mockResolvedValueOnce([
        failure === "TypeSpec" ? null : new Error("yaml failure\n"),
        "yaml output\n",
        "yaml stderr\n",
      ]);

    const result = await new FormatRule().execute(mockFolder);

    expect(result.success).toBe(false);
    expect(result.stdOutput).toBe("tsp output\nyaml output\n");
    expect(result.errorOutput).toContain("tsp stderr\n");
    expect(result.errorOutput).toContain("yaml stderr\n");
    if (failure !== "YAML") expect(result.errorOutput).toContain("tsp failure\n");
    if (failure !== "TypeSpec") expect(result.errorOutput).toContain("yaml failure\n");
    expect(runNodeBin).toHaveBeenCalledTimes(2);
    expect(gitDiffTopSpecFolder).not.toHaveBeenCalled();
  });

  it("reports changed files and both fix commands", async () => {
    vi.mocked(gitDiffTopSpecFolder).mockResolvedValue({
      success: false,
      stdOutput: "git output",
      errorOutput: "changed tspconfig.yaml",
    });

    const result = await new FormatRule().execute(mockFolder);

    expect(result.success).toBe(false);
    expect(result.stdOutput).toBe("git output");
    expect(result.errorOutput).toContain("changed tspconfig.yaml");
    expect(result.errorOutput).toContain('pnpm exec tsp format "../**/*.tsp"');
    expect(result.errorOutput).toContain("pnpm exec oxfmt --write tspconfig.yaml");
  });
});
