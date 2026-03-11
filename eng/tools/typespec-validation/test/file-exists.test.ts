import fs from "fs";
import { strict as assert } from "node:assert";
import os from "os";
import path from "path";
import { afterEach, beforeEach, describe, it } from "vitest";
import { fileExists } from "../src/utils.js";

describe("fileExists", function () {
  let tmpDir: string;

  beforeEach(() => {
    tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), "tsv-test-"));
  });

  afterEach(() => {
    fs.rmSync(tmpDir, { recursive: true });
  });

  it("should return true for a file that exists with exact case", async function () {
    const filePath = path.join(tmpDir, "client.tsp");
    fs.writeFileSync(filePath, "");
    assert.equal(await fileExists(filePath), true);
  });

  it("should return true for a directory that exists", async function () {
    const dirPath = path.join(tmpDir, "examples");
    fs.mkdirSync(dirPath);
    assert.equal(await fileExists(dirPath), true);
  });

  it("should return false for a file that does not exist", async function () {
    const filePath = path.join(tmpDir, "client.tsp");
    assert.equal(await fileExists(filePath), false);
  });

  it("should return false when case differs from actual file on disk", async function () {
    // Create "Client.tsp" (PascalCase)
    fs.writeFileSync(path.join(tmpDir, "Client.tsp"), "");
    // Query for "client.tsp" (lowercase) — should return false regardless of OS
    const filePath = path.join(tmpDir, "client.tsp");
    assert.equal(await fileExists(filePath), false);
  });
});
