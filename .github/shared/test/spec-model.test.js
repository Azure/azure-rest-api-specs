// @ts-check

import { readdir } from "fs/promises";
import { dirname, isAbsolute, join, resolve } from "path";
import { describe, expect, it } from "vitest";
import { mapAsync } from "../src/array.js";
import { ConsoleLogger } from "../src/logger.js";
import { SpecModel } from "../src/spec-model.js";
import { repoRoot } from "./repo.js";

const options = { logger: new ConsoleLogger(/*debug*/ true) };

describe("SpecModel", () => {
  it("can be created with mock folder", async () => {
    const specModel = new SpecModel("foo");
    expect(specModel.folder).toBe(resolve("foo"));

    await expect(specModel.getReadmes()).rejects.toThrowError(
      /no such file or directory/i,
    );
  });

  it("returns spec model", async () => {
    const folder = resolve(
      __dirname,
      "fixtures/getSpecModel/specification/contosowidgetmanager/resource-manager",
    );

    const specModel = new SpecModel(folder, options);

    expect(specModel.toString()).toContain("SpecModel");
    expect(specModel.folder).toBe(folder);

    const readmes = [...(await specModel.getReadmes())];
    expect(readmes.length).toBe(1);

    const readme = readmes[0];
    expect(readme.toString()).toContain("Readme");
    expect(readme.path).toBe(resolve(folder, "readme.md"));

    expect(readme.getGlobalConfig()).resolves.toEqual({
      "openapi-type": "arm",
      "openapi-subtype": "rpaas",
      tag: "package-2021-11-01",
    });

    const tags = [...(await readme.getTags())].sort((a, b) =>
      a.name.localeCompare(b.name),
    );
    expect(tags.length).toBe(2);

    expect(tags[0].toString()).toContain("Tag");
    expect(tags[0].name).toBe("package-2021-10-01-preview");

    const inputFiles0 = [...tags[0].inputFiles];
    expect(inputFiles0.length).toBe(1);
    expect(inputFiles0[0].toString()).toContain("Swagger");
    expect(inputFiles0[0].path).toBe(
      resolve(
        folder,
        "Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
      ),
    );

    const refs0 = [...(await inputFiles0[0].getRefs())].sort((a, b) =>
      a.path.localeCompare(b.path),
    );

    expect(refs0.length).toBe(1);

    expect(refs0[0].path).toBe(
      resolve(
        dirname(inputFiles0[0].path),
        "../../../../../common-types/resource-management/v5/types.json",
      ),
    );

    expect(tags[1].name).toBe("package-2021-11-01");
    const inputFiles1 = [...tags[1].inputFiles];
    expect(inputFiles1.length).toBe(1);
    expect(inputFiles1[0].path).toBe(
      resolve(folder, "Microsoft.Contoso/stable/2021-11-01/contoso.json"),
    );

    const jsonDefault = await specModel.toJSONAsync();
    const readmePathDefault = jsonDefault.readmes[0].path;
    expect(isAbsolute(readmePathDefault)).toBe(true);
    expect(jsonDefault.readmes[0].tags[0].inputFiles[0].refs).toBeUndefined();

    const jsonRefsRelative = await specModel.toJSONAsync({
      includeRefs: true,
      relativePaths: true,
    });
    const readmePathRelative = jsonRefsRelative.readmes[0].path;
    expect(isAbsolute(readmePathRelative)).toBe(false);
    expect(
      jsonRefsRelative.readmes[0].tags[0].inputFiles[0].refs,
    ).toBeDefined();
  });

  it("uses strings for tag names and doesn't parse Date object", async () => {
    const folder = resolve(
      __dirname,
      "fixtures/getSpecModel/specification/yaml-date-parsing",
    );

    const specModel = new SpecModel(folder, options);

    const readme = [...(await specModel.getReadmes())][0];

    const globalConfig = await readme.getGlobalConfig();

    const tag = globalConfig["tag"];

    // @ts-ignore
    expect(tag).not.toBeTypeOf(Date);

    expect(tag).toBeTypeOf("string");
    expect(tag).toBe("2022-12-01");
  });

  it("throws when a tag is defined more than once", async () => {
    // data-plane/readme.md defines the `package-2022-12-01` tag twice.
    const folder = resolve(
      __dirname,
      "fixtures/getSpecModel/specification/contosowidgetmanager/data-plane",
    );

    const specModel = new SpecModel(folder, options);

    const readmes = await specModel.getReadmes();

    await expect(
      mapAsync([...readmes], async (r) => await r.getTags()),
    ).rejects.toThrowError(/multiple.*tag/i);
  });

  describe("getAffectedReadmeTags", () => {
    it("returns affected readme tags", async () => {
      const folder = resolve(
        __dirname,
        "fixtures/getAffectedReadmeTags/specification/contosowidgetmanager",
      );

      const specModel = new SpecModel(folder, options);

      const swaggerPath = resolve(
        folder,
        "resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      );

      const actual = await specModel.getAffectedReadmeTags(swaggerPath);

      const entries = [...actual];

      expect(entries.length).toBe(1);

      const readme = entries[0][0];
      expect(readme.path).toBe(resolve(folder, "resource-manager/readme.md"));

      const tags = [...entries[0][1]].sort((a, b) =>
        a.name.localeCompare(b.name),
      );
      expect(tags.length).toBe(1);

      expect(tags[0].name).toBe("package-2021-11-01");
    });

    it("returns affected readme tags for multiple tags", async () => {
      const folder = resolve(
        __dirname,
        "fixtures/getAffectedSwaggers/specification/1",
      );

      const specModel = new SpecModel(folder, options);

      const swaggerPath = resolve(folder, "data-plane/shared/shared.json");

      const actual = await specModel.getAffectedReadmeTags(swaggerPath);

      const entries = [...actual];

      expect(entries.length).toBe(1);

      const readme = entries[0][0];
      expect(readme.path).toBe(resolve(folder, "data-plane/readme.md"));

      const tags = [...entries[0][1]].sort((a, b) =>
        a.name.localeCompare(b.name),
      );

      expect(tags.length).toBe(2);
      expect(tags[0].name).toBe("tag-1");
      expect(tags[1].name).toBe("tag-2");
    });
  });

  describe("getAffectedSwaggers", async () => {
    const folder = resolve(
      __dirname,
      "fixtures/getAffectedSwaggers/specification/1",
    );

    const specModel = new SpecModel(folder, options);

    it("returns directly referenced swagger", async () => {
      const swaggerPath = resolve(folder, "data-plane/a.json");

      const actual = [...(await specModel.getAffectedSwaggers(swaggerPath))]
        .map((s) => s.path)
        .sort();

      const expected = ["data-plane/a.json"]
        .map((p) => resolve(folder, p))
        .sort();

      expect(actual).toEqual(expected);
    });

    it("throws when swagger file is not found", async () => {
      const swaggerPath = resolve(folder, "data-plane/not-found.json");

      await expect(
        specModel.getAffectedSwaggers(swaggerPath),
      ).rejects.toThrowError(/no affected swaggers/i);
    });

    it("returns correct swaggers for one layer of dependencies", async () => {
      const swaggerPath = resolve(folder, "data-plane/nesting/b.json");

      const actual = [...(await specModel.getAffectedSwaggers(swaggerPath))]
        .map((s) => s.path)
        .sort();

      const expected = ["data-plane/a.json", "data-plane/nesting/b.json"]
        .map((p) => resolve(folder, p))
        .sort();

      expect(actual).toEqual(expected);
    });

    it("returns correct swaggers for two layers of dependencies", async () => {
      const swaggerPath = resolve(folder, "data-plane/c.json");

      const actual = [...(await specModel.getAffectedSwaggers(swaggerPath))]
        .map((s) => s.path)
        .sort();

      const expected = [
        "data-plane/a.json",
        "data-plane/nesting/b.json",
        "data-plane/c.json",
      ]
        .map((p) => resolve(folder, p))
        .sort();

      expect(actual).toEqual(expected);
    });

    it("returns correct swaggers for three layers of dependencies", async () => {
      const swaggerPath = resolve(folder, "data-plane/d.json");

      const actual = [...(await specModel.getAffectedSwaggers(swaggerPath))]
        .map((s) => s.path)
        .sort();

      const expected = [
        "data-plane/a.json",
        "data-plane/nesting/b.json",
        "data-plane/c.json",
        "data-plane/d.json",
      ]
        .map((p) => resolve(folder, p))
        .sort();

      expect(actual).toEqual(expected);
    });

    it("returns correctly for multiple shared dependencies", async () => {
      const swaggerPath = resolve(folder, "data-plane/shared/shared.json");

      const actual = [...(await specModel.getAffectedSwaggers(swaggerPath))]
        .map((s) => s.path)
        .sort();

      const expected = [
        "data-plane/a.json",
        "data-plane/nesting/b.json",
        "data-plane/c.json",
        "data-plane/d.json",
        "data-plane/shared/shared.json",
        "data-plane/e.json",
      ]
        .map((p) => resolve(folder, p))
        .sort();

      expect(actual).toEqual(expected);
    });
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

// TODO: Update tests for new object-oriented API

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
        const specModel = new SpecModel(`specification/${folder}`, options);

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
        const specModel = new SpecModel(`specification/${folder}`, options);

        expect(specModel).toBeDefined();
      }
    },
  );
});
