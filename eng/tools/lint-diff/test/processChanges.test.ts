import { describe, expect, test } from "vitest";

import { ReadmeAffectedTags } from "../src/lintdiff-types.js";
import {
  buildState,
  getAffectedServices,
  getChangedSwaggers,
  getService,
  reconcileChangedFilesAndTags,
} from "../src/processChanges.js";

import { Readme } from "@azure-tools/specs-shared/readme";
import { Tag } from "@azure-tools/specs-shared/tag";
import { resolve } from "node:path";
import { isWindows } from "./test-util.js";

declare module "vitest" {
  interface Assertion<T = any> {
    // Asserts readmes for testing reconcileChangedFilesAndTags
    toBeReadmeWith(expected: Readme): Promise<void>;
  }
}

describe("getAffectedServices", () => {
  test.skipIf(isWindows())("returns single service with multiple files", async () => {
    const changedFiles = ["specification/service1/file1.json", "specification/service1/file2.json"];
    const affectedServices = await getAffectedServices(changedFiles);

    expect(affectedServices).toEqual(new Set<string>(["specification/service1"]));
  });

  test.skipIf(isWindows())("returns multiple services", async () => {
    const changedFiles = [
      "specification/service1/file1.json",
      "specification/service1/file2.json",
      "specification/service2/file1.json",
    ];
    const affectedServices = await getAffectedServices(changedFiles);

    expect(affectedServices).toEqual(
      new Set<string>(["specification/service1", "specification/service2"]),
    );
  });
});

describe("getService", () => {
  test.skipIf(isWindows())("returns service name from file path", () => {
    const filePath = "specification/service1/file1.json";
    const serviceName = getService(filePath);

    expect(serviceName).toEqual("specification/service1");
  });

  test.skipIf(isWindows())("returns service name from file path with leading separator", () => {
    const filePath = "/specification/service1/file1.json";
    const serviceName = getService(filePath);

    expect(serviceName).toEqual("specification/service1");
  });

  test("throws when file path does not contain enough pieces to assemble a service name", () => {
    const filePath = "file1.json";
    expect(() => getService(filePath)).toThrow("Could not find service for file path");
  });
});

function createMockReadme(path: string, defaultTag: string, existingTags: string[] = []): Readme {
  const mockReadme = new Readme(path);
  mockReadme.getGlobalConfig = async () => ({ tag: defaultTag });
  mockReadme.getTags = async () =>
    new Map<string, Tag>(existingTags.map((tag) => [tag, {} as Tag]));
  return mockReadme;
}

describe("reconcileChangedFilesAndTags", () => {
  expect.extend({
    async toBeReadmeWith(received: Readme, expected: Readme) {
      const passMessages: string[] = [];
      const failMessages: string[] = [];

      try {
        expect(received.path).toBe(resolve(expected.path));
        passMessages.push(`path is ${expected.path}`);
      } catch (e) {
        failMessages.push(String(e));
      }
      try {
        const expectedDefaultTag = (await expected.getGlobalConfig()).tag;
        await expect(received.getGlobalConfig()).resolves.toEqual({ tag: expectedDefaultTag });
        passMessages.push(`default tag is ${expectedDefaultTag}`);
      } catch (e) {
        failMessages.push(String(e));
      }

      try {
        const expectedTags = [...(await expected.getTags()).keys()];
        const actualTags = [...(await received.getTags()).keys()];
        expect(actualTags).toEqual(expect.arrayContaining(expectedTags));
        passMessages.push(`tags are ${expectedTags.join(", ")}`);
      } catch (e) {
        failMessages.push(String(e));
      }

      const pass = failMessages.length === 0;
      return {
        pass,
        message: () =>
          pass
            ? `Readme matches expected values\nChecks: ${passMessages.join("; ")}`
            : `Readme object checks failed:\n- ${failMessages.join("\n- ")}`,
      };
    },
  });

  // These tests assume that an existing readme.md at specification/1/readme.md
  // has 3 tags:
  // tag1 - default
  // tag2
  // tag3
  const beforeTags = ["tag1", "tag2", "tag3"];

  // Mocks an output of buildState with values relevant to testing
  // reconcileChangedFilesAndTags
  function createReadmeTags(
    tags: string[],
    defaultTag: string = "tag1",
    readmePath: string = "specification/1/readme.md",
  ): Map<string, ReadmeAffectedTags> {
    return new Map<string, ReadmeAffectedTags>([
      [
        readmePath,
        {
          readme: createMockReadme(readmePath, defaultTag, beforeTags),
          changedTags: new Set<string>(tags),
        },
      ],
    ]);
  }

  test.each([
    [
      "1. add a tag to an existing readme",
      // Given this before state...
      createReadmeTags([]),
      // ... and this after state
      createReadmeTags(["tag4"]),

      // Modify the set of things to check in before to match:
      createReadmeTags([""]),

      // And modify the set of things in after to match: 
      createReadmeTags(["tag4"]),
    ],
    [
      "2. add a new tag and make it default",
      createReadmeTags([]),
      createReadmeTags(["tag4"], "tag4"),
      createReadmeTags([""]),
      createReadmeTags(["tag4"], "tag4"),
    ],
    [
      "3. add multiple tags",
      createReadmeTags([]),
      createReadmeTags(["tag4", "tag5"]),
      createReadmeTags([""]),
      createReadmeTags(["tag4", "tag5"]),
    ],
    [
      "4. add multiple tags and update default",
      createReadmeTags([]),
      createReadmeTags(["tag4", "tag5"], "tag5"),
      createReadmeTags([""]),
      createReadmeTags(["tag4", "tag5"], "tag5"),
    ],
    [
      "5. update an existing tag",
      createReadmeTags(["tag2"]),
      createReadmeTags(["tag2"]),
      createReadmeTags(["tag2"]),
      createReadmeTags(["tag2"]),
    ],
    [
      "6. update default tag",
      createReadmeTags(["tag1"]),
      createReadmeTags(["tag1"]),
      createReadmeTags(["tag1"]),
      createReadmeTags(["tag1"]),
    ],
    [
      "7. add and edit multiple new tags but don't affect default tag",
      createReadmeTags(["tag2", "tag3"]),
      createReadmeTags(["tag2", "tag3", "tag4", "tag5"]),
      createReadmeTags(["tag2", "tag3", ""]),
      createReadmeTags(["tag2", "tag3", "tag4", "tag5"]),
    ],
    [
      "8. add a new file to an existing tag",
      // TODO: Document why before tags is an empty array
      createReadmeTags([]),
      createReadmeTags(["tag2"]),
      createReadmeTags(["tag2"]),
      createReadmeTags(["tag2"]),
    ],
    [
      // TODO: Re-number scenarios
      "8.5 add new files to multiple existing tags",
      createReadmeTags([]),
      createReadmeTags(["tag2", "tag3"]),
      createReadmeTags(["tag2", "tag3"]),
      createReadmeTags(["tag2", "tag3"]),
    ],
    [
      "9. remove a tag",
      createReadmeTags(["tag2"]),
      createReadmeTags([]),
      createReadmeTags([]),
      createReadmeTags([]),
    ],
    [
      "10. remove a tag and edit a tag",
      createReadmeTags(["tag2", "tag3"]),
      createReadmeTags(["tag3"]),
      createReadmeTags(["tag3"]),
      createReadmeTags(["tag3"]),
    ],
    [
      "11. remove a tag add a new tag",
      createReadmeTags(["tag2"]),
      createReadmeTags(["tag4"]),
      createReadmeTags([""]),
      createReadmeTags(["tag4"]),
    ],
    [
      "12. delete default tag set new default",
      createReadmeTags(["tag1"]),
      createReadmeTags(["tag2"], "tag2"),
      createReadmeTags(["tag2"]), // there's an asymmetry of expectations here
      createReadmeTags(["tag2"], "tag2"),
    ],
    [
      "13. update muiltiple tags including default tag",
      createReadmeTags(["tag1", "tag2"]),
      createReadmeTags(["tag1", "tag2"]),
      createReadmeTags(["tag1", "tag2"]),
      createReadmeTags(["tag1", "tag2"]),
    ],
    [
      "14. update mulitple tags including default tag and add a new tag",
      createReadmeTags(["tag1", "tag2"]),
      createReadmeTags(["tag1", "tag2", "tag4", "tag5"]),
      createReadmeTags(["tag1", "tag2"]),
      createReadmeTags(["tag1", "tag2", "tag4", "tag5"]),
    ],
    [
      "15. delete a readme",
      createReadmeTags([]),
      new Map<string, ReadmeAffectedTags>([]),
      createReadmeTags([]),
      new Map<string, ReadmeAffectedTags>([]),
    ],
    [
      "15.1 delete a readme",
      createReadmeTags(["tag1", "tag2", "tag3"]),
      new Map<string, ReadmeAffectedTags>([]),
      createReadmeTags(["tag1", "tag2", "tag3"]),
      new Map<string, ReadmeAffectedTags>([]),
    ],
    [
      "16. delete a readme and swagger files",
      createReadmeTags(["tag1", "tag2", "tag3"]),
      new Map<string, ReadmeAffectedTags>([]),
      createReadmeTags(["tag1", "tag2", "tag3"]),
      new Map<string, ReadmeAffectedTags>([]),
    ],

    // For this test case, the assumption that a readme exists at
    // specification/1/readme.md is irrelevant, so use an empty map.
    [
      "17. add a new readme",
      new Map<string, ReadmeAffectedTags>([]),
      createReadmeTags(["tag1", "tag2"], "tag1", "specification/2/readme.md"),
      new Map<string, ReadmeAffectedTags>([]),
      createReadmeTags(["tag1", "tag2"], "tag1", "specification/2/readme.md"),
    ],
    [
      "18. only change readme.md file",
      createReadmeTags([]),
      createReadmeTags([]),
      createReadmeTags([]),
      createReadmeTags([]),
    ],
    [
      "19. only change readme.md file updating default tag",
      createReadmeTags([]),
      createReadmeTags([], "tag2"),
      createReadmeTags([]),
      createReadmeTags([], "tag2"),
    ],
    [
      "20. add a file to the default tag",
      createReadmeTags([]),
      createReadmeTags(["tag1"]),
      createReadmeTags(["tag1"]), // There's an asymmetry here
      createReadmeTags(["tag1"]),
    ],
  ])(
    "reconcileChangedFilesAndTags - %s",
    async (_, before, after, expectedBeforeFinal, expectedAfterFinal) => {
      const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);

      expect([...beforeFinal.keys()]).toEqual(
        expect.arrayContaining([...expectedBeforeFinal.keys()]),
      );
      expect([...afterFinal.keys()]).toEqual(
        expect.arrayContaining([...expectedAfterFinal.keys()]),
      );

      for (const [key, expectedValue] of expectedBeforeFinal) {
        const actual = beforeFinal.get(key)!;
        expect(actual.changedTags).toEqual(expectedValue.changedTags);
        await expect(actual.readme).toBeReadmeWith(expectedValue.readme);
      }

      for (const [key, expectedValue] of expectedAfterFinal) {
        const actual = afterFinal.get(key)!;
        expect(actual.changedTags).toEqual(expectedValue.changedTags);
        await expect(actual.readme).toBeReadmeWith(expectedValue.readme);
      }
    },
  );

  test("keeps a specification in before if it is deleted in after", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: new Readme("specification/1/readme.md"),
          changedTags: new Set<string>(["tag1", "tag2"]),
        },
      ],
    ]);
    const after = new Map<string, ReadmeAffectedTags>();

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });
});

describe("getChangedSwaggers", () => {
  test("returns an empty set if no swaggers are changed", async () => {
    await expect(
      getChangedSwaggers(
        "test/fixtures/getChangedSwaggers/before",
        "test/fixtures/getChangedSwaggers/after",
        new Set<string>(),
      ),
    ).resolves.toEqual(new Set<string>());
  });

  test("excludes swaggers that are not changed", async () => {
    const swaggers = await getChangedSwaggers(
      "test/fixtures/getChangedSwaggers/before/",
      "test/fixtures/getChangedSwaggers/after/",
      new Set<string>(["specification/service1/file1.json"]),
    );
    expect(swaggers).toEqual(new Set<string>());
  });

  test("includes swaggers that don't exist in before", async () => {
    const swaggers = await getChangedSwaggers(
      "test/fixtures/getChangedSwaggers/before/",
      "test/fixtures/getChangedSwaggers/after/",
      new Set<string>(["specification/service1/new-file.json"]),
    );
    expect(swaggers).toEqual(new Set<string>(["specification/service1/new-file.json"]));
  });

  test("includes swagger that has been changed", async () => {
    const swaggers = await getChangedSwaggers(
      "test/fixtures/getChangedSwaggers/before/",
      "test/fixtures/getChangedSwaggers/after/",
      new Set<string>(["specification/service1/different.json"]),
    );
    expect(swaggers).toEqual(new Set<string>(["specification/service1/different.json"]));
  });

  test("includes swaggers that have a relevant changed dependency", async () => {
    const swaggers = await getChangedSwaggers(
      "test/fixtures/getChangedSwaggers/before/",
      "test/fixtures/getChangedSwaggers/after/",
      new Set<string>([
        "specification/service1/with-dependency.json",
        "specification/service1/changed-dependency.json",
      ]),
    );
    expect(swaggers).toEqual(
      new Set<string>([
        "specification/service1/with-dependency.json",
        "specification/service1/changed-dependency.json",
      ]),
    );
  });
});

describe("buildState", () => {
  test.skipIf(isWindows())("returns output for a swagger edited in place", async () => {
    const actual = await buildState(
      ["specification/edit-in-place/data-plane/swagger.json"],
      "test/fixtures/buildState/",
    );

    expect(actual).toMatchInlineSnapshot(`
      [
        Map {
          "specification/edit-in-place/readme.md" => {
            "changedTags": Set {
              "package-2022-12-01",
            },
            "readme": Readme {},
          },
        },
        [
          "specification/edit-in-place/data-plane/swagger.json",
        ],
      ]
    `);
  });

  test.skipIf(isWindows())("returns output for an edited readme", async () => {
    const actual = await buildState(
      ["specification/edit-in-place/readme.md"],
      "test/fixtures/buildState/",
    );

    expect(actual).toMatchObject([
      new Map([
        [
          "specification/edit-in-place/readme.md",
          {
            changedTags: new Set<string>([""]),
            readme: expect.any(Readme) as unknown,
          },
        ],
      ]),
      [],
    ]);

    expect(actual[0].get("specification/edit-in-place/readme.md")!.readme.path).toEqual(
      resolve("test/fixtures/buildState/", "specification/edit-in-place/readme.md"),
    );
  });

  test("does not throw if a file is missing", async () => {
    await expect(
      buildState(
        ["specification/edit-in-place/data-plane/does-not-exist.json"],
        "test/fixtures/buildState/",
      ),
    ).resolves.not.toThrow();
  });

  test.skipIf(isWindows())("does not include readme files that has no input-file:", async () => {
    const actual = await buildState(
      ["specification/no-input-file/readme.md"],
      "test/fixtures/buildState/",
    );

    expect(actual).toEqual([new Map<string, ReadmeAffectedTags>(), []]);
  });

  test("handles deleted (i.e. nonexistant) readme.md file", async () => {
    const actual = await buildState(
      ["specification/deleted-readme/readme.md"],
      "test/fixtures/buildState/",
    );

    expect(actual).toEqual([new Map<string, ReadmeAffectedTags>(), []]);
  });

  test("handles deleted (i.e. nonexistant) readme.md file and swagger JSON", async () => {
    const actual = await buildState(
      [
        "specification/deleted-readme/readme.md",
        "specification/deleted-readme/data-plane/swagger.json",
      ],
      "test/fixtures/buildState/",
    );

    expect(actual).toEqual([new Map<string, ReadmeAffectedTags>(), []]);
  });
});
