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
import { resolve } from "node:path";
import { isWindows } from "./test-util.js";
import { Tag } from "@azure-tools/specs-shared/tag";

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
  test.skipIf(isWindows())("returns service name from file path", async () => {
    const filePath = "specification/service1/file1.json";
    const serviceName = await getService(filePath);

    expect(serviceName).toEqual("specification/service1");
  });

  test.skipIf(isWindows())(
    "returns service name from file path with leading separator",
    async () => {
      const filePath = "/specification/service1/file1.json";
      const serviceName = await getService(filePath);

      expect(serviceName).toEqual("specification/service1");
    },
  );

  test("throws when file path does not contain enough pieces to assemble a service name", async () => {
    const filePath = "file1.json";
    await expect(() => getService(filePath)).toThrow("Could not find service for file path");
  });
});

function createMockReadme(path: string, defaultTag: string, existingTags: string[] = []): Readme {
  const mockReadme = new Readme(path);
  mockReadme.getGlobalConfig = async () => ({ tag: defaultTag });
  mockReadme.getTags = async () => new Map<string, Tag>(existingTags.map(tag => [tag, {} as Tag]));
  return mockReadme;
}

describe("reconcileChangedFilesAndTags", () => {
  // These tests assume that an existing readme.md at specification/1/readme.md
  // has 3 tags: 
  // tag1 - default
  // tag2
  // tag3
  const beforeTags = ["tag1", "tag2", "tag3"];
  test("1. add a tag to an existing readme", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1", beforeTags),
          changedTags: new Set<string>([]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1", beforeTags),
          changedTags: new Set<string>(["tag4"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);

    expect(afterFinal).toEqual(after);
    expect(beforeFinal).toEqual(
      new Map<string, ReadmeAffectedTags>([
        [
          "specification/1/readme.md",
          {
            readme: expect.any(Readme),
            changedTags: new Set<string>([""]),
          },
        ],
      ]),
    );
  });

  test("2. add a new tag and make it default", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>([]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag4"),
          changedTags: new Set<string>(["tag4"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);

    expect(afterFinal).toEqual(after);
    expect(beforeFinal).toEqual(
      new Map<string, ReadmeAffectedTags>([
        [
          "specification/1/readme.md",
          {
            readme: expect.any(Readme),
            changedTags: new Set<string>([""]),
          },
        ],
      ]),
    );
  });

  test("3. add multiple tags", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>([]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag4", "tag5"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);

    expect(afterFinal).toEqual(after);
    expect(beforeFinal).toEqual(
      new Map<string, ReadmeAffectedTags>([
        [
          "specification/1/readme.md",
          {
            readme: expect.any(Readme),
            changedTags: new Set<string>([""]),
          },
        ],
      ]),
    );
  });

  test("4. add multiple tags and update default", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>([]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag5"),
          changedTags: new Set<string>(["tag4", "tag5"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);

    expect(afterFinal).toEqual(after);
    expect(beforeFinal).toEqual(
      new Map<string, ReadmeAffectedTags>([
        [
          "specification/1/readme.md",
          {
            readme: expect.any(Readme),
            changedTags: new Set<string>([""]),
          },
        ],
      ]),
    );
  });

  test("5. update an existing tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag2"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag2"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);

    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });

  test("6. update default tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);

    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });

  test("7. add and edit multiple new tags but don't affect default tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag2", "tag3"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag2", "tag3", "tag4", "tag5"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);

    expect(beforeFinal).toEqual(new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: expect.any(Readme),
          changedTags: new Set<string>(["tag2", "tag3", ""]),
        },
      ]
    ]));
    expect(afterFinal).toEqual(after);
  });

  test("8. add a new file to an existing tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1", beforeTags),
          changedTags: new Set<string>([]),
        }
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag2"]),
        }
      ]
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);

    expect(beforeFinal).toEqual(new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: expect.any(Readme),
          changedTags: new Set<string>(["tag2"]),
        },
      ]
    ]));
    expect(afterFinal).toEqual(after);
  });

  test("9. remove a tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag2"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>([]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: expect.any(Readme),
          changedTags: new Set<string>([]),
        },
      ]
    ]));
    expect(afterFinal).toEqual(after);
  });

  test("10. remove a tag and edit a tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag2", "tag3"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag3"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: expect.any(Readme),
          changedTags: new Set<string>(["tag3"]),
        },
      ]
    ]));
    expect(afterFinal).toEqual(after);
  });

  test("11. remove a tag add a new tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag2"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag4"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: expect.any(Readme),
          changedTags: new Set<string>([""]),
        },
      ]
    ]));
    expect(afterFinal).toEqual(after);
  });

  // TODO: This should probably have no "before" state so all linting errors
  // come through in "after"
  test("12. delete default tag set new default", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag2"),
          changedTags: new Set<string>(["tag2"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: expect.any(Readme),
          changedTags: new Set<string>([""]),
        },
      ]
    ]));
    expect(afterFinal).toEqual(after);  
  });

  test("13. update muiltple tags including default tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1", "tag2"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1", "tag2"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });

  test("14. update mulitple tags including default tag and add a new tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1", "tag2"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1", "tag2", "tag4", "tag5"]),
        },
      ],
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    expect(beforeFinal).toEqual(
      new Map<string, ReadmeAffectedTags>([
        [
          "specification/1/readme.md",
          {
            readme: expect.any(Readme),
            changedTags: new Set<string>(["tag1", "tag2"]),
          },
        ],
      ]),
    );
    expect(afterFinal).toEqual(after);
  });

  test("15. delete a readme", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>([]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });

  test("16. delete a readme and swagger files", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1", "tag2", "tag3"]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });

  test("17. add a new readme", async () => { 
    const before = new Map<string, ReadmeAffectedTags>([]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/2/readme.md",
        {
          readme: createMockReadme("specification/2/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1", "tag2"]),
        },
      ]
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(new Map<string, ReadmeAffectedTags>([]));
    expect(afterFinal).toEqual(after);
  });

  test("18. only change readme.md file", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>([]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>([]),
        },
      ]
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });

  test("19. only change readme.md file updating default tag", async () => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>([]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag2"),
          changedTags: new Set<string>([]),
        },
      ]
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });

  test("20. add a file to the default tag", async() => {
    const before = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>([]),
        },
      ]
    ]);
    const after = new Map<string, ReadmeAffectedTags>([
      [
        "specification/1/readme.md",
        {
          readme: createMockReadme("specification/1/readme.md", "tag1"),
          changedTags: new Set<string>(["tag1"]),
        },
      ]
    ]);

    const [beforeFinal, afterFinal] = await reconcileChangedFilesAndTags(before, after);
    
    expect(beforeFinal).toEqual(
      new Map<string, ReadmeAffectedTags>([
        [
          "specification/1/readme.md",
          {
            readme: expect.any(Readme),
            changedTags: new Set<string>([""]),
          },
        ]
      ])
    );

    expect(afterFinal).toEqual(
      new Map<string, ReadmeAffectedTags>([
        [
          "specification/1/readme.md",
          {
            readme: expect.any(Readme),
            changedTags: new Set<string>(["tag1"]),
          },
        ]
      ])
    );
  });
});


describe("getChangedSwaggers", () => {
  test("returns an empty set if no swaggers are changed", async () => {
    expect(
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
            readme: expect.any(Readme),
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
    await expect(() =>
      buildState(
        ["specification/edit-in-place/data-plane/does-not-exist.json"],
        "test/fixtures/buildState/",
      ),
    ).not.toThrow();
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
      ["specification/deleted-readme/readme.md", "specification/deleted-readme/data-plane/swagger.json"],
      "test/fixtures/buildState/",
    );
    
    expect(actual).toEqual([new Map<string, ReadmeAffectedTags>(), []]);
  });
});
