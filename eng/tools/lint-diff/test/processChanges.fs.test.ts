import { getAffectedReadmes } from "../src/processChanges.js";
import { vol } from "memfs";
import { beforeEach, vi, test, describe } from "vitest";

// This test is in a separate module because fs mocking is difficult to undo

vi.mock("fs/promises", async () => {
  const memfs = await import("memfs");
  return {
    ...memfs.fs.promises,
  };
});

describe("getAffectedReadmes", () => {
  beforeEach(() => {
    vol.reset();
  });

  test.concurrent("includes expected changed file", async ({ expect }) => {
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

  test.concurrent("includes files up the heirarchy", async ({ expect }) => {
    const files = {
      "./specification/a/readme.md": "a",
      "./specification/a/b/c/readme.md": "c",
    };
    vol.fromJSON(files, ".");

    const changedFiles = ["specification/a/b/c/readme.md"];
    const affectedReadmes = await getAffectedReadmes(changedFiles, ".");
    expect(affectedReadmes).toEqual(["specification/a/b/c/readme.md", "specification/a/readme.md"]);
  });

  test.concurrent(
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

  test.concurrent("excludes files outside of specification/", async ({ expect }) => {
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
