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

    const swaggerPathPreview =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";
    const swaggerContentPreview = readFileSync(
      join(repoRoot, swaggerPathPreview),
      {
        encoding: "utf8",
      },
    );

    const swaggerPathStable =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json";
    const swaggerContentStable = readFileSync(
      join(repoRoot, swaggerPathStable),
      {
        encoding: "utf8",
      },
    );

    const expected = {
      readmes: new Map([
        [
          readmePath,
          {
            path: readmePath,
            content: readmeContent,
            globalConfig: {
              "openapi-type": "arm",
              "openapi-subtype": "rpaas",
              tag: "package-2021-11-01",
            },
            tags: new Map([
              [
                "package-2021-11-01",
                [
                  {
                    path: swaggerPathStable,
                    content: swaggerContentStable,
                    refs: new Set([
                      "/home/mharder/specs-mh/specification/common-types/resource-management/v5/types.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Operations_List.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_ListBySubscription.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_ListByResourceGroup.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_CreateOrUpdate.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Update.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Delete.json",
                    ]),
                  },
                ],
              ],
              [
                "package-2021-10-01-preview",
                [
                  {
                    path: swaggerPathPreview,
                    content: swaggerContentPreview,
                    refs: new Set([
                      "/home/mharder/specs-mh/specification/common-types/resource-management/v5/types.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Operations_List.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_ListBySubscription.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_ListByResourceGroup.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_CreateOrUpdate.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Update.json",
                      "/home/mharder/specs-mh/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Delete.json",
                    ]),
                  },
                ],
              ],
            ]),
          },
        ],
      ]),
    };

    const specModel = await getSpecModel(
      "specification/contosowidgetmanager/resource-manager",
    );

    expect(specModel).toEqual(expected);
  });
});
