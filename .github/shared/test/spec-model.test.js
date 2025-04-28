import { readFileSync } from "fs";
import { dirname, join, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, it, expect } from "vitest";
import {
  getAffectedReadmeTags,
  getSpecModel,
  getAffectedSwaggers,
} from "../src/spec-model.js";
import { readdir } from "fs/promises";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const repoRoot = join(__dirname, "..", "..", "..");

describe("getSpecModel", () => {
  it("returns spec model given relative path", async ({ expect }) => {
    const servicePath = "specification/contosowidgetmanager";

    const actual = await getSpecModel(servicePath);
    expect(actual).toBeDefined();
  });

  it("returns spec model", async ({ expect }) => {
    const fixtureRoot = resolve(__dirname, "fixtures/getSpecModel");

    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";
    const readmeContent = readFileSync(join(fixtureRoot, readmePath), {
      encoding: "utf8",
    });

    const swaggerPathPreview =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";
    const swaggerContentPreview = readFileSync(
      join(fixtureRoot, swaggerPathPreview),
      {
        encoding: "utf8",
      },
    );

    const swaggerPathStable =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json";
    const swaggerContentStable = readFileSync(
      join(fixtureRoot, swaggerPathStable),
      {
        encoding: "utf8",
      },
    );

    const expected = {
      repoRoot: fixtureRoot,
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
                    // TODO: Absolute paths won't test properly across machines.
                    // Make paths relative or remove comment
                    refs: expect.any(Map),
                  },
                ],
              ],
              [
                "package-2021-10-01-preview",
                [
                  {
                    path: swaggerPathPreview,
                    content: swaggerContentPreview,
                    // TODO: Absolute paths won't test properly across machines.
                    // Make paths relative or remove comment
                    refs: expect.any(Map),
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
      { repoRoot: fixtureRoot },
    );

    expect(specModel).toEqual(expected);
  });

  it("throws when a tag is defined more than once", async ({ expect }) => {
    const fixtureRoot = resolve(__dirname, "fixtures/getSpecModel");

    // data-plane/readme.md defines the `package-2022-12-01` tag twice.
    const specRoot = "specification/contosowidgetmanager/data-plane";

    await expect(
      async () => await getSpecModel(specRoot, { repoRoot: fixtureRoot }),
    ).rejects.toThrowError();
  });
});

describe("getReadme regex", () => {
  it.each([
    ["```yaml $(package-A-tag) == 'package-A-[[Version]]'", false],
    ["``` yaml $(tag)=='package-2017-03' && $(go)", true],
    ["``` yaml $(csharp) && $(tag) == 'release_4_0'", true],
    ["``` yaml $(tag) == 'package-2021-12-01-preview'", true], // Typical case
  ])("ignores tags that don't match the regex: %s", (example, expected) => {
    const regex = /yaml.*\$\(tag\) ?== ?'([^']*)'/;
    expect(regex.test(example)).toEqual(expected);
  });
});

describe("getAffectedReadmeTags", () => {
  it("returns affected readme tags", async ({ expect }) => {
    const specModel = await getSpecModel(
      "specification/contosowidgetmanager",
      // { repoRoot: resolve(__dirname, "fixtures/getAffectedReadmeTags") }
    );

    const actual = getAffectedReadmeTags(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      specModel,
    );

    const expected = new Map([
      [
        "specification/contosowidgetmanager/resource-manager/readme.md",
        new Set(["package-2021-11-01"]),
      ],
    ]);
    expect(actual).toEqual(expected);
  });

  it("returns affected readme tags for multiple tags", async ({ expect }) => {
    const specModel = await getSpecModel("specification/1", {
      repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
    });
    const actual = getAffectedReadmeTags(
      "specification/1/data-plane/shared/shared.json",
      specModel,
    );

    const expected = new Map([
      ["specification/1/data-plane/readme.md", new Set(["tag-1", "tag-2"])],
    ]);
    expect(actual).toEqual(expected);
  });
});

describe("getAffectedSwaggers", () => {
  it("returns affected swaggers", async ({ expect }) => {
    const specModel = await getSpecModel("specification/contosowidgetmanager");

    const actual = getAffectedSwaggers(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      specModel,
    );

    const expected = new Set([
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
    ]);
    expect(actual).toEqual(expected);
  });

  it("returns directly referenced swagger", async ({ expect }) => {
    const specModel = await getSpecModel("specification/1", {
      repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
    });

    const actual = getAffectedSwaggers(
      "specification/1/data-plane/a.json",
      specModel,
    );

    const expected = new Set(["specification/1/data-plane/a.json"]);

    expect(actual).toEqual(expected);
  });

  it("throws when swagger file is not found", async ({ expect }) => {
    const specModel = await getSpecModel("specification/1", {
      repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
    });
    const swaggerFile = "specification/1/data-plane/not-found.json";
    const actual = () => getAffectedSwaggers(swaggerFile, specModel);
    expect(actual).toThrowError(
      expect.objectContaining({
        message: expect.stringContaining(swaggerFile),
      }),
    );
  });

  it("returns correct swaggers for one layer of dependencies", async ({
    expect,
  }) => {
    const specModel = await getSpecModel("specification/1", {
      repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
    });

    const actual = getAffectedSwaggers(
      "specification/1/data-plane/nesting/b.json",
      specModel,
    );

    const expected = new Set([
      "specification/1/data-plane/a.json",
      "specification/1/data-plane/nesting/b.json",
    ]);
    expect(actual).toEqual(expected);
  });

  it("returns correct swaggers for two layers of dependencies", async ({
    expect,
  }) => {
    const specModel = await getSpecModel("specification/1", {
      repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
    });

    const actual = getAffectedSwaggers(
      "specification/1/data-plane/c.json",
      specModel,
    );
    const expected = new Set([
      "specification/1/data-plane/a.json",
      "specification/1/data-plane/nesting/b.json",
      "specification/1/data-plane/c.json",
    ]);
    expect(actual).toEqual(expected);
  });

  it("returns correct swaggers for three layers of dependencies", async ({
    expect,
  }) => {
    const specModel = await getSpecModel("specification/1", {
      repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
    });

    const actual = getAffectedSwaggers(
      "specification/1/data-plane/d.json",
      specModel,
    );
    const expected = new Set([
      "specification/1/data-plane/a.json",
      "specification/1/data-plane/nesting/b.json",
      "specification/1/data-plane/c.json",
      "specification/1/data-plane/d.json",
    ]);
    expect(actual).toEqual(expected);
  });

  it("returns correctly for multiple shared dependencies", async ({
    expect,
  }) => {
    const specModel = await getSpecModel("specification/1", {
      repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
    });

    const actual = getAffectedSwaggers(
      "specification/1/data-plane/shared/shared.json",
      specModel,
    );
    const expected = new Set([
      "specification/1/data-plane/a.json",
      "specification/1/data-plane/nesting/b.json",
      "specification/1/data-plane/c.json",
      "specification/1/data-plane/d.json",
      "specification/1/data-plane/shared/shared.json",
      "specification/1/data-plane/e.json",
    ]);
    expect(actual).toEqual(expected);
  });
});

// Stress test the parser against all specs in the specification/ folder. This
// is a long-running test and should be run manually. To run this test, remove
// the '.skip' from the describe block. Put '.skip' back in when done or this
// test may fail unexpectedly in the future.
describe("Parse readmes", () => {
  it(
    "Does not produce exceptions",
    { timeout: 30 * 60 * 1000 /* 30 minutes */ },
    async ({ expect }) => {
      const excludeFolders = [
        "authorization", // specification/authorization/resource-manager/readme.md defines has duplicate tags including 'package-2020-10-01'
        "azureactivedirectory", // specification/azureactivedirectory/resource-manager/readme.md has duplicate tags including 'package-preview-2020-07'
        "cost-management", // specification/cost-management/resource-manager/readme.md has duplicate tags including 'package-2019-01'
        "migrate", // specification/migrate/resource-manager/readme.md has duplicate tags including 'package-migrate-2023-04'
        "quota", // specification/quota/resource-manager/readme.md has duplicate tags including 'package-2023-02-01'
        "redisenterprise", // specification/redisenterprise/resource-manager/readme.md has duplicate tags including 'package-2024-02'
        "security", // specification/security/resource-manager/readme.md has duplicate tags including 'package-2021-07-preview-only'
        "confidentialledger", // data-plane/readme.md tag 'package-2022-04-20-preview-ledger' points to a swagger file that doesn't exist
        "network", // network takes a long time to evaluate
        "servicenetworking", // servicenetworking includes a swagger file which references a file that doesn't exist
      ];

      // List all folders under specification/
      const folders = await readdir(join(repoRoot, "specification"), {
        withFileTypes: true,
      });
      const services = folders
        .filter((f) => f.isDirectory() && !excludeFolders.includes(f.name))
        .map((f) => f.name);
      for (const folder of services) {
        // Folders are listed in alphabetical order, when running this function
        // iteratively over all service folders, a value can be placed in in this
        // condition to skip folders that appear before a given folder. This means
        // you won't have to wait for tests to run over all folders that have
        // previously passed.
        if (folder < "000") {
          console.log(`Skipping service: ${folder}`);
          continue;
        }

        console.log(`Testing service: ${folder}`);
        const specModel = await getSpecModel(`specification/${folder}`, {
          debug: false,
        });

        expect(specModel).toBeDefined();
      }
    },
  );

  it(
    "runs properly against specific services",
    { timeout: 30 * 60 * 1000 /* 30 minutes */ },
    async ({ expect }) => {
      const folders = [
        // Fill in services to test here
      ];
      for (const folder of folders) {
        console.log(`Testing service: ${folder}`);
        const specModel = await getSpecModel(`specification/${folder}`, {
          debug: true,
        });

        expect(specModel).toBeDefined();
      }
    },
  );
});
