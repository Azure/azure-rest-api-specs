import { test, describe, vi, expect } from "vitest";
import { vol } from "memfs";
import { pathExists, isFailure, isWarning } from "../src/util.js";
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

describe("isFailure", () => {
  // Data driven test
  test.each([
    { level: "error", expected: true },
    { level: "fatal", expected: true },
    { level: "warning", expected: false },
    { level: "information", expected: false },
    { level: "info", expected: false },
  ])(`isFailure($level) returns $expected`, ({ level, expected }) => {
    expect(isFailure(level)).toEqual(expected);
  });
});

describe("isWarning", () => {
  test.each([
    { level: "error", expected: false },
    { level: "fatal", expected: false },
    { level: "warning", expected: true },
    { level: "information", expected: false },
    { level: "info", expected: false },
  ])(`isWarning($level) returns $expected`, ({ level, expected }) => {
    expect(isWarning(level)).toEqual(expected);
  });
});
