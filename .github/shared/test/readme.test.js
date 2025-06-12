// @ts-check

import { resolve } from "path";
import { describe, expect, it } from "vitest";
import { ConsoleLogger } from "../src/logger.js";
import { Readme, TagMatchRegex } from "../src/readme.js";
import { SpecModel } from "../src/spec-model.js";
import { contosoReadme } from "./examples.js";

const options = { logger: new ConsoleLogger(/*debug*/ true) };

describe("readme", () => {
  it("can be created with mock path", async () => {
    const readme = new Readme("bar");
    expect(readme.path).toBe(resolve("bar"));

    await expect(readme.getTags()).rejects.toThrowError(
      /no such file or directory/i,
    );

    expect(readme.specModel).toBeUndefined();
  });

  it("resolves path against SpecModel", async () => {
    const readme = new Readme("readme.md", {
      specModel: new SpecModel("/specs/foo"),
    });
    expect(readme.path).toBe(resolve("/specs/foo/readme.md"));
  });

  // TODO: Test that path is resolved against backpointer

  it("can be created with string content", async () => {
    const folder = "/fake";
    const readme = new Readme(resolve(folder, "readme.md"), {
      ...options,
      content: contosoReadme,
    });

    const tags = await readme.getTags();
    const tagNames = [...tags.keys()];
    const expectedTagNames = [
      "package-2021-11-01",
      "package-2021-10-01-preview",
    ];

    expect(tagNames.sort()).toEqual(expectedTagNames.sort());

    const swaggerPaths = [...tags.values()].flatMap((t) => [
      ...t.inputFiles.keys(),
    ]);

    const expectedPaths = [
      resolve(folder, "Microsoft.Contoso/stable/2021-11-01/contoso.json"),
      resolve(
        folder,
        "Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
      ),
    ];

    expect(swaggerPaths.sort()).toEqual(expectedPaths.sort());
  });

  it("can be created with empty content", async () => {
    const folder = "/fake";
    const readme = new Readme(resolve(folder, "readme.md"), {
      ...options,
      // Simulate empty file
      content: "",
    });

    const tags = await readme.getTags();

    // Ensures code doesn't try to read file `/fake/readme.md` which would throw
    expect(tags.size).toBe(0);
  });
});

describe("TagMatchRegex", () => {
  it.each([
    ["```yaml $(package-A-tag) == 'package-A-[[Version]]'", false, undefined],
    ["``` yaml $(tag)=='package-2017-03' && $(go)", true, "package-2017-03"],
    ["``` yaml $(csharp) && $(tag) == 'release_4_0'", true, "release_4_0"],
    [
      "``` yaml $(tag) == 'package-2021-12-01-preview'",
      true,
      "package-2021-12-01-preview",
    ],
    ['``` yaml $(tag) == "package-2025-06-05"', true, "package-2025-06-05"],
    ["``` yaml $(tag) == 'package-2025-06-05\"", false, undefined],
    ["``` yaml $(tag) == \"package-2025-06-05'", false, undefined],
  ])(
    "matches tags and extracts tag names properly: %s",
    (example, expectedMatch, expectedTag) => {
      const match = example.match(TagMatchRegex);
      expect(TagMatchRegex.test(example)).toEqual(expectedMatch);
      expect(match?.[2]).toEqual(expectedTag);
    },
  );
});
