import { readFileSync } from "fs";
import { dirname, join } from "path";
import { fileURLToPath } from "url";
import { describe, it } from "vitest";
import { getSpecModel } from "../src/spec-model.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const repoRoot = join(__dirname, "..", "..");

describe("spec-model", () => {
  it("getSpecModel", async ({ expect }) => {
    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";
    const readmeContent = readFileSync(join(repoRoot, readmePath), {
      encoding: "utf8",
    });

    const swaggerPath = "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";
    const swaggerContent = readFileSync(join(repoRoot, swaggerPath), {
      encoding: "utf8",
    });

    const expected = {
      readmes: new Map([
        [
          readmePath,
          expect.objectContaining({
            path: readmePath,
            content: readmeContent,
            globalConfig: {
              "openapi-type": "arm",
              "openapi-subtype": "rpaas",
              tag: "package-2021-11-01",
            },
            // Warning: this 
            tags: new Map([
              ["package-2021-11-01", { "input-file": [ {
                path: swaggerPath, 
                content: swaggerContent,
                refs: expect.anything(),
          }]}],
              ["package-2021-10-01-preview", { "input-file": [expect.anything()]}],
            ])
          }),
        ],
      ]),
    };

    await expect(
      getSpecModel("specification/contosowidgetmanager/resource-manager"),
    ).resolves.toEqual(expected);
  });
});
