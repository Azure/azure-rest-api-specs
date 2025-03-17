import { describe, expect, it } from "vitest";
import { getInputFiles } from "../src/readme";
import { contosoReadme } from "./examples.js";
import { createMockCore } from "./mocks.js";

describe("readme", () => {
  it("getInputFiles", async () => {
    await expect(
      getInputFiles(contosoReadme, createMockCore()),
    ).resolves.toEqual(
      new Set([
        "Microsoft.Contoso/stable/2021-11-01/contoso.json",
        "Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
      ]),
    );
  });
});
