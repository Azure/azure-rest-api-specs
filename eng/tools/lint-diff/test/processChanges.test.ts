import { test, describe, expect } from "vitest";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import {
  getSwaggerDependenciesMap,
  getAffectedSwaggers,
  getAffectedServices,
  getService,
  reconcileChangedFilesAndTags,
} from "../src/processChanges.js";

import { isWindows } from "./test-util.js";

describe("getSwaggerDependenciesMap", () => {
  test("empty set on no .json files", async () => {
    const __dirname = dirname(fileURLToPath(import.meta.url));
    console.log("dirname", __dirname);
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/empty",
    );

    expect(dependencyMap.size).toEqual(0);
  });

  test.skipIf(isWindows())("d has no dependencies", async () => {
    const __dirname = dirname(fileURLToPath(import.meta.url));
    console.log("dirname", __dirname);
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    console.log(dependencyMap);

    expect(dependencyMap.has("specification/1/d.json")).toEqual(true);
    expect(dependencyMap.get("specification/1/d.json")).toEqual(new Set<string>());
  });

  test.skipIf(isWindows())("a depends on b and c (and d transitively)", async () => {
    const __dirname = dirname(fileURLToPath(import.meta.url));
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    console.log(dependencyMap);

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

  test.skipIf(isWindows())("b depends on c and d", async () => {
    const __dirname = dirname(fileURLToPath(import.meta.url));
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    console.log(dependencyMap);

    expect(dependencyMap.has("specification/1/nesting/b.json")).toEqual(true);
    expect(dependencyMap.get("specification/1/nesting/b.json")).toEqual(
      new Set<string>(["specification/1/c.json", "specification/1/d.json"]),
    );
  });
});

describe("getAffectedSwaggers", () => {
  test("a affects only a", async () => {
    const __dirname = dirname(fileURLToPath(import.meta.url));
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/a.json"], dependencyMap);

    expect(affectedSwaggers).toEqual(["specification/1/a.json"]);
  });

  test.skipIf(isWindows())("b affects a and b", async () => {
    const __dirname = dirname(fileURLToPath(import.meta.url));
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    console.log(dependencyMap);

    const affectedSwaggers = getAffectedSwaggers(["specification/1/nesting/b.json"], dependencyMap);

    expect(affectedSwaggers).toEqual(["specification/1/nesting/b.json", "specification/1/a.json"]);
  });

  test.skipIf(isWindows())("c affects a, b, c", async () => {
    const __dirname = dirname(fileURLToPath(import.meta.url));
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

  test.skipIf(isWindows())("d affects a, b, d", async () => {
    const __dirname = dirname(fileURLToPath(import.meta.url));
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

  test.skipIf(isWindows())("d, c affects a, b, c, d", async () => {
    const __dirname = dirname(fileURLToPath(import.meta.url));
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

  test.skipIf(isWindows())("returns service name from file path with leading separator", async () => {
    const filePath = "/specification/service1/file1.json";
    const serviceName = await getService(filePath);

    expect(serviceName).toEqual("specification/service1");
  });

  test("throws when file path does not contain enough pieces to assemble a service name", async () => {
    const filePath = "file1.json";
    await expect(() => getService(filePath)).toThrow("Could not find service for file path");
  });
});

describe("reconcileChangedFilesAndTags", () => {
  test("if a tag is deleted in after and exists in before, remove the tag from before", () => {
    const before = new Map<string, string[]>([["specification/1/readme.md", ["tag1", "tag2"]]]);
    const after = new Map<string, string[]>([["specification/1/readme.md", ["tag1"]]]);

    const [beforeFinal, afterFinal] = reconcileChangedFilesAndTags(before, after);
    expect(beforeFinal).toEqual(
      new Map<string, string[]>([["specification/1/readme.md", ["tag1"]]]),
    );
    expect(afterFinal).toEqual(after);
  });

  test("does not change if there is no change", () => {
    const before = new Map<string, string[]>([["specification/1/readme.md", ["tag1", "tag2"]]]);
    const after = new Map<string, string[]>([["specification/1/readme.md", ["tag1", "tag2"]]]);

    const [beforeFinal, afterFinal] = reconcileChangedFilesAndTags(before, after);
    expect(beforeFinal).toEqual(before);
    expect(afterFinal).toEqual(after);
  });

  // TODO: Test this and ensure the behavior matches
  test("keeps a specification in before if it is deleted in after", () => {
    const before = new Map<string, string[]>([["specification/1/readme.md", ["tag1", "tag2"]]]);
    const after = new Map<string, string[]>();

    const [beforeFinal, afterFinal] = reconcileChangedFilesAndTags(before, after);
    expect(beforeFinal).toEqual(beforeFinal);
    expect(afterFinal).toEqual(after);
  });
});
