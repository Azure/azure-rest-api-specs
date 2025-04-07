import { test, describe, vi, expect } from "vitest";
import { vol } from "memfs";
import { pathExists } from "../src/util.js";
import { beforeEach } from "node:test";

vi.mock("fs/promises", () => {
  const memfs = require("memfs");
  return {
    ...memfs.fs.promises,
  };
});

describe("pathExists", () => {
  beforeEach(() => {
    vol.reset();
  });

  test("returns true for existing path", async () => {
    const files = {
      "./file-exists": "a",
    };
    vol.fromJSON(files, ".");

    const exists = await pathExists("./file-exists");

    expect(exists).toEqual(true);
  });

  test("returns false for non-existing path", async () => {
    const files = {
      "./file-exists": "a",
    };
    vol.fromJSON(files, ".");

    const exists = await pathExists("./file-does-not-exist");

    expect(exists).toEqual(false);
  });
});
