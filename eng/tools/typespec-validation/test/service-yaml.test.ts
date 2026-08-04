import { mockFolder, mockSimpleGit } from "./mocks.ts";
mockSimpleGit();

import { strict as assert } from "node:assert";
import { afterEach, beforeEach, describe, it, type MockInstance, vi } from "vitest";
import { ServiceYamlRule } from "../src/rules/service-yaml.ts";

import * as fsPromises from "fs/promises";
import * as utils from "../src/utils.ts";

const validServiceYaml = `versions:
  - version: 2024-06-01
    source: typespec
    swagger-files:
      - resource-manager/Contoso/stable/2024-06-01/openapi.json
  - version: 2023-01-01
    source: swagger
    swagger-files:
      - ../legacy/stable/2023-01-01/contoso.json
`;

describe("service-yaml", function () {
  let fileExistsSpy: MockInstance;
  let readFileSpy: MockInstance;
  let readTspConfigSpy: MockInstance;

  beforeEach(() => {
    fileExistsSpy = vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    readFileSpy = vi.spyOn(fsPromises, "readFile").mockResolvedValue(validServiceYaml);
    readTspConfigSpy = vi
      .spyOn(utils, "readTspConfig")
      .mockResolvedValue(`emit:\n  - "@azure-tools/typespec-autorest"\n`);
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  it("should have suppressable flag set to true", function () {
    assert.equal(new ServiceYamlRule().suppressable, true);
  });

  it("should skip when main.tsp does not exist and there is no service.yaml", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("main.tsp") && !path.endsWith("service.yaml")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(result.success);
    assert(result.stdOutput?.includes("main.tsp not found"));
  });

  it("should skip when tspconfig.yaml does not exist", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("tspconfig.yaml") && !path.endsWith("service.yaml")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(result.success);
    assert(result.stdOutput?.includes("tspconfig.yaml not found"));
  });

  it("should skip when tspconfig.yaml does not emit typespec-autorest", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("service.yaml")),
    );
    readTspConfigSpy.mockResolvedValue(`emit:\n  - "@azure-tools/typespec-python"\n`);

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(result.success);
    assert(result.stdOutput?.includes("does not emit"));
  });

  it("should validate swagger paths even when main.tsp does not exist", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("main.tsp") && !path.endsWith("openapi.json")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(!result.success);
    assert(result.errorOutput?.includes("swagger files that do not exist"));
  });

  it("should pass when service.yaml is valid and all swagger files exist", async function () {
    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(result.success);
    assert(result.stdOutput?.includes("Validated 2 swagger file(s) across 2 version(s)"));
  });

  it("should pass when a version has no swagger-files", async function () {
    readFileSpy.mockResolvedValue(`versions:\n  - version: 2024-06-01\n    source: typespec\n`);

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(result.success);
  });

  it("should fail when service.yaml is missing", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("service.yaml")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(!result.success);
    assert(result.errorOutput?.includes("Missing service.yaml"));
  });

  it("should fail when a swagger file does not exist", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("openapi.json")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(!result.success);
    assert(result.errorOutput?.includes("swagger files that do not exist"));
    assert(result.errorOutput?.includes("2024-06-01"));
  });

  it("should report all broken swagger paths, not just the first", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith(".json") || path.endsWith("tspconfig.yaml")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(!result.success);
    assert(result.errorOutput?.includes("resource-manager/Contoso/stable/2024-06-01/openapi.json"));
    assert(result.errorOutput?.includes("../legacy/stable/2023-01-01/contoso.json"));
  });

  it("should fail when a swagger path differs only by case", async function () {
    // fileExists() does an exact-case check, so a case-only mismatch reports as missing
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("OpenAPI.json")),
    );
    readFileSpy.mockResolvedValue(
      `versions:\n  - version: 2024-06-01\n    source: typespec\n    swagger-files:\n      - stable/2024-06-01/OpenAPI.json\n`,
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(!result.success);
    assert(result.errorOutput?.includes("must match on case"));
  });

  it("should fail when service.yaml is not valid YAML", async function () {
    readFileSpy.mockResolvedValue("versions: [\n  - broken");

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(!result.success);
    assert(result.errorOutput?.includes("not valid YAML"));
  });

  it("should fail when service.yaml is missing the versions property", async function () {
    readFileSpy.mockResolvedValue("someOtherKey: true\n");

    const result = await new ServiceYamlRule().execute(mockFolder);
    assert(!result.success);
    assert(result.errorOutput?.includes("does not match the expected format"));
    assert(result.errorOutput?.includes("versions"));
  });
});
