import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import { strict as assert } from "node:assert";
import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";
import { FlavorAzureRule } from "../src/rules/flavor-azure.js";

import * as utils from "../src/utils.js";
import { mockFolder } from "./mocks.js";

describe("flavor-azure", function () {
  let readTspConfigSpy: MockInstance;

  beforeEach(() => {
    readTspConfigSpy = vi.spyOn(utils, "readTspConfig").mockResolvedValue(contosoTspConfig);
  });

  afterEach(() => {
    readTspConfigSpy.mockReset();
  });

  const clientEmitterNames = [
    "@azure-tools/typespec-csharp",
    "@azure-tools/typespec-java",
    "@azure-tools/typespec-python",
    "@azure-tools/typespec-ts",
    "@typespec/http-client-foo",
  ];

  const nonClientEmitterNames = ["@azure-tools/typespec-autorest", "@typespec/openapi3"];

  clientEmitterNames.forEach(function (emitter) {
    it(`should fail if "${emitter}" is missing flavor`, async function () {
      readTspConfigSpy.mockImplementation(
        async (_folder: string) => `
      options:
        "${emitter}":
          package-dir: "foo"
      `,
      );
      const result = await new FlavorAzureRule().execute(mockFolder);
      assert(!result.success);
    });

    it(`should fail if "${emitter}" flavor is not "azure"`, async function () {
      readTspConfigSpy.mockImplementation(
        async (_folder: string) => `
      options:
        "${emitter}":
          package-dir: "foo"
          flavor: not-azure
      `,
      );
      const result = await new FlavorAzureRule().execute(mockFolder);
      assert(!result.success);
    });

    it(`should succeed if ${emitter} flavor is "azure"`, async function () {
      readTspConfigSpy.mockImplementation(
        async (_folder: string) => `
      options:
        "${emitter}":
          package-dir: "foo"
          flavor: azure
      `,
      );
      const result = await new FlavorAzureRule().execute(mockFolder);
      assert(result.success);
    });
  });

  nonClientEmitterNames.forEach(function (emitter) {
    it(`should succeed if ${emitter} is missing flavor`, async function () {
      readTspConfigSpy.mockImplementation(
        async (_folder: string) => `
      options:
        "${emitter}":
          azure-resource-provider-folder: "data-plane"
      `,
      );
      const result = await new FlavorAzureRule().execute(mockFolder);
      assert(result.success);
    });
  });

  it("should succeed if config is empty", async function () {
    readTspConfigSpy.mockImplementation(async (_folder: string) => "");
    const result = await new FlavorAzureRule().execute(mockFolder);
    assert(result.success);
  });

  it("should succeed if config has no options", async function () {
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
emit:
  - "@azure-tools/typespec-autorest"
`,
    );
    const result = await new FlavorAzureRule().execute(mockFolder);
    assert(result.success);
  });
});
