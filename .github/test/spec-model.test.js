import { describe, expect, it } from "vitest";
import { getSpecModel } from "../src/spec-model.js";

describe("readme", () => {
  it("getInputFiles", async () => {
    await expect(
      getSpecModel("specification/contosowidgetmanager/resource-manager"),
    ).resolves.toEqual({
      readmes: new Map([
        [
          "specification/contosowidgetmanager/resource-manager/readme.md",
          expect.objectContaining({
            path: "specification/contosowidgetmanager/resource-manager/readme.md",
            globalConfig: {
              "openapi-type": "arm",
              "openapi-subtype": "rpaas",
              tag: "package-2021-11-01",
            },
          }),
        ],
      ]),
    });
  });
});
