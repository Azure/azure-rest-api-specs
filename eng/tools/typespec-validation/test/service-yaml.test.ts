import { mockFolder, mockSimpleGit } from "./mocks.ts";
mockSimpleGit();

import { resolve } from "node:path";
import { afterEach, beforeEach, describe, expect, it, type MockInstance, vi } from "vitest";
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
    expect(new ServiceYamlRule().suppressable).toBe(true);
  });

  it("should skip when main.tsp does not exist and there is no service.yaml", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("main.tsp") && !path.endsWith("service.yaml")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("main.tsp not found");
  });

  it("should skip when tspconfig.yaml does not exist", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("tspconfig.yaml") && !path.endsWith("service.yaml")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("tspconfig.yaml not found");
  });

  it("should skip when tspconfig.yaml does not emit typespec-autorest", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("service.yaml")),
    );
    readTspConfigSpy.mockResolvedValue(`emit:\n  - "@azure-tools/typespec-python"\n`);

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("does not emit");
  });

  it("should pass when service.yaml is valid and all swagger files exist", async function () {
    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(true);
    expect(result.stdOutput).toContain("Validated 2 swagger file(s) across 2 version(s)");
  });

  it("should pass when a version has no swagger-files", async function () {
    readFileSpy.mockResolvedValue(`versions:\n  - version: 2024-06-01\n    source: typespec\n`);

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(true);
  });

  it("should validate swagger paths even when main.tsp does not exist", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("main.tsp") && !path.endsWith("openapi.json")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("swagger files that do not exist");
  });

  it("should fail when service.yaml is missing", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("service.yaml")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("Missing service.yaml");
  });

  it("should fail when a swagger file does not exist", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(!path.endsWith("openapi.json")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("swagger files that do not exist");
    expect(result.errorOutput).toContain("2024-06-01");
  });

  it("should report all broken swagger paths, not just the first", async function () {
    fileExistsSpy.mockImplementation((path: string) =>
      Promise.resolve(path.endsWith("service.yaml") || path.endsWith("main.tsp")),
    );

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("resource-manager/Contoso/stable/2024-06-01/openapi.json");
    expect(result.errorOutput).toContain("../legacy/stable/2023-01-01/contoso.json");
  });

  it("should resolve swagger paths relative to service.yaml", async function () {
    const checked: string[] = [];
    fileExistsSpy.mockImplementation((path: string) => {
      checked.push(path);
      return Promise.resolve(true);
    });

    await new ServiceYamlRule().execute(mockFolder);
    expect(checked).toContain(
      resolve(mockFolder, "resource-manager/Contoso/stable/2024-06-01/openapi.json"),
    );
    expect(checked).toContain(resolve(mockFolder, "../legacy/stable/2023-01-01/contoso.json"));
  });

  it("should fail when service.yaml is not valid YAML", async function () {
    readFileSpy.mockResolvedValue("versions: [\n  - broken");

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("not valid YAML");
  });

  it("should fail when service.yaml is missing the versions property", async function () {
    readFileSpy.mockResolvedValue("someOtherKey: true\n");

    const result = await new ServiceYamlRule().execute(mockFolder);
    expect(result.success).toBe(false);
    expect(result.errorOutput).toContain("does not match the expected format");
    expect(result.errorOutput).toContain("versions");
  });
});
