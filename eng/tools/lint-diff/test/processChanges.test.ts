import { test, describe } from "vitest";
import { join } from "node:path";

import {
  getSwaggerDependenciesMap,
  getAffectedSwaggers,
  getAffectedServices,
  getService,
  reconcileChangedFilesAndTags,
} from "../src/processChanges.js";

import { isWindows } from "./test-util.js";

describe("getSwaggerDependenciesMap", () => {
  test.skipIf(isWindows)
  .concurrent("empty set on no .json files", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    console.log("dirname", __dirname);
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/empty",
    );

    expect(dependencyMap.size).toEqual(0);
  });

  test.skipIf(isWindows)
  .concurrent("d has no dependencies", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    expect(dependencyMap.has("specification/1/d.json")).toEqual(true);
    expect(dependencyMap.get("specification/1/d.json")).toEqual(new Set<string>());
  });

  test.skipIf(isWindows)
  .concurrent("a depends on b and c (and d transitively)", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    expect(dependencyMap.has("specification/1/a.json")).toEqual(true);
    expect(dependencyMap.get("specification/1/a.json")).toEqual(
      new Set<string>([
        "specification/1/nesting/b.json",
        "specification/1/c.json",
        // d.json is a dependency of a.json through b.json
        "specification/1/d.json",
      ]),
    );
  });

  test.skipIf(isWindows)
  .concurrent("b depends on c and d", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    expect(dependencyMap.has("specification/1/nesting/b.json")).toEqual(true);
    expect(dependencyMap.get("specification/1/nesting/b.json")).toEqual(
      new Set<string>(["specification/1/c.json", "specification/1/d.json"]),
    );
  });
});

describe("getAffectedSwaggers", () => {
  test.skipIf(isWindows)
  .concurrent("a affects only a", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/a.json"], dependencyMap);

    expect(affectedSwaggers).toEqual(["specification/1/a.json"]);
  });

  test.skipIf(isWindows)
  .concurrent("b affects a and b", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/nesting/b.json"], dependencyMap);

    expect(affectedSwaggers).toEqual(["specification/1/nesting/b.json", "specification/1/a.json"]);
  });

  test.skipIf(isWindows)
  .concurrent("c affects a, b, c", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/c.json"], dependencyMap);

    expect(affectedSwaggers).toEqual([
      "specification/1/c.json",
      "specification/1/a.json",
      "specification/1/nesting/b.json",
    ]);
  });

  test.skipIf(isWindows)
  .concurrent("d affects a, b, d", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/d.json"], dependencyMap);

    expect(affectedSwaggers).toEqual([
      "specification/1/d.json",
      "specification/1/a.json",
      "specification/1/nesting/b.json",
    ]);
  });

  test.skipIf(isWindows)
  .concurrent("d, c affects a, b, c, d", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(
      ["specification/1/d.json", "specification/1/c.json"],
      dependencyMap,
    );

    expect(affectedSwaggers).toEqual([
      "specification/1/d.json",
      "specification/1/c.json",
      "specification/1/a.json",
      "specification/1/nesting/b.json",
    ]);
  });
});

describe("getAffectedServices", () => {
  test.skipIf(isWindows)
  .concurrent("returns single service with multiple files", async ({ expect }) => {
    const changedFiles = ["specification/service1/file1.json", "specification/service1/file2.json"];
    const affectedServices = await getAffectedServices(changedFiles);

    expect(affectedServices).toEqual(new Set<string>(["specification/service1"]));
  });

  test.skipIf(isWindows)
  .concurrent("returns multiple services", async ({ expect }) => {
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
  test.skipIf(isWindows)
  .concurrent("returns service name from file path", async ({ expect }) => {
    const filePath = "specification/service1/file1.json";
    const serviceName = await getService(filePath);

    expect(serviceName).toEqual("specification/service1");
  });

  test.skipIf(isWindows)
  .concurrent(
    "returns service name from file path with leading separator",
    async ({ expect }) => {
      const filePath = "/specification/service1/file1.json";
      const serviceName = await getService(filePath);

      expect(serviceName).toEqual("specification/service1");
    },
  );

  test.concurrent(
    "throws when file path does not contain enough pieces to assemble a service name",
    async ({ expect }) => {
      const filePath = "file1.json";
      await expect(() => getService(filePath)).toThrow("Could not find service for file path");
    },
  );
});

describe("reconcileChangedFilesAndTags", () => {
  test.concurrent(
    "if a tag is deleted in after and exists in before, remove the tag from before",
    ({ expect }) => {
      const before = new Map<string, string[]>([["specification/1/readme.md", ["tag1", "tag2"]]]);
      const after = new Map<string, string[]>([["specification/1/readme.md", ["tag1"]]]);

      const [beforeFinal, afterFinal] = reconcileChangedFilesAndTags(before, after);
      expect(beforeFinal).toEqual(
        new Map<string, string[]>([["specification/1/readme.md", ["tag1"]]]),
      );
      expect(afterFinal).toEqual(after);
    },
  );

  test.concurrent("does not change if there is no change", ({ expect }) => {
    const before = new Map<string, string[]>([["specification/1/readme.md", ["tag1", "tag2"]]]);
    const after = new Map<string, string[]>([["specification/1/readme.md", ["tag1", "tag2"]]]);

    const [beforeFinal, afterFinal] = reconcileChangedFilesAndTags(before, after);
    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });

  // TODO: Test this and ensure the behavior matches
  test.concurrent("keeps a specification in before if it is deleted in after", ({ expect }) => {
    const before = new Map<string, string[]>([["specification/1/readme.md", ["tag1", "tag2"]]]);
    const after = new Map<string, string[]>();

    const [beforeFinal, afterFinal] = reconcileChangedFilesAndTags(before, after);
    expect(beforeFinal).toEqual(beforeFinal);
    expect(afterFinal).toEqual(after);
  });
});
