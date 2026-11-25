import { describe, expect, it } from "vitest";
import { getLocalTypeSpecImports } from "../../typespec-import-parser/src/index.ts";

describe("getLocalTypeSpecImports", () => {
  it("returns sorted relative TypeSpec imports without loading imported files", async () => {
    const imports = await getLocalTypeSpecImports(
      "specification/widget/main.tsp",
      [
        'import "../shared/common.tsp";',
        'import "@azure-tools/typespec-azure-core";',
        'import "./decorators.js";',
        'import "./Shared.Models";',
        'import "./models.tsp";',
      ].join("\n"),
    );

    expect(imports).toEqual(["../shared/common.tsp", "./Shared.Models", "./models.tsp"]);
  });

  it("excludes JavaScript module variants", async () => {
    const imports = await getLocalTypeSpecImports(
      "specification/widget/main.tsp",
      [
        'import "./decorators.js";',
        'import "./decorators.cjs";',
        'import "./decorators.mjs";',
        'import "./models.tsp";',
      ].join("\n"),
    );

    expect(imports).toEqual(["./models.tsp"]);
  });

  it("deduplicates imports without failing on duplicate-import warnings", async () => {
    const imports = await getLocalTypeSpecImports(
      "specification/widget/main.tsp",
      ['import "./models.tsp";', 'import "./models.tsp";'].join("\n"),
    );

    expect(imports).toEqual(["./models.tsp"]);
  });

  it("reports source-loader diagnostics for malformed TypeSpec", async () => {
    await expect(
      getLocalTypeSpecImports("specification/widget/main.tsp", 'import "./models.tsp'),
    ).rejects.toThrow(
      /Unable to load TypeSpec imports from 'specification\/widget\/main\.tsp': \d+ error diagnostic\(s\)/,
    );
  });
});
