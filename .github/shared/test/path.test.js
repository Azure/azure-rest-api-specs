// @ts-check

import { strict as assert } from "assert";
import { existsSync, mkdirSync, rmSync } from "fs";
import { dirname, join } from "path";
import { fileURLToPath } from "url";
import { afterEach, beforeEach, describe, it } from "vitest";
import { includesFolder } from "../src/path.js";

// Get the directory of this test file
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

/**
 * Unit tests for path.js utility functions
 */
describe("Path utilities", () => {
  let tempTestDir;

  beforeEach(() => {
    // Create a temporary directory for test files
    tempTestDir = join(__dirname, "temp-path-tests");
    if (existsSync(tempTestDir)) {
      rmSync(tempTestDir, { recursive: true, force: true });
    }
    mkdirSync(tempTestDir, { recursive: true });
  });

  afterEach(() => {
    // Clean up temporary directory
    if (existsSync(tempTestDir)) {
      rmSync(tempTestDir, { recursive: true, force: true });
    }
  });

  describe("includesFolder", () => {
    it("should return true when path contains the specified folder", () => {
      assert.equal(includesFolder("/path/to/examples/file.json", "examples"), true);
      assert.equal(includesFolder("/path/to/examples", "examples"), true);
    });

    it("should return false when path does not contain the specified folder", () => {
      assert.equal(includesFolder("/path/to/swagger/file.json", "examples"), false);
    });
  });
});
