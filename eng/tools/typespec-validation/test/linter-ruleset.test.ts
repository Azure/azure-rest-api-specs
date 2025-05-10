import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import { strict as assert } from "node:assert";
import { join } from "path";
import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";
import { LinterRulesetRule } from "../src/rules/linter-ruleset.js";

import * as utils from "../src/utils.js";
import { mockFolder } from "./mocks.js";

describe("linter-ruleset", function () {
  let fileExistsSpy: MockInstance;
  let readTspConfigSpy: MockInstance;

  beforeEach(() => {
    fileExistsSpy = vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    readTspConfigSpy = vi.spyOn(utils, "readTspConfig").mockResolvedValue(contosoTspConfig);
  });

  afterEach(() => {
    fileExistsSpy.mockReset();
    readTspConfigSpy.mockReset();
  });

  it("succeeds with default config", async function () {
    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(result.success);
  });

  it("succeeds with resource-manager/resource-manager", async function () {
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/resource-manager"
`,
    );
    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(result.success);
  });

  it("succeeds with data-plane/data-plane", async function () {
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`,
    );
    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(result.success);
  });

  it("succeeds with client.tsp/data-plane", async function () {
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`,
    );

    fileExistsSpy.mockImplementation(
      async (file: string) => file === join(mockFolder, "client.tsp"),
    );

    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(result.success);
  });

  it("fails with no-config", async function () {
    readTspConfigSpy.mockImplementation(async (_folder: string) => "");
    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(!result.success);
  });

  it("fails with resource-manager/no-linter", async function () {
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`,
    );
    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(!result.success);
  });

  it("fails with resource-manager/data-plane", async function () {
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`,
    );
    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(!result.success);
  });

  it("fails with data-plane/resource-manager", async function () {
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/resource-manager"
`,
    );
    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(!result.success);
  });

  it("fails with data-plane/old-and-new", async function () {
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
linter:
  extends:
    - "@azure-tools/typespec-azure-core/all"
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`,
    );
    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(!result.success);
  });

  it("fails with resource-manager/old-and-new", async function () {
    readTspConfigSpy.mockImplementation(
      async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
linter:
  extends:
    - "@azure-tools/typespec-azure-resource-manager/all"
    - "@azure-tools/typespec-azure-rulesets/resource-manager"
`,
    );
    const result = await new LinterRulesetRule().execute(mockFolder);

    assert(!result.success);
  });
});
