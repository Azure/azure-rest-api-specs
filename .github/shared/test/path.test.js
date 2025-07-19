// @ts-check

import { strict as assert } from "assert";
import { describe, it } from "vitest";
import { includesFolder } from "../src/path.js";

describe("includesFolder", () => {
  it("should return true when path contains the specified folder", () => {
    assert.equal(includesFolder("/path/to/examples/file.json", "examples"), true);
  });

  it("should return false when path does not contain the specified folder", () => {
    assert.equal(includesFolder("/path/to/swagger/file.json", "examples"), false);
  });
});

describe("relativeCwd", () => {
  it("TODO", () => {
    assert.fail();
  });
});

describe("resolveCwd", () => {
  it("TODO", () => {
    assert.fail();
  });
});
