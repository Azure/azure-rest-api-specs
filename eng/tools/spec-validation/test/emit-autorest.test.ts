import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import { strict as assert } from "node:assert";
import { join } from "path";
import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";
import { EmitAutorestRule } from "../src/rules/emit-autorest.js";

import * as utils from "../src/utils.js";
import { mockFolder } from "./mocks.js";

describe("emit-autorest", function () {
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

  it("should succeed if no main.tsp", async function () {
    fileExistsSpy.mockImplementation(async (file: string) => file != join(mockFolder, "main.tsp"));

    const result = await new EmitAutorestRule().execute(mockFolder);

    assert(result.success);
  });

  it("should succeed if emits autorest", async function () {
    readTspConfigSpy.mockImplementation(
      async (_mockFolder: string) => `
emit:
  - "@azure-tools/typespec-autorest"
`,
    );

    const result = await new EmitAutorestRule().execute(mockFolder);

    assert(result.success);
  });

  it("should fail if config is empty", async function () {
    readTspConfigSpy.mockImplementation(async (_mockFolder: string) => "");

    const result = await new EmitAutorestRule().execute(mockFolder);

    assert(!result.success);
  });

  it("should fail if no emit", async function () {
    readTspConfigSpy.mockImplementation(
      async (_mockFolder: string) => `
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
`,
    );

    const result = await new EmitAutorestRule().execute(mockFolder);

    assert(!result.success);
  });

  it("should fail if no emit autorest", async function () {
    readTspConfigSpy.mockImplementation(
      async (_mockFolder: string) => `
emit:
- foo
`,
    );

    const result = await new EmitAutorestRule().execute(mockFolder);

    assert(!result.success);
  });
});
