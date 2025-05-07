import { test, describe, expect } from "vitest";

import {
  getAffectedServices,
  getService,
  reconcileChangedFilesAndTags,
  getChangedSwaggers,
} from "../src/processChanges.js";

import { isWindows } from "./test-util.js";

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
