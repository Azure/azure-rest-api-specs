import { beforeEach, describe, expect, it, vi } from "vitest";
import { FormatRule } from "../src/rules/format.ts";
import * as utils from "../src/utils.ts";

vi.mock("../src/utils.ts", () => ({
  runNodeBin: vi.fn(),
  gitDiffTopSpecFolder: vi.fn(),
}));

describe("format", () => {
  const folder = "specification/foo/Foo";

  beforeEach(() => {
    vi.resetAllMocks();
    vi.mocked(utils.runNodeBin).mockResolvedValue([null, "", ""]);
    vi.mocked(utils.gitDiffTopSpecFolder).mockResolvedValue({
      success: true,
      stdOutput: "",
      errorOutput: "",
    });
  });

  it("runs both formatters directly with the project as their working directory", async () => {
    await expect(new FormatRule().execute(folder)).resolves.toMatchObject({ success: true });
    expect(utils.runNodeBin).toHaveBeenNthCalledWith(
      1,
      "@typespec/compiler",
      ["tsp", "format", "../**/*.tsp"],
      folder,
    );
    expect(utils.runNodeBin).toHaveBeenNthCalledWith(
      2,
      "prettier",
      ["prettier", "--write", "tspconfig.yaml"],
      folder,
    );
    expect(utils.gitDiffTopSpecFolder).toHaveBeenCalledWith(folder);
  });

  it("preserves formatter errors and still runs the second formatter", async () => {
    vi.mocked(utils.runNodeBin).mockResolvedValueOnce([new Error("format failed"), "out", "err"]);
    await expect(new FormatRule().execute(folder)).resolves.toMatchObject({
      success: false,
      stdOutput: "out",
      errorOutput: "format failederr",
    });
    expect(utils.runNodeBin).toHaveBeenCalledTimes(2);
    expect(utils.gitDiffTopSpecFolder).not.toHaveBeenCalled();
  });

  it("still fails if formatting changes tracked files", async () => {
    vi.mocked(utils.gitDiffTopSpecFolder).mockResolvedValue({
      success: false,
      stdOutput: "diff",
      errorOutput: "changed files",
    });
    await expect(new FormatRule().execute(folder)).resolves.toMatchObject({
      success: false,
      errorOutput: expect.stringContaining("changed files") as unknown,
    });
  });
});
