import { execa } from "execa";
import { test, vi } from "vitest";
import { getAffectedReadmes } from "../src/lint-diff.js";
import { beforeEach, describe } from "node:test";
import { vol } from "memfs";
// import exp from "constants";

// TODO: Actual tests
describe("e2e", () => {
  test.concurrent("Executes", async ({ expect }) => {
    const { exitCode } = await execa("npm", ["exec", "--no", "--", "lint-diff"], { reject: false });

    expect(exitCode).toBe(1);
  });
});

describe("getAffectedReadmes", () => {
  // TODO: Does the mock need to be cleaned up?
  vi.mock("fs/promises", async () => {
    // TODO: Why does memfs need to be imported here manually?
    const memfs = await import("memfs");
    return {
      ...memfs.fs.promises,
    };
  });

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
