import { test, describe } from "vitest";
import { join } from "node:path";

import {
  getSwaggerDependenciesMap,
  getAffectedSwaggers,
  getAffectedServices,
} from "../src/util.js";

describe("getSwaggerDependenciesMap", () => {
  test.concurrent("empty set on no .json files", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/empty",
    );

    expect(dependencyMap.size).toEqual(0);
  });

  test.concurrent("d has no dependencies", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    expect(dependencyMap.has("specification/1/d.json")).toEqual(true);
    expect(dependencyMap.get("specification/1/d.json")).toEqual(new Set<string>());
  });

  test.concurrent("a depends on b and c (and d transitively)", async ({ expect }) => {
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

  test.concurrent("b depends on c and d", async ({ expect }) => {
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
  test.concurrent("a affects only a", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/a.json"], dependencyMap);

    expect(affectedSwaggers).toEqual(["specification/1/a.json"]);
  });

  test.concurrent("b affects a and b", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/nesting/b.json"], dependencyMap);

    expect(affectedSwaggers).toEqual(["specification/1/nesting/b.json", "specification/1/a.json"]);
  });

  test.concurrent("c affects a, b, c", async ({ expect }) => {
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

  test.concurrent("d affects a, b, d", async ({ expect }) => {
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

  test.concurrent("d, c affects a, b, c, d", async ({ expect }) => {
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
  test.concurrent("returns single service with multiple files", async ({ expect }) => {
    const changedFiles = ["specification/service1/file1.json", "specification/service1/file2.json"];
    const affectedServices = await getAffectedServices(changedFiles);

    expect(affectedServices).toEqual(new Set<string>(["specification/service1"]));
  });

  test.concurrent("returns multiple services", async ({ expect }) => {
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
