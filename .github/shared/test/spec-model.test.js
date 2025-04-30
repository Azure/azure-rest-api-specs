import { readdir } from "fs/promises";
import { dirname, join, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";
import {
  getAffectedReadmeTags,
  getAffectedSwaggers,
  getSpecModel,
} from "../src/spec-model.js";
import { isWindows } from "./test-utils.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const repoRoot = join(__dirname, "..", "..", "..");

describe("getSpecModel", () => {
  // Skip this test as it checks a code path that is not available when running
  // tests in CI.
  it.skip("returns spec model given relative path", async ({ expect }) => {
    const servicePath = "specification/contosowidgetmanager";

    const actual = await getSpecModel(servicePath);
    expect(actual).toBeDefined();
  });

  it("uses strings for tag names and doesn't parse Date object", async ({
    expect,
  }) => {
    const fixtureRoot = resolve(__dirname, "fixtures/getSpecModel");
    const actual = await getSpecModel("specification/yaml-date-parsing", {
      repoRoot: fixtureRoot,
    });

    const actualTag = actual.readmes.get(
      "specification/yaml-date-parsing/readme.md",
    ).globalConfig["tag"];

    expect(actualTag).not.toBeTypeOf(Date);
    expect(actualTag).toBeTypeOf("string");
    expect(actualTag).toBe("2022-12-01");
  });

  it.skipIf(isWindows())("returns spec model", async ({ expect }) => {
    const fixtureRoot = resolve(__dirname, "fixtures/getSpecModel");

    const readmePath =
      "specification/contosowidgetmanager/resource-manager/readme.md";

    const swaggerPathPreview =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    const swaggerPathStable =
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json";

    const expected = {
      repoRoot: fixtureRoot,
      readmes: {
        [readmePath]: {
          path: readmePath,
          globalConfig: {
            "openapi-type": "arm",
            "openapi-subtype": "rpaas",
            tag: "package-2021-11-01",
          },
          tags: {
            "package-2021-11-01": [
              {
                path: swaggerPathStable,
                refs: expect.anything(),
              },
            ],

            "package-2021-10-01-preview": [
              {
                path: swaggerPathPreview,
                refs: expect.anything(),
              },
            ],
          },
        },
      },
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
  it.skipIf(isWindows())("returns affected readme tags", async ({ expect }) => {
    const specModel = await getSpecModel("specification/contosowidgetmanager", {
      repoRoot: resolve(__dirname, "fixtures/getAffectedReadmeTags"),
    });

    const actual = getAffectedReadmeTags(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      specModel,
    );

    const expected = {
      "specification/contosowidgetmanager/resource-manager/readme.md": [
        "package-2021-11-01",
      ],
    };
    expect(actual).toEqual(expected);
  });

  it.skipIf(isWindows())(
    "returns affected readme tags for multiple tags",
    async ({ expect }) => {
      const specModel = await getSpecModel("specification/1", {
        // TODO: Cleanup
        repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
      });
      const actual = getAffectedReadmeTags(
        "specification/1/data-plane/shared/shared.json",
        specModel,
      );

      const expected = {
        "specification/1/data-plane/readme.md": ["tag-1", "tag-2"],
      };
      expect(actual).toEqual(expected);
    },
  );
});

describe("getAffectedSwaggers", () => {
  it.skipIf(isWindows())(
    "returns directly referenced swagger",
    async ({ expect }) => {
      const specModel = await getSpecModel("specification/1", {
        repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
      });

      const actual = getAffectedSwaggers(
        "specification/1/data-plane/a.json",
        specModel,
      );

      const expected = ["specification/1/data-plane/a.json"];

      expect(actual).toEqual(expected);
    },
  );

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

  it.skipIf(isWindows())(
    "returns correct swaggers for one layer of dependencies",
    async ({ expect }) => {
      const specModel = await getSpecModel("specification/1", {
        repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
      });

      const actual = getAffectedSwaggers(
        "specification/1/data-plane/nesting/b.json",
        specModel,
      );

      const expected = [
        "specification/1/data-plane/a.json",
        "specification/1/data-plane/nesting/b.json",
      ];
      expect(actual).toEqual(expected);
    },
  );

  it.skipIf(isWindows())(
    "returns correct swaggers for two layers of dependencies",
    async ({ expect }) => {
      const specModel = await getSpecModel("specification/1", {
        repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
      });

      const actual = getAffectedSwaggers(
        "specification/1/data-plane/c.json",
        specModel,
      );
      const expected = [
        "specification/1/data-plane/a.json",
        "specification/1/data-plane/nesting/b.json",
        "specification/1/data-plane/c.json",
      ];

      expect(actual.sort()).toEqual(expected.sort());
    },
  );

  it.skipIf(isWindows())(
    "returns correct swaggers for three layers of dependencies",
    async ({ expect }) => {
      const specModel = await getSpecModel("specification/1", {
        repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
      });

      const actual = getAffectedSwaggers(
        "specification/1/data-plane/d.json",
        specModel,
      );
      const expected = [
        "specification/1/data-plane/a.json",
        "specification/1/data-plane/nesting/b.json",
        "specification/1/data-plane/c.json",
        "specification/1/data-plane/d.json",
      ];
      expect(actual.sort()).toEqual(expected.sort());
    },
  );

  it.skipIf(isWindows())(
    "returns correctly for multiple shared dependencies",
    async ({ expect }) => {
      const specModel = await getSpecModel("specification/1", {
        repoRoot: resolve(__dirname, "fixtures/getAffectedSwaggers"),
      });

      const actual = getAffectedSwaggers(
        "specification/1/data-plane/shared/shared.json",
        specModel,
      );
      const expected = [
        "specification/1/data-plane/a.json",
        "specification/1/data-plane/nesting/b.json",
        "specification/1/data-plane/c.json",
        "specification/1/data-plane/d.json",
        "specification/1/data-plane/shared/shared.json",
        "specification/1/data-plane/e.json",
      ];
      expect(actual.sort()).toEqual(expected.sort());
    },
  );
});

// Stress test the parser against all specs in the specification/ folder. This
// is a long-running test and should be run manually. To run this test, remove
// the '.skip' from the describe block. Put '.skip' back in when done or this
// test may fail unexpectedly in the future.
describe.skip("Parse readmes", () => {
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
