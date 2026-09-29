import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import { strict as assert } from "node:assert";
import { join } from "path";
import { afterEach, beforeEach, describe, it, type MockInstance, vi } from "vitest";
import { LinterRulesetRule } from "../src/rules/linter-ruleset.ts";

import * as utils from "../src/utils.ts";
import { mockFolder } from "./mocks.ts";

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
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/resource-manager"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/resource-manager/Foo");
    assert(result.success);
  });

  it("succeeds with data-plane/data-plane", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/data-plane/Foo");
    assert(result.success);
  });

  it("succeeds with client.tsp/data-plane", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`),
    );

    fileExistsSpy.mockImplementation((file: string) =>
      Promise.resolve(file === join(mockFolder, "client.tsp")),
    );

    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(result.success);
  });

  it("fails with no-config", async function () {
    readTspConfigSpy.mockImplementation(() => Promise.resolve(""));
    const result = await new LinterRulesetRule().execute(mockFolder);
    assert(!result.success);
  });

  it("fails with resource-manager/no-linter", async function () {
    readTspConfigSpy.mockImplementation(() => Promise.resolve(``));
    const result = await new LinterRulesetRule().execute("specification/foo/resource-manager/Foo");
    assert(!result.success);
  });

  it("fails with resource-manager/data-plane", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/Foo.Management");
    assert(!result.success);
  });

  it("fails with data-plane/resource-manager", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/resource-manager"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/data-plane/Foo");
    assert(!result.success);
  });

  it("fails with data-plane/old-and-new", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-core/all"
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/data-plane/Foo");
    assert(!result.success);
  });

  it("fails with resource-manager/old-and-new", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-resource-manager/all"
    - "@azure-tools/typespec-azure-rulesets/resource-manager"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/resource-manager/Foo");

    assert(!result.success);
  });

  it("succeeds with client emitter options and client-sdk ruleset", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
    - "@azure-tools/typespec-azure-rulesets/client-sdk"
options:
  "@azure-tools/typespec-python":
    package-dir: "azure-contoso-widgetmanager"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/data-plane/Foo");
    assert(result.success);
  });

  it("fails with client emitter options but missing client-sdk ruleset", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
options:
  "@azure-tools/typespec-csharp":
    package-dir: "Azure.Template.Contoso"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/data-plane/Foo");
    assert(!result.success);
  });

  it("succeeds with no client emitter options (client-sdk not required)", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/data-plane/Foo");
    assert(result.success);
  });

  it("succeeds with only non-client emitter options (client-sdk not required)", async function () {
    readTspConfigSpy.mockImplementation(() =>
      Promise.resolve(`
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
  "@azure-tools/typespec-client-generator-cli":
    additionalDirectories:
      - "specification/foo/Foo.Shared/"
`),
    );
    const result = await new LinterRulesetRule().execute("specification/foo/data-plane/Foo");
    assert(result.success);
  });
});
