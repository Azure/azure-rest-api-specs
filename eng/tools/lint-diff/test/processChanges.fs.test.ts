import { beforeEach, vi, test, describe } from "vitest";
import { vol } from "memfs";

import { getAffectedReadmes, readFileList } from "../src/processChanges.js";
import { afterEach } from "node:test";
import { isWindows } from "./test-util.js";

// These tests are in a separate module because fs mocking is difficult to undo

vi.mock("node:fs", () => {
  const memfs = require("memfs");
  return {
    ...memfs.fs,
  };
});
vi.mock("node:fs/promises", () => {
  const memfs = require("memfs");
  return {
    ...memfs.fs.promises,
  };
});

describe("getAffectedReadmes", () => {
  beforeEach(() => {
    vol.reset();
  });

  test.skipIf(isWindows)
  .concurrent("includes expected changed file", async ({ expect }) => {
    const files = {
      "./specification/a/readme.md": "a",
      "./specification/b/readme.md": "b",
    };
    vol.fromJSON(files, ".");

    const changedFiles = ["specification/a/readme.md"];
    const affectedReadmes = await getAffectedReadmes(changedFiles, ".");
    expect(affectedReadmes).toEqual(["specification/a/readme.md"]);
  });

  test.concurrent("excludes non-changed file outside of scope", async ({ expect }) => {
    const files = {
      "./specification/a/readme.md": "a",
      "./specification/b/readme.md": "b",
    };
    vol.fromJSON(files, ".");

    const changedFiles = ["specification/a/readme.md"];
    const affectedReadmes = await getAffectedReadmes(changedFiles, ".");
    expect(affectedReadmes).not.toContain(["specification/b/readme.md"]);
  });

  test.skipIf(isWindows)
  .concurrent("includes files up the heirarchy", async ({ expect }) => {
    const files = {
      "./specification/a/readme.md": "a",
      "./specification/a/b/c/readme.md": "c",
    };
    vol.fromJSON(files, ".");

    const changedFiles = ["specification/a/b/c/readme.md"];
    const affectedReadmes = await getAffectedReadmes(changedFiles, ".");
    expect(affectedReadmes).toEqual(["specification/a/b/c/readme.md", "specification/a/readme.md"]);
  });

  test.skipIf(isWindows)
  .concurrent(
    "lists reademe files in folders with affected swagger files",
    async ({ expect }) => {
      const files = {
        "./specification/service1/readme.md": "a",
        "./specification/service1/b/c/swagger.json": "{}",
        "./specification/service2/readme.md": "b",
        "./specification/service2/swagger.json": "{}",
      };
      vol.fromJSON(files, ".");

      const changedFiles = ["specification/service1/b/c/swagger.json"];
      const affectedReadmes = await getAffectedReadmes(changedFiles, ".");
      expect(affectedReadmes).toEqual(["specification/service1/readme.md"]);
    },
  );

  test.skipIf(isWindows)
  .concurrent("excludes files outside of specification/", async ({ expect }) => {
    const files = {
      "./repo-root/specification/a/readme.md": "a",
      "./repo-root/specification/b/readme.md": "b",
      "./repo-root/readme.md": "root",
      "./repo-root/some.json": "{}",
    };
    vol.fromJSON(files, ".");

    const changedFiles = ["some.json", "readme.md", "specification/a/readme.md"];
    const affectedReadmes = await getAffectedReadmes(changedFiles, "./repo-root");
    expect(affectedReadmes).toEqual(["specification/a/readme.md"]);
  });
});

describe("readFileList", async () => {
  afterEach(() => {
    vol.reset();
  });

  test.concurrent("returns a list of items", async ({ expect }) => {
    // Using test1.txt because somehow another test affects the
    // value of test.txt in this context.
    const files = {
      "./test1.txt": "line1\nline2",
    };
    vol.fromJSON(files, ".");

    const fileList = await readFileList("./test1.txt");
    expect(fileList).toEqual(["line1", "line2"]);
  });

  test.concurrent("returns an empty list if the file is empty", async ({ expect }) => {
    const files = {
      "./test.txt": "",
    };
    vol.fromJSON(files, ".");

    const fileList = await readFileList("./test.txt");
    expect(fileList).toEqual([]);
  });
});
