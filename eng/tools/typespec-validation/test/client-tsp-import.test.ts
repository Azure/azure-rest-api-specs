import { mockFolder, mockSimpleGit } from "./mocks.ts";
mockSimpleGit();

import { strict as assert } from "node:assert";
import { afterEach, beforeEach, describe, it, type MockInstance, vi } from "vitest";
import { ClientTspImportRule } from "../src/rules/client-tsp-import.ts";

import * as fsPromises from "fs/promises";
import * as utils from "../src/utils.ts";

describe("client-tsp-import", function () {
  let fileExistsSpy: MockInstance;
  let readFileSpy: MockInstance;

  beforeEach(() => {
    fileExistsSpy = vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    readFileSpy = vi.spyOn(fsPromises, "readFile").mockResolvedValue('import "./client.tsp";\n');
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  it("should have suppressable flag set to true", function () {
    assert.equal(new ClientTspImportRule().suppressable, true);
  });

  it("should pass when client.tsp does not exist", async function () {
    fileExistsSpy.mockImplementation((path: string) => {
      return Promise.resolve(!path.endsWith("client.tsp"));
    });

    const result = await new ClientTspImportRule().execute(mockFolder);
    assert(result.success);
  });

  it("should pass when main.tsp does not exist", async function () {
    fileExistsSpy.mockImplementation((path: string) => {
      return Promise.resolve(!path.endsWith("main.tsp"));
    });

    const result = await new ClientTspImportRule().execute(mockFolder);
    assert(result.success);
  });

  it("should pass when main.tsp imports client.tsp with double quotes", async function () {
    readFileSpy.mockResolvedValue('import "./client.tsp";\n');

    const result = await new ClientTspImportRule().execute(mockFolder);
    assert(result.success);
  });

  it("should pass when main.tsp imports client.tsp with single quotes", async function () {
    readFileSpy.mockResolvedValue("import './client.tsp';\n");

    const result = await new ClientTspImportRule().execute(mockFolder);
    assert(result.success);
  });

  it("should pass when import has leading whitespace", async function () {
    readFileSpy.mockResolvedValue('  import "./client.tsp";\n');

    const result = await new ClientTspImportRule().execute(mockFolder);
    assert(result.success);
  });

  it("should pass when import is among other imports", async function () {
    readFileSpy.mockResolvedValue(
      'import "@azure-tools/typespec-azure-core";\nimport "./client.tsp";\nimport "./models.tsp";\n',
    );

    const result = await new ClientTspImportRule().execute(mockFolder);
    assert(result.success);
  });

  it("should fail when main.tsp does not import client.tsp", async function () {
    readFileSpy.mockResolvedValue(
      'import "@azure-tools/typespec-azure-core";\nimport "./models.tsp";\n',
    );

    const result = await new ClientTspImportRule().execute(mockFolder);
    assert(!result.success);
    assert(result.errorOutput?.includes("main.tsp does not import client.tsp"));
  });

  it("should fail when main.tsp is empty", async function () {
    readFileSpy.mockResolvedValue("");

    const result = await new ClientTspImportRule().execute(mockFolder);
    assert(!result.success);
  });
});
